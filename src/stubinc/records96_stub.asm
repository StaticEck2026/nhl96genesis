;	Segment build for front\records96.asm: sets its origin and the outside routines and data it uses,
;	then includes the file on its own for checking against the ROM.

; region code
	org	$1E646C

; includes for stubs to replace removed code
	include	stubinc\ports.inc	;IO_* / VDP_* ports
	include	stubinc\equals.inc	;VDP status bits
	include	ram96.asm		;RAM map
	include	externs96.asm		;outside addresses still in incbin segments. Equates only
	include	macros\genesis.mac	;String

; External addresses outside, read from lst/nhl96.bin.
printz = $01BB8E		;video96
PushNumberWidth = $01BE1C		;video96
WriteSRAM = $024188		;sram96
MakeSRAMChecksum = $0241AA		;sram96
ReadSRAM = $0241E8		;sram96
sub_1218A = $01218A		;season96
sub_12640 = $012640		;season96
dobitmap = $01B692		;video96
DecompressGraphicsPlain = $01B730		;video96
sub_1217A = $01217A		;season96
DrawSetupTeamBlock = $012B84		;season96
unk_12D46 = $012D46		;teamgfx96
orjoy = $01B2C4		;video96
ProcessInputWithRepeat = $01B320		;video96
ReadJoy1 = $01B348		;video96
ReadJoy2 = $01B360		;video96
ReadJoy3 = $01B378		;video96
ReadJoy4 = $01B390		;video96
setVram = $01B57E		;video96
eraser = $01B976		;video96
printsmallz = $01BA2E		;video96
printcurz = $01BC72		;video96
printcur = $01BC84		;video96
printbigz = $01BED6		;video96
unk_170B0C = $170B0C		;data96_07
RosterFont = $179168		;data96_08
BigFontMap4 = $17B680		;data96_08
DecompressGraphicsWithCallback = $01B724		;video96
unk_1ACFE6 = $1ACFE6		;data96_09
unk_1AD7C6 = $1AD7C6		;data96_09
unk_1AEB94 = $1AEB94		;data96_09
PadIconMap1 = $1B53C4		;data96_09
PadIconMap2 = $1B5942		;data96_09
PadIconMap3 = $1B5EC0		;data96_09
PadIconMap4 = $1B643E		;data96_09
WriteNameLog = $1D7B46		;code96_14
ReadNameLog = $1D7B50		;code96_14


; Main segment code
	include	front\records96.asm
