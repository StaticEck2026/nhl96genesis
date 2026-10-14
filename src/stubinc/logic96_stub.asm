;	Segment build for engine\logic96.asm: sets its origin and the outside routines and data it uses,
;	then includes the file on its own for checking against the ROM.

; region code
	org	$00C548

; includes for stubs to replace removed code
	include	stubinc\ports.inc	;IO_* / VDP_* ports
	include	stubinc\equals.inc	;VDP status bits
	include	ram96.asm		;RAM map
	include	externs96.asm		;outside addresses still in incbin segments. Equates only
	include	macros\genesis.mac	;String

; External addresses outside, read from lst/nhl96.bin.
assfaceoff = $009A24		;faceoff96
assfaceoffpl = $009A40		;faceoff96
puckfaceoff = $009AD6		;faceoff96
puckfaceoff2 = $009E52		;faceoff96
assbench = $016E40		;code96_06b
asseben = $016FCE		;code96_06b
asspenalty = $017058		;code96_06b
assdopen = $0171E0		;code96_06b
assepen = $017210		;code96_06b
assgoaliebreakwait = $0172C2		;code96_06b
assstanley = $017334		;code96_06b
assscore = $017388		;code96_06b
assgoaliectrl = $01745A		;code96_06b
assgoaliecpu = $0175BE		;code96_06b
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
rtss2 = $01F84A		;code96_10
assonetimer = $1D6872		;data96_10
assfight = $00B988		;fight96
assfwatch = $00C1C8		;fight96


; Main segment code
	include	engine\logic96.asm
