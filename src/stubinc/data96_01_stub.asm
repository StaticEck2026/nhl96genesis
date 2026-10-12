;	Segment build for data96_01.asm: sets its origin and the outside routines and data it uses,
;	then includes data96_01.asm on its own for checking against the ROM.

; region code
	org	$012BFE

; includes for stubs to replace removed code
	include	stubinc\ports.inc	;IO_* / VDP_* ports
	include	stubinc\equals.inc	;VDP status bits
	include	ram96.asm		;RAM map
	include	externs96.asm		;outside addresses still in incbin segments. Equates only
	include	macros\genesis.mac	;String

; External addresses outside, read from lst/nhl96.bin.
Detect4WayPlay = $00B5C8		;code96_02
sub_FD14 = $00FD14		;code96_04
sub_FFD0 = $00FFD0		;code96_04
sub_11226 = $011226		;code96_05
sub_1147E = $01147E		;code96_05
sub_1149E = $01149E		;code96_05
sub_1161E = $01161E		;code96_05
ReadMenuJoy = $015CD8		;code96_06
updatereplay = $0161E2		;code96_06
rtss8 = $0162EE		;code96_06
updateplayers = $0162F0		;code96_06
LockScroll = $016786		;code96_06
checkwindow = $01679A		;code96_06


; Main segment code
	include	data96_01.asm
