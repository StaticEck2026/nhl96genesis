#!/usr/bin/env python3
"""find95.py: find NHL 95 Genesis labels in an NHL 96 range by their bytes, to pick 95G names.

Usage: python3 tools/find95.py <segment | start-end> [--len 20] [--min-distinct 5] [--refresh]
  python3 tools/find95.py code96_01            a segment from tools/segmap96.json
  python3 tools/find95.py 0x200-0x775          an address range (hex)
It downloads the 95G ROM and docs/name_map.csv from the public repo
https://github.com/abdulahmad/NHL95Genesis (raw.githubusercontent.com) into output/ref95/ once
(--refresh downloads again). For every 95G label it takes the first --len bytes at its 95 address
and searches lst/nhl96.bin; a hit that is unique in the 96 ROM and inside the range is printed with
its 96 address, the 95G name and file. A hit is a hint: compare the bodies before you take a name.
Output goes to the screen and to output/find95_<range>.log.
"""
import argparse, csv, io, json, os, sys, urllib.request

RAW = 'https://raw.githubusercontent.com/abdulahmad/NHL95Genesis/main/'
ROOT = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..')
ap = argparse.ArgumentParser()
ap.add_argument('range')
ap.add_argument('--len', type=int, default=20)
ap.add_argument('--min-distinct', type=int, default=5, help='skip patterns with fewer distinct bytes (fills, zero runs)')
ap.add_argument('--refresh', action='store_true')
a = ap.parse_args()

ref = os.path.join(ROOT, 'output', 'ref95'); os.makedirs(ref, exist_ok=True)
def get(path):
    local = os.path.join(ref, os.path.basename(path))
    if a.refresh or not os.path.exists(local):
        print(f'downloading {RAW + path}', file=sys.stderr)
        urllib.request.urlretrieve(RAW + path, local)
    return local
r95 = open(get('lst/nhl95.bin'), 'rb').read()
names = list(csv.DictReader(open(get('docs/name_map.csv'), encoding='utf-8')))
r96 = open(os.path.join(ROOT, 'lst', 'nhl96.bin'), 'rb').read()

if '-' in a.range:
    lo, hi = (int(x, 16) for x in a.range.split('-'))
else:
    segs = json.load(open(os.path.join(ROOT, 'tools', 'segmap96.json')))['segments']
    s = next((s for s in segs if s['name'] == a.range), None)
    if not s: sys.exit(f'no segment {a.range} in tools/segmap96.json')
    lo, hi = s['start'], s['end']

out, seen = [], set()
for r in names:
    try: ad = int(r['address'].lstrip('$'), 16)
    except ValueError: continue
    if (ad, r['name']) in seen: continue
    seen.add((ad, r['name']))
    pat = r95[ad:ad + a.len]
    if len(pat) < a.len or len(set(pat)) < a.min_distinct: continue
    i = r96.find(pat)
    if i == -1 or r96.find(pat, i + 1) != -1 or not lo <= i <= hi: continue
    out.append((i, r['name'], r['module'], ad))
out.sort()
lines = [f'${i:06X}  {n:32} 95G {m} (${ad:06X})' for i, n, m, ad in out]
lines.append(f'{len(out)} 95G labels found in ${lo:06X}-${hi:06X}')
print('\n'.join(lines))
open(os.path.join(ROOT, 'output', f'find95_{a.range}.log'), 'w').write('\n'.join(lines) + '\n')
