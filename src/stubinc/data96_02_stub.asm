;	Segment build for data96_02.asm: sets its origin and the outside routines and data it uses,
;	then includes data96_02.asm on its own for checking against the ROM.

; region code
	org	$023248

; includes for stubs to replace removed code
	include	stubinc\ports.inc	;IO_* / VDP_* ports
	include	stubinc\equals.inc	;VDP status bits
	include	ram96.asm		;RAM map
	include	externs96.asm		;outside addresses still in incbin segments. Equates only
	include	macros\genesis.mac	;String

; External addresses outside, read from lst/nhl96.bin.
Start = $000200		;main96
WriteSRAMBits = $0096E8		;srambits96
asstab = $00C548		;logic96
NullSaveClear = $00EF00		;code96_04
DefaultRosters = $0100C0		;trade96
sub_1147E = $01147E		;season96
vcountwait = $0151E0		;data96_01b
PlayoffStatsMenu = $015490		;data96_01b
TimeoutMenu = $015570		;data96_01b
SelectGoalieMenu = $015604		;data96_01b
ReplayMode = $01581C		;code96_06
ReadJoy1 = $01B348		;code96_08
DecompressGraphicsWithCallback = $01B724		;code96_08
DecompressGraphicsPlain = $01B730		;code96_08
loadTeamStruct = $01D328		;code96_09
rtss2 = $01F84A		;code96_10
SetOriginalLines = $02154E		;code96_11
AbortGame = $021A2E		;code96_11
SmallFontMap = $179A76		;data96_08
BigFontMap = $1B89C8		;data96_09
BigFontMap3 = $1B9416		;data96_09
ManualGoalieMenu = $1D86A4		;code96_14
ClearCreatedPlayers = $1DFA34		;code96_17
LineEditor = $1E1B18		;code96_18
LoadTeamLine = $1E2310		;code96_18
SaveTeamLine = $1E239E		;code96_18
TeamRosterScreen = $1E2EFC		;data96_12
ScoringSummaryScreen = $1E352A		;data96_12
PenaltySummaryScreen = $1E38E6		;data96_12
PeriodStatsScreen = $1E3C7C		;data96_12
GameStatisticsScreen = $1E3FDE		;data96_12
ShootoutShooters = $1E4582		;data96_12
RecordHoldersScreen = $1E4DCC		;data96_12
PlayerStatsScreen = $1E55BA		;data96_12

; Main segment code
	include	data96_02.asm
