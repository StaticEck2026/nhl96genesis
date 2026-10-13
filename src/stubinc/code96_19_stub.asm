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
FormatPlayerNameD7 = $01017A		;code96_04
GetCreatedName = $0101DC		;code96_04
sub_1217A = $01217A		;code96_05
sub_1218A = $01218A		;code96_05
unk_122A4 = $0122A4		;code96_05
sub_12640 = $012640		;code96_05
DrawSetupTeamBlock = $012B84		;code96_05
sub_12BB2 = $012BB2		;code96_05
TeamBlockPtrs = $012BFE		;data96_01
unk_12D46 = $012D46		;data96_01
GetGoalieCountD7 = $015774		;code96_06
forceblack = $01AF52		;code96_08
sub_1B282 = $01B282		;code96_08
orjoy = $01B2C4		;code96_08
ProcessInputWithRepeat = $01B320		;code96_08
ReadJoy1 = $01B348		;code96_08
ReadJoy2 = $01B360		;code96_08
ReadJoy3 = $01B378		;code96_08
ReadJoy4 = $01B390		;code96_08
setVram = $01B57E		;code96_08
Vmaddr = $01B678		;code96_08
dobitmap = $01B692		;code96_08
DecompressGraphicsWithCallback = $01B724		;code96_08
DecompressGraphicsPlain = $01B730		;code96_08
eraser = $01B976		;code96_08
printsmallz = $01BA2E		;code96_08
printz = $01BB8E		;code96_08
print = $01BBA0		;code96_08
printcurz = $01BC72		;code96_08
printcur = $01BC84		;code96_08
PushNumberWidth = $01BE1C		;code96_08
printbigz = $01BED6		;code96_08
printbig = $01BEEC		;code96_08
printbigz1 = $01C11A		;code96_09
printbigz2 = $01C12C		;code96_09
printbig1 = $01C13E		;code96_09
printbig2 = $01C15A		;code96_09
sub_1CFE4 = $01CFE4		;code96_09
EASNLogo = $01D064		;code96_09
SkipStrings = $01D7F2		;code96_09
rtss2 = $01F84A		;code96_10
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

; Main segment code
	include	code96_19.asm
