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
WriteSRAMBits = $0096E8		;code96_02
asstab = $00C548		;code96_03
NullSaveClear = $00EF00		;code96_04
DefaultRosters = $0100C0		;code96_04
sub_1147E = $01147E		;code96_05
vcountwait = $0151E0		;data96_01
PlayoffStatsMenu = $015490		;data96_01
TimeoutMenu = $015570		;data96_01
SelectGoalieMenu = $015604		;data96_01
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

; Main segment code
	include	data96_02.asm
