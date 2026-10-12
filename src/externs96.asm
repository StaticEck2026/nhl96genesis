;	Outside addresses. A routine or table that converted code uses, but that is still inside an incbin
;	segment, is an equate here: one name, one line, in address order. When its segment is converted the
;	equate moves out (the label in the segment replaces it). Included by nhl96.asm and every stub.

VBjsr		equ	$000776	;vertical blank interrupt, jumps through the vbint RAM vector
Begin		equ	$01464C	;cold start: clear RAM, start the sound driver and the menus
IRQ7		equ	$0202E4	;rte
AdrErr		equ	$023144	;bus and address error handler
InvOpCode	equ	$02316C	;illegal instruction handler
DivBy0		equ	$023196	;zero divide handler
ValidationRoutine	equ	$1E9038	;ROM checksum
