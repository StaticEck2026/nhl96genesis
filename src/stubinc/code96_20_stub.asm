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
sub_103AA = $0103AA		;trade96
sub_104EE = $0104EE		;trade96
sub_1161E = $01161E		;season96
SmallLogoPtrs = $012CDE		;teamgfx96
unk_12D46 = $012D46		;teamgfx96
GetGoalieCountD7 = $015774		;players96_count
forceblack = $01AF52		;video96
randomd0 = $01B0A6		;video96
sub_1B282 = $01B282		;video96
orjoy = $01B2C4		;video96
DoFill = $01B52E		;video96
setVram = $01B57E		;video96
setVram_0 = $01B594		;video96
Vmaddr = $01B678		;video96
dobitmap = $01B692		;video96
DecompressGraphicsWithCallback = $01B724		;video96
DecompressGraphicsPlain = $01B730		;video96
eraser = $01B976		;video96
printsmallz = $01BA2E		;video96
printsmall = $01BA40		;video96
printz = $01BB8E		;video96
printbigcur = $01BEE8		;video96
VBlank = $0201DC		;display96
updatescroll = $0203BC		;display96
KillCrowd = $020E28		;display96
setupIceRinkPal = $02109A		;display96
maketree = $021CF4		;playoff96
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
