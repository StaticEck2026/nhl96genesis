// extractSegments96.js: cut lst/nhl96.bin into Extracted/segments/<name>.bin from tools/segmap96.json.
// The build no longer runs this. tools/prebuild.js runs tools/extractAssets96.js, and no source
// incbins a segment slice. The map is still what find95.py and the docs use.
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
const mapText = fs.readFileSync(path.join(ROOT, 'tools', 'segmap96.json'));
const map = JSON.parse(mapText);
const out = path.join(ROOT, 'Extracted', 'segments');
fs.mkdirSync(out, { recursive: true });
const files = [];
for (const s of map.segments) {
    const data = rom.subarray(s.start, s.end + 1);
    const rel = `segments/${s.name}.bin`;
    fs.writeFileSync(path.join(ROOT, 'Extracted', rel), data);
    files.push({ path: rel, size: data.length });
}
for (const a of map.assets || []) {
    const data = rom.subarray(a.start, a.end + 1);
    const p = path.join(ROOT, 'Extracted', a.path);
    fs.mkdirSync(path.dirname(p), { recursive: true });
    fs.writeFileSync(p, data);
    files.push({ path: a.path, size: data.length });
}
const marker = { romSha1, extractorSha1: sha1Of(fs.readFileSync(__filename)), mapSha1: sha1Of(mapText), files };
fs.writeFileSync(path.join(ROOT, 'Extracted', '.extract-complete.json'), JSON.stringify(marker, null, 1));
console.log(`Extracted ${map.segments.length} slices to Extracted/segments/ and ${(map.assets || []).length} assets`);
