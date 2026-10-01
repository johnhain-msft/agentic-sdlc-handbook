#!/usr/bin/env node
/**
 * check-layout.mjs — mechanical layout gate for a rendered worksheet.
 *
 * Loads the rendered HTML in Chromium, measures every .sheet at true physical
 * size, and reports the facts a human reviewer would otherwise have to eyeball.
 * It also writes one PNG per sheet so the review agent has something to LOOK at.
 *
 *   node check-layout.mjs <rendered.html> <out-dir> [--json report.json]
 *
 * Exit 0 = no defects. Exit 1 = at least one defect. Exit 2 = could not run.
 *
 * This script reports; it never edits. Fixing is the review agent's job.
 */

import { chromium } from 'playwright';
import { mkdir, writeFile } from 'node:fs/promises';
import { existsSync } from 'node:fs';
import { pathToFileURL } from 'node:url';
import path from 'node:path';

const PX_PER_MM = 96 / 25.4;
const MIN_WRITABLE_MM = 6;      // .sm primitives; everything else must clear 8mm
const MIN_DEFAULT_MM = 8;

const [, , htmlArg, outArg, ...rest] = process.argv;

if (!htmlArg || !outArg) {
  console.error('usage: check-layout.mjs <rendered.html|http://localhost/...> <out-dir> [--json report.json]');
  process.exit(2);
}

const isUrl = /^https?:\/\//i.test(htmlArg);
if (!isUrl && !existsSync(htmlArg)) {
  console.error(`FATAL: no such file: ${htmlArg}`);
  process.exit(2);
}
const targetUrl = isUrl ? htmlArg : pathToFileURL(path.resolve(htmlArg)).href;

const jsonIdx = rest.indexOf('--json');
const jsonOut = jsonIdx >= 0 ? rest[jsonIdx + 1] : null;

await mkdir(outArg, { recursive: true });

/**
 * Launch the best available Chromium. Prefer Playwright's own build; fall back
 * to a system Chrome/Edge so the gate still runs on a machine where the
 * browser download is blocked. Both render the same CSS engine, and the gate
 * measures geometry, not pixels, so the fallback is sound.
 */
async function launchChromium() {
  const attempts = [
    { label: 'playwright chromium', opts: {} },
    { label: 'system chrome', opts: { channel: 'chrome' } },
    { label: 'system msedge', opts: { channel: 'msedge' } },
  ];
  const failures = [];
  for (const a of attempts) {
    try {
      const b = await chromium.launch(a.opts);
      if (a.label !== 'playwright chromium') {
        console.error(`note: using ${a.label} (Playwright's own build was unavailable)`);
      }
      return b;
    } catch (err) {
      failures.push(`${a.label}: ${String(err.message).split('\n')[0]}`);
    }
  }
  console.error('FATAL: could not launch any Chromium.\n  ' + failures.join('\n  '));
  process.exit(2);
}

const browser = await launchChromium();
const page = await browser.newPage({ deviceScaleFactor: 2 });

await page.goto(targetUrl, { waitUntil: 'networkidle' });
await page.emulateMedia({ media: 'print' });
await page.waitForTimeout(350);

const report = await page.evaluate((PX_PER_MM) => {
  const mm = (px) => +(px / PX_PER_MM).toFixed(1);
  const defects = [];
  const sheets = [...document.querySelectorAll('.sheet')];

  if (sheets.length === 0) {
    defects.push({
      severity: 'fatal',
      rule: 'structure',
      detail: 'No .sheet element found. A worksheet must wrap each physical page in <div class="sheet">.',
    });
  }

  // ---- unfilled template placeholders -----------------------------------
  const bodyText = document.body.innerText || '';
  const placeholders = [...bodyText.matchAll(/<<[^>]{0,120}>>/g)].map((m) => m[0]);
  if (placeholders.length) {
    defects.push({
      severity: 'fatal',
      rule: 'placeholder',
      detail: `${placeholders.length} unfilled template placeholder(s) reached the render.`,
      samples: [...new Set(placeholders)].slice(0, 8),
    });
  }

  // ---- per sheet ---------------------------------------------------------
  const sheetInfo = sheets.map((sheet, i) => {
    const cs = getComputedStyle(sheet);
    const rect = sheet.getBoundingClientRect();
    const padT = parseFloat(cs.paddingTop);
    const padR = parseFloat(cs.paddingRight);
    const padB = parseFloat(cs.paddingBottom);
    const padL = parseFloat(cs.paddingLeft);

    const contentBox = {
      top: rect.top + padT,
      right: rect.right - padR,
      bottom: rect.bottom - padB,
      left: rect.left + padL,
    };

    // Anything that reaches outside the printable content box is clipped.
    let worstOverflow = 0;
    const offenders = [];
    for (const el of sheet.querySelectorAll('*')) {
      const s = getComputedStyle(el);
      if (s.display === 'none' || s.visibility === 'hidden') continue;
      if (el.closest('.screen-only')) continue;
      const r = el.getBoundingClientRect();
      if (r.width === 0 && r.height === 0) continue;

      const over = Math.max(
        r.bottom - contentBox.bottom,
        r.right - contentBox.right,
        contentBox.top - r.top,
        contentBox.left - r.left,
      );
      if (over > 1) {
        worstOverflow = Math.max(worstOverflow, over);
        if (offenders.length < 6) {
          offenders.push({
            tag: el.tagName.toLowerCase(),
            cls: (el.className || '').toString().slice(0, 60),
            overflow_mm: mm(over),
            text: (el.innerText || '').trim().slice(0, 70),
          });
        }
      }
    }

    if (worstOverflow > 1) {
      defects.push({
        severity: 'fatal',
        rule: 'clipping',
        detail: `Sheet ${i + 1} content overflows its printable area by ${mm(worstOverflow)}mm. It will clip when printed.`,
        sheet: i + 1,
        offenders,
      });
    }

    return {
      index: i + 1,
      width_mm: mm(rect.width),
      height_mm: mm(rect.height),
      overflow_mm: mm(worstOverflow),
    };
  });

  // ---- every sheet states its true place in the worksheet -----------------
  // The template has the builder hand-type "sheet N of M" into every footer,
  // and a builder or reviewer that adds or splits a sheet updates some footers
  // and not others. A facilitator who reads "sheet 1 of 4" on a five-sheet
  // worksheet concludes a sheet is missing. The page must not misstate itself.
  // A footer carries exactly one such claim, so every claim found is checked.
  const misnumbered = [];
  sheets.forEach((sheet, i) => {
    const feet = [...sheet.querySelectorAll('.ws-foot')].filter((f) => !f.closest('.screen-only'));
    if (!feet.length) {
      misnumbered.push(`sheet ${i + 1}: has no .ws-foot footer at all`);
      return;
    }
    const claims = feet.flatMap((f) => [...(f.innerText || '').matchAll(/\bsheet\s+(\d+)\s+of\s+(\d+)\b/gi)]);
    if (!claims.length) {
      misnumbered.push(`sheet ${i + 1}: its .ws-foot does not say "sheet ${i + 1} of ${sheets.length}"`);
      return;
    }
    for (const [text, n, of] of claims) {
      if (+n !== i + 1 || +of !== sheets.length) {
        misnumbered.push(`sheet ${i + 1}: footer says "${text}", but this is sheet ${i + 1} of ${sheets.length}`);
      }
    }
  });
  if (misnumbered.length) {
    defects.push({
      severity: 'fatal',
      rule: 'sheet-numbering',
      detail: `${misnumbered.length} sheet(s) misstate their place in the worksheet. Every sheet's .ws-foot must read "sheet N of M", where N is that sheet's position and M is the worksheet's total number of sheets. Splitting or merging a sheet changes M on every footer.`,
      samples: misnumbered.slice(0, 8),
    });
  }

  // ---- the printed page must match the on-screen sheet -------------------
  // The commonest silent clipping failure is a worksheet whose screen sheet
  // says A3 portrait while its @page says A4. Catch it mechanically.
  const A_SERIES = {
    a0: [841, 1189], a1: [594, 841], a2: [420, 594],
    a3: [297, 420],  a4: [210, 297], a5: [148, 210],
  };
  let pageRuleText = null;
  for (const ss of document.styleSheets) {
    let rules;
    try { rules = ss.cssRules; } catch { continue; }
    if (!rules) continue;
    for (const r of rules) {
      if (r.constructor?.name === 'CSSPageRule' || /^@page/.test(r.cssText || '')) {
        pageRuleText = r.cssText;
      }
    }
  }

  if (!pageRuleText) {
    defects.push({
      severity: 'fatal',
      rule: 'no-page-rule',
      detail: 'The worksheet declares no @page rule, so printing silently falls back to the browser default (usually A4) regardless of the on-screen sheet size. Declare @page in the worksheet frontmatter.',
    });
  } else if (sheets.length) {
    const m = /size:\s*(a[0-5])\s*(portrait|landscape)?/i.exec(pageRuleText);
    if (m) {
      const [w, h] = A_SERIES[m[1].toLowerCase()];
      const landscape = (m[2] || 'portrait').toLowerCase() === 'landscape';
      const wantW = landscape ? h : w;
      const wantH = landscape ? w : h;
      const gotW = mm(sheets[0].getBoundingClientRect().width);
      const gotH = mm(sheets[0].getBoundingClientRect().height);
      if (Math.abs(gotW - wantW) > 2 || Math.abs(gotH - wantH) > 2) {
        defects.push({
          severity: 'fatal',
          rule: 'page-size-mismatch',
          detail: `@page declares ${m[1].toUpperCase()} ${landscape ? 'landscape' : 'portrait'} (${wantW}x${wantH}mm) but the sheet renders at ${gotW}x${gotH}mm. The print will clip. Check that the frontmatter uses the html:root selector — a plain :root override loses to the stylesheet on source order.`,
          declared: `${wantW}x${wantH}mm`,
          rendered: `${gotW}x${gotH}mm`,
        });
      }
    }
  }

  // ---- a table must actually span its block ------------------------------
  // Quarto's table filter re-parses raw HTML tables and can write a narrow
  // inline width onto them. Catch a table that is not filling its block.
  const narrowTables = [];
  for (const t of document.querySelectorAll('table.ws')) {
    const parent = t.parentElement;
    if (!parent) continue;
    const tw = t.getBoundingClientRect().width;
    const pw = parent.getBoundingClientRect().width;
    if (pw > 0 && tw / pw < 0.95) {
      narrowTables.push({
        width_pct: Math.round((tw / pw) * 100),
        inline_style: t.getAttribute('style') || '(none)',
        first_header: (t.querySelector('th')?.innerText || '').trim().slice(0, 40),
      });
    }
  }
  if (narrowTables.length) {
    defects.push({
      severity: 'fatal',
      rule: 'table-not-full-width',
      detail: `${narrowTables.length} table(s) do not fill their block, wasting sheet width. Give every <col> a PERCENT width and make them sum to 100 — Quarto drops mm/px col widths and derives the table width from the percentages it kept.`,
      offenders: narrowTables.slice(0, 5),
    });
  }

  // ---- writable fields have real physical height -------------------------
  const writableSel = '.f-text,.f-box,.f-owner,.f-sign,.f-currency,.f-computed,.f-date .seg,td.fill';
  let writableCount = 0;
  const tooSmall = [];
  for (const el of document.querySelectorAll(writableSel)) {
    const r = el.getBoundingClientRect();
    if (r.height === 0) continue;
    writableCount++;
    const floor = el.classList.contains('sm') ? 6 : 8;
    if (mm(r.height) < floor - 0.3) {
      if (tooSmall.length < 8) {
        tooSmall.push({ cls: (el.className || '').toString(), height_mm: mm(r.height), floor_mm: floor });
      }
    }
  }
  if (tooSmall.length) {
    defects.push({
      severity: 'fatal',
      rule: 'unwritable-field',
      detail: `${tooSmall.length} field(s) are too short to write in by hand.`,
      offenders: tooSmall,
    });
  }
  if (writableCount === 0) {
    defects.push({
      severity: 'fatal',
      rule: 'no-writable-fields',
      detail: 'The worksheet has no writable fields at all. It is a handout, not a worksheet.',
    });
  }

  // ---- house rule 1: a prior must not look like a blank ------------------
  const priors = [...document.querySelectorAll('.prior')];
  const fills = [...document.querySelectorAll('.fill')];
  const bg = (el) => getComputedStyle(el).backgroundColor;
  const indistinct = [];
  if (priors.length && fills.length) {
    const fillBg = bg(fills[0]);
    for (const p of priors) {
      if (bg(p) === fillBg) {
        indistinct.push((p.innerText || '').trim().slice(0, 60));
      }
    }
  }
  if (indistinct.length) {
    defects.push({
      severity: 'fatal',
      rule: 'prior-not-distinct',
      detail: `${indistinct.length} printed prior(s) render with the same background as a blank cell. House rule 1 requires them to be unmistakable.`,
      samples: indistinct.slice(0, 6),
    });
  }

  // ---- house rule 2: a hedged figure keeps its hedge ---------------------
  const hedgeProblems = [];
  for (const h of document.querySelectorAll('.prior--hedged')) {
    const fig = h.querySelector('.hedge-figure');
    const txt = h.querySelector('.hedge-text');
    if (!fig || !(fig.innerText || '').trim()) hedgeProblems.push('a .prior--hedged block has no .hedge-figure');
    if (!txt || (txt.innerText || '').trim().length < 20) {
      hedgeProblems.push(`hedged figure "${(fig?.innerText || '?').trim().slice(0, 50)}" carries no verbatim hedge`);
    }
  }
  if (hedgeProblems.length) {
    defects.push({
      severity: 'fatal',
      rule: 'hedge-stripped',
      detail: 'A hedged figure printed without the book\'s own hedge beside it.',
      samples: hedgeProblems.slice(0, 6),
    });
  }

  // ---- a bare number sitting loose in a table header ---------------------
  // Cheap heuristic for the laundering failure mode: a % or currency figure
  // printed in a column header, where layout alone reads it as a target.
  const suspectHeaders = [];
  for (const th of document.querySelectorAll('table.ws thead th')) {
    const t = (th.innerText || '').trim();
    if (/\d+\s?(%|percent)|[$£€]\s?\d/.test(t)) suspectHeaders.push(t.slice(0, 70));
  }
  if (suspectHeaders.length) {
    defects.push({
      severity: 'warn',
      rule: 'figure-in-header',
      detail: 'A numeric figure appears in a column header, where a blank cell beneath it reads as a target by layout alone. Confirm it is not a hedged figure.',
      samples: suspectHeaders,
    });
  }

  // ---- fill order is legible --------------------------------------------
  // Badges are checked for ascending order WITHIN each table or block, not
  // across the whole document. A multi-panel worksheet legitimately restarts
  // numbering per panel — Panel A 1..9, Panel B 1..7 — and flagging that as a
  // defect is a false positive that costs a review cycle.
  const badgeGroups = [];
  for (const g of document.querySelectorAll('table.ws, .ws-block')) {
    if (g.closest('table.ws') && g.matches('.ws-block')) continue;
    const ns = [...g.querySelectorAll('.fno')]
      .map((b) => parseInt(b.innerText.trim(), 10))
      .filter((n) => Number.isFinite(n));
    if (ns.length > 1) badgeGroups.push(ns);
  }

  const outOfOrder = [];
  for (const ns of badgeGroups) {
    for (let i = 1; i < ns.length; i++) {
      if (ns[i] < ns[i - 1]) { outOfOrder.push(`${ns[i - 1]} then ${ns[i]}`); break; }
    }
  }

  const numbered = [...document.querySelectorAll('.fno')]
    .map((b) => parseInt(b.innerText.trim(), 10))
    .filter((n) => Number.isFinite(n));

  if (outOfOrder.length) {
    defects.push({
      severity: 'warn',
      rule: 'fill-order',
      detail: `Field-number badges run backwards inside ${outOfOrder.length} block(s), so the fill order is not obvious from the page. Numbering that restarts per panel is fine; numbering that goes backwards within one block is not.`,
      samples: outOfOrder.slice(0, 5),
    });
  }

  return {
    sheets: sheetInfo,
    stats: {
      sheet_count: sheets.length,
      writable_fields: writableCount,
      printed_priors: priors.length,
      hedged_figures: document.querySelectorAll('.prior--hedged').length,
      numbered_fields: numbered.length,
    },
    defects,
  };
}, PX_PER_MM);

// ---- screenshots: one per sheet, at true size ------------------------------
const shots = [];
const sheetEls = await page.$$('.sheet');
for (let i = 0; i < sheetEls.length; i++) {
  const file = path.join(outArg, `sheet-${String(i + 1).padStart(2, '0')}.png`);
  await sheetEls[i].screenshot({ path: file });
  shots.push(file);
}
// A full-page shot makes any spill past a paper edge visible in one image.
const fullShot = path.join(outArg, 'full-page.png');
await page.screenshot({ path: fullShot, fullPage: true });
shots.push(fullShot);

report.screenshots = shots;
report.source = htmlArg;

await browser.close();

if (jsonOut) await writeFile(jsonOut, JSON.stringify(report, null, 2), 'utf8');

// ---- human-readable summary ------------------------------------------------
const fatal = report.defects.filter((d) => d.severity === 'fatal');
const warn = report.defects.filter((d) => d.severity === 'warn');

console.log(`\nLAYOUT REPORT — ${path.basename(htmlArg)}`);
console.log('='.repeat(64));
for (const s of report.sheets) {
  console.log(`  sheet ${s.index}: ${s.width_mm} x ${s.height_mm} mm` +
    (s.overflow_mm > 1 ? `   OVERFLOW ${s.overflow_mm}mm` : '   fits'));
}
console.log(`  writable fields: ${report.stats.writable_fields}` +
  ` | printed priors: ${report.stats.printed_priors}` +
  ` | hedged figures: ${report.stats.hedged_figures}`);
console.log(`  screenshots: ${shots.length} written to ${outArg}`);
console.log('-'.repeat(64));

for (const d of report.defects) {
  console.log(`  [${d.severity.toUpperCase()}] ${d.rule}: ${d.detail}`);
  for (const s of d.samples || []) console.log(`        - ${s}`);
  for (const o of d.offenders || []) console.log(`        - ${JSON.stringify(o)}`);
}

if (!report.defects.length) console.log('  no defects');
console.log('='.repeat(64));
console.log(fatal.length ? `FAIL — ${fatal.length} fatal, ${warn.length} warning` : `PASS — ${warn.length} warning(s)`);

process.exit(fatal.length ? 1 : 0);
