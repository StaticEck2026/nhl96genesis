;	Segment build for data96_01b.asm: sets its origin and the outside routines and data it uses,
;	then includes the file on its own for checking against the ROM.

; region code
	org	$013EA0

; includes for stubs to replace removed code
	include	stubinc\ports.inc	;IO_* / VDP_* ports
	include	stubinc\equals.inc	;VDP status bits
	include	ram96.asm		;RAM map
	include	externs96.asm		;outside addresses still in incbin segments. Equates only
	include	macros\genesis.mac	;String

; External addresses outside, read from lst/nhl96.bin.
Detect4WayPlay = $00B5C8		;fourway96
sub_FD14 = $00FD14		;input96_shot
sub_FFD0 = $00FFD0		;input96_shot
sub_11226 = $011226		;season96
sub_1147E = $01147E		;season96
sub_1149E = $01149E		;season96
sub_1161E = $01161E		;season96
ReadMenuJoy = $015CD8		;code96_06
updatereplay = $0161E2		;code96_06
rtss8 = $0162EE		;code96_06
updateplayers = $0162F0		;code96_06
LockScroll = $016786		;code96_06
checkwindow = $01679A		;code96_06
ChkGoalies = $019782		;code96_07
assinsert = $01A3D0		;code96_08
assreplace = $01A3DA		;code96_08
forceblack = $01AF52		;code96_08
randomd0 = $01B0A6		;code96_08
orjoy = $01B2C4		;code96_08
ProcessInputWithRepeat = $01B320		;code96_08
ReadJoy1 = $01B348		;code96_08
ReadJoy2 = $01B360		;code96_08
ReadJoy3 = $01B378		;code96_08
ReadJoy4 = $01B390		;code96_08
printsmallz = $01BA2E		;code96_08
printsmall = $01BA40		;code96_08
printbigcur = $01BEE8		;code96_08
AddPenalty2 = $01C1D2		;code96_09
PenaltyManager = $01C272		;code96_09
ClearPenaltyBuffer = $01CCB0		;code96_09
updatepwrplay = $01CE8A		;code96_09
sub_1D4CE = $01D4CE		;code96_09
VBlank = $0201DC		;code96_11
setvideo = $02034A		;code96_11
KillCrowd = $020E28		;code96_11
setupice = $020E52		;code96_11
clearTeamStats = $021482		;code96_11
IntermissionStart = $02161E		;code96_11
ExitToOpening = $0216EE		;code96_11
Opening = $0216F2		;code96_11
EASportsScreen = $021A4C		;code96_11
DefaultMenus = $021B82		;code96_11
maketree = $021CF4		;code96_11
WritePassData = $0223B0		;code96_12
WritePassBits = $0223EA		;code96_12
GetShifter = $0224E2		;code96_12
ReadTeamStats = $0225E0		;code96_12
ShowInjuryBox = $022A2C		;code96_12
CrowdFrameTbl = $023248		;data96_02
ShootoutPauseMenu = $0236B0		;data96_02
PauseMenu = $023734		;data96_02
PauseMenuNoTimeout = $023890		;data96_02
InitSaveRAM = $023F1C		;data96_02
MakeSRAMChecksum = $0241AA		;data96_02
ClearSRAMBytes = $024208		;data96_02
Z80Program = $025500		;data96_02
SoundBanks = $027026		;data96_02
SoundCmd = $08839E		;data96_04
UpdateCwdExcite = $0883AC		;data96_04
updatesound = $0883D4		;data96_04
CheckLateGameSong = $08842E		;data96_04
sfx = $088470		;data96_04
song = $088586		;data96_04
stop_current_song = $0885FC		;data96_04
SoundOff = $088676		;data96_04
ChooseSong = $088688		;data96_04
InitCrowdMeter = $1D6D22		;code96_14
Create_HotCold_Table = $1D6F24		;code96_14
setSlotBit = $1D733C		;code96_14
ManualGoalieMenu = $1D86A4		;code96_14
nullsub_6 = $1D8782		;code96_14
HiScoreScreen = $1D9114		;code96_15
ClearPenalties = $1D97F4		;code96_15
SetMenuPadSide = $1D9844		;code96_15
SeasonPlayoffStats = $1DB020		;code96_15
sub_1DFA1C = $1DFA1C		;code96_17
ReturnToGame = $1E2688		;code96_18
PlayerStatsList = $1E55BC		;data96_12


; Main segment code
	include	data96_01b.asm
