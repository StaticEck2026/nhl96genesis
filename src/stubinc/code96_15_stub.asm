;	Segment build for code96_15.asm: sets its origin and the outside routines and data it uses,
;	then includes code96_15.asm on its own for checking against the ROM.

; region code
	org	$1D8E5C

; includes for stubs to replace removed code
	include	stubinc\ports.inc	;IO_* / VDP_* ports
	include	stubinc\equals.inc	;VDP status bits
	include	ram96.asm		;RAM map
	include	externs96.asm		;outside addresses still in incbin segments. Equates only
	include	macros\genesis.mac	;String

; External addresses outside, read from lst/nhl96.bin.
sub_1218A = $01218A		;code96_05
unk_122A4 = $0122A4		;code96_05
sub_12640 = $012640		;code96_05
GetPOSlotTeam = $0143BC		;data96_01
GetGoalieCountD7 = $015774		;code96_06
GetPlayerCountD7 = $0157B2		;code96_06
assexit = $01A3BE		;code96_08
SetSPA = $01A614		;code96_08
forceblack = $01AF52		;code96_08
waitx = $01B152		;code96_08
setVram_0 = $01B594		;code96_08
dobitmap = $01B692		;code96_08
DecompressGraphicsPlain = $01B730		;code96_08
printz = $01BB8E		;code96_08
print = $01BBA0		;code96_08
PushNumberWidth = $01BE1C		;code96_08
sub_1FE78 = $01FE78		;code96_10
vb2 = $0202C4		;code96_11
Opening2 = $02174A		;code96_11
ReplayIconMap = $140AFE		;data96_06
unk_1468D6 = $1468D6		;data96_07
unk_147896 = $147896		;data96_07
unk_18B4F8 = $18B4F8		;data96_08
WaitAnyPad = $1DB288		;code96_16
PStatsArrows = $1DB30E		;code96_16
PStatsClearList = $1DB364		;code96_16
PStatsSetup = $1DB390		;code96_16
PStatsTeamBlock = $1DB526		;code96_16
PStatsHeading = $1DB558		;code96_16
PStatsHelp = $1DB5C4		;code96_16
PStatsCategory = $1DB674		;code96_16
PStatsBuildList = $1DB716		;code96_16
PStatsPrintList = $1DB996		;code96_16

; Main segment code
	include	code96_15.asm
