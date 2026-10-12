#!/usr/bin/env python3
"""Write tools/segmap96.json, the first split of the NHL 96 ROM into segments.

Usage: python3 tools/make_segmap96.py [--lst lst/nhl96.bin.lst] [--rom lst/nhl96.bin]
       [--code-cap 0x2000] [--data-cap 0x20000] [--out tools/segmap96.json]

It reads the IDA listing, takes every label whose name ends in its address (sub_, loc_, unk_ ...),
marks each one code or data from its first line, and cuts the ROM:
  - at every change between a code run and a data run of at least 0x800 bytes,
  - inside a code run at the first sub_ label once the segment reaches --code-cap bytes
    (at any label once it reaches twice the cap of its run),
  - inside a data run at the first label once the segment reaches --data-cap bytes.
The $FF fill at the end of the ROM is not a segment; nhl96.asm fills it with dcb.b.
main96 (vectors, header, startup, Begin) ends where VBLANK starts (the long at vector $78).
It only proposes the split. Segment agents confirm each range from the listing as they convert it.
"""
import argparse, json, re, struct

ap = argparse.ArgumentParser()
ap.add_argument('--lst', default='lst/nhl96.bin.lst')
ap.add_argument('--rom', default='lst/nhl96.bin')
ap.add_argument('--code-cap', type=lambda s: int(s, 0), default=0x2000)
ap.add_argument('--data-cap', type=lambda s: int(s, 0), default=0x20000)
ap.add_argument('--out', default='tools/segmap96.json')
a = ap.parse_args()

rom = open(a.rom, 'rb').read()
fill = len(rom)
while rom[fill - 1] == 0xFF: fill -= 1

labs, pending = [], None
for line in open(a.lst, encoding='latin-1'):
    m = re.match(r'^(\w+):\s*(.*)', line)
    body = line.strip()
    if m:
        ad = re.search(r'_([0-9A-F]{1,6})$', m[1])
        pending = (int(ad[1], 16), m[1]) if ad else None
        body = m[2].strip()
    if pending and body and not body.startswith(';'):
        labs.append((pending[0], pending[1], 'data' if body.startswith('dc.') else 'code'))
        pending = None
labs = sorted(set(l for l in labs if l[0] < fill))

runs = []
for ad, n, k in labs:
    if not runs or runs[-1][1] != k: runs.append([ad, k])
big = set()
for i, (ad, k) in enumerate(runs):
    end = runs[i + 1][0] if i + 1 < len(runs) else fill
    if end - ad >= 0x800: big.add(ad)

vblank = struct.unpack('>I', rom[0x78:0x7C])[0]
cuts = [(0, 'code'), (vblank, 'code')]
kind = 'code'
for ad, n, k in labs:
    if ad <= vblank: continue
    s = cuts[-1][0]
    if ad in big and k != kind:
        kind = k; cuts.append((ad, k)); continue
    cap = a.code_cap if kind == 'code' else a.data_cap
    if ad - s >= 2 * cap or (k == kind and ad - s >= cap and (kind == 'data' or n.startswith('sub_'))):
        cuts.append((ad, kind))
segs, nc, nd = [], 0, 0
for i, (s, k) in enumerate(cuts):
    e = cuts[i + 1][0] if i + 1 < len(cuts) else fill
    if i == 0: name = 'main96'
    elif k == 'code': nc += 1; name = f'code96_{nc:02d}'
    else: nd += 1; name = f'data96_{nd:02d}'
    segs.append({'name': name, 'kind': k, 'start': s, 'end': e - 1})
json.dump({'rom': a.rom, 'fill_start': fill, 'segments': segs}, open(a.out, 'w'), indent=1)
print(f'{len(segs)} segments, fill from 0x{fill:06X}; wrote {a.out}')
