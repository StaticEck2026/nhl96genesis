;	Segment build for code96_07.asm: sets its origin and the outside routines and data it uses,
;	then includes code96_07.asm on its own for checking against the ROM.

; region code
	org	$017C06

; includes for stubs to replace removed code
	include	stubinc\ports.inc	;IO_* / VDP_* ports
	include	stubinc\equals.inc	;VDP status bits
	include	ram96.asm		;RAM map
	include	externs96.asm		;outside addresses still in incbin segments. Equates only
	include	macros\genesis.mac	;String

; External addresses outside, read from lst/nhl96.bin.
LockScroll = $016786		;code96_06
vtoa = $01A3EE		;code96_08
SetSPA = $01A614		;code96_08
SPA0074 = $74		;SPA value (frames96)
SPA0170 = $170		;SPA value (frames96)
SPA02C0 = $2C0		;SPA value (frames96)
SPA031A = $31A		;SPA value (frames96)
SPAgglovel = $1CA		;SPA value (frames96)
SPAgglover = $12E		;SPA value (frames96)
SPAgstackl = $3E6		;SPA value (frames96)
SPAgstackr = $440		;SPA value (frames96)
SPAgstickl = $20C		;SPA value (frames96)
SPAgstickr = $266		;SPA value (frames96)


; Main segment code
	include	code96_07.asm
