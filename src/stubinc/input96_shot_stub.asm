;	Segment build for engine\input96_shot.asm: sets its origin and the outside routines and data it uses,
;	then includes the file on its own for checking against the ROM.

; region code
	org	$00F374

; includes for stubs to replace removed code
	include	stubinc\ports.inc	;IO_* / VDP_* ports
	include	stubinc\equals.inc	;VDP status bits
	include	ram96.asm		;RAM map
	include	externs96.asm		;outside addresses still in incbin segments. Equates only
	include	macros\genesis.mac	;String

; External addresses outside, read from lst/nhl96.bin.
rtss7 = $00A3DA		;faceoff96
getGoalieSCnum = $0168B8		;control96
sub_16D36 = $016D36		;control96
assinsert = $01A3D0		;logic96_vec
vtoa = $01A3EE		;logic96_vec
GetHot = $01A458		;logic96_vec
SetSPA = $01A614		;skate96
dirtab = $01AE60		;skate96
randomd0s = $01B09A		;video96
randomd0 = $01B0A6		;video96
sroot = $01B0DE		;video96
loadTeamStruct = $01D328		;code96_09
makepde = $01FAFA		;code96_10
sfx = $088470		;data96_04
puckvzadj = $1D6622		;data96_10
OneTimerPass = $1D66AC		;data96_10
OneTimerTarget = $1D6718		;data96_10
PSandSOpassdir = $1D8B26		;code96_14
ReadGoaliePulled = $1D9352		;code96_15


; Main segment code
	include	engine\input96_shot.asm
