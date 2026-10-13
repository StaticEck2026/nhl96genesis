;	Segment build for code96_04.asm: sets its origin and the outside routines and data it uses,
;	then includes the file on its own for checking against the ROM.

; region code
	org	$00EF00

; includes for stubs to replace removed code
	include	stubinc\ports.inc	;IO_* / VDP_* ports
	include	stubinc\equals.inc	;VDP status bits
	include	ram96.asm		;RAM map
	include	externs96.asm		;outside addresses still in incbin segments. Equates only
	include	macros\genesis.mac	;String

; External addresses outside, read from lst/nhl96.bin.
TeamList = $00077E		;teamdata96
GetPlayerCountD7 = $0157B2		;code96_06
PAttribOverallMask = $023456		;data96_02
GAttribOverallMask = $0235B8		;data96_02
CalcAttribRating = $1DF8AC		;data96_11
OvrPlayerWgtList2 = $1DF9EC		;data96_11
OvrGoalWgtList2 = $1DF9FC		;data96_11
GetRosterName = $0101E6		;trade96
sub_103AA = $0103AA		;trade96


; Main segment code
	include	code96_04.asm
