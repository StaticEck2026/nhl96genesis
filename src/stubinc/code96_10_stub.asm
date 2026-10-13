;	Segment build for code96_10.asm: sets its origin and the outside routines and data it uses,
;	then includes code96_10.asm on its own for checking against the ROM.

; region code
	org	$01E110

; includes for stubs to replace removed code
	include	stubinc\ports.inc	;IO_* / VDP_* ports
	include	stubinc\equals.inc	;VDP status bits
	include	ram96.asm		;RAM map
	include	externs96.asm		;outside addresses still in incbin segments. Equates only
	include	macros\genesis.mac	;String

; External addresses outside, read from lst/nhl96.bin.
GetRosterName = $0101E6		;code96_04
GetJerseyNumber = $0102B8		;code96_04
GetPeriodTime = $0148A2		;data96_01
GetPlayerCount = $0157F4		;code96_06
LockScroll = $016786		;code96_06
setc1player = $016C52		;code96_06
setc2player = $016C5C		;code96_06
setc3player = $016C68		;code96_06
setc4player = $016C74		;code96_06
chkpk2 = $018410		;code96_07
EndPenaltyShotPlay = $01971A		;code96_07
puckflip = $019F3E		;code96_08
assinsert = $01A3D0		;code96_08
assreplace = $01A3DA		;code96_08
vtoa = $01A3EE		;code96_08
SetSPA = $01A614		;code96_08
randomd0s = $01B09A		;code96_08
randomd0 = $01B0A6		;code96_08
sroot = $01B0DE		;code96_08
AddPenalty2 = $01C1D2		;code96_09
Stop4Pen = $01C784		;code96_09
PenGoalStuff = $01CC52		;code96_09
nullsub_4 = $01D062		;code96_09
ChkShotStat = $01D218		;code96_09
ClampNibble = $0201C6		;code96_11
sublist = $0233BC		;data96_02
priolist = $023426		;data96_02
sfx = $088470		;data96_04
song = $088586		;data96_04
stop_current_song = $0885FC		;data96_04
ChooseSong = $088688		;data96_04
newcheck = $0887E4		;code96_13
SPA0F14 = $F14		;SPA value (frames96)
SPA12EC = $12EC		;SPA value (frames96)
SPA15B8 = $15B8		;SPA value (frames96)
SPA17E4 = $17E4		;SPA value (frames96)
SPA1F76 = $1F76		;SPA value (frames96)
SPA2576 = $2576		;SPA value (frames96)
SPA26C8 = $26C8		;SPA value (frames96)
SPAboardleft = $2360		;SPA value (frames96)
SPAboardmidl = $2084		;SPA value (frames96)
SPAboardmidr = $24C4		;SPA value (frames96)


; Main segment code
	include	code96_10.asm
