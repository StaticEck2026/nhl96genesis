;	Outside addresses. A routine or table that converted code uses, but that is still inside an incbin
;	segment, is an equate here: one name, one line, in address order. When its segment is converted the
;	equate moves out (the label in the segment replaces it). Included by nhl96.asm and every stub.

unk_1E99DB	equ	$1E99DB
byte_1EAF98	equ	$1EAF98
unk_1EB5BB	equ	$1EB5BB
unk_1EB75F	equ	$1EB75F
