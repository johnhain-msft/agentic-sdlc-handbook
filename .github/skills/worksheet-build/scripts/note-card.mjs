#!/usr/bin/env node
/**
 * note-card.mjs — render a short message as a PNG card for an attachment slot.
 *
 *   node note-card.mjs <out.png> <#background> <message...>
 *
 * capture-for-review.sh uses it for a slot with no sheet to show and for a
 * capture that failed. The card used to be rendered by an inline `node -e`
 * from the repository root, where `playwright` does not resolve, so every
 * card silently fell back to a 1x1 PNG — and one 1x1 attachment makes the
 * model drop every image.
 *
 * Exit 0 = card written. Exit 1 = could not render; the caller falls back.
 */

import { createRequire } from 'node:module';
import { join } from 'node:path';

// capture-for-review.sh runs a COPY of this script from outside the working
// tree, because it checks out the pull request's tree first, which may predate
// this file. PLAYWRIGHT_FROM then names the skill directory, whose untracked
// node_modules survives that checkout. Run in place, it resolves from here.
const requireFrom = createRequire(process.env.PLAYWRIGHT_FROM
  ? join(process.env.PLAYWRIGHT_FROM, 'package.json')
  : import.meta.url);
const { chromium } = requireFrom('playwright');

const [, , out, bgArg, ...words] = process.argv;
const message = words.join(' ').trim();

if (!out || !message) {
  console.error('usage: note-card.mjs <out.png> <#background> <message...>');
  process.exit(2);
}

const bg = /^#[0-9a-f]{3,8}$/i.test(bgArg || '') ? bgArg : '#334155';
const text = message.replace(/[<>&]/g, '');

let browser;
for (const opts of [{}, { channel: 'chrome' }, { channel: 'msedge' }]) {
  try {
    browser = await chromium.launch(opts);
    break;
  } catch {
    // try the next browser
  }
}
if (!browser) {
  console.error('note-card: could not launch any Chromium');
  process.exit(1);
}

try {
  const page = await browser.newPage({ viewport: { width: 1100, height: 320 } });
  await page.setContent(`<body style="margin:0;min-height:320px;box-sizing:border-box;padding:44px;
      background:${bg};color:#fff;font:22px/1.5 system-ui,sans-serif">
    <div style="font-size:14px;letter-spacing:.2em;opacity:.8">WORKSHEET CAPTURE</div>
    <div style="font-size:26px;margin-top:16px">${text}</div>
  </body>`);
  await page.screenshot({ path: out, fullPage: true });
} catch (err) {
  console.error(`note-card: ${String(err.message).split('\n')[0]}`);
  process.exitCode = 1;
} finally {
  await browser.close();
}
