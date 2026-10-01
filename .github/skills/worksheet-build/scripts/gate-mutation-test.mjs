#!/usr/bin/env node
/**
 * gate-mutation-test.mjs — attack the layout gate.
 *
 * A gate that passes everything is worse than no gate, because it manufactures
 * confidence. This takes the known-good specimen, breaks ONE house rule at a
 * time, and asserts the gate catches each break with the right rule name.
 *
 *   node gate-mutation-test.mjs
 *
 * Exit 0 = every mutation was caught. Exit 1 = the gate is blind to something.
 *
 * Run this after any change to styles/worksheet.css or check-layout.mjs.
 */

import { execFileSync } from 'node:child_process';
import { mkdtempSync, readFileSync, writeFileSync, rmSync, mkdirSync, copyFileSync } from 'node:fs';
import { tmpdir } from 'node:os';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const HERE = path.dirname(fileURLToPath(import.meta.url));
const ROOT = execFileSync('git', ['rev-parse', '--show-toplevel'], { encoding: 'utf8' }).trim();
const CHECKER = path.join(HERE, 'check-layout.mjs');
const RENDERED = path.join(ROOT, 'worksheets', '_output', 'specimen.html');

/**
 * Each mutation edits the RENDERED html (not the source), because the gate
 * measures the render. `expect` is the defect rule that must fire.
 */
const MUTATIONS = [
  {
    name: 'unfilled template placeholder survives to the render',
    expect: 'placeholder',
    apply: (h) => h.replace('>free text<', '>&lt;&lt;Field name&gt;&gt;<'),
  },
  {
    name: 'a printed prior is styled like a blank cell',
    expect: 'prior-not-distinct',
    // Neutralise the tint so prior and fill share a background.
    apply: (h) => h.replace('</head>',
      '<style>td.prior{background:#fff !important;border-left-color:#93a0ad !important}</style></head>'),
  },
  {
    name: 'a hedged figure is stripped of the book\'s own hedge',
    expect: 'hedge-stripped',
    apply: (h) => h.replace(/<span class="hedge-text">[\s\S]*?<\/span>/, '<span class="hedge-text"></span>'),
  },
  {
    name: 'content overflows the printable area (too many rows for the sheet)',
    expect: 'clipping',
    // Realistic overflow: a builder puts too many rows on one sheet. Padding
    // alone is absorbed by the flex column, so duplicate real content instead.
    apply: (h) => {
      // Quarto adds class="odd"/"even" to rows, so match loosely.
      const row = h.match(/<tr[^>]*>\s*<td class="ws-num">[\s\S]*?<\/tr>/);
      if (!row) return h;
      return h.replace(row[0], row[0].repeat(40));
    },
  },
  {
    name: '@page disagrees with the rendered sheet size',
    expect: 'page-size-mismatch',
    apply: (h) => h.replace(/@page\s*\{[^}]*\}/, '@page { size: A5 portrait; margin: 8mm; }'),
  },
  {
    name: 'no @page rule at all, so print silently falls back to A4',
    expect: 'no-page-rule',
    apply: (h) => h.replace(/@page\s*\{[^}]*\}/g, ''),
  },
  {
    name: 'a table does not fill its block (the mm-colgroup trap)',
    expect: 'table-not-full-width',
    apply: (h) => h.replace('</head>',
      '<style>table.ws{width:55% !important}</style></head>'),
  },
  {
    name: 'a writable field is too short to write in',
    expect: 'unwritable-field',
    apply: (h) => h.replace('</head>',
      '<style>.f-text{height:3mm !important}</style></head>'),
  },
  {
    name: 'a numeric figure sits in a column header above blank cells',
    expect: 'figure-in-header',
    apply: (h) => h.replace('>Your answer<', '>Target: 85%<'),
  },
];

function runGate(htmlPath, outDir) {
  try {
    const out = execFileSync('node', [CHECKER, htmlPath, outDir, '--json', path.join(outDir, 'r.json')],
      { encoding: 'utf8', stdio: ['ignore', 'pipe', 'pipe'] });
    return { exit: 0, out };
  } catch (e) {
    return { exit: e.status ?? 1, out: `${e.stdout || ''}${e.stderr || ''}` };
  }
}

function rulesFrom(outDir) {
  try {
    return JSON.parse(readFileSync(path.join(outDir, 'r.json'), 'utf8')).defects.map((d) => d.rule);
  } catch { return []; }
}

const work = mkdtempSync(path.join(tmpdir(), 'ws-mutate-'));
const base = readFileSync(RENDERED, 'utf8');

console.log('\nGATE MUTATION TEST');
console.log('='.repeat(72));

// Control: the unmutated specimen must PASS, or every result below is noise.
const ctlDir = path.join(work, 'control');
mkdirSync(ctlDir, { recursive: true });
const ctlHtml = path.join(ctlDir, 'specimen.html');
copyFileSync(RENDERED, ctlHtml);
const ctl = runGate(ctlHtml, ctlDir);
const ctlRules = rulesFrom(ctlDir).filter((r) => r !== 'figure-in-header');

if (ctl.exit !== 0 || ctlRules.length) {
  console.log(`  CONTROL FAILED — the unmutated specimen does not pass (${ctlRules.join(', ') || 'exit ' + ctl.exit}).`);
  console.log('  Every mutation result below would be meaningless. Fix the specimen first.');
  console.log(ctl.out);
  process.exit(1);
}
console.log('  control: unmutated specimen PASSES — mutations are measurable\n');

let failed = 0;
for (const [i, m] of MUTATIONS.entries()) {
  const dir = path.join(work, `m${i}`);
  mkdirSync(dir, { recursive: true });
  const f = path.join(dir, 'specimen.html');
  const mutated = m.apply(base);

  if (mutated === base) {
    console.log(`  [SKIP] ${m.name}\n         mutation did not change the html — the test itself is stale`);
    failed++;
    continue;
  }

  writeFileSync(f, mutated, 'utf8');
  runGate(f, dir);
  const rules = rulesFrom(dir);
  const caught = rules.includes(m.expect);

  console.log(`  [${caught ? 'CAUGHT' : 'MISSED'}] ${m.name}`);
  console.log(`           expected: ${m.expect}`);
  console.log(`           fired:    ${rules.length ? rules.join(', ') : '(nothing)'}`);
  if (!caught) failed++;
}

rmSync(work, { recursive: true, force: true });

console.log('='.repeat(72));
if (failed) {
  console.log(`FAIL — the gate is blind to ${failed} of ${MUTATIONS.length} deliberate defects.`);
  process.exit(1);
}
console.log(`PASS — all ${MUTATIONS.length} deliberate defects were caught.`);
