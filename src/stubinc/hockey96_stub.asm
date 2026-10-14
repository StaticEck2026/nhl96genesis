;	Segment build for hockey96.asm: sets its origin and the outside routines and data it uses,
;	then includes the file on its own for checking against the ROM.

; region code
	org	$01464C

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
updatereplay = $0161E2		;code96_06
rtss8 = $0162EE		;code96_06
updateplayers = $0162F0		;code96_06
LockScroll = $016786		;code96_06
checkwindow = $01679A		;code96_06
ChkGoalies = $019782		;code96_07
assinsert = $01A3D0		;code96_08
assreplace = $01A3DA		;code96_08
randomd0 = $01B0A6		;code96_08
orjoy = $01B2C4		;code96_08
ReadJoy1 = $01B348		;code96_08
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
Opening = $0216F2		;code96_11
EASportsScreen = $021A4C		;code96_11
DefaultMenus = $021B82		;code96_11
ShowInjuryBox = $022A2C		;code96_12
CrowdFrameTbl = $023248		;data96_02
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
nullsub_6 = $1D8782		;code96_14
HiScoreScreen = $1D9114		;code96_15
ClearPenalties = $1D97F4		;code96_15
demoread = $014CC8		;pause96
Pausemode = $014D8C		;pause96


; Main segment code
	include	hockey96.asm
