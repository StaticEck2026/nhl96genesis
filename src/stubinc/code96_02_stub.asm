;	Segment build for code96_02.asm: sets its origin and the outside routines and data it uses,
;	then includes code96_02.asm on its own for checking against the ROM.

; region code
	org	$0096E8

; includes for stubs to replace removed code
	include	stubinc\ports.inc	;IO_* / VDP_* ports
	include	stubinc\equals.inc	;VDP status bits
	include	ram96.asm		;RAM map
	include	externs96.asm		;outside addresses still in incbin segments. Equates only
	include	macros\genesis.mac	;String

; External addresses outside, read from lst/nhl96.bin.
DrawSetupTeamBlock = $012B84		;code96_05
SetShotMode = $00F496		;code96_04
ShotMode = $00F530		;code96_04
lineinput = $00EE0E		;code96_04
passmode = $00F8D2		;code96_04
setpassmode = $00F898		;code96_04
startfight = $00B85E		;code96_03
SetInst = $00B8D0		;code96_03
rtsfight = $00B986		;code96_03
fightinput = $00C26C		;code96_03
SetLCmode = $00EC30		;code96_03
ZeroLong = $000772		;main96
SPAlist = $005F96		;frames96
SPAgdive = $49A		;SPA value (frames96)
SPAgglover = $12E		;SPA value (frames96)
SPAgglovel = $1CA		;SPA value (frames96)
SPAgstackr = $440		;SPA value (frames96)
SPAgstackl = $3E6		;SPA value (frames96)
SPAgstickr = $266		;SPA value (frames96)
SPAgstickl = $20C		;SPA value (frames96)
SPA099A = $99A		;SPA value (frames96)
SPAhook = $1792		;SPA value (frames96)
SPA2126 = $2126		;SPA value (frames96)
SPA2150 = $2150		;SPA value (frames96)
SPA288C = $288C		;SPA value (frames96)
startpause1 = $014D6E		;data96_01
startpause2 = $014D74		;data96_01
startpause3 = $014D7C		;data96_01
startpause4 = $014D84		;data96_01
vcountwait = $0151E0		;data96_01
getGoalieSCnum = $0168B8		;code96_06
burst = $016934		;code96_06
holdplayer = $016988		;code96_06
chgplayer = $016A46		;code96_06
setc1player = $016C52		;code96_06
setc2player = $016C5C		;code96_06
setc3player = $016C68		;code96_06
setc4player = $016C74		;code96_06
setpads = $016D6A		;code96_06
goaliesave = $017C58		;code96_07
checkob = $0187D4		;code96_07
assinsert = $01A3D0		;code96_08
assreplace = $01A3DA		;code96_08
vtoa = $01A3EE		;code96_08
SetSPA = $01A614		;code96_08
doplayeracc = $01A62A		;code96_08
sroot = $01B0DE		;code96_08
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
Framer = $01B9B0		;code96_08
printsmallz = $01BA2E		;code96_08
printsmall = $01BA40		;code96_08
printz = $01BB8E		;code96_08
print = $01BBA0		;code96_08
SkipStrings = $01D7F2		;code96_09
checkcoll = $01D7FE		;code96_09
VBlank_SetOptions = $021B52		;code96_11
linelist = $023342		;data96_02
MakeSRAMChecksum = $0241AA		;data96_02
doassignment = $024380		;data96_02
FaceOffMap = $091D46		;data96_05
ControllerBgMap = $173C7A		;data96_07
RosterFont = $179168		;data96_08
PadIconMap1 = $1B53C4		;data96_09
PadIconMap2 = $1B5942		;data96_09
PadIconMap3 = $1B5EC0		;data96_09
PadIconMap4 = $1B643E		;data96_09
PadCursorMap = $1B69BC		;data96_09
ControllerTitleMap = $1B6F3A		;data96_09
unk_1B773A = $1B773A		;data96_09
PuckOnAttackHalf = $1D6B66		;code96_14
ShortenMsgTimer = $1D8676		;code96_14


; Main segment code
	include	code96_02.asm
