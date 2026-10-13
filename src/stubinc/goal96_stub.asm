;	Segment build for engine\goal96.asm: sets its origin and the outside routines and data it uses,
;	then includes the file on its own for checking against the ROM.

; region code
	org	$00B04E

; includes for stubs to replace removed code
	include	stubinc\ports.inc	;IO_* / VDP_* ports
	include	stubinc\equals.inc	;VDP status bits
	include	ram96.asm		;RAM map
	include	externs96.asm		;outside addresses still in incbin segments. Equates only
	include	macros\genesis.mac	;String

; External addresses outside, read from lst/nhl96.bin.
DrawSetupTeamBlock = $012B84		;season96
ZeroLong = $000772		;main96
vcountwait = $0151E0		;data96_01
orjoy = $01B2C4		;code96_08
nodiag = $01B2F8		;code96_08
ReadJoy1 = $01B348		;code96_08
ReadJoy2 = $01B360		;code96_08
ReadJoy3 = $01B378		;code96_08
ReadJoy4 = $01B390		;code96_08
setVram = $01B57E		;code96_08
Vmaddr = $01B678		;code96_08
dobitmap = $01B692		;code96_08
DecompressGraphicsPlain = $01B730		;code96_08
eraser = $01B976		;code96_08
printsmallz = $01BA2E		;code96_08
printsmall = $01BA40		;code96_08
printz = $01BB8E		;code96_08
VBlank_SetOptions = $021B52		;code96_11
ControllerBgMap = $173C7A		;data96_07
RosterFont = $179168		;data96_08
PadIconMap1 = $1B53C4		;data96_09
PadIconMap2 = $1B5942		;data96_09
PadIconMap3 = $1B5EC0		;data96_09
PadIconMap4 = $1B643E		;data96_09
PadCursorMap = $1B69BC		;data96_09
ControllerTitleMap = $1B6F3A		;data96_09
unk_1B773A = $1B773A		;data96_09

; Main segment code
	include	engine\goal96.asm
