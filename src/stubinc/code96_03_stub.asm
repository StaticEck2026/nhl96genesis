;	Segment build for code96_03.asm: sets its origin and the outside routines and data it uses,
;	then includes code96_03.asm on its own for checking against the ROM.

; region code
	org	$00B85E

; includes for stubs to replace removed code
	include	stubinc\ports.inc	;IO_* / VDP_* ports
	include	stubinc\equals.inc	;VDP status bits
	include	ram96.asm		;RAM map
	include	externs96.asm		;outside addresses still in incbin segments. Equates only
	include	macros\genesis.mac	;String

; External addresses outside, read from lst/nhl96.bin.
rtss7 = $00A3DA		;code96_02
assfaceoff = $009A24		;code96_02
assfaceoffpl = $009A40		;code96_02
puckfaceoff = $009AD6		;code96_02
puckfaceoff2 = $009E52		;code96_02
assbench = $016E40		;code96_06
asseben = $016FCE		;code96_06
asspenalty = $017058		;code96_06
assdopen = $0171E0		;code96_06
assepen = $017210		;code96_06
assgoaliebreakwait = $0172C2		;code96_06
assstanley = $017334		;code96_06
assscore = $017388		;code96_06
assgoaliectrl = $01745A		;code96_06
assgoaliecpu = $0175BE		;code96_06
assgoalietopuck = $017E7E		;code96_07
chkpuckc = $018068		;code96_07
asspuckc = $018092		;code96_07
assbreakaway = $018874		;code96_07
assnearest = $01889A		;code96_07
asspassrec = $018ECA		;code96_07
assshoot = $018FE0		;code96_07
puckshootout = $019018		;code96_07
puckpenshot = $019326		;code96_07
pucknorm = $019B70		;code96_07
puckunflip = $019F14		;code96_07
puckshadow = $019F58		;code96_08
assinsert = $01A3D0		;code96_08
SetSPA = $01A614		;code96_08
playeracc = $01AB56		;code96_08
eraser = $01B976		;code96_08
printz = $01BB8E		;code96_08
AddPenalty2 = $01C1D2		;code96_09
loadTeamStruct = $01D328		;code96_09
setd0player = $01F662		;code96_10
rtss2 = $01F84A		;code96_10
assonetimer = $1D6872		;data96_10
SPA3128 = $3128		;SPA value (frames96)
SPA3182 = $3182		;SPA value (frames96)
SPA3252 = $3252		;SPA value (frames96)
SPA3300 = $3300		;SPA value (frames96)
SPA333A = $333A		;SPA value (frames96)
SPA34D0 = $34D0		;SPA value (frames96)
SPAfgrab = $328C		;SPA value (frames96)
SPAfhigh = $31BC		;SPA value (frames96)
SPAfight = $30A4		;SPA value (frames96)
SPAflow = $32C6		;SPA value (frames96)


; Main segment code
	include	code96_03.asm
