# HANDOFF (NHL96)

## Purpose
A bit-perfect SNASM68k disassembly of NHL 96 (Sega Genesis) that reads like original source, named after
the NHL95Genesis lineage. Code and data never change: every build must MATCH the retail ROM.

## Setup
See START_HERE.md. ROM `lst/nhl96.bin` (SHA-1 7204633fbb9966ac637e7966d02ba15c5acdee6b, 2 MB) and the
IDA listing `lst/nhl96.bin.lst` are in the repo for now (the listing is about 53 MB; GitHub warns above
50 MB). If they are removed later, put them back at exactly those paths; the prebuild message names
the path, SHA-1 and size.
Windows: `npm run build:retail`, `npm run seg:<name>`. Linux (wine): `tools/build_rom.sh`,
`tools/verify_segment.sh <name>`, `tools/verify_all.sh`. All logs go to `output/`.

## Tools
- `tools/prebuild.js [retail]`: ROM check, then runs the extractor when `Extracted/` is missing or stale
  (marker `Extracted/.extract-complete.json`).
- `tools/extractSegments96.js [rom]`: cuts the ROM into `Extracted/segments/<name>.bin` from `tools/segmap96.json`.
- `tools/make_segmap96.py [--lst] [--rom] [--code-cap] [--data-cap] [--out]`: made the first split. Do not
  rerun it onto `tools/segmap96.json` once segments are converted (`npm run segmap` writes to `output/`).
  When a segment's confirmed range differs, edit its entry in `tools/segmap96.json` and the neighbour's.
- `tools/fixopcodes.js`, `tools/verifyRom.js`, `tools/verifySegment.js`: as in 95G.

## Naming and comment rules
In SEGMENT_AGENT.md, "Current rules". History (renames, IDA names) lives in `docs/name_map.csv`
(address,name,ida_name,old_name,module).

## Conventions
One segment per commit, MATCH before every push; `git pull --rebase origin main` then push to main.
No force-push. Contributors: fork, branch, PR (START_HERE.md section 0).

## Current state / Next
- Bootstrap: 33 incbin segments, full ROM and every segment MATCH.
- main96 converted (test of the docs): 95G names for SegaInit, CHECK_VDP, RegionPrint, RegionFont, RegionOK, VBjsr, Begin, IRQ7, ValidationRoutine; the 96 region lock (hex digit country code) named from what it does. MATCH (segment and ROM).
- Next: code96_01.
