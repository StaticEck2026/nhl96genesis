;	Segment build for code96_18.asm: sets its origin and the outside routines and data it uses,
;	then includes code96_18.asm on its own for checking against the ROM.

; region code
	org	$1E1A3C

; includes for stubs to replace removed code
	include	stubinc\ports.inc	;IO_* / VDP_* ports
	include	stubinc\equals.inc	;VDP status bits
	include	ram96.asm		;RAM map
	include	externs96.asm		;outside addresses still in incbin segments. Equates only
	include	macros\genesis.mac	;String

; External addresses outside, read from lst/nhl96.bin.
DrawFaceoffWindow = $00A2A0		;faceoff96
forceblack = $01AF52		;video96
DoFill = $01B52E		;video96
setVram_0 = $01B594		;video96
dobitmap = $01B692		;video96
DecompressGraphicsPlain = $01B730		;video96
printz = $01BB8E		;video96
sub_1C184 = $01C184		;penalty96
nullsub_4 = $01D062		;penalty96
VBlank = $0201DC		;code96_11
setvideo = $02034A		;code96_11
sub_21046 = $021046		;code96_11
setupIceRinkPal = $02109A		;code96_11
setupEASNmap = $0210B0		;code96_11
SprSort = $0213AE		;code96_11
setplayercolors = $0215B2		;code96_11
LoadSmallFont = $0243A0		;data96_02
LoadBigFonts = $0243BA		;data96_02
Z80Program = $025500		;data96_02
SoundBanks = $027026		;data96_02
SoundCmd = $08839E		;data96_04
stop_current_song = $0885FC		;data96_04
FaceOffMap = $091D46		;data96_05
Rinktilelist = $0923E4		;data96_05
RefTiles = $097E72		;data96_05
RefTilesHor = $098F30		;data96_05
CrowdFrameList = $13AA96		;data96_06
FaceOffSprites = $13BCB0		;data96_06
EnergyBarMap = $13D290		;data96_06
ReplayBannerMap = $141228		;data96_07
unk_1C4C4E = $1C4C4E		;data96_10
LoadReplayIcon = $1D8E5C		;code96_15
LoadHomeTeamGfx = $1D8E6C		;code96_15

; Main segment code
	include	code96_18.asm
