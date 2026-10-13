;	Segment build for code96_09.asm: sets its origin and the outside routines and data it uses,
;	then includes code96_09.asm on its own for checking against the ROM.

; region code
	org	$01BF94

; includes for stubs to replace removed code
	include	stubinc\ports.inc	;IO_* / VDP_* ports
	include	stubinc\equals.inc	;VDP status bits
	include	ram96.asm		;RAM map
	include	externs96.asm		;outside addresses still in incbin segments. Equates only
	include	macros\genesis.mac	;String

; External addresses outside, read from lst/nhl96.bin.
TeamList = $00077E		;teamdata96
limitfo = $00A370		;code96_02
checkfight = $00B6A0		;code96_02
ClearMessageLine = $00C0A2		;code96_03
sub_10CF2 = $010CF2		;code96_05
sub_112DA = $0112DA		;code96_05
sub_11510 = $011510		;code96_05
SetupPauseScreen = $014F14		;data96_01
InitMenuState = $014F70		;data96_01
HandleMenuInput = $014FA8		;data96_01
vcountwait = $0151E0		;data96_01
getGoalieSCnum = $0168B8		;code96_06
assinsert = $01A3D0		;code96_08
assreplace = $01A3DA		;code96_08
vtoa = $01A3EE		;code96_08
GetHot = $01A458		;code96_08
SetSPA = $01A614		;code96_08
WeightedRandomSelect = $01AED4		;code96_08
forceblack = $01AF52		;code96_08
randomd0 = $01B0A6		;code96_08
sub_1B282 = $01B282		;code96_08
ProcessInputWithRepeat = $01B320		;code96_08
Vmaddr = $01B678		;code96_08
dobitmap = $01B692		;code96_08
DecompressGraphicsPlain = $01B730		;code96_08
eraser = $01B976		;code96_08
Framer = $01B9B0		;code96_08
printz = $01BB8E		;code96_08
print = $01BBA0		;code96_08
PushTime = $01BD84		;code96_08
appendz = $01BE78		;code96_08
appstring = $01BE80		;code96_08
printbigcur = $01BEE8		;code96_08
FallDown = $01E110		;code96_10
checkwallcoll = $01E630		;code96_10
GetPeriodTimeRemaining = $01EBCC		;code96_10
rtss2 = $01F84A		;code96_10
ResetBench = $01FDF4		;code96_10
sub_1FE58 = $01FE58		;code96_10
setplayer = $01FEA0		;code96_10
GetShifter = $0224E2		;code96_12
ShowThreeStars = $022820		;code96_12
PenaltyShotBox = $022B70		;code96_12
ShowGoalBox = $022C5E		;code96_12
GetPlayerName = $022E70		;code96_12
GetPlayerNumInitial = $022ED6		;code96_12
bfasciicon = $0232C8		;data96_02
priolist = $023426		;data96_02
ShootoutIntermissionMenu = $0239D4		;data96_02
PregameMenu = $023A58		;data96_02
PlayoffPregameMenu = $023AF4		;data96_02
IntermissionMenu = $023BA8		;data96_02
GameOverMenu = $023CBC		;data96_02
PlayoffGameOverMenu = $023D88		;data96_02
sfx = $088470		;data96_04
song = $088586		;data96_04
stop_current_song = $0885FC		;data96_04
newcheck = $0887E4		;code96_13
Framermap = $091B86		;data96_05
RefTiles = $097E72		;data96_05
RefTilesHor = $098F30		;data96_05
EnergyBarMap = $13D290		;data96_06
EASNmap = $13D59E		;data96_06


; Main segment code
	include	code96_09.asm
