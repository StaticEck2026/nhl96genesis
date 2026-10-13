;	Segment build for data96_01.asm: sets its origin and the outside routines and data it uses,
;	then includes the file on its own for checking against the ROM.

; region code
	org	$012BFE

; includes for stubs to replace removed code
	include	stubinc\ports.inc	;IO_* / VDP_* ports
	include	stubinc\equals.inc	;VDP status bits
	include	ram96.asm		;RAM map
	include	externs96.asm		;outside addresses still in incbin segments. Equates only
	include	macros\genesis.mac	;String

; External addresses outside, read from lst/nhl96.bin.
TeamBlockANH = $148054		;data96_07
TeamBlockBOS = $148502		;data96_07
TeamBlockBUF = $148970		;data96_07
TeamBlockCGY = $148DDE		;data96_07
TeamBlockCHI = $14928C		;data96_07
TeamBlockDAL = $14973A		;data96_07
TeamBlockDET = $149BA8		;data96_07
TeamBlockEDM = $14A016		;data96_07
TeamBlockFLA = $14A4E4		;data96_07
TeamBlockHFD = $14A952		;data96_07
TeamBlockLA = $14AE20		;data96_07
TeamBlockMTL = $14B2EE		;data96_07
TeamBlockNJ = $14B7BC		;data96_07
TeamBlockNYI = $14BC8A		;data96_07
TeamBlockNYR = $14C158		;data96_07
TeamBlockOTW = $14C626		;data96_07
TeamBlockPHI = $14CAD4		;data96_07
TeamBlockPIT = $14CFA2		;data96_07
TeamBlockQUE = $14D470		;data96_07
TeamBlockSJ = $14D8DE		;data96_07
TeamBlockSTL = $14DD6C		;data96_07
TeamBlockTB = $14E1DA		;data96_07
TeamBlockTOR = $14E6A8		;data96_07
TeamBlockVAN = $14EB56		;data96_07
TeamBlockWSH = $14F024		;data96_07
TeamBlockWPG = $14F4F2		;data96_07
TeamLogoANH = $14F9A0		;data96_07
TeamLogoBOS = $150A8E		;data96_07
TeamLogoBUF = $151B1C		;data96_07
TeamLogoCGY = $152BEA		;data96_07
TeamLogoCHI = $153CD8		;data96_07
TeamLogoDAL = $154DE6		;data96_07
TeamLogoDET = $155ED4		;data96_07
TeamLogoEDM = $156FA2		;data96_07
TeamLogoFLA = $1580B0		;data96_07
TeamLogoHFD = $15919E		;data96_07
TeamLogoLA = $15A2AC		;data96_07
TeamLogoMTL = $15B3DA		;data96_07
TeamLogoNJ = $15C508		;data96_07
TeamLogoNYI = $15D636		;data96_07
TeamLogoNYR = $15E764		;data96_07
TeamLogoOTW = $15F872		;data96_07
TeamLogoPHI = $160980		;data96_07
TeamLogoPIT = $161AAE		;data96_07
TeamLogoQUE = $162BDC		;data96_07
TeamLogoSJ = $163CAA		;data96_07
TeamLogoSTL = $164DB8		;data96_07
TeamLogoTB = $165EA6		;data96_07
TeamLogoTOR = $166FB4		;data96_07
TeamLogoVAN = $1680A2		;data96_07
TeamLogoWSH = $1691D0		;data96_07
TeamLogoWPG = $16A2FE		;data96_07
SmallLogoFLA = $16B40C		;data96_07
SmallLogoBUF = $16B78C		;data96_07
SmallLogoANH = $16BAAC		;data96_07
SmallLogoBOS = $16BDEC		;data96_07
SmallLogoCGY = $16C14C		;data96_07
SmallLogoCHI = $16C52C		;data96_07
SmallLogoDAL = $16C8CC		;data96_07
SmallLogoDET = $16CBAC		;data96_07
SmallLogoEDM = $16CEEC		;data96_07
SmallLogoHFD = $16D2CC		;data96_07
SmallLogoLA = $16D56C		;data96_07
SmallLogoMTL = $16D86C		;data96_07
SmallLogoNJ = $16DBAC		;data96_07
SmallLogoNYI = $16DF4C		;data96_07
SmallLogoNYR = $16E26C		;data96_07
SmallLogoOTW = $16E64C		;data96_07
SmallLogoPHI = $16E9CC		;data96_07
SmallLogoPIT = $16ECEC		;data96_07
SmallLogoQUE = $16F00C		;data96_07
SmallLogoSJ = $16F32C		;data96_07
SmallLogoSTL = $16F6AC		;data96_07
SmallLogoTB = $16FA0C		;data96_07
SmallLogoTOR = $16FDEC		;data96_07
SmallLogoVAN = $1700EC		;data96_07
SmallLogoWSH = $17040C		;data96_07
SmallLogoWPG = $17074C		;data96_07


; Main segment code
	include	data96_01.asm
