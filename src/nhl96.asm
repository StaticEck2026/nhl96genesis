;	Top level of the ROM build. It includes the equates and then every module in ROM order, and
;	each file assembles right after the one before it. Only this file sets the start address; a
;	segment build sets its own in its stub. The include comments are the ROM map.

	include	stubinc\ports.inc	;IO_* / VDP_* ports. Equates only
	include	stubinc\equals.inc	;VDP status bits. Equates only
	include	ram96.asm		;RAM map. Equates only
	include	externs96.asm		;outside addresses still in incbin segments. Equates only
	include	macros\genesis.mac	;String, Player and the other data macros

	org	0			;the ROM starts at 0. Without an org SNASM writes a short, misaligned bin (the stubs carry their own org)
	include	main96.asm		; $000000  code
	include	teamdata96.asm		; $000776  VBjsr, TeamList and the team blocks, playoffseats
	include	credits96.asm		; $0056F0  Credits, CreditsList
	include	frames96.asm		; $005F96  SPAlist and the sprite animation tables
	include	code96_02.asm		; $0096E8  pads, faceoffs, controller setup, 4 way play
	include	engine\fight96.asm	; $00B6A0  fighting
	include	code96_03.asm		; $00C548  asstab, penalty texts
	include	code96_04.asm		; $00EC6E  code
	include	code96_05.asm		; $010CB2  code
	include	data96_01.asm		; $012BFE  data
	include	code96_06.asm		; $015774  code
	include	code96_07.asm		; $017C06  code
	include	code96_08.asm		; $019F3E  code
	include	code96_09.asm		; $01BF94  code
	include	code96_10.asm		; $01E110  code
	include	code96_11.asm		; $0201C6  code
	include	code96_12.asm		; $0221D4  code
	include	data96_02.asm		; $023248  data
	include	data96_03.asm		; $044120  data
	include	data96_04.asm		; $07A40A  data
	include	code96_13.asm		; $0887E4  code
	include	data96_05.asm		; $08F2C6  data
	include	data96_06.asm		; $120034  data
	include	data96_07.asm		; $140B06  data
	include	data96_08.asm		; $179168  data
	include	data96_09.asm		; $199BE4  data
	include	data96_10.asm		; $1BDCDC  data
	include	code96_14.asm		; $1D6B66  code
	include	code96_15.asm		; $1D8E5C  code
	include	code96_16.asm		; $1DB288  code
	include	data96_11.asm		; $1DC03C  data
	include	code96_17.asm		; $1DFA1C  code
	include	code96_18.asm		; $1E1A3C  code
	include	data96_12.asm		; $1E2E76  data
	include	code96_19.asm		; $1E6162  code
	include	code96_20.asm		; $1E824C  code
	dcb.b	$200000-*,$FF		;fill to the 2 MB ROM end
