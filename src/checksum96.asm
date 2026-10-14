;	The ROM checksum.

ChecksumLongs	;ValidationRoutine: the number of ROM longs before this table
	dc.l	$7A40A

ChecksumValue	;ValidationRoutine: the expected sum
	dc.l	$5F4547E9

dword_1E9030
	dc.l	0

dword_1E9034
	dc.l	0

ValidationRoutine	;The ROM checksum: sum the ROM longs, less the header long at ProductCode+$C; a red screen and a
	;hang when it is not ChecksumValue
	moveq	#0,d0
	suba.l	a0,a0
	move.l	dword_1E9030(pc),d1
	lsr.l	#2,d1
	move.l	d1,d2
	beq.w	.1
	subq.l	#1,d1
	cmp.l	ChecksumLongs(pc),d2
	ble.s	.0
	move.l	ChecksumLongs(pc),d1
	subq.l	#1,d1
.0
	add.l	(a0)+,d0
	dbf	d1,.0
	not.w	d1
	subq.l	#1,d1
	bgt.s	.0
.1
	cmp.l	ChecksumLongs(pc),d2
	bgt.s	.3
	move.l	dword_1E9034(pc),d2
	lsr.l	#2,d2
	cmp.l	ChecksumLongs(pc),d2
	bgt.s	.3
	move.l	ChecksumLongs(pc),d1
	subq.l	#1,d1
	movea.l	dword_1E9034(pc),a0
	cmp.l	#0,d2
	beq.w	.2
	addq.l	#1,a0
	move.l	a0,d3
	lsr.l	#2,d3
	sub.l	d3,d1
.2
	add.l	(a0)+,d0
	dbf	d1,.2
	not.w	d1
	subq.l	#1,d1
	bgt.s	.2
.3
	sub.l	(ProductCode+$C).w,d0
	cmp.l	ChecksumValue(pc),d0
	bne.s	.4
	rts
.4
	movea.l	#VDP_CTRL,a4
	move.w	#$8F02,(a4)
	move.w	#$8004,(a4)
	move.w	#$8700,(a4)
	move.w	#$8144,(a4)
	move.w	#$C000,(a4)
	move.w	#$3F,d1
.5
	move.w	#$E,-4(a4)
	dbf	d1,.5
.6
	bra.s	.6
