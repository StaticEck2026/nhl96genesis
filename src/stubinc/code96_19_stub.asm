;	Segment build for code96_19.asm: sets its origin and the outside routines and data it uses,
;	then includes code96_19.asm on its own for checking against the ROM.

; region code
	org	$1E6162

; includes for stubs to replace removed code
	include	stubinc\ports.inc	;IO_* / VDP_* ports
	include	stubinc\equals.inc	;VDP status bits
	include	ram96.asm		;RAM map
	include	externs96.asm		;outside addresses still in incbin segments. Equates only
	include	macros\genesis.mac	;String

; External addresses outside, read from lst/nhl96.bin.
TeamList = $00077E		;teamdata96
FormatPlayerNameD7 = $01017A		;trade96
GetCreatedName = $0101DC		;trade96
sub_1217A = $01217A		;season96
sub_1218A = $01218A		;season96
unk_122A4 = $0122A4		;season96
sub_12640 = $012640		;season96
DrawSetupTeamBlock = $012B84		;season96
sub_12BB2 = $012BB2		;season96
TeamBlockPtrs = $012BFE		;teamgfx96
unk_12D46 = $012D46		;teamgfx96
GetGoalieCountD7 = $015774		;players96_count
forceblack = $01AF52		;video96
sub_1B282 = $01B282		;video96
orjoy = $01B2C4		;video96
ProcessInputWithRepeat = $01B320		;video96
ReadJoy1 = $01B348		;video96
ReadJoy2 = $01B360		;video96
ReadJoy3 = $01B378		;video96
ReadJoy4 = $01B390		;video96
setVram = $01B57E		;video96
Vmaddr = $01B678		;video96
dobitmap = $01B692		;video96
DecompressGraphicsWithCallback = $01B724		;video96
DecompressGraphicsPlain = $01B730		;video96
eraser = $01B976		;video96
printsmallz = $01BA2E		;video96
printz = $01BB8E		;video96
print = $01BBA0		;video96
printcurz = $01BC72		;video96
printcur = $01BC84		;video96
PushNumberWidth = $01BE1C		;video96
printbigz = $01BED6		;video96
printbig = $01BEEC		;video96
printbigz1 = $01C11A		;penalty96
printbigz2 = $01C12C		;penalty96
printbig1 = $01C13E		;penalty96
printbig2 = $01C15A		;penalty96
sub_1CFE4 = $01CFE4		;penalty96
EASNLogo = $01D064		;penalty96
SkipStrings = $01D7F2		;hockey96_inter
rtss2 = $01F84A		;collide96
FinalizeTextBuffer = $0230AA		;code96_12
WriteSRAM = $024188		;data96_02
MakeSRAMChecksum = $0241AA		;data96_02
ReadSRAM = $0241E8		;data96_02
unk_170B0C = $170B0C		;data96_07
RosterFont = $179168		;data96_08
SmallFontMap2 = $17A164		;data96_08
BigFontMap4 = $17B680		;data96_08
unk_1ACFE6 = $1ACFE6		;data96_09
unk_1AD7C6 = $1AD7C6		;data96_09
unk_1AEB94 = $1AEB94		;data96_09
unk_1AEF62 = $1AEF62		;data96_09
unk_1AF782 = $1AF782		;data96_09
unk_1B11B0 = $1B11B0		;data96_09
PresidentsPic = $1B14DE		;data96_09
ArtRossPic = $1B1B34		;data96_09
NorrisPic = $1B244A		;data96_09
VezinaPic = $1B2BC0		;data96_09
CampbellPic = $1B32B6		;data96_09
WalesPic = $1B3A0C		;data96_09
HartPic = $1B3F82		;data96_09
ConnSmythePic = $1B4538		;data96_09
PearsonPic = $1B4D4E		;data96_09
PadIconMap1 = $1B53C4		;data96_09
PadIconMap2 = $1B5942		;data96_09
PadIconMap3 = $1B5EC0		;data96_09
PadIconMap4 = $1B643E		;data96_09
BigFontMap = $1B89C8		;data96_09
unk_1BDCD4 = $1BDCD4		;data96_09
unk_1C0302 = $1C0302		;data96_10
unk_1C4810 = $1C4810		;data96_10
WriteNameLog = $1D7B46		;code96_14
ReadNameLog = $1D7B50		;code96_14
unk_1DAE32 = $1DAE32		;code96_15
PListColumns = $1E6142		;data96_12
GetAwardWinner = $1E824C		;code96_20
sub_1E83E6 = $1E83E6		;code96_20

; Main segment code
	include	code96_19.asm
