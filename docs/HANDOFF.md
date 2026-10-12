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
- Matching 96 code to 95G: the 95G repo has its IDA listing (lst/nhl95.bin.lst). Aligning the two listings by
  instruction shape (addresses masked) finds renamed and moved routines that find95.py (exact bytes) misses.

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
- code96_02 converted: the listing range as SNASM source, names from 95G where the routine matches (instruction
  alignment of the 96 and 95 IDA listings, then the 95G source for locals and comments; RAM names only where the
  address offset agrees with its neighbours or the code shows it). MATCH (segment and ROM).
- IDA's text is lossy after printz / printsmallz calls (the inline String): it shows ori.b lines with other bytes
  and even drops words. Those Strings were written from the ROM bytes; check every jsr to them in later segments.
- Code the listing leaves as dc.b (reached through tables or not referenced) stays as bytes, split at the labels the
  pointers or 95G byte matches show (assfaceoff ... puckfaceoff2, Endfaceoff, ReadJoySwapPad1-4; PrintSetupStrHi
  is 95G source, same bytes). Code bytes after sub_975A have no reference and no name.
- Kept as IDA names (no clear match): sub_AFDA, sub_B6A0, loc_AFD4, and outside loc_14D6E-loc_14D84 (doinput start
  button), loc_EE0E (95 jumps to lineinput there, but the 96 code differs), loc_1A62A, loc_16934, loc_C26C.
- RAM: about 80 IDA names renamed (ram96.asm, name_map.csv). crowdlevel and padiconchars2 share $FFFFB8B2 (the setup
  screen keeps pad icon chars in game RAM). 96 tmstruct is $FFFFC726 with size $39E (equals.inc tmsize is still 95's
  $366). The 96 cont1team ... cont4team are $FFFFC390-$FFFFC396.
- frames96: the goalie tables named from ClampTargetY's unreferenced SPA list and doinput_goaliedive (SPAgglover,
  SPAgglovel, SPAgstackr, SPAgstackl, SPAgstickr, SPAgstickl, SPAgdive).
- code96_03 converted: fighting, asstab and the penalty texts. MATCH (segment and ROM).
- 96 brings fighting back from 93: the fight routines take the 93G names (checkfight in code96_02, startfight
  for 93's checkfight .sf, SetInst, fightinput, ClearMessageLine, assfight, assfwatch). 96's player struct is not 95's
  past $60: SetInst reads the player number at $67 and the fight rating at $75 (95 / 93: $66 / $74), so the 95 names
  in equals.inc for $66-$76 (pnum, weight, ... checking, handed) are not used until 96's layout is known.
- About 11 KB of this segment is code the listing does not decode (the assignment routines behind asstab, assfight,
  assfwatch): bytes, with a label at every asstab entry (loc_<address> where nothing names the routine). Even with
  RAM addresses masked only a third of it matches 95: 96 rewrote the player AI. With the "do not disassemble" rule
  these segments stay mostly bytes; a re-analysed listing (IDA following asstab) would turn them into code.
- Penaltylist and PenShotPenalties are data: written from the bytes in the 95G layout; 95's local names where the
  penalty number and text are the same, .pXX for the rest (96 adds Boarding, Elbowing and High Sticking).
- Next: code96_04.
