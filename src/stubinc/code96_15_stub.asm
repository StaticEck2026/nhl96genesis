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
sub_1218A = $01218A		;season96
unk_122A4 = $0122A4		;season96
sub_12640 = $012640		;season96
GetPOSlotTeam = $0143BC		;awards96
GetGoalieCountD7 = $015774		;players96_count
GetPlayerCountD7 = $0157B2		;players96_count
assexit = $01A3BE		;logic96_vec
SetSPA = $01A614		;skate96
forceblack = $01AF52		;video96
waitx = $01B152		;video96
setVram_0 = $01B594		;video96
dobitmap = $01B692		;video96
DecompressGraphicsPlain = $01B730		;video96
printz = $01BB8E		;video96
print = $01BBA0		;video96
PushNumberWidth = $01BE1C		;video96
sub_1FE78 = $01FE78		;players96
vb2 = $0202C4		;display96
Opening2 = $02174A		;hockey96_open
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
