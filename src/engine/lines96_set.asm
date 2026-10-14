;	The team's lines. NullSaveClear is the rts ClearSRAM calls. sub_EF02 writes the lines
;	of a team.

NullSaveClear	;An rts. Called from ClearSRAM
	rts

sub_EF02
	movem.l	d0-d7/a1-a6,-(sp)
	bsr.w	sub_F300
	bne.w	.0
	movea.l	#TeamList,a0
	asl.w	#2,d7
	movea.l	(a0,d7.w),a0
	adda.w	6(a0),a0
	bra.w	.1
.0
	movea.l	#$FFFFD171,a3
	move.w	#0,d5
	bsr.w	sub_F1F0
	movea.l	#$FFFFD177,a3
	move.w	#1,d5
	bsr.w	sub_F1F0
	movea.l	#$FFFFD195,a3
	move.w	#2,d5
	bsr.w	sub_F1F0
	movea.l	#$FFFFD1B3,a3
	move.w	#3,d5
	bsr.w	sub_F1F0
	movea.l	#$FFFFD1D1,a3
	move.w	#4,d5
	bsr.w	sub_F1F0
	movea.l	#$FFFFD1EF,a3
	move.w	#5,d5
	bsr.w	sub_F1F0
	movea.l	#$FFFFD130,a0
	bsr.w	sub_F1E6
	move.w	#2,d1
	bsr.w	sub_F09A
	move.l	(ThreeStars).w,(dword_FFD138).w
	move.l	(dword_FFD134).w,(dword_FFD13C).w
	bsr.w	sub_F102
	movea.l	#$FFFFD140,a0
	bsr.w	sub_F1E6
	move.w	#3,d1
	bsr.w	sub_F09A
	bsr.w	sub_F102
	movea.l	#$FFFFD148,a0
	bsr.w	sub_F1E6
	move.w	#4,d1
	bsr.w	sub_F09A
	move.l	(ThreeStars).w,(dword_FFD150).w
	move.l	(dword_FFD134).w,(dword_FFD154).w
	move.l	(dword_FFD140).w,(dword_FFD158).w
	move.l	(dword_FFD144).w,(dword_FFD15C).w
	bsr.w	sub_F102
	movea.l	#$FFFFD1B3,a3
	move.w	#$FFFF,d5
	bsr.w	sub_F1F0
	movea.l	#$FFFFD160,a0
	bsr.w	sub_F1E6
	move.w	#2,d1
	bsr.w	sub_F030
	move.w	#2,d1
	bsr.w	sub_F050
	bsr.w	sub_F102
	move.b	(byte_FFD160).w,(StandingsBuf).w
	movea.l	#$FFFFD169,a0
	move.w	#3,d1
	bsr.w	sub_F030
	move.w	#4,d1
	bsr.w	sub_F050
	movea.l	#$FFFFD130,a0
.1
	movem.l	(sp)+,d0-d7/a1-a6
	rts

sub_F030
	movea.l	#$FFFFD177,a1
	movea.l	#unk_F1D2,a2
	bsr.w	sub_F154
	movea.l	#$FFFFD195,a1
	movea.l	#unk_F1D2,a2
	bra.w	sub_F154

sub_F050
	movea.l	#$FFFFD1B3,a1
	movea.l	#unk_F1D2,a2
	bsr.w	sub_F154
	addq.w	#1,d1
	movea.l	#$FFFFD1B3,a1
	movea.l	#unk_F1D2,a2
	bsr.w	sub_F154
	addq.w	#1,d1
	movea.l	#$FFFFD1B3,a1
	movea.l	#unk_F1D2,a2
	bsr.w	sub_F154
	addq.w	#1,d1
	movea.l	#$FFFFD1B3,a1
	movea.l	#unk_F1D2,a2
	bsr.w	sub_F154
	clr.b	(a0)+
	rts

sub_F09A
	movea.l	#$FFFFD177,a1
	movea.l	#unk_F1BE,a2
	bsr.w	sub_F154
	movea.l	#$FFFFD195,a1
	movea.l	#unk_F1BE,a2
	bsr.w	sub_F154
	movea.l	#$FFFFD1B3,a1
	movea.l	#unk_F1AA,a2
	bsr.w	sub_F154
	movea.l	#$FFFFD1D1,a1
	movea.l	#unk_F1AA,a2
	bsr.w	sub_F154
	movea.l	#$FFFFD1EF,a1
	movea.l	#unk_F1AA,a2
	bsr.w	sub_F154
	move.w	#3,d1
	movea.l	#$FFFFD1D1,a1
	movea.l	#unk_F1AA,a2
	bsr.w	sub_F154
	clr.b	(a0)+
	rts

sub_F102
	movem.l	d0-d3/a0,-(sp)
	movea.l	#$FFFFD1D1,a0
	bsr.w	sub_F13E
	movea.l	#$FFFFD1B3,a0
	bsr.w	sub_F13E
	movea.l	#$FFFFD1EF,a0
	bsr.w	sub_F13E
	movea.l	#$FFFFD177,a0
	bsr.w	sub_F13E
	movea.l	#$FFFFD195,a0
	bsr.w	sub_F13E
	movem.l	(sp)+,d0-d3/a0
	rts

sub_F13E
	move.b	(a0),d1
	ext.w	d1
	addq.w	#2,a0
	subq.w	#1,d1
	bmi.w	.1
.0
	andi.b	#$7F,(a0)+
	dbf	d1,.0
.1
	rts

sub_F154
	bsr.w	sub_F162
	bne.w	.0
	bsr.w	sub_F18C
.0
	rts

sub_F162
	movem.w	d1,-(sp)
	subq.w	#1,d1
	cmp.b	(a1),d1
	movem.w	(sp)+,d1
	bgt.w	.0
	move.b	(a1,d1.w),d0
	bmi.w	.0
	addq.b	#1,d0
	move.b	d0,(a0)+
	ori.b	#$80,(a1,d1.w)
	rts
.0
	move.w	#0,d0
	rts

sub_F18C
	move.w	d1,-(sp)
.0
	clr.w	d4
	addq.w	#1,d1
.1
	movea.l	(a2,d4.w),a1
	bsr.s	sub_F162
	bne.w	.2
	addq.w	#4,d4
	cmp.w	#$14,d4
	beq.s	.0
	bra.s	.1
.2
	move.w	(sp)+,d1
	rts

unk_F1AA
	dc.l	$FFFFD1D1,$FFFFD1EF,$FFFFD1B3,$FFFFD195,$FFFFD177

unk_F1BE
	dc.l	$FFFFD177,$FFFFD195,$FFFFD1D1,$FFFFD1EF,$FFFFD1B3

unk_F1D2
	dc.l	$FFFFD177,$FFFFD195,$FFFFD1B3,$FFFFD1B3,$FFFFD1B3

sub_F1E6
	move.b	(byte_FFD173).w,d0
	addq.b	#1,d0
	move.b	d0,(a0)+
	rts

sub_F1F0
	clr.b	(a3)
	clr.b	1(a3)
	movea.l	a3,a2
	addq.w	#2,a2
	movea.l	#$FFFFD20D,a5
	jsr	(GetPlayerCountD7).l
	subq.w	#1,d0
	move.w	d0,d3
	clr.w	d2
.0
	movem.l	d2-d3,-(sp)
	move.w	d2,d0
	jsr	(sub_103AA).l
	tst.w	d5
	bpl.w	.1
	cmp.w	#$FFFF,d5
	beq.w	.7
	cmp.w	#1,d0
	beq.w	.3
	cmp.w	#2,d0
	beq.w	.3
	bra.w	.4
.7
	cmp.w	#4,d0
	beq.w	.3
	cmp.w	#3,d0
	beq.w	.3
	cmp.w	#5,d0
	beq.w	.3
	bra.w	.4
.1
	cmp.w	d0,d5
	bne.w	.4
.3
	move.b	d2,(a2)+
	addq.b	#1,(a3)
	move.w	d2,d0
	jsr	(GetRosterName).l
	adda.w	(a1),a1
	addq.w	#8,a1
	movea.l	a1,a0
	movea.l	#$F300,a4
	movea.l	#OvrGoalWgtList2,a6
	move.l	(GAttribOverallMask).l,d4
	tst.w	d5
	beq.w	.2
	movea.l	#OvrPlayerWgtList2,a6
	move.l	(PAttribOverallMask).l,d4
.2
	jsr	(CalcAttribRating).l
	move.b	d0,(a5)+
.4
	movem.l	(sp)+,d2-d3
	addq.w	#1,d2
	dbf	d3,.0
	move.b	(a3),d0
	ext.w	d0
	subq.w	#2,d0
	bmi.w	.9
.5
	move.w	d0,d1
	clr.w	d6
	movea.l	a3,a0
	addq.w	#2,a0
	movea.l	#$FFFFD20D,a1
.6
	move.b	(a1),d3
	cmp.b	1(a1),d3
	bge.w	.8
	move.b	1(a1),d4
	move.b	d3,1(a1)
	move.b	d4,(a1)
	move.b	(a0),d3
	move.b	1(a0),d4
	move.b	d3,1(a0)
	move.b	d4,(a0)
	st	d6
.8
	addq.w	#1,a0
	addq.w	#1,a1
	dbf	d1,.6
	tst.w	d6
	bne.s	.5
.9
	rts
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00

sub_F300
	movem.l	d0-d7/a0-a6,-(sp)
	movea.l	#TeamList,a0
	move.w	d7,-(sp)
	asl.w	#2,d7
	movea.l	(a0,d7.w),a0
	adda.w	(a0),a0
	clr.w	d0
.1
	addq.w	#1,d0
	adda.w	(a0),a0
	addq.w	#8,a0
	cmpi.w	#2,(a0)
	bne.s	.1
	move.w	(sp)+,d7
	move.w	d0,d1
	jsr	(GetPlayerCountD7).l
	cmp.w	d0,d1
	bne.w	.playerabovetopgoalline
	subq.w	#1,d1
	clr.w	d2
	move.w	d7,d0
	mulu.w	#$6C,d0
	movea.l	#$202AA0,a0
	adda.l	d0,a0
.0
	move.w	(a0)+,d0
	andi.w	#$1F,d0
	cmp.b	d0,d7
	bne.w	.playerabovetopgoalline
	move.w	(a0)+,d0
	cmp.b	d0,d2
	bne.w	.playerabovetopgoalline
	addq.w	#1,d2
	dbf	d1,.0
	bra.w	.2
.playerabovetopgoalline
	move.w	#1,d0
	bra.w	.8
.2
	move.w	#0,d0
.8
	movem.l	(sp)+,d0-d7/a0-a6
	rts

