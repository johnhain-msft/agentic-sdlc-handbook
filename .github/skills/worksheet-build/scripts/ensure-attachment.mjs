#!/usr/bin/env node
/**
 * ensure-attachment.mjs — make sure every attachment slot holds an image the
 * model will accept, so one bad slot cannot blind the agent to the good ones.
 *
 *   node ensure-attachment.mjs <png> [<png> ...]
 *
 * A Copilot request carrying one unusable image is rejected as a whole, and
 * the CLI then drops EVERY image and carries on blind. That is how a two-sheet
 * worksheet's review saw nothing: its empty third slot held a 1x1 PNG whose
 * image-data checksum was wrong and whose pixels were short.
 *
 * A file is kept only if it is a PNG that decodes: the signature, every
 * chunk's CRC, an IHDR, image data that inflates to exactly the length the
 * IHDR implies, an IEND, and at least 200x100 pixels. Anything else — missing,
 * corrupt, short, tiny — is replaced with a plain 1100x320 image. A kept image
 * is left byte for byte.
 *
 * Prints the name of each replaced file on stdout, so the caller can record it
 * where the agent will read it, and a warning on stderr. Always exits 0: a
 * replaced slot is reported, never fatal.
 *
 *   node ensure-attachment.mjs --check <png> [<png> ...]
 *
 * Checks without writing anything: names each unusable file on stderr and
 * exits 1 if there is one. For tests, which must not repair the evidence.
 */

import { readFileSync, writeFileSync, mkdirSync } from 'node:fs';
import { basename, dirname } from 'node:path';
import { createInflate, deflateSync } from 'node:zlib';

const CHECK_ONLY = process.argv.includes('--check');

const MIN_W = 200;
const MIN_H = 100;
const SIGNATURE = Buffer.from([0x89, 0x50, 0x4e, 0x47, 0x0d, 0x0a, 0x1a, 0x0a]);
const CHANNELS = { 0: 1, 2: 3, 3: 1, 4: 2, 6: 4 };
const ADAM7 = [[0, 0, 8, 8], [4, 0, 8, 8], [0, 4, 4, 8], [2, 0, 4, 4], [0, 2, 2, 4], [1, 0, 2, 2], [0, 1, 1, 2]];

const CRC_TABLE = Array.from({ length: 256 }, (_, n) => {
  let c = n;
  for (let k = 0; k < 8; k++) c = c & 1 ? 0xedb88320 ^ (c >>> 1) : c >>> 1;
  return c >>> 0;
});
function crc32(buf) {
  let c = 0xffffffff;
  for (const byte of buf) c = CRC_TABLE[(c ^ byte) & 0xff] ^ (c >>> 8);
  return (c ^ 0xffffffff) >>> 0;
}

/** Bytes of filtered image data a decoder expects, from the IHDR. */
function expectedLength({ w, h, depth, colour, interlace }) {
  const bits = depth * CHANNELS[colour];
  const rows = (pw, ph) => (pw && ph ? ph * (1 + Math.ceil((pw * bits) / 8)) : 0);
  if (!interlace) return rows(w, h);
  return ADAM7.reduce((sum, [x0, y0, dx, dy]) =>
    sum + rows(Math.max(0, Math.ceil((w - x0) / dx)), Math.max(0, Math.ceil((h - y0) / dy))), 0);
}

/** Streams the data through inflate, keeping only a count: -1 if it fails. */
function inflatedLength(data) {
  return new Promise((resolve) => {
    const z = createInflate();
    let n = 0;
    z.on('data', (chunk) => { n += chunk.length; });
    z.on('end', () => resolve(n));
    z.on('error', () => resolve(-1));
    z.end(data);
  });
}

/** Why a buffer is not a usable PNG, or null if it is one. */
async function problem(buf) {
  if (buf.length < 8 || !buf.subarray(0, 8).equals(SIGNATURE)) return 'not a PNG';
  let off = 8;
  let ihdr = null;
  const data = [];
  while (off + 12 <= buf.length) {
    const len = buf.readUInt32BE(off);
    if (off + 12 + len > buf.length) return 'truncated';
    const type = buf.toString('latin1', off + 4, off + 8);
    if (crc32(buf.subarray(off + 4, off + 8 + len)) !== buf.readUInt32BE(off + 8 + len)) {
      return `a corrupt ${type} chunk`;
    }
    if (type === 'IHDR' && len >= 13) {
      ihdr = {
        w: buf.readUInt32BE(off + 8), h: buf.readUInt32BE(off + 12),
        depth: buf[off + 16], colour: buf[off + 17], interlace: buf[off + 20],
      };
    }
    if (type === 'IDAT') data.push(buf.subarray(off + 8, off + 8 + len));
    if (type === 'IEND') {
      if (!ihdr || !CHANNELS[ihdr.colour]) return 'no usable IHDR';
      if (ihdr.w < MIN_W || ihdr.h < MIN_H) return `${ihdr.w}x${ihdr.h}, below ${MIN_W}x${MIN_H}`;
      const want = expectedLength(ihdr);
      const got = await inflatedLength(Buffer.concat(data));
      if (got !== want) return got < 0 ? 'image data that does not inflate' : `image data of ${got} bytes, not ${want}`;
      return null;
    }
    off += 12 + len;
  }
  return 'no IEND';
}

function chunk(type, data) {
  const head = Buffer.alloc(8);
  head.writeUInt32BE(data.length, 0);
  head.write(type, 4, 'latin1');
  const crc = Buffer.alloc(4);
  crc.writeUInt32BE(crc32(Buffer.concat([head.subarray(4), data])), 0);
  return Buffer.concat([head, data, crc]);
}

/** A plain, valid 8-bit RGB PNG. */
function plainPng(w = 1100, h = 320, [r, g, b] = [51, 65, 85]) {
  const row = Buffer.alloc(1 + w * 3);
  for (let x = 0; x < w; x++) row.set([r, g, b], 1 + x * 3);
  const ihdr = Buffer.alloc(13);
  ihdr.writeUInt32BE(w, 0);
  ihdr.writeUInt32BE(h, 4);
  ihdr[8] = 8;
  ihdr[9] = 2;
  return Buffer.concat([
    SIGNATURE,
    chunk('IHDR', ihdr),
    chunk('IDAT', deflateSync(Buffer.concat(Array(h).fill(row)))),
    chunk('IEND', Buffer.alloc(0)),
  ]);
}

for (const file of process.argv.slice(2).filter((a) => a !== '--check')) {
  try {
    let why;
    try {
      why = await problem(readFileSync(file));
    } catch {
      why = 'missing';
    }
    if (!why) continue;
    if (CHECK_ONLY) {
      console.error(`${file}: ${why}`);
      process.exitCode = 1;
      continue;
    }
    mkdirSync(dirname(file), { recursive: true });
    writeFileSync(file, plainPng());
    console.log(basename(file));
    console.error(`::warning title=Attachment replaced::${file} was ${why}; replaced with a plain ` +
      `1100x320 image so it cannot make the model drop the other attachments.`);
  } catch (err) {
    console.error(`::error title=Attachment unusable::${file} could not be checked or replaced: ` +
      `${String(err.message).split('\n')[0]}`);
  }
}
