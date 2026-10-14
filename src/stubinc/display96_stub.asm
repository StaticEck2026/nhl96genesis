;	Segment build for display96.asm: sets its origin and the outside routines and data it uses,
;	then includes the file on its own for checking against the ROM.

; region code
	org	$0201DC

; includes for stubs to replace removed code
	include	stubinc\ports.inc	;IO_* / VDP_* ports
	include	stubinc\equals.inc	;VDP status bits
	include	ram96.asm		;RAM map
	include	externs96.asm		;outside addresses still in incbin segments. Equates only
	include	macros\genesis.mac	;String

; External addresses outside, read from lst/nhl96.bin.
jdtab = $01B3C8		;video96
DoDMA = $01B3EC		;video96
DoFill = $01B52E		;video96
setVram = $01B57E		;video96
DecompressGraphicsPlain = $01B730		;video96
sub_1C184 = $01C184		;penalty96
rtss2 = $01F84A		;collide96
sizetab = $0233AC		;data96_02
LoadSmallFont = $0243A0		;data96_02
LoadBigFonts = $0243BA		;data96_02
Rinktilelist = $0923E4		;data96_05
Sprites = $09AA9E		;data96_05
CrowdFrameList = $13AA96		;data96_06
FaceOffSprites = $13BCB0		;data96_06
EnergyBarMap = $13D290		;data96_06
EASNmap = $13D59E		;data96_06
RevRinkTilelist = $13E99A		;data96_06
SmallFontMap = $179A76		;data96_08
UpdateCrowdMeter = $1D6D40		;code96_14
nullsub_5 = $1D84D4		;shootout96_path
LoadReplayIcon = $1D8E5C		;code96_15
LoadHomeTeamGfx = $1D8E6C		;code96_15
showclock = $1E7664		;middle96_clock
setplayercolors = $0215B2		;control96_team


; Main segment code
	include	display96.asm
