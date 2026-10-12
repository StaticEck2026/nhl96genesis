;	Segment build for code96_05.asm: sets its origin and the outside routines and data it uses,
;	then includes code96_05.asm on its own for checking against the ROM.

; region code
	org	$010CB2

; includes for stubs to replace removed code
	include	stubinc\ports.inc	;IO_* / VDP_* ports
	include	stubinc\equals.inc	;VDP status bits
	include	ram96.asm		;RAM map
	include	externs96.asm		;outside addresses still in incbin segments. Equates only
	include	macros\genesis.mac	;String


; External addresses outside, read from lst/nhl96.bin.
WriteSRAMBits = $0096E8		;code96_02
ReadSRAMBits = $00975A		;code96_02
sub_1051A = $01051A		;code96_04
SimGameStats = $01091A		;code96_04
TeamBlockPtrs = $012BFE		;data96_01
TeamLogoPtrs = $012C6E		;data96_01
unk_12D46 = $012D46		;data96_01
SeasonSchedule = $013558		;data96_01
ResolveGames = $013EA2		;data96_01
GetTeamPOSlot = $0143A8		;data96_01
GetGoalieCountD7 = $015774		;code96_06


; Main segment code
	include	code96_05.asm
