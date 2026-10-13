;	Segment build for code96_11.asm: sets its origin and the outside routines and data it uses,
;	then includes code96_11.asm on its own for checking against the ROM.

; region code
	org	$0201C6

; includes for stubs to replace removed code
	include	stubinc\ports.inc	;IO_* / VDP_* ports
	include	stubinc\equals.inc	;VDP status bits
	include	ram96.asm		;RAM map
	include	externs96.asm		;outside addresses still in incbin segments. Equates only
	include	macros\genesis.mac	;String

; External addresses outside, read from lst/nhl96.bin.
TeamList = $00077E		;teamdata96
ReadSRAMBits = $00975A		;srambits96
SetContTeams = $00B04E		;goal96
sub_EF02 = $00EF02		;code96_04
sub_10FB4 = $010FB4		;code96_05
sub_11024 = $011024		;code96_05
sub_1116A = $01116A		;code96_05
sub_113C2 = $0113C2		;code96_05
sub_1147E = $01147E		;code96_05
sub_1149E = $01149E		;code96_05
sub_11510 = $011510		;code96_05
sub_115EA = $0115EA		;code96_05
sub_1169C = $01169C		;code96_05
sub_11814 = $011814		;code96_05
sub_1223E = $01223E		;code96_05
unk_122A4 = $0122A4		;code96_05
nullsub_2 = $013556		;data96_01
nullsub_3 = $013EA0		;data96_01
BeginPlayoffs = $014026		;data96_01
StartGame = $014702		;data96_01
ResetClock = $01483A		;data96_01
StartPer = $0148BA		;data96_01
PlayoffStatsMenu = $015490		;data96_01
CopyPaletteToCRAM = $01B064		;code96_08
randomd0 = $01B0A6		;code96_08
waitx = $01B152		;code96_08
jdtab = $01B3C8		;code96_08
DoDMA = $01B3EC		;code96_08
DoFill = $01B52E		;code96_08
setVram = $01B57E		;code96_08
setVram_0 = $01B594		;code96_08
dobitmap = $01B692		;code96_08
DecompressGraphicsPlain = $01B730		;code96_08
printz = $01BB8E		;code96_08
sub_1C184 = $01C184		;code96_09
Intermission = $01D3CE		;code96_09
UpdateScores = $01D518		;code96_09
rtss2 = $01F84A		;code96_10
ReadPassBits = $0221D4		;code96_12
EncodePW = $02229C		;code96_12
ReadPassData = $022386		;code96_12
WritePassData = $0223B0		;code96_12
WritePassBits = $0223EA		;code96_12
GetShifter = $0224E2		;code96_12
AddPlayoffTeamStats = $0224FA		;code96_12
sizetab = $0233AC		;data96_02
MakeSRAMChecksum = $0241AA		;data96_02
ReadSRAM = $0241E8		;data96_02
ClearSRAMBytes = $024208		;data96_02
LoadSmallFont = $0243A0		;data96_02
LoadBigFonts = $0243BA		;data96_02
Z80Program = $025500		;data96_02
SoundBanks = $027026		;data96_02
SoundCmd = $08839E		;data96_04
song = $088586		;data96_04
stop_current_song = $0885FC		;data96_04
SoundOff = $088676		;data96_04
Rinktilelist = $0923E4		;data96_05
Sprites = $09AA9E		;data96_05
CrowdFrameList = $13AA96		;data96_06
FaceOffSprites = $13BCB0		;data96_06
EnergyBarMap = $13D290		;data96_06
EASNmap = $13D59E		;data96_06
EASportsMap = $13DA74		;data96_06
RevRinkTilelist = $13E99A		;data96_06
SmallFontMap = $179A76		;data96_08
UpdateCrowdMeter = $1D6D40		;code96_14
nullsub_5 = $1D84D4		;code96_14
LoadReplayIcon = $1D8E5C		;code96_15
LoadHomeTeamGfx = $1D8E6C		;code96_15
OptionsScreen = $1E0DDE		;code96_17
ReturnToGame = $1E2688		;code96_18
UserNameEntry = $1E6C4C		;code96_19
PlayoffScreen = $1E700A		;code96_19
showclock = $1E7664		;code96_19
SeasonAwards = $1E7AC4		;code96_19
sub_1E827A = $1E827A		;code96_20
sub_1E8544 = $1E8544		;code96_20
sub_1E889C = $1E889C		;code96_20
sub_1E89FC = $1E89FC		;code96_20
sub_1E8C5E = $1E8C5E		;code96_20


; Main segment code
	include	code96_11.asm
