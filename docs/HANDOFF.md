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
- `tools/extractSegments96.js [rom]`: cuts the ROM into `Extracted/segments/<name>.bin` from `tools/segmap96.json`,
  and every entry of its `assets` list (path, start, end) into `Extracted/<path>` (the team palettes so far).
  The marker records the map's SHA-1 too, so a changed segment map extracts again.
- `tools/make_segmap96.py [--lst] [--rom] [--code-cap] [--data-cap] [--out]`: made the first split. Do not
  rerun it onto `tools/segmap96.json` once segments are converted (`npm run segmap` writes to `output/`).
  When a segment's confirmed range differs, edit its entry in `tools/segmap96.json` and the neighbour's.
- `tools/find95.py <segment | start-end> [--len N] [--min-distinct N] [--refresh]`: 95G labels found in a 96 range
  by their first bytes (95G ROM and name map downloaded from GitHub into `output/ref95/`). Log in `output/`.
- `tools/fixopcodes.js`, `tools/verifyRom.js`, `tools/verifySegment.js`: as in 95G.

## Naming and comment rules
In SEGMENT_AGENT.md, "Current rules". History (renames, IDA names) lives in `docs/name_map.csv`
(address,name,ida_name,old_name,module).

## Conventions
One segment per commit, MATCH before every push; `git pull --rebase origin main` then push to main.
No force-push. Contributors: fork, branch, PR (START_HERE.md section 0).

## Setup friction fixed
- The main96 test needed the 95G ROM to find matching routines; tools/find95.py fetches it from the public repo.
- Linux: wine was not installed in a fresh cloud container (`apt-get install wine wine32` after `dpkg --add-architecture i386`).
- Linux: `buildseg.bat` stopped at `cd /d ... || exit /b 1` (wine 9 cmd takes the `||` branch even when cd works), so
  every segment build wrote no log; it now uses `if errorlevel 1 exit /b 1`.

## Current state / Next
- Bootstrap: 33 incbin segments, full ROM and every segment MATCH.
- main96 converted (test of the docs): 95G names for SegaInit, CHECK_VDP, RegionPrint, RegionFont, RegionOK, VBjsr, Begin, IRQ7, ValidationRoutine; the 96 region lock (hex digit country code) named from what it does. MATCH (segment and ROM).
- code96_01 ($000776-$0096E7) turned out to be data only, in the 95G order of teamdata95, credits95 and frames95, so it
  is split into three segments: teamdata96 (VBjsr in front of TeamList, the team blocks, playoffseats), credits96 (Credits,
  CreditsList) and frames96 (SPAlist and the animation tables). All three MATCH (whole range) and the ROM MATCHes.
  Source written from the ROM bytes with the 95G macros (src/macros/genesis.mac copied from 95G: String, Player).
- 96 team data: no All-Star teams (TeamList slots 26 and 27 point to Boston and Montreal), and every block ends with
  .pos, one nibble per player: the player's slot in .ls order (0 G ... 5 RW), $F padded.
- 96 rebuilt the animation tables: almost none match a 95 table by shape, and find95 finds none of the 95 animation
  code. The tables are named SPAxxxx by their SPA value (the number the code moves into SPA(a3), d1 for SetSPA,
  sub_1A614 in 96) until the code using them is converted; then rename them (name_map.csv). The 96 animation
  routine is sub_16654 (95 updateanim): it only uses attribute bit 0 (loop) and stops a direction at its first
  negative time; pairs after it are marked "past the end" (the code may still index them directly).
- RAM: dword_FFD244 is now vbint.
- Next: code96_02.
