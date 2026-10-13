# Align 96G with 95G

Audit only. No source bytes were moved in this commit. 95G was read on GitHub
(`SEGMENT_AGENT.md`, `PROMPT.md`, `docs/HANDOFF.md`, `src/nhl95.asm`, the include lists,
`docs/name_map.csv`, `tools/extractAssets95.js`). 95G has no `START_HERE.md`.

95G is one file per subsystem, in folders, included in ROM order. 96G is still the
first mechanical cut (`code96_*`, `data96_*`): one file per ROM slice, several
subsystems in each slice. Names already follow 95G where an earlier pass matched
the body. What is left is the file split, the labels that still differ, and
extracting graphics and sound the way 95G does.

Matching used three checks:

- 96 `docs/name_map.csv` joined to the 95G name map by name (case-insensitive).
  1902 labels: 928 already wear a 95G name, 260 are still `sub_` / `loc_` / `unk_` /
  `word_` / `byte_`, 714 are descriptive names 95G does not have (296 of those are RAM,
  107 are SPA tables named by their SPA value).
- Exact first-20-bytes search, the same test as `tools/find95.py`. 163 unique hits.
  Most 96 routines differ in the first bytes because RAM addresses moved, so a miss
  is not "different code".
- Masked words (a 16-bit word at or above `$A000` matches any such word), 12 words,
  one unique hit. That is how the earlier passes matched bodies. 62 extra hits;
  the ones that change a name are listed below.

95G keeps a routine that moved in from another 94 file inside the host file.
96G will do the same: a couple of guests stay in the host. A file is split only
when two subsystems each own a real contiguous run. A 95G module that the 96 ROM
splits into two places becomes two includes. The first and largest piece gets the
95G file name with 96 instead of 95. A later piece gets a short suffix
(`logic96_ai.asm`) because one file cannot be assembled twice. That suffix is a
ROM-order limit, recorded here, not a second naming scheme.

`src/nhl96.asm` stays the ROM-order include list. 95G's `engine95.asm` and
`front95.asm` exist because those runs are contiguous and branches cross the
files. 96G's engine and front-end code are interleaved across the whole ROM, so
there is no single engine list to include once. Folders still match: `engine/`,
`front/`, `sound/`, `sega/`, `stubinc/`, `macros/`.

## File map

| 96 file | Range | 95G modules in it (named labels) | Action |
|---|---|---|---|
| main96 | `$000000-$000775` | main95 | Keep `src/main96.asm`. Sega header and `SegaInit` already live in `src/sega/`. |
| teamdata96 | `$000776-$0056EF` | teamdata95 | Keep `src/teamdata96.asm`. Palettes are already incbins. |
| credits96 | `$0056F0-$005F95` | credits95 | Keep the name. 95G puts credits after graphics; 96G's ROM puts them here. Do not move the bytes. |
| frames96 | `$005F96-$0096E7` | frames95 | Keep `src/frames96.asm`. SPA tables that 95G names are already renamed; the rest stay `SPAxxxx` until a routine uses them. |
| code96_02 | `$0096E8-$00B85D` | faceoff95, input95, skate95 (inside doinput), goal95 (controller setup), fourway95, plus new SRAM bit routines and `checkfight` | Split, in ROM order, into the files in the work queue. |
| code96_03 | `$00B85E-$00EC6D` | fight (new), logic95 (`asstab`), penalty95, lines95 (`SetLCmode` only) | Split off `engine/fight96.asm`. `asstab` through the assignment bytes becomes `engine/logic96.asm`. Penalty texts stay with logic until `penalty96` exists, or move with the penalty run if the boundary is clean. `SetLCmode` is the start of the next file. |
| code96_04 | `$00EC6E-$010CB1` | lines95, input95 (shot and pass), trade95, season95 | Split into `engine/lines96.asm`, `engine/input96_shot.asm` (shot/pass; `input96.asm` is doinput), `front/trade96.asm`, `front/season96_sim.asm`. |
| code96_05 | `$010CB2-$012BFD` | new season / save screens (source is `sub_` names, almost none in the name map) | `front/season96.asm` once the bodies are read. Until then the file is renamed, not re-split. |
| data96_01 | `$012BFE-$015773` | awards95, setup95, hockey95, pause95, schedule95 (`SeasonSchedule`), crowd, injury | Split into `src/schedule96.asm` (the schedule table only), `front/awards96.asm` (seeding), `src/hockey96.asm` (Begin through the frame loop), `engine/pause96.asm`, `engine/setup96.asm` (attribute columns and the roster helpers). Pointer tables at the top stay with the first of these. |
| code96_06 | `$015774-$017C05` | replay95, control95, logic95 (more `asstab` entries), players95 | Split into `engine/replay96.asm`, `src/control96.asm`, and `engine/logic96_ass.asm` for the assignment entries. The two count helpers at the top stay with control (they are called from the replay / bench path). |
| code96_07 | `$017C06-$019F3D` | logic95, shootout95, penalty95, lines95 | The logic run joins the logic story as `engine/logic96_puck.asm`. Shootout and penalty runs become `front/shootout96.asm` and `engine/penalty96.asm` only where the run is more than a guest; a single routine stays in the host. |
| code96_08 | `$019F3E-$01BF93` | video95, middle95, skate95, logic95 (a few assignment tails) | Split into `engine/skate96.asm`, `engine/video96.asm`, `engine/middle96.asm`. The short logic tail at the top stays in skate or moves to `logic96_puck` if it sits before `vtoa` with no fall-through. |
| code96_09 | `$01BF94-$01E10F` | penalty95, middle95 (big print), lines95, collide95, faceoff95, shootout95 | `engine/penalty96.asm`, `engine/lines96` already started so this run is `engine/lines96_bar.asm`, `engine/collide96.asm`. Big-print stays a guest of penalty or becomes the next piece of `middle96`. |
| code96_10 | `$01E110-$0201C5` | collide95, players95, middle95 (energy) | Extend `collide96` with the wall and goal code. `engine/players96.asm` for `setpersonel` through `setplayer`. |
| code96_11 | `$0201C6-$0221D3` | video95 (vblank), display95, crowd95, control95, hockey95, setup95 | `src/display96.asm`, more of `hockey96` (`Opening`), `engine/setup96_menu.asm`. Vblank stays with display (95G puts VBlank in video, but 96G's vblank sits with the sprite code; keep it in display and record that). |
| code96_12 | `$0221D4-$023247` | setup95 (pass bits), stats95, goal95, middle95 (names), main95 (exceptions) | `engine/goal96.asm` for the boxes if goal96 is not already the controller screen; otherwise `engine/goal96_box.asm`. Name helpers join `middle96`. Exceptions stay in the file that ends at `crash` (`src/main96` cannot take them: they are not at the start of the ROM). Home: the end of `goal96_box` or a few labels left in that file. |
| data96_02 | `$023248-$04411F` | tables (middle, players, lines, setup, crowd), sram95, video95 pads, sound95 driver and the start of the bank | Split the tables into the subsystem that owns them when that file exists; until then keep one `src/data96_tables.asm` only as a temporary name. `src/sram96.asm` for InitSaveRAM through the save RAM calls. `src/sound96.asm` from `SndDriver` to the end of the bank. |
| data96_03 | `$044120-$07A409` | sound95 bank data | Becomes incbins inside `sound96` (extraction step). |
| data96_04 | `$07A40A-$0887E3` | sound95 bank tail and the sound calls | Same `sound96`. |
| code96_13 | `$0887E4-$08F2C5` | sound95 `newcheck`, scout95 text | `newcheck` stays at the end of `sound96` (95G did that). `ScoutTextScript` goes to `front/scout96.asm` as an incbin. The unreferenced block after it stays in that file. |
| data96_05 to data96_09 | `$08F2C6-$1BDCDC` | graphics95 | One `src/graphics96.asm` of incbins, after extraction. Not before: merging the `dc.b` dumps first only makes a larger file to throw away. |
| data96_10 | `$1BDCDC-$1D6B65` | graphics95, then input95 / logic95 one-timer | Graphics part joins `graphics96`. `puckvzadj` through `setonetimeranim` joins `input96_shot` or `logic96_puck`, whichever is contiguous with nothing between. |
| code96_14 | `$1D6B66-$1D8E5B` | shootout95, middle95, scout95, records95, collide95 | `front/shootout96.asm` for the paths and the shootout body. Records and scout helpers go to `front/records96.asm` and `front/scout96.asm` when those runs are contiguous; guests stay. |
| code96_15 | `$1D8E5C-$1DB287` | season95 standings, goal95, injury95, penalty95, playoff95 | `front/season96_stand.asm` for the standings tables. The rest are guests of the surrounding files unless a run is long. |
| code96_16 | `$1DB288-$1DC03B` | new in 96 (no 95G name) | `front/season96_menu.asm` (season playoff stats and the playoff menu). |
| data96_11 | `$1DC03C-$1DFA1B` | create95, trade95 | `front/trade96.asm` and `front/create96.asm`. |
| code96_17 | `$1DFA1C-$1E1A3B` | create95, then the options screen (new) | Create-player list joins `create96`. Options become `front/options96.asm` (new in 96). |
| code96_18 | `$1E1A3C-$1E2E75` | stats95 line editor, pause95 return-to-game | `front/stats96.asm` and the pause tail joins `pause96` if the branch across the boundary is absolute. |
| data96_12 | `$1E2E76-$1E6161` | summary95, stats95, shootout95, records95 | `front/summary96.asm`, more of `stats96`, `shootout96`, `records96`. |
| code96_19 | `$1E6162-$1E824B` | records95, playoff95, awards95, middle95 clock | `front/records96.asm`, `engine/playoff96.asm`, `front/awards96.asm` (second piece: `awards96_show.asm`). |
| code96_20 | `$1E824C-$1E90D1` | injury95, new opening screens, checksum95 | `front/injury96.asm`, `front/title96.asm` for the opening screens, `src/checksum96.asm` for `ChecksumLongs` through `ValidationRoutine`. |

`src/ram96.asm`, `src/externs96.asm`, `src/stubinc/`, `src/macros/genesis.mac` stay where 95G puts them.

## Work queue (file split)

One module per commit. After each move: `tools/verify_all.sh` ends in `ALL MATCH`, then commit and push, then `docs/HANDOFF.md`. A split is a new file, its stub, its `seg:` script, the `nhl96.asm` include, the ROM map row, and the `module` column in `docs/name_map.csv`. Segment builds already branch to equates in other files (`bne.w faceoffinput` from input96), so a split on a label boundary is safe when every cross-edge is a branch to a global label or a `jsr` / `jmp`.

1. `engine/fight96.asm` — done. `checkfight` through `sub_C51C`.
2. `engine/fourway96.asm` — done. `Detect4WayPlay` through `ReadJoySwapPad4`.
3. `engine/goal96.asm` — done. `SetContTeams` through `ReadAllPads`.
4. `engine/input96.asm` — done. `updatepadinput` through `PadOnTeam` (doinput, including the goalie parts that 95G kept in skate95; they are inside doinput here). `PadOnTeam` follows `sub_AFDA` and `doinput` branches to it, so it stays in this file.
5. `engine/faceoff96.asm` — done. `faceoffinput` through `Endfaceoff`. What remains of code96_02 is `WriteSRAMBits` / `ReadSRAMBits` and the unreferenced bytes between them and the faceoff.
6. `src/srambits96.asm` — done. `WriteSRAMBits` / `ReadSRAMBits` and the unreferenced bytes that follow them. The 95G save-RAM block is later and is the file that gets the name `src/sram96.asm`.
7. `engine/logic96.asm` — `asstab` through the assignment bytes in code96_03. Penalty texts that sit in the middle of that run stay in the file (guest) until penalty96 is the next include and the bytes are contiguous with it.
8. `engine/lines96.asm` — `SetLCmode` through `lcfound2`.
9. Continue down the table above. Do not start graphics or the sound bank until the extraction step.

## Names that differ

Already the 95G name: 928 labels. Leave them.

Rename, the masked body matches and nothing else owns the 95G name:

| 96 address | 96 name | 95G name | File |
|---|---|---|---|
| `$0168B8` | getGoalieSCnum | FindGoalie | code96_06 |
| `$1D8180` | ClearShootout | ShootoutInit | code96_14 |
| `$1E6B04` | LetterGrid | CreateLetterGrid | code96_19 |

`getGoalieSCnum` is the 95G routine 95G now calls `FindGoalie` (d0 = the goalie's SCnum). `ClearShootout` is 95G `ShootoutInit`. `LetterGrid` is 95G `CreateLetterGrid`.

Labels the masked search found inside bytes, where 96 has no name at that address (the 95G name is a global, not a `GatherAndSort.something` local). Confirm the body, then name them. Skip any that land in the middle of a routine that already has a name.

| 96 address | 95G name | 95G file | In |
|---|---|---|---|
| `$018400` | chkpk | middle95 | code96_07 |
| `$019692` | UpdatePenaltyShotEnd | shootout95 | code96_07 |
| `$019DA2` | a2touchpuck | logic95 | code96_07 |
| `$01E8C0` | Goal | goal95 | code96_10 |
| `$02032C` | rtss2 | video95 | code96_11 |
| `$02032E` | SetScroll2 | video95 | code96_11 |
| `$020892` | ClockDigitChar | middle95 | code96_11 |
| `$021510` | setteams | control95 | code96_11 |
| `$022198` | InitializeGameStructures | setup95 | code96_11 |
| `$1DE98C` | InitCreateRecord | create95 | data96_11 |
| `$1E36D6` | GoalTypeTbl | summary95 | data96_12 |

`code96_05` is still `sub_` / `unk_` in the source and those names were never written to `docs/name_map.csv`. Naming them is part of the season96 pass, not a drive-by.

SegaInit locals (`h_s`, `cold_start`, `clr_wk`, ...) already exist in `src/sega/SegaInit.asm`. They are missing from `docs/name_map.csv` only. Add the rows; do not invent a second copy.

RAM: 294 names are shared with `src/ram95.asm`. 286 of those sit at a different address, which is expected (the RAM map moved). 145 RAM names are still `word_FF` / `byte_FF` / `unk_FF`. Rename one when a converted use matches a 95G RAM name by what the code does, and record it in `docs/name_map.csv`. Do not rename from the address alone.

### Do not rename (checked, not a 95G match)

| 96 name | Why it stays |
|---|---|
| stopfast | Same shape as 95G `stopna2` with step `$7D0`. 96G already has `stopna2` in code96_08. Clash rule. |
| StandingsPoints | Same shape as `CalcSeedPoints`. 96G already has `CalcSeedPoints` in data96_01. |
| PrintCurLetter | 95G `PrintGridLetter` is already the create-player label in data96_11. This one is name entry. |
| DoFrameUpdates | The first words match `CheckNewCarrier`; the routine then does the crowd, the clock and the one-second work. |
| SetSframe | Masked hit is 95G `AddSpriteFrame`. 95G also has `SetSframe`. The 96 comment matches `SetSframe`. Left alone until the two 95G bodies are compared side by side. |
| SortValuesUp, CreateListMove, rtsNameCursor | The 95G hit is a local (`GatherAndSort.sortValuesUp`, `CreatePlayer.createListMove`, `rtsCreate2`), not a global to copy. |
| Start / SegaInit | Both names already sit on `$000200`, as in 95G. |

## New in 96

| What | Where now | Home |
|---|---|---|
| Fighting (`checkfight`, `startfight`, `SetInst`, `fightinput`, `assfight`, `assfwatch`) | code96_02 tail, code96_03 head | `engine/fight96.asm` |
| Save RAM bit fields (`WriteSRAMBits`, `ReadSRAMBits`) | code96_02 head | `src/srambits96.asm` |
| Season screens and the playoff menu (`sub_` in code96_05, code96_16) | code96_05, code96_16 | `front/season96.asm`, `front/season96_menu.asm` |
| Options screen (`OptionsScreen` and the menu after the create-player list) | code96_17 | `front/options96.asm` |
| Opening screens after the injuries (`sub_1E889C` through `sub_1E8F52`) | code96_20 | `front/title96.asm` |
| Region lock as a hex digit of region bits | main96 | stays in `main96` (95G's lock is the same file, different test) |
| `.pos` nibble per player, no All-Star teams | teamdata96 | stays in `teamdata96` |
| Player struct fields past `$60` shifted by one | equals.inc, readers in the fight and goalie code | a later equals pass, not a new file |

## Asset extraction

95G: `tools/extractAssets95.js` writes `Extracted/NHL95/...` (team pals, `*.map.jim`, sprite and font bins, arena graphics, `z80_snd_drv95.bin`, `snd95_patch_XX.bin` / `sample` / `song` / `list`, `ScoutTextScript.bin`) and `Extracted/.extract-complete.json`. `tools/prebuild.js` runs it. Source incbins those files. `npm run assets` and `npm run extractassets` are the entry points.

96G today: `tools/extractSegments96.js` writes `Extracted/segments/<name>.bin` plus the team pals under `Extracted/NHL96/Graphics/Pals/*h96.pal`. The marker file and the "ROMs are not included in the repo" stop in `tools/prebuild.js` already match. No converted source incbins a segment slice anymore (only the team pals).

Target:

- `tools/extractAssets96.js`, same shape as the 95G extractor (SHA-1 check, asset table, marker last). `prebuild.js` and `npm run extractassets` call it.
- Keep the team pals. Add graphics (`NHL96/Graphics/<Label>.map.jim` or `.bin`, one file per label whose body is data), the Z80 program, each sound-bank item, and `NHL96/Text/ScoutTextScript.bin`.
- `graphics96` and `sound96` incbin those files. A map stays one incbin; tiles are `Label+8`, as in 95G. Do not leave a `dc.b` dump of a ROM range in a file 95G extracts.
- Drop segment-slice extraction once nothing includes `Extracted/segments/`. `tools/segmap96.json` remains the ROM map the docs and `find95.py` use.
- Missing ROM: the existing prebuild message stays, including "ROMs are not included in the repo".

## Symbols, comments, docs

Where 95G writes `SPA*` / `SPF*`, a RAM field, a team equate or an `SFX_*` id, 96G still has the hex in places (the frames file defines tables by SPA value; immediates in the code are only partly converted). Do that pass after the file that owns the symbol exists, and only where the bytes do not change.

File headers are already short stories in most converted files. When a file is split, each new file gets a header in that style. No rename history, no ROM addresses, no "from 95G".

After the layout and the extractor exist, update `START_HERE.md`, `SEGMENT_AGENT.md`, `PROMPT.md` and `docs/HANDOFF.md` so the next agent follows the folders and `extractAssets96.js`.

## Unsure

- `SetSframe` versus 95G `AddSpriteFrame` (see the table above).
- Which `code96_05` `sub_` is which season screen. No 95G byte match, and the name map does not list them.
- 145 IDA RAM names. No rename until a use shows the 95G variable.
- 95G `print` versus 96G `print` / `printcur`. Already decided (clash). Do not revisit.
- Dotted 95G locals reported by the masked search (`sortValuesUp`, `createListMove`, `rtsCreate2`). Not copied.
- Whether `ClockDigitChar` at `$020892` is the same routine as middle95 or a second copy. 96G also has `ClockDigitChar` in code96_19.
