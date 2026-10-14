;	Segment build for engine\pause96_menu.asm: sets its origin and the outside routines and data it uses,
;	then includes the file on its own for checking against the ROM.

; region code
	org	$015490

; includes for stubs to replace removed code
	include	stubinc\ports.inc	;IO_* / VDP_* ports
	include	stubinc\equals.inc	;VDP status bits
	include	ram96.asm		;RAM map
	include	externs96.asm		;outside addresses still in incbin segments. Equates only
	include	macros\genesis.mac	;String

; External addresses outside, read from lst/nhl96.bin.
ReadTeamStats = $0225E0		;playoff96
SeasonPlayoffStats = $1DB020		;code96_15
PlayerStatsList = $1E55BC		;data96_12


; Main segment code
	include	engine\pause96_menu.asm
