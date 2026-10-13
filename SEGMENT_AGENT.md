# NHL 96 segment agent

This file is the queue. Do not rewrite it as a whole file. Edit it in place.

## Current rules (Oct 2026; these override older notes below)

Naming lineage is 92G -> 93G -> 94G -> 95G -> 96G.
- A routine, variable or table that matches its parent takes the parent's name. 92G is the naming root. A 96 routine that matches 95G takes the 95G name.
- Clash rule: if one name would mean two different things, the earliest game's meaning keeps the name and the later one gets a new name.
- Fix the earliest repo first, then propagate the change down the lineage (92 -> 93 -> 94 -> 95 -> 96).
- Team names: 93 uses the city names of its own data; 94, 95 and 96 use NYIslanders / NYRangers (short NYI / NYR).

Source style:
- No rename-history, provenance or origin-tag comments ("was X", "from 95G", "renamed", `IDA: loc_...`). That history lives in `docs/name_map.csv` only.
- No hardcoded ROM addresses in comments, and no hand-kept derived counts (sizes, numbers of entries, totals) that the code or the assembler can compute. The include comments in `src/nhl96.asm` (the ROM map) are the one place for addresses.
- Mark "New in 96:" only for major features (new modes, screens, systems), not for every changed routine.
- First-pass naming: a label with no 95G (or 94G / 93G / 92G) match is named from what the code clearly does when that is obvious; never guess a name.
- Local labels in 92 style: `.loop`, `.next`, `.done`, `.exit`, and plain numbers (`.0`, `.1`) for trivial jumps. A routine that matches 95G keeps its 95G locals.
- File headers are short plain-English stories of what the file does, modelled on the 95G file headers (`src/main95.asm`, `src/hockey95.asm`).

Layout: follow 95G (https://github.com/abdulahmad/NHL95Genesis). `src/nhl96.asm` includes every segment in ROM order. Segment build stubs go in `src/stubinc`, tools in `tools/`. The build runs a prebuild ROM check (`tools/prebuild.js`) that names the path, file name, SHA-1 and size of the ROM it needs and extracts the segment slices automatically. Segment files may be renamed for their subsystem once their content is known (`code96_06` -> `display96`): rename the file, its stub, its include line, its `seg:` script and its ROM map row in the same commit.

Work in small steps: every change is built and checked byte for byte against the reference ROM, then committed and pushed to main (no force push; outside contributors push to their fork and open a PR, see START_HERE.md). Keep `docs/HANDOFF.md` current after each push.

## Current segment

data96_02. <- CURRENT

## Sources

- Listing: `lst/nhl96.bin.lst`, an IDA LST in ASM68K / MRI mode. It has no address column; a `loc_`, `sub_`, `unk_`, `byte_`, `word_`, `off_` name is the address. Do not disassemble `lst/nhl96.bin` and do not write a disassembler.
- Reference ROM: `lst/nhl96.bin` (2 MB, SHA-1 `7204633fbb9966ac637e7966d02ba15c5acdee6b`). Bytes and branch displacements come from it.
- Every segment starts as an `incbin ..\Extracted\segments\<name>.bin` of its range, cut from the ROM by `tools/extractSegments96.js` (run automatically by the prebuild check).
- Names: 95G `docs/name_map.csv` (address, name, IDA name, old name, module) and the 95G source. 96 reordered the code a lot against 95, so match by body, never by address. `python3 tools/find95.py <segment>` (or `<start>-<end>` in hex; options `--len`, `--min-distinct`, `--refresh`) lists the 95G labels whose first bytes are found in the range, with the 96 address, the 95G name and file. It downloads the 95G ROM and name map from GitHub into `output/ref95/` once. A hit is a hint; compare the bodies. Routines whose bytes changed (moved data, other RAM addresses) are not found by it.

## Segment files and stubs

- A segment file has no `org`. Its stub `src/stubinc/<name>_stub.asm` carries the `org`, includes `stubinc\ports.inc`, `stubinc\equals.inc`, `ram96.asm`, `externs96.asm`, then outside equates, then the segment file. Paths are relative to `src/`. Add `include macros\genesis.mac` (copy it from 95G) when the segment uses a macro.
- `src/externs96.asm`: an equate for every address converted code uses that is still inside an incbin segment. Included by `nhl96.asm` and every stub. When a segment is converted, the equates for its own labels leave this file (otherwise the build fails with a duplicate symbol).
- A label another converted segment defines: an equate in your stub only (the full build has the label itself).
- `src/ram96.asm`: the RAM map, IDA names to start. Rename a variable to its 95G name when you first convert code that uses it (update every use; record it in `docs/name_map.csv`). Define each name once.

## Rules (SNASM68k, from 95G)

- Write real `cmp`, `cmpi`, and `exg`. `tools/fixopcodes.js` rewrites `cmp #imm` from SNASM's `CMPI` to EA's `CMP` opcode using the listing; a real `cmpi.l #imm,d0` stays `0C80`. Do not write a compare as `dc.w`.
- `jsr name` only when SNASM emits the same opcode. `jsr (name).l` is `4EB9`, `jsr (name).w` is `4EB8`; `bsr.w` stays `bsr.w`. IDA writes `jsr (sub_1E9038).l`: keep the `.l`.
- A global label ends local-label scope. A local that another routine branches to stays global. SNASM symbols are case-insensitive.
- Keep each comment line under 200 characters. A longer line makes SNASM write an empty bin.
- A MATCH of 0 bytes is a failure; the byte count must be the segment's range.
- Old output can look like a pass: the scripts delete the old bin first. Only a check made this session counts.
- Data goes in the segment of the code that owns it. Graphics and sound stay incbins (later from an asset extractor), named for the asset, never for an IDA address.
- An asset inside a converted segment (the team palettes) is listed under `assets` in `tools/segmap96.json` (path, start, end); the extractor writes it to `Extracted/<path>` and the source incbins it from there.

## ROM map

The first row whose status is incbin is the current segment. Rows are in ROM order and tile `$000000` up to the `$FF` fill, which `src/nhl96.asm` writes with `dcb.b`. The first split came from `python3 tools/make_segmap96.py` (see its header for the options): it cuts the listing at code / data changes and at `sub_` labels about every 8 KB of code (128 KB of data). The kind is a guess from the listing, and the 95G column lists the 95G files whose routines were found at the start of their bytes in the range (a hint, not a match). Ranges are confirmed from the listing as each segment is converted.

| File | Status | Start | End | Kind | 95G hint | Main names |
|---|---|---|---|---|---|---|
| main96 | matched, 1910 bytes | $000000 | $000775 | code | main95 | Vectors, header (sega\SegaIDTable96), SegaInit (as 95G), CHECK_VDP: the region lock reads CountryCode as a hex digit of region bits (RegionJapanNtsc ... RegionOverseasPal, PrintDeveloped ... PrintAnd, RegionPrint, RegionFont), RegionOK (ValidationRoutine, then jmp Begin), ZeroLong |
| teamdata96 | matched, 20346 bytes | $000776 | $0056EF | data | teamdata95 | VBjsr, TeamList (the ASE / ASW slots point to Boston / Montreal), the team blocks Anaheim ... Winnipeg (Player / String macros, palettes as incbin assets, .pos position nibbles), playoffseats |
| credits96 | matched, 2214 bytes | $0056F0 | $005F95 | data | credits95 | Credits (copyright lines, String -1), CreditsList (legal pages and credits, each page ended by an empty String) |
| frames96 | matched, 14162 bytes | $005F96 | $0096E7 | data | frames95 | SPAlist and the sprite animation tables, named SPAxxxx by their SPA value until the code that uses them is converted |
| code96_02 | matched, 8566 bytes | $0096E8 | $00B85D | code | fourway95 | WriteSRAMBits, ReadSRAMBits (new: bit fields in the save RAM), faceoffinput, the faceoff routines assfaceoff ... puckfaceoff2 and Endfaceoff (bytes: not decoded in the listing), DrawFaceoffWindow, limitfo, updatepadinput, doinput (doinput_goaliedive, doinput_cbut, ClampTargetY, doinput_chkanim, doinput_skater, doinput_ispc, doinput_islocked), PadOnTeam, SetContTeams, DrawPadSetup, DrawPadIcon, ControllerSetupScreen, PrintSetupStr(Hi), ReadAllPads, Detect4WayPlay, ReadJoySwapPad1-4 |
| code96_03 | matched, 13328 bytes | $00B85E | $00EC6D | code | - | Fighting (startfight, SetInst, fightinput, ClearMessageLine; assfight and assfwatch as bytes), asstab, the assignment routines (bytes, labelled at their asstab entries), Penaltylist, PenShotPenalties, SetLCmode |
| code96_04 | matched, 8260 bytes | $00EC6E | $010CB1 | code | lines95, input95, trade95 | SetLCmode2, setlccords, getlchoice(2), lineinput, lcfound(2); shotdiradj, shotdirmath, SetShotMode, ShotMode, prepshot, doshot, setpassmode, passmode, dopass, passtoa0; DefaultRosters, FormatPlayerNameD7, getplayername, GetCreatedName, GetRosterName(Tail), GetJerseyNumber; SimGameStats, SimGoalieStats, SimGoalie, PickSimGoalie |
| code96_05 | matched, 8012 bytes | $010CB2 | $012BFD | code | - | Season and save RAM handling and its screens, mostly new in 96 (IDA names); DrawSetupTeamBlock |
| data96_01 | matched, 11126 bytes | $012BFE | $015773 | code | setup95, awards95, hockey95, pause95 | Mostly code: TeamBlockPtrs, TeamLogoPtrs, SeasonSchedule (Day), ResolveGames, the playoff seeding (BeginPlayoffs, InitPlayoffs, SeedPairings, SortSeeds, CalcSeedPoints, SetupPlayoffs, GetTeamPOSlot, BuildPOSlots), Begin, StartGame, StartPer, Gameloop, DoGameFrame, ResetClock, restoreteams, RestoreBenchEnergy, updatecrowdf, clockcont, demoread, startpause1-4, Pausemode and the pause menu (seta2, InitMenuState, HandleMenuInput, UpdateMenuSelection, PrintMenuItem), vcountwait, GetNameandAttrib and the Attrib columns (bytes), TimeoutMenu, SelectGoalieMenu (bytes) |
| code96_06 | matched, 9362 bytes | $015774 | $017C05 | code | display95, replay95, control95, players95, logic95 (94G assign94) | GetGoalieCount(D7), GetPlayerCount(D7), ReadMenuJoy, updatereplay, updateplayers, updateanim, LockScroll, checkwindow, getGoalieSCnum, burst, holdplayer, chgplayer, setcplayer, setc1-4player, Sweepcheck, restorepl, setpads; as labelled bytes: ReplayMode and its helpers (ShowReplayIcon ... ClampReplayView), check4bench, donothing and the asstab entries (96 asstab uses the 94 numbering: assscore, assstanley, asseben, assepen, assbench, asspenalty, assdopen, assgoaliecpu, assgoaliectrl, assgoaliebreakwait) |
| code96_07 | matched, 9016 bytes | $017C06 | $019F3D | code | logic95, lines95, penalty95, shootout95 | AdjustFacingDirection, goaliesave, saveanim, chkpk2, checkob, EndPenaltyShotPlay, ChkGoalies, CPgoalie; as labelled bytes: the asstab entries assgoalietopuck, chkpuckc, asspuckc, assbreakaway, assnearest, asspassrec, assshoot, puckshootout, puckpenshot, pucknorm, puckunflip (94 numbering), breakaway, BreakawayOffsidesFlagSet, EvadePC, check4check, SelectPenaltyShotSkater, ReturnGoalies, CompLine, AssignPads, ChkOffsides, a2offsides, puckIChk |
| code96_08 | matched, 8278 bytes | $019F3E | $01BF93 | code | video95, logic95, middle95, skate95 | puckflip, assexit, assinsert, assreplace, vtoa, GetHot, SetSPA, doplayeracc, goalieacc, playeracc, dostop, stopna2, MaxSpeed, dirtab(2), WeightedRandomSelect, remap, forceblack, forcefade, cramfade, randomd0(s), sroot, waitx, orjoy, nodiag, ReadJoy1-4, ReadJoy, DoDMA, DoFill, setVram, dobitmap, DecompressGraphics, DecompressBytecode and its opcodes, xyVmMap, eraser, Framer, printsmall(z), ControlCodeJumpTable, print(z), printcur(z), PushTime, PushNumber(Width), appstring, printbig(z), printbigtext |
| code96_09 | matched, 8572 bytes | $01BF94 | $01E10F | code | collide95, penalty95, lines95, middle95, faceoff95 | PrintBigChar, PutBigTile, printbig1/2 (printbigz1/2), AddPenalty, AddPenalty2, PenaltyManager, chkprogress, PenShotChk, getBAplayerInfo, InProgress, coinsearch, checkfornewpen, Stop4Pen, UpdatePA, SetPA(2), PushRef, prefmes, PenaltyTimeTxt, PenGoalStuff, updatepentime, ProcessPenaltyList, releasepl, GetLowestPen, updatepwrplay, EASNLogo, linebar, getlinee, AvgCline, ChkShotStat, SetupTeamForIntermission, SetupTeamLine, RestoreTeamEnergy, Intermission, UpdateScores, SetScore, sctab, PrintBigListItem, PrintSmallListItem, SkipStrings, checkcoll, checkplcoll, checkcx, checkint, CCStart, checkagr, holdcheck |
| code96_10 | matched, 8374 bytes | $01E110 | $0201C5 | code | collide95, players95, shootout95 | FallDown, setInjuryType, checkwallcoll, checkgoal, AssignTeam, GetPeriodTimeRemaining, checkgoalp, CheckBump, wallcollb, wallcoll, setd0player, rtss2, makepde, getpde, setpde, setpersonel, SetPlList, TryAddPlayerToList, ResetBench, setplayer; as labelled bytes: puckbody, SetupPenaltyShot, forcepldata |
| code96_11 | matched, 8206 bytes | $0201C6 | $0221D3 | code | players95, display95, video95, hockey95, setup95 | ClampNibble, VBlank, vb2 (bytes), IRQ7, setvideo, updatescroll, showref, checkfo, showcrowd, ShowCrowdPb, ShowCrowdFrame, checksso, setsortcords, setffo, uppads, QueuePadLabel, RenderSmallFontChar, addframe, addframe2, find3d, KillCrowd, setupice, defaultsprites(2), SprSort, clearTeamStats, InitTeamStructure, setplayercolors, IntermissionStart, ExitToOpening, Opening, Opening2, EASportsScreen, VBlank_SetOptions, DefaultMenus, defmenuoptions, ContinuePlayoffs, NewPO, SetTreeGameTeams, FigureJoy; DumpSprites, resetplstuff, UpdatePlayoffLevel (bytes) |
| code96_12 | matched, 4212 bytes | $0221D4 | $023247 | code | setup95, stats95, injury95, goal95, shootout95, middle95, main95 | ReadPassBits, EncodePW, ReadPassData, WritePassData, WritePassBits, PushBits, ClrPassBits, SuperAdd, SuperMult, SuperDiv, GetShifter, AddPlayoffTeamStats, ReadTeamStats, ResolveGames, ShowThreeStars, TakeTopStarScore, ShowInjuryBox, PenaltyShotBox, PenShotBigTxt, ShowGoalBox, GoalBigTxt, PPGoalBigTxt, box, GetPlayerName, getname, GetPlayerNumInitial, FormatPlayerNumInitial, FormatPlayerName, FinalizeTextBuffer, ConvertByteToDigits, AdrErr, InvOpCode, DivBy0, crash; CalcStarScores, CalcTeamStarScores, FormatPlayerNumInitialShort, GetPlayerNumLast, FormatPlayerNameLast, FormatPlayerNameShort, FormatLastName, GetPlayerInitial, FormatPlayerInitial, PushNumberWidthZero (bytes) |
| data96_02 | incbin | $023248 | $04411F | data | sound95, setup95, middle95 | |
| data96_03 | incbin | $044120 | $07A409 | data | - | |
| data96_04 | incbin | $07A40A | $0887E3 | data | sound95 | |
| code96_13 | incbin | $0887E4 | $08F2C5 | code | - | |
| data96_05 | incbin | $08F2C6 | $120033 | data | - | |
| data96_06 | incbin | $120034 | $140B05 | data | - | |
| data96_07 | incbin | $140B06 | $179167 | data | - | |
| data96_08 | incbin | $179168 | $199BE3 | data | - | |
| data96_09 | incbin | $199BE4 | $1BDCDB | data | - | |
| data96_10 | incbin | $1BDCDC | $1D6B65 | data | - | |
| code96_14 | incbin | $1D6B66 | $1D8E5B | code | shootout95, middle95, scout95 | |
| code96_15 | incbin | $1D8E5C | $1DB287 | code | season95, goal95, logic95 | |
| code96_16 | incbin | $1DB288 | $1DC03B | code | - | |
| data96_11 | incbin | $1DC03C | $1DFA1B | data | create95, trade95, records95 | |
| code96_17 | incbin | $1DFA1C | $1E1A3B | code | - | |
| code96_18 | incbin | $1E1A3C | $1E2E75 | code | stats95 | |
| data96_12 | incbin | $1E2E76 | $1E6161 | data | summary95, shootout95, records95 | |
| code96_19 | incbin | $1E6162 | $1E824B | code | create95, records95 | |
| code96_20 | incbin | $1E824C | $1E90D1 | code | - | |

## New in 96

Add a system here when the listing shows something 95 does not have.

- Fighting (code96_02 checkfight, code96_03): back from 93 (checkfight, SetInst, fightinput, assfight, assfwatch, ClearMessageLine take the 93G names), with new fight moves (more SPAs) and a second round (word_FFDCDE).
