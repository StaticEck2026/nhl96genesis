;	Segment build for engine\pause96.asm: sets its origin and the outside routines and data it uses,
;	then includes the file on its own for checking against the ROM.

; region code
	org	$014CC8

; includes for stubs to replace removed code
	include	stubinc\ports.inc	;IO_* / VDP_* ports
	include	stubinc\equals.inc	;VDP status bits
	include	ram96.asm		;RAM map
	include	externs96.asm		;outside addresses still in incbin segments. Equates only
	include	macros\genesis.mac	;String

; External addresses outside, read from lst/nhl96.bin.
ReadMenuJoy = $015CD8		;code96_06
rtss8 = $0162EE		;code96_06
forceblack = $01AF52		;code96_08
ProcessInputWithRepeat = $01B320		;code96_08
ReadJoy1 = $01B348		;code96_08
ReadJoy2 = $01B360		;code96_08
ReadJoy3 = $01B378		;code96_08
ReadJoy4 = $01B390		;code96_08
printsmallz = $01BA2E		;code96_08
printbigcur = $01BEE8		;code96_08
ExitToOpening = $0216EE		;code96_11
ShootoutPauseMenu = $0236B0		;data96_02
PauseMenu = $023734		;data96_02
PauseMenuNoTimeout = $023890		;data96_02
Z80Program = $025500		;data96_02
SoundBanks = $027026		;data96_02
SoundCmd = $08839E		;data96_04
stop_current_song = $0885FC		;data96_04
SoundOff = $088676		;data96_04
ManualGoalieMenu = $1D86A4		;code96_14
SetMenuPadSide = $1D9844		;code96_15
ReturnToGame = $1E2688		;code96_18
TimeoutMenu = $015570		;data96_01c
SelectGoalieMenu = $015604		;data96_01c


; Main segment code
	include	engine\pause96.asm
