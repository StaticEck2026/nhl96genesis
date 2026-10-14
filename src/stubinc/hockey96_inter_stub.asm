;	Segment build for hockey96_inter.asm: sets its origin and the outside routines and data it uses,
;	then includes the file on its own for checking against the ROM.

; region code
	org	$01D3CE

; includes for stubs to replace removed code
	include	stubinc\ports.inc	;IO_* / VDP_* ports
	include	stubinc\equals.inc	;VDP status bits
	include	ram96.asm		;RAM map
	include	externs96.asm		;outside addresses still in incbin segments. Equates only
	include	macros\genesis.mac	;String

; External addresses outside, read from lst/nhl96.bin.
TeamList = $00077E		;teamdata96
sub_10CF2 = $010CF2		;season96
sub_112DA = $0112DA		;season96
sub_11510 = $011510		;season96
SetupPauseScreen = $014F14		;pause96
InitMenuState = $014F70		;pause96
HandleMenuInput = $014FA8		;pause96
vcountwait = $0151E0		;pause96
WeightedRandomSelect = $01AED4		;skate96
forceblack = $01AF52		;video96
randomd0 = $01B0A6		;video96
sub_1B282 = $01B282		;video96
ProcessInputWithRepeat = $01B320		;video96
rtss2 = $01F84A		;collide96
GetShifter = $0224E2		;code96_12
ShootoutIntermissionMenu = $0239D4		;data96_02
PregameMenu = $023A58		;data96_02
PlayoffPregameMenu = $023AF4		;data96_02
IntermissionMenu = $023BA8		;data96_02
GameOverMenu = $023CBC		;data96_02
PlayoffGameOverMenu = $023D88		;data96_02
UpdateRecords = $1D7BC6		;code96_14
SetupTeamForIntermission = $01D33E		;lines96_bar


; Main segment code
	include	hockey96_inter.asm
