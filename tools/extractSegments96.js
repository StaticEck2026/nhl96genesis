// extractSegments96.js: cut lst/nhl96.bin into the segment slices the incbin segments include.
// Usage: node tools/extractSegments96.js [lst/nhl96.bin]
// Reads tools/segmap96.json and writes Extracted/segments/<name>.bin for every segment, then
// Extracted/.extract-complete.json last (ROM SHA-1, extractor SHA-1, every file and its size).
// tools/prebuild.js runs it automatically when Extracted/ is missing or incomplete.
// Refuses any ROM but the NHL 96 retail ROM.
const fs = require('fs');
const path = require('path');
const crypto = require('crypto');

const ROOT = path.join(__dirname, '..');
const ROMS = { '7204633fbb9966ac637e7966d02ba15c5acdee6b': 'NHL 96 retail (1995.JUL, GM T-172036-00)' };
const romPath = path.resolve(ROOT, process.argv[2] || 'lst/nhl96.bin');
const sha1Of = (b) => crypto.createHash('sha1').update(b).digest('hex');

const rom = fs.readFileSync(romPath);
const romSha1 = sha1Of(rom);
if (!ROMS[romSha1]) {
    console.error(`Unknown ROM ${romPath} (SHA-1 ${romSha1}). Supported: ${Object.entries(ROMS).map(([k, v]) => `${v} ${k}`).join('; ')}`);
    process.exit(1);
}
console.log(`ROM: ${ROMS[romSha1]}`);
const map = JSON.parse(fs.readFileSync(path.join(ROOT, 'tools', 'segmap96.json'), 'utf8'));
const out = path.join(ROOT, 'Extracted', 'segments');
fs.mkdirSync(out, { recursive: true });
const files = [];
for (const s of map.segments) {
    const data = rom.subarray(s.start, s.end + 1);
    const rel = `segments/${s.name}.bin`;
    fs.writeFileSync(path.join(ROOT, 'Extracted', rel), data);
    files.push({ path: rel, size: data.length });
}
const marker = { romSha1, extractorSha1: sha1Of(fs.readFileSync(__filename)), files };
fs.writeFileSync(path.join(ROOT, 'Extracted', '.extract-complete.json'), JSON.stringify(marker, null, 1));
console.log(`Extracted ${files.length} slices to Extracted/segments/`);
