;	Segment build for code96_20.asm: sets its origin and the outside routines and data it uses,
;	then includes code96_20.asm on its own for checking against the ROM.

; region code
	org	$1E824C

; includes for stubs to replace removed code
	include	stubinc\ports.inc	;IO_* / VDP_* ports
	include	stubinc\equals.inc	;VDP status bits
	include	ram96.asm		;RAM map
	include	externs96.asm		;outside addresses still in incbin segments. Equates only
	include	macros\genesis.mac	;String

; External addresses outside, read from lst/nhl96.bin.
ProductCode = $000180		;main96
WriteSRAMBits = $0096E8		;srambits96
ReadSRAMBits = $00975A		;srambits96
sub_103AA = $0103AA		;code96_04
sub_104EE = $0104EE		;code96_04
sub_1161E = $01161E		;code96_05
SmallLogoPtrs = $012CDE		;data96_01
unk_12D46 = $012D46		;data96_01
GetGoalieCountD7 = $015774		;code96_06
forceblack = $01AF52		;code96_08
randomd0 = $01B0A6		;code96_08
sub_1B282 = $01B282		;code96_08
orjoy = $01B2C4		;code96_08
DoFill = $01B52E		;code96_08
setVram = $01B57E		;code96_08
setVram_0 = $01B594		;code96_08
Vmaddr = $01B678		;code96_08
dobitmap = $01B692		;code96_08
DecompressGraphicsWithCallback = $01B724		;code96_08
DecompressGraphicsPlain = $01B730		;code96_08
eraser = $01B976		;code96_08
printsmallz = $01BA2E		;code96_08
printsmall = $01BA40		;code96_08
printz = $01BB8E		;code96_08
printbigcur = $01BEE8		;code96_08
VBlank = $0201DC		;code96_11
updatescroll = $0203BC		;code96_11
KillCrowd = $020E28		;code96_11
setupIceRinkPal = $02109A		;code96_11
maketree = $021CF4		;code96_11
MakeSRAMChecksum = $0241AA		;data96_02
ReadSRAM = $0241E8		;data96_02
Z80Program = $025500		;data96_02
SoundBanks = $027026		;data96_02
SoundCmd = $08839E		;data96_04
updatesound = $0883D4		;data96_04
sfx = $088470		;data96_04
song = $088586		;data96_04
SoundOff = $088676		;data96_04
unk_88A18 = $088A18		;code96_13
unk_8F2C6 = $08F2C6		;data96_05
unk_90686 = $090686		;data96_05
unk_911B8 = $0911B8		;data96_05
Rinktilelist = $0923E4		;data96_05
RosterFont = $179168		;data96_08
BigFontMap = $1B89C8		;data96_09
unk_1C6C4C = $1C6C4C		;data96_10
unk_1CAEFA = $1CAEFA		;data96_10
unk_1CCBA8 = $1CCBA8		;data96_10
unk_1CCEE8 = $1CCEE8		;data96_10
unk_1D5420 = $1D5420		;data96_10
StandingsPoints = $1D9CC6		;code96_15
StandingsGroups = $1D9D12		;code96_15
StandingsGroup4 = $1D9D76		;code96_15
SortStandings = $1D9D92		;code96_15
sub_1DA9EA = $1DA9EA		;code96_15
unk_1E2E76 = $1E2E76		;data96_12

; Main segment code
	include	code96_20.asm
