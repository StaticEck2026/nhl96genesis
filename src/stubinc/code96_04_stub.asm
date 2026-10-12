;	Segment build for code96_04.asm: sets its origin and the outside routines and data it uses,
;	then includes code96_04.asm on its own for checking against the ROM.

; region code
	org	$00EC6E

; includes for stubs to replace removed code
	include	stubinc\ports.inc	;IO_* / VDP_* ports
	include	stubinc\equals.inc	;VDP status bits
	include	ram96.asm		;RAM map
	include	externs96.asm		;outside addresses still in incbin segments. Equates only
	include	macros\genesis.mac	;String

; External addresses outside, read from lst/nhl96.bin.
sub_10CB2 = $010CB2		;code96_05
sub_10CF2 = $010CF2		;code96_05
rtss7 = $00A3DA		;code96_02
TeamList = $00077E		;teamdata96
GetGoalieCountD7 = $015774		;code96_06
GetGoalieCount = $0157A2		;code96_06
GetPlayerCountD7 = $0157B2		;code96_06
GetPlayerCount = $0157F4		;code96_06
getGoalieSCnum = $0168B8		;code96_06
sub_16D36 = $016D36		;code96_06
assinsert = $01A3D0		;code96_08
vtoa = $01A3EE		;code96_08
GetHot = $01A458		;code96_08
SetSPA = $01A614		;code96_08
doplayeracc = $01A62A		;code96_08
dirtab = $01AE60		;code96_08
randomd0s = $01B09A		;code96_08
randomd0 = $01B0A6		;code96_08
sroot = $01B0DE		;code96_08
eraser = $01B976		;code96_08
Framer = $01B9B0		;code96_08
printz = $01BB8E		;code96_08
print = $01BBA0		;code96_08
sub_1CFE4 = $01CFE4		;code96_09
nullsub_4 = $01D062		;code96_09
linebar = $01D14E		;code96_09
loadTeamStruct = $01D328		;code96_09
SkipStrings = $01D7F2		;code96_09


; Main segment code
	include	code96_04.asm
