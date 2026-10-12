;	Segment build for code96_02.asm: sets its origin and the outside routines and data it uses,
;	then includes code96_02.asm on its own for checking against the ROM.

; region code
	org	$0096E8

; includes for stubs to replace removed code
	include	stubinc\ports.inc	;IO_* / VDP_* ports
	include	stubinc\equals.inc	;VDP status bits
	include	ram96.asm		;RAM map
	include	externs96.asm		;outside addresses still in incbin segments. Equates only
	include	macros\genesis.mac	;String

; External addresses outside, read from lst/nhl96.bin.
ZeroLong = $000772		;main96
SPAlist = $005F96		;frames96
SPAgdive = $49A		;SPA value (frames96)
SPAgglover = $12E		;SPA value (frames96)
SPAgglovel = $1CA		;SPA value (frames96)
SPAgstackr = $440		;SPA value (frames96)
SPAgstackl = $3E6		;SPA value (frames96)
SPAgstickr = $266		;SPA value (frames96)
SPAgstickl = $20C		;SPA value (frames96)
SPA099A = $99A		;SPA value (frames96)
SPA1792 = $1792		;SPA value (frames96)
SPA2126 = $2126		;SPA value (frames96)
SPA2150 = $2150		;SPA value (frames96)
SPA288C = $288C		;SPA value (frames96)


; Main segment code
	include	code96_02.asm
