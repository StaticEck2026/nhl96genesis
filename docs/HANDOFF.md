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
- code96_04 converted: line changes, shot and pass, roster names, the season simulation. MATCH (segment and ROM).
  Unmatched routines keep their IDA names; small unreferenced code runs stay bytes. A comment on doshot reads
  shotacc at $6E (95 $6D): more evidence that 96's player struct is shifted past $60.
- Converting a segment can change names other converted segments use (code96_02 now jumps to lineinput, defined
  here): run the full ROM build, not only the segment, before committing.
- code96_05 converted: season / save RAM code and screens, almost all new in 96 (no 95 or 93 match), so IDA names.
  MATCH (segment and ROM). sub_12B84 is DrawSetupTeamBlock (95's role in ControllerSetupScreen; the code has
  95 DrawPadIcon's shape, but code96_02 DrawPadIcon is the one with the pad icon tables).
- More inline data after calls: besides printz / printsmallz, the routines at $1BC72, $1BEC4, $1BED6, $1C11A and
  $1C12C take a String after the call (move.l a1,-(sp) / movea.l 4(sp),a1), and DecompressGraphicsWithCallback
  ($1B724) takes an 8 byte remap table. IDA decodes all of these as instructions (some do not even assemble).
- SNASM turns addi / subi #1-8 into addq / subq: the source keeps them with opt oaq- / opt osq- (osq for subi).
- macros/genesis.mac: String takes up to 40 arguments (the 96 stat screen Strings are long).
- data96_01 converted: mostly code, not data. MATCH (segment and ROM). It holds the playoff seeding (95G awards95
  names: InitPlayoffs, SeedPairings, SortSeeds, CalcSeedPoints, CopyBytes, ConferenceTeams1 / 2, SetupPlayoffs;
  96 seeds the 16 slots by conference and division, TeamDivisions), ResolveGames, the hockey95 game flow (Begin,
  StartGame, StartPer, Gameloop, DoGameFrame), ResetClock, restoreteams, RestoreBenchEnergy, updatecrowdf, clockcont,
  demoread, startpause1-4 and the pause95 menu (Pausemode, seta2, InitMenuState, HandleMenuInput,
  UpdateMenuSelection, PrintMenuItem). The 96 menu code is shorter than 95's; the names follow the 95 role.
- unk_13558 is SeasonSchedule (the 95G Day format, 191 days): written with the Day macro and the team equates.
- Byte runs with labels: GetNameandAttrib, attribjmp (written as offsets) and the Attrib column handlers
  (StatusTextTbl, InjuryGamesTbl, HandedTextTbl as Strings; 96 adds RatingToWeight / WeightTbl), TimeoutMenu and
  SelectGoalieMenu (found from the pause menu lists), RestoreSeasonHeader (95G shape, unreferenced), PrintMenuList
  (jsr from code96_05) and the vbint handler unk_12D46. Code after Pausemode has no reference and no name.
- Save RAM in 96 is byte addressed (SaveRAM+offset, odd bytes): ram96.asm has SRSeasonHeader, SRPOPairings,
  SRSeasonHeaderSave, SRPOSlots as offsets. The seeding work lists sit at the start of RAM (AwardIds, SeedStandings,
  SeedPoints, SeedGames, SeedCount, POPairingsTmp).
- RAM: 50 more names (gsp, gsstruct, bosgames, gamelevel, WinBits, menuitem, menulist, OptPlayMode, PALflag, ...).
  crowdcnt and CwdExciteLvl share $FFFFB8B6 / $FFFFB8B8 with the pad icon chars, as crowdlevel does.
  Outside routines named where this code proves them: SoundCmd, SoundOff, KillCrowd, stop_current_song, song,
  Z80Program, SoundBanks, Opening, vb2, ChooseSong, sfx, ExitToOpening, ClearPenalties, ClearPenaltyBuffer,
  LockScroll, setupice, Create_HotCold_Table.
- code96_06 converted: updatereplay, updateplayers, updateanim, checkwindow, the pad switches (chgplayer,
  setcplayer, setc1-4player, restorepl, setpads), burst, holdplayer, getGoalieSCnum, GetGoalieCount(D7) and
  GetPlayerCount(D7) (96 reads the counts from save RAM SRTeamCounts). MATCH (segment and ROM).
- The 96 asstab uses the 94 assignment numbers (NHL94Genesis data94.asm asstab), not 95's: entry n of the 96 table
  matches the 94 routine n by bytes (RAM words masked). So the asstab entries take their 95 / 94 names by index:
  here assscore, assstanley (94 only), asseben, assepen, assbench, asspenalty, assdopen, assgoaliecpu, assgoaliectrl,
  assgoaliebreakwait. The entries in code96_03 ($1-$6: assdefo, assdefd, asswingd, asswingo, asscenterd,
  asscentero) and later segments ($F asstab entries on) can be named the same way when those files are touched.
- Undecoded entries found by masked byte comparison with the 95 / 94 ROMs (a small helper: 16-bit words equal, or
  both $A000 and up as RAM): ReplayMode and its helpers (WaitVSyncAndReadInput, ShowReplayIcon, EraseReplayIcon,
  ShowReplayBanner, EraseReplayBanner, suba4, UpdateCameraPos, RevReplayAdj, ClampReplayView), check4bench,
  donothing. A second copy of burst (unreferenced) and a dead block in updateplayers stay as unnamed bytes.
- SPA values used here renamed with their 95 names (SPAboardmidl ... SPAboardbot, SPAhook, SPAHold, SPAburst);
  the tables of every named SPA value are now <name>_table, as name_map.csv already said for the earlier ones.
- Outside routines named: getpde, setpde, PlaceBoardFall, dirtab. RAM: Vpos, Hpos, glovecords, bholdtimer34,
  yc1, yleader, PBnum, BA_Sktr_SCnum, FallXPos, replaydelay, replayend, crowdframe (shares padiconchars1).
- code96_07 converted: AdjustFacingDirection, goaliesave (saveanim written with the SPA names), chkpk2, checkob,
  EndPenaltyShotPlay, ChkGoalies, CPgoalie. MATCH (segment and ROM). Most of the segment is code the listing does
  not decode: labelled bytes at the asstab entries (assgoalietopuck, chkpuckc, asspuckc, assbreakaway, assnearest,
  asspassrec, assshoot, puckshootout, puckpenshot, pucknorm, puckunflip) and where outside jsr / jmp / movea.l
  targets match a 95 routine by masked bytes (breakaway, BreakawayOffsidesFlagSet, EvadePC, check4check,
  SelectPenaltyShotSkater, ReturnGoalies, CompLine, AssignPads, ChkOffsides, a2offsides, puckIChk); the others
  keep address names (loc_19B16, sub_19E6E).
- The listing decodes btst Dn,#imm (btst d1,#$42) as a blank mnemonic and garbage; written by hand in
  AdjustFacingDirection (code96_06 sub_16D36 has the same form).
- RAM: savednewpnum, puckz, RefCnt. Outside: PushRef, setpersonel, CountShootoutGoals.
- code96_08 converted: the player movement core (SetSPA, doplayeracc, goalieacc, playeracc, dostop, stopna2) and the
  shared low level code (vtoa, GetHot, random numbers, sroot, the pads, dma, vram, palette fades, the graphics
  decompressor, the print routines). MATCH (segment and ROM). Undecoded parts labelled from 95G bytes: the
  DecompressBytecode opcodes (jump_table written as offsets), the print control codes (ControlCodeJumpTable written
  with their names), cramfade, forceblack2, DoDMA_nd2, FormatAndPrintTime, PeriodLabelTable, PushNumber, findpc,
  puckshadow (asstab $19).
- Print routines: 96 has three String printers. printsmall ($1BA40), print ($1BBA0, a fixed font map) and the one
  with the font map at smallfontptr, which is 95's print; it is printcur / printcurz here because print and printz
  already name $1BBA0 / $1BB8E everywhere (clash rule). printbig / printbigz set bigfontptr; printbigcur /
  printbigcurz print with the font already there. All the z forms take the String after the call.
- RAM: pad4way1-4, lj1-4, callbackPtr, ThreeStars, nibblebuffer, seed, dmaram, PushWidthBuf, BigFontChars,
  bigfontptr, framercset, printa, printm, printfontset, repeatdelayframes, palfadenew, waitxpad.
- code96_09 converted: penalties and the ref window, the penalty box and power play box, line energy, shot stats,
  intermission and the other games' scores, the collision and check code. MATCH (segment and ROM).
- Inline Strings here also follow bsr.w calls (bsr.w printz), appendz, and the new printbigz1 / printbigz2: the
  scratch fixer handles bsr.w (4 byte call) now. IDA also decoded the penalty length Strings (PenaltyTimeTxt) as
  code with a bogus sub_1CBDC; written as Strings. Some instructions IDA dropped after a String were put back by
  hand from the ROM bytes (moveq, movea.l, cmpi.b, two bsr.w).
- Game code had picked up the setup-screen names of the shared crowd RAM (padiconchars2 / padcursorchars);
  it now uses crowdlevel, CwdExciteLvl, crowdcnt, crowdframe and the new crowdtblidx.
- RAM: sflags4, sflags8, Ylist, OOlist(pos), PenSum, energybarchars, EASNcset, wcradiusx/y, ltx, lty, collflag,
  msgtimer, Penaltytimer, penmsgtimer, RefStep, RefPen, TempPlOffset, TickerNum, BA_Team, BA_Goalie_Offset,
  BA_Checker_Offset, pspenalty. Outside: ResetBench, checkwallcoll, UpdateRecords, FallDown.
- code96_10 converted: FallDown, setInjuryType, the wall and goal collisions (checkwallcoll, checkgoal, checkgoalp,
  CheckBump, wallcollb, wallcoll), the player energy (makepde, getpde, setpde) and the players on the ice
  (setpersonel, SetPlList, TryAddPlayerToList, ResetBench, setplayer). MATCH (segment and ROM). puckbody,
  SetupPenaltyShot and forcepldata are labelled bytes found by masked byte comparison (SetupPenaltyShot uses
  assignment $20, the 94 number of 95's $1D).
- 95 comments that name player struct fields past $60 (or the roster bytes setplayer reads) were dropped where
  the 96 offsets differ.
- RAM: puckcross2, puckcross6, PPBonus, PlayerChked, PlayerChking, ScoreSum, PlList, ltplayer, crowdnoisedelay,
  FallYPos, homeshootgoals, awayshootgoals, shootoutteam. Outside: AttributeCalc.
- code96_11 converted: the vertical blank handlers and the sprite / display code, setupice, the team setup, the game
  flow between periods and games, the EA Sports screen, DefaultMenus, the playoff tree and FigureJoy. MATCH (segment
  and ROM).
- $201DC is VBlank (the game handler, 95 VBlank by masked bytes) and $202C4 is vb2 (the fade-only handler forcefade
  and EASportsScreen set): data96_01 had called $201DC vb2 from 95's StartGame; StartGame now sets VBlank.
- IntermissionStart ($2161E), ExitToOpening, Opening and Opening2 sit together here; StartGame (data96_01) jumps
  to IntermissionStart.
- RAM: DMAList, DMAlistend, Satt, sso, pads, padcont, fofdata2, Joy1/3/4Struct, potree, postarts, potreeteam,
  pojoy, OptNOP, Opt1team, Opt2team, animchars, faceoffvrcset, Oldrow, Hscroll, Vscroll, zamx.
- code96_12 converted: the playoff pass bits (ReadPassBits, EncodePW, WritePassBits, the 5 word arithmetic), the
  playoff team stats in save RAM, ResolveGames, the Stars of the Game box, the injury, penalty shot and goal boxes,
  the player name strings and the exception vectors (crash, the 94 handler). MATCH (segment and ROM).
- ResolveGames is $22670 (95 ResolveGames by bytes); the data96_01 routine that had the name is ResolveDayGames.
  $21CF4 (code96_11) is maketree (EncodePW calls ResolveGames then it); $14AD4 (data96_01) is CheckInjury, the
  timer head of ShowInjuryBox. The injury box ($22A2C) was undecoded in the listing and is written out by hand.
- getplayername ($101C6) is GetPlayerNamePointer as in the 95 source: SNASM labels ignore case, so it clashed
  with GetPlayerName ($22E70).
- Outside: CountGoalies, PrintPlayerGoals, PrintPlayerAssists, ShootoutModeBox (externs96).
- RAM: tpassbits, pwddatabuffer, statsbuffer, recwins, homegoalies, awaygoalies, InjCntDown, jerseynum, injurygames,
  puck_pflags2.
- data96_02 converted: the game tables, the save RAM routines, the pads, the font loaders, the sound driver, the
  Z80 program and the start of the sound bank. MATCH (segment and ROM).
- The tables are written as source: CrowdFrameTbl, bfasciicon, linelist, PlayerPositionText, PerLabels(2), sizetab,
  sublist, priolist and the attribute columns as in 95; the pause, intermission and line menus as String items with
  dc.l handlers (InitMenuState lists). code96_09's intermission table is now IntermissionMenus (dc.l of the menus).
- Menu handlers named by their item, as 95's pause menus name them: PlayGame, LineEditor, GameStatisticsScreen,
  PlayerStatsScreen, ScoringSummaryScreen, PenaltySummaryScreen, TeamRosterScreen, RecordHoldersScreen,
  PeriodStatsScreen, ManualGoalieMenu, ShootoutShooters, SaveTeamLine, LoadTeamLine (externs96), AbortGame and
  SetOriginalLines (code96_11; SetOriginalLines is the line setup tail of InitTeamStructure).
- The save RAM is $2000 bytes here (95: $8000): InitSaveRAM, ValidateSRAM, ClearSRAM, WriteSRAM, MakeSRAMChecksum
  (skipped while GameFlags bit 6), ReadSRAM, ClearSRAMBytes. nullsub_1 (code96_04) is NullSaveClear.
- The sound driver is the 95 one with 19 commands through SndJumpTable ($A queues a command, $10 SndSongControl,
  $11 SndFindSong, $12 the old SndSendZ80); its routines are labelled bytes (95 masked byte matches and the table).
  SndDriver writes its cmpi.w #$13,d0 as dc.w: tools/fixopcodes.js turns a built cmpi.w #,d0 into cmp.w.
- SoundBanks: the SndItem table (168 items), then the item data with a comment per item; the segment ends inside
  sample 16, which continues in data96_03.
- RAM: ValidSRAM, SRAMChecksum, SndDrvRAM.
- data96_03 converted: SoundBanks item data from inside sample 16 to inside song 0 (the samples, the patches), dc.b
  with one comment per item. MATCH (segment and ROM). No labels: the listing's unk_44120 was the constant
  move.l #$44120,(a1) in code96_04 (String length 4, 'A '), now written as the constant.
- data96_04 converted: the rest of the SoundBanks items (songs, the load lists; one comment per item) and the
  game's sound calls as in 95 sound95: SoundCmd, UpdateCwdExcite, updatesound, CheckLateGameSong, sfx / sfxplay with
  SfxTable, song, StartSong, stop_current_song, SoundOff, ChooseSong with TeamSongs and RandomSongs. MATCH (segment
  and ROM).
- The unreferenced 95 leftovers are labelled bytes: stop_current_song2, KillCrowd2 (a copy of code96_11's KillCrowd,
  so the name), p_initialZ80 (cut down to the Z80 reset), ClearAllTrackAndSFXSlots.
- The listing's unk_7A40A (from off_1E9028) is a number: the code at $1E9038 compares with it (cmp.l off_1E9028(pc)),
  so no label here; write that dc.l as $7A40A when its segment is converted.
- RAM: asv, periodendtime, MaxCwdExciteLvl, NumCwdExciteLvl, SumCwdExciteLvl, SndSeqPtr, SndSeqId.
- code96_13 converted: newcheck (95), then data nothing references: ScoutTextScript, the 95 scouting text lines
  (95 masked byte match; written as dc.b strings with $D), and a $68AE byte block after it with no 95 match and no
  reference (kept as dc.b). MATCH (segment and ROM). RAM: ltack.
- data96_05 converted: graphics. The maps chain one after another, each as its header (dc.l .pal-X,.map-X), the
  tile count and tiles (dc.b), the palette (.pal, dc.w) and the map (.map: width, height, the words): unk_8F2C6,
  unk_90686, unk_911B8 (used from code96_20, purpose not known yet), Framermap, FaceOffMap, Rinktilelist, RefTiles,
  RefTilesHor (95 names by use); then Sprites (header: the palette and frameSprData offsets land in data96_06) and
  the start of Spritetiles. MATCH (segment and ROM).
- The +8 references (the tiles) are written Label+8 in the other files. code96_11's sub_2109A is setupIceRinkPal.
- The listing's unk_A0000 (from data96_10, move.l #unk_A0000,d1 before a divu) is the number $A0000: no label; write
  it as #$A0000 when data96_10 is converted. data96_06 holds the sprite palette at $12F588 (Sprites + $94AEA)
  and frameSprData at $12F608 (Sprites + $94B6A).
- data96_06 converted: graphics, dc.b with labels at the resources the code uses (95 names by use): the rest of
  Spritetiles, SpritePalette and frameSprData (the Sprites header offsets), HotList, HotList2 (the GetHot variants in
  code96_08), CrowdFrameList, FaceOffSprites, EnergyBarMap and EASNmap (written as maps), EASportsMap, RevRinkTilelist
  and the start of ReplayIconMap (used by ShowReplayIcon; its tiles at +8 open data96_07). MATCH (segment and ROM).
  code96_11's sub_210B0 is setupEASNmap.
- data96_07 converted: graphics maps, each written as a map (header, tiles, .pal, .map): the rest of ReplayIconMap,
  ReplayBannerMap (ShowReplayBanner), the maps used from code96_14 / code96_15 / code96_05 (unk_ names, purpose not
  known yet), the setup team blocks, team logos and small logos, named per team from the data96_01 pointer tables
  (TeamBlockPtrs, TeamLogoPtrs, SmallLogoPtrs, now dc.l of the labels), and ControllerBgMap. One unreferenced block
  stays dc.b. MATCH (segment and ROM).
- data96_08 converted: the fonts (RosterFont, SmallFontMap, SmallFontMap2, BigFontMap, BigFontMap2) and the screen
  maps. A label at every address the code uses (unk_ names where the purpose is not known; their +8 tile references
  are written Label+8); a labelled region that parses as a map is written as a map, a further map in it as numbers
  under ";The next map", anything else dc.b. MATCH (segment and ROM).
- data96_09 converted the same way as data96_08: the screen maps (unk_ names), the controller setup pad icons,
  cursor and ControllerTitleMap, and the big fonts. The big font names follow 95 by the print routine: printbig1 uses
  BigFontMap, printbig BigFontMap2, printbig2 BigFontMap3; the font printbig takes with sflags11 bit 2 is BigFontMap4
  (data96_08's BigFontMap / BigFontMap2 renamed, old names in name_map). MATCH (segment and ROM).
- data96_10 converted: screen maps used from other code (unk_ names), then the one-timer code that 95 keeps in
  input95 / logic95: puckvzadj, OneTimerPass, OneTimerTarget and OneTimerNearTbl / FarTbl / GoalieTbl as source;
  assonetimer (asstab $23) and setonetimeranim as labelled bytes. The constant $A0000 in puckvzadj is written as a
  number. RAM: onetimertargetx, onetimertargety. MATCH (segment and ROM).
- code96_14: $1D6D10 is CheckOneTimerFacing (setonetimeranim calls it after vtoa, as in 95); PuckOnAttackHalf starts
  the segment.
- code96_14 converted: the crowd meter (InitCrowdMeter, UpdateCrowdMeter), stopfast (a stopna2 copy with step $7D0;
  stopna2 itself is code96_08's), checkcornercoll / cornercollb (95 names: the wall test without the goals;
  code96_10 keeps checkwallcoll), the hot / cold players, the team / crowd records and name log, CalcAttrib with its
  weight lists, the string helpers, the shootout code and skate paths, GetTeamNickname / GetTeamArena. Undecoded
  routines are labelled bytes by 95 masked byte matches. MATCH (segment and ROM).
- ShowCrowdFrame2 is a copy of code96_11's ShowCrowdFrame that nothing reaches.
- code96_15 converted: LoadReplayIcon, LoadHomeTeamGfx and TeamGfxList, the goal / assist counts, PlaceBoardFall,
  getFgtbyte / chkFgtBit1 (96 reads $75 / $77 of the player), HiScoreScreen, ReadGoaliePulled, EndOneTimer,
  ClearPenalties, the standings code and group tables, SetSframe; labelled bytes for TeamLogoPalettes (exact 95 bytes;
  code96_14's near copy is now TeamLogoPalettes2), LeadSong, CanBlock, LeadersScrollArrows, SortValuesUp.
  MATCH (segment and ROM). RAM: StandingsMode, StandingsBuf, StandingsList, CalTeam (= ThreeStars), CalMonth,
  StandingsOrder, onetimerflags.
- code96_16 converted (new in 96, no 95 match): WaitAnyPad, the helpers of the season playoff stats screen
  (code96_15's loc_1DB020 is now SeasonPlayoffStats; the helpers are PStats...), and the playoff menu screen
  (PlayoffMenuScreen, its routine table and ClearPlayoffSave). A few inline Strings after printcurz were written
  by hand from the ROM bytes. MATCH (segment and ROM).
- data96_11 converted: the roster menu (RosterMenuList, YesNoMenuList: Strings, then item routines that return
  their text in a1; MenuCreatePlayers / MenuSignFreeAgents / MenuReleasePlayer), the trade and create player
  screens (code the listing does not decode: labelled bytes by 95 masked byte matches and by the tables: the
  Field... / Edit... routines follow SkaterFieldList / GoalieFieldList / SkaterEditList / GoalieEditList and the
  rating labels; 96 has no Aggression row and its Checking row sits where 95 kept Aggression), the texts and tables
  written out, then CalcAttribRating (source), MinOverallRating and the weight list copies (OvrPlayerWgtList2,
  OvrGoalWgtList2, AttribWgtList2). code96_16's PlayoffMenuRoutines is now dc.l labels. MATCH (segment and ROM).
  RAM: attribsum, attribcount, CreatePoints. sub_1DFBAC / sub_1E0536 (free agents, release player) are code96_17.
- Next: code96_17.
