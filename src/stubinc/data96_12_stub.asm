;	Segment build for data96_12.asm: sets its origin and the outside routines and data it uses,
;	then includes data96_12.asm on its own for checking against the ROM.

; region code
	org	$1E2E76

; includes for stubs to replace removed code
	include	stubinc\ports.inc	;IO_* / VDP_* ports
	include	stubinc\equals.inc	;VDP status bits
	include	ram96.asm		;RAM map
	include	externs96.asm		;outside addresses still in incbin segments. Equates only
	include	macros\genesis.mac	;String

; External addresses outside, read from lst/nhl96.bin.
sub_1217A = $01217A		;season96
sub_1218A = $01218A		;season96
unk_122A4 = $0122A4		;season96
sub_12640 = $012640		;season96
DrawSetupTeamBlock = $012B84		;season96
unk_12D46 = $012D46		;teamgfx96
GetGoalieCountD7 = $015774		;players96_count
GetPlayerCountD7 = $0157B2		;players96_count
orjoy = $01B2C4		;video96
ProcessInputWithRepeat = $01B320		;video96
ReadJoy1 = $01B348		;video96
ReadJoy2 = $01B360		;video96
ReadJoy3 = $01B378		;video96
ReadJoy4 = $01B390		;video96
setVram = $01B57E		;video96
dobitmap = $01B692		;video96
DecompressGraphicsPlain = $01B730		;video96
eraser = $01B976		;video96
printsmallz = $01BA2E		;video96
printz = $01BB8E		;video96
printcurz = $01BC72		;video96
printbigz = $01BED6		;video96
printbig = $01BEEC		;video96
SkipStrings = $01D7F2		;hockey96_inter
Opening2 = $02174A		;hockey96_open
unk_170B0C = $170B0C		;data96_07
RosterFont = $179168		;data96_08
SmallFontMap2 = $17A164		;data96_08
BigFontMap4 = $17B680		;data96_08
unk_18948A = $18948A		;data96_08
unk_18B4F8 = $18B4F8		;data96_08
unk_18B916 = $18B916		;data96_08
unk_1AC7C6 = $1AC7C6		;data96_09
PStatsClearList = $1DB364		;code96_16
PStatsPalette = $1DBB92		;code96_16
PListPrint = $1E6162		;code96_19

; Main segment code
	include	data96_12.asm
