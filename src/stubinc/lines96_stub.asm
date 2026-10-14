;	Segment build for engine\lines96.asm: sets its origin and the outside routines and data it uses,
;	then includes the file on its own for checking against the ROM.

; region code
	org	$00EC30

; includes for stubs to replace removed code
	include	stubinc\ports.inc	;IO_* / VDP_* ports
	include	stubinc\equals.inc	;VDP status bits
	include	ram96.asm		;RAM map
	include	externs96.asm		;outside addresses still in incbin segments. Equates only
	include	macros\genesis.mac	;String

; External addresses outside, read from lst/nhl96.bin.
rtss7 = $00A3DA		;faceoff96
loadTeamStruct = $01D328		;code96_09
doplayeracc = $01A62A		;skate96
eraser = $01B976		;video96
Framer = $01B9B0		;video96
printz = $01BB8E		;video96
print = $01BBA0		;video96
sub_1CFE4 = $01CFE4		;code96_09
nullsub_4 = $01D062		;code96_09
linebar = $01D14E		;code96_09
SkipStrings = $01D7F2		;code96_09
setpersonel = $01FB52		;code96_10
box = $022E58		;code96_12
linelist = $023342		;data96_02
ClearBigScore = $1E7A78		;code96_19
rtss = $00F8D0		;input96_shot


; Main segment code
	include	engine\lines96.asm
