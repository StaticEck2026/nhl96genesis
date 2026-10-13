;	Line changes, shooting and passing, roster names and the season game simulation. SetLCmode2 ... lcfound2
;	open the line change box and take the choice; shotdiradj ... doshot and setpassmode ... passtoa0 are the
;	shot and pass of the puck carrier; GetRosterName and GetJerseyNumber read the rosters; SimGameStats ...
;	PickSimGoalie simulate the games the user does not play.

SetLCmode2	;Open the line change box: wait for the box, then draw the line choices (setlccords, getlchoice)
	btst	#0,(gmode).w
	beq.w	.0
	bsr.w	setlccords
	cmpi.w	#$F,(printy).w
	blt.w	.2
	jsr	(sub_1E7A78).l
	bclr	#2,(sflags12).w
.0
	bset	#2,(sflags12).w
	bne.w	.2
	jsr	(sub_1CFE4).l
.2
	bsr.w	setlccords
	cmpi.w	#$F,(printy).w
	blt.w	.box
	bset	#0,(sflags3).w
	bra.w	.1
.box
	jsr	(box).l
	bsr.w	setlccords
.1
	jsr	(Framer).l
	subq.w	#2,(printy).w
	addq.w	#1,(printx).w
	moveq	#2,d4
.loop
	move.w	d4,d0
	bsr.w	getlchoice
	tst.w	d0
	bmi.w	.next
	btst	#1,$30(a2)
	bne.w	.pr
	cmp.w	$2E(a2),d4
	bne.w	.up
	move.w	$16(a2),d0
.pr
	movea.w	#(mesarea-M68K_RAM),a1
	move.l	#$44120,(a1)	;String length 4, 'A '
	add.b	d4,2(a1)
	jsr	(print).l
	move.w	d0,-(sp)
	movea.l	#linelist,a1
	jsr	(SkipStrings).l
	jsr	(print).l
	move.w	(sp)+,d0
	jsr	(linebar).l
	subq.w	#5,(printx).w
.up
	subq.w	#1,(printy).w
.next
	dbf	d4,.loop
	movea.l	$1E(a2),a1
	adda.w	4(a1),a1
	adda.w	(a1),a1
	addq.w	#2,(printx).w
	jmp	print

setlccords	;printx / printy of the line change box for team a2
	clr.w	d0
	cmpa.w	#$C726,a2
	bne.w	.0
	eori.w	#$16,d0
.0
	btst	#1,(gmode).w
	beq.w	.1
	eori.w	#$16,d0
.1
	jsr	(printz).l
	String	-(TXPRI+TXMAP1),$16,0,0
	add.w	d0,(printy).w
	moveq	#2,d0
	bsr.w	getlchoice
	moveq	#6,d1
	tst.w	d0
	bpl.w	.ex
	subq.w	#1,d1
	addq.w	#1,(printy).w
.ex
	moveq	#9,d0
	rts

getlchoice	;Line choice d0 from the line change box
	movem.l	d1-d2,-(sp)
	move.w	$3C2(a2),d2
	cmpa.w	#$C726,a2
	beq.w	getlchoice2
	move.w	-$37A(a2),d2

getlchoice2
	sub.w	$24(a2),d2
	beq.w	.0
	addi.w	#$15,d0
	tst.w	d2
	bmi.w	.0
	addi.w	#$15,d0
.0
	move.w	$16(a2),d1
	add.w	d1,d0
	add.w	d1,d0
	add.w	d1,d0
	lea	unk_EDCE(pc),a0
	move.b	(a0,d0.w),d0
	ext.w	d0
	movem.l	(sp)+,d1-d2
	rts

unk_EDCE
	dc.b	$00,$01,$02,$01,$02,$00,$02,$00,$01,$00,$01,$02,$00,$01,$02,$00
	dc.b	$01,$02,$00,$01,$02,$03,$04,$FF,$03,$04,$FF,$03,$04,$FF,$03,$04
	dc.b	$FF,$04,$03,$FF,$03,$04,$FF,$03,$04,$FF,$05,$06,$FF,$05,$06,$FF
	dc.b	$05,$06,$FF,$05,$06,$FF,$05,$06,$FF,$05,$06,$FF,$06,$05,$FF,$FF

lineinput	;Pad input while the line change box is open (pflags2 bit 3)
	movem.w	d1/d4,-(sp)
	movea.w	#(tmstruct-M68K_RAM),a2
	btst	#6,pflags(a3)
	beq.w	.1
	adda.w	#$39E,a2
.1
	bclr	#0,limpact(a2)
	beq.w	.0
	bsr.w	lcfound2
	bsr.w	SetLCmode2
.0
	movem.w	(sp)+,d1/d4
	clr.w	d2
	btst	#6,d1
	bne.w	.2
	addq.w	#1,d2
	btst	#4,d1
	bne.w	lcfound
	addq.w	#1,d2
	btst	#5,d1
	bne.w	lcfound
	btst	#3,pflags(a3)
	beq.w	.x
	btst	#5,pflags(a3)
	bne.w	.x
	btst	#0,pflags2(a3)
	beq.w	.5
.x
	rts
.5
	jmp	doplayeracc
.2
	movem.l	a0,-(sp)
	movea.l	#$FFFFD2EC,a0
	move.w	#$3E8,(a0,d4.w)
	movem.l	(sp)+,a0

lcfound	;Line choice d2 made: set the line, close the box
	move.w	d2,d0
	move.w	d2,impactp(a2)
	bsr.w	getlchoice	;translate choice 0-2 into line number 0-6
	tst.w	d0
	bmi.w	rtss
	bclr	#3,pflags2(a3)
	bset	#3,pflags(a3)
	jsr	(loadTeamStruct).l
	bclr	#1,limpact(a2)
	move.w	d0,$16(a2)
	jsr	(setpersonel).l

lcfound2
	btst	#4,(sflags9).w
	bne.w	rtss
	bsr.w	setlccords
	cmpi.w	#$F,(printy).w
	blt.w	.nollcm
	bclr	#0,(sflags3).w
.nollcm
	addq.w	#1,d1
	move.w	#$7FF,d2
	jsr	(eraser).l
	bclr	#2,(sflags12).w
	bset	#3,(sflags12).w
	jmp	nullsub_4

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
	move.b	(byte_FFD160).w,(byte_FFD168).w
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
	movea.l	#unk_1DF9FC,a6
	move.l	(GAttribOverallMask).l,d4
	tst.w	d5
	beq.w	.2
	movea.l	#unk_1DF9EC,a6
	move.l	(PAttribOverallMask).l,d4
.2
	jsr	(sub_1DF8AC).l
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

shotdiradj	;Adjust the shot direction by the pad and the shooter
	btst	#3,pflags3(a3)	;check if shooting one timer
	bne.w	.0	;jump if shooting one timer
	btst	#3,pflags(a3)
	bne.w	.2
.0
	moveq	#8,d0
	moveq	#5,d1
	movea.w	#(SortCords-SCstruct-M68K_RAM),a0	;SC Struct start - 80
	btst	#6,pflags(a3)
	bne.w	.g
	adda.w	#$300,a0
.g
	adda.w	#$80,a0
	tst.w	position(a0)
	dbeq	d1,.g
	bne.w	.setpassdir
	move.b	Xvel(a0),d0
	ext.w	d0	;sign extend d0
	asr.w	#1,d0	;divide by 2
	add.w	(a0),d0	;Xpos
	sub.w	(puckx).w,d0	;sub puckx from d0
	move.b	Yvel(a0),d1
	ext.w	d1	;sign extend d1
	asr.w	#1,d1	;divide by 2
	add.w	Ypos(a0),d1
	sub.w	(pucky).w,d1	;sub pucky from d1
	movem.w	d0-d1,-(sp)	;push to stack
	muls.w	d0,d0	;square d0
	muls.w	d1,d1	;square d1
	add.l	d1,d0	;add d1 to d0
	addq.l	#1,d0	;add 1 to d0
	jsr	(sroot).l
	move.w	d0,d2	;move result into d2
	movem.w	(sp)+,d0-d1	;pop from stack (distance x and y from G to puck)
	moveq	#$12,d3	;post?
	move.w	#$11E,d4
	btst	#7,pflags(a3)
	bne.w	.chkposts
	neg.w	d4	;negate if bottom goal
.chkposts
	movem.w	d3-d4,-(sp)	;push to stack
	bsr.w	shotdirmath
	move.w	d4,d5
	movem.w	(sp)+,d3-d4	;pop from stack
	neg.w	d3	;negate d3 (other post)
	bsr.w	shotdirmath
	add.w	d5,d4	;add results to d4
	clr.w	d0	;clear d0
	cmp.w	#$2C,d4	;2C - right X edge of crease
	bgt.w	.setpassdir
	cmp.w	#$FFD4,d4	;-$2C, the left X edge of the crease
	blt.w	.setpassdir
	btst	#7,pflags(a3)
	beq.w	.passdir
	neg.w	d4	;negate d4
.passdir
	moveq	#2,d0	;move 2 into d0
	tst.w	d4	;check if d4 is 0
	bpl.w	.setpassdir
	moveq	#6,d0	;move 6 into d0
.setpassdir
	move.w	d0,(passdir).w	;will be 0,2,6, or 8 (no goalie)
	btst	#2,(BA_PS_flags).w
	bne.w	.1
	btst	#0,(gmode2).w	;check if shootout
	beq.w	.2
.1
	jsr	(sub_1D8B26).l
.2
	rts

shotdirmath
	sub.w	(puckx).w,d3
	sub.w	(pucky).w,d4
	muls.w	d0,d4
	muls.w	d1,d3
	sub.l	d3,d4
	divs.w	d2,d4
	rts
	;Not decoded in the listing and not referenced from it: kept as bytes
	dc.b	$58,$4F,$30,$38,$B7,$72,$08,$2B,$00,$07,$00,$62,$66,$00,$00,$04
	dc.b	$44,$40,$32,$3C,$01,$1E,$92,$40,$E6,$49,$B2,$7C,$00,$14,$6D,$00
	dc.b	$00,$04,$72,$14,$37,$41,$00,$42,$70,$12,$4E,$F9,$00,$01,$A3,$DA

SetShotMode	;Start the shot mode (C button)
	btst	#2,(BA_PS_flags).w	;check for PS or SO
	beq.w	.0
	btst	#0,(GameFlags).w
	bne.w	.0
	bclr	#2,(gmode2).w
	bset	#5,(BA_PS_flags).w
	bne.w	rtss7
	bclr	#5,(gmode2).w
	move.w	#$64,(passmodetimer).w
.0
	move.w	#8,(passdir).w	;default shot direction
	bset	#3,(sflags).w
	clr.w	d0	;find dx/dy for shot
	move.w	#$13A,d1	;#296 = top Y boards
	btst	#7,pflags(a3)
	bne.w	.ck0
	neg.w	d1	;flip if bottom goal
.ck0
	sub.w	(a3),d0	;Sub Xpos of player from d0. d0 starts as 0 (middle of rink in X)
	sub.w	Ypos(a3),d1	;Sub Ypos of player from Y boards
	jsr	(vtoa).l
	move.w	#$F,(passspeed).w
	move.w	#$11BA,d1
	btst	#0,(GameFlags).w
	beq.w	.13
	move.w	#$2E40,d1
.13
	jsr	(sub_16D36).l
	beq.w	.4
	move.w	#$FB6,d1
	btst	#0,(GameFlags).w
	beq.w	.3
	move.w	#$2F72,d1
.3
	move.w	#$F,(passspeed).w
.4
	jmp	SetSPA

ShotMode	;Shot mode: wind up, then doshot
	cmpi.w	#$1C,SPAnum(a3)
	bge.w	prepshot	;end of animation so shoot
	btst	#3,d0	;checks dpad for direction
	bne.w	.ss0
	andi.w	#7,d0	;pass the first 3 bits of d0
	move.w	d0,(passdir).w	;set shot direction
.ss0
	cmpi.w	#$10,SPAnum(a3)
	bge.w	.end
	add.w	d7,(passspeed).w
	cmpi.w	#$C,SPAnum(a3)
	bne.w	.checkcbut
	addq.w	#1,(passspeed).w
.checkcbut
	btst	#5,d2	;5 = #cbut
	beq.w	.end
	neg.w	SPAnum(a3)	;end windup and swing through
	addi.w	#$1C,SPAnum(a3)
.end
	rts

prepshot
	bclr	#4,(sflags5).w
	move.w	#$B,d0
	btst	#6,pflags(a3)
	beq.w	.33
	move.w	#5,d0	;opponent is home
.33
	jsr	(getGoalieSCnum).l
	tst.w	d0
	bmi.w	.nogoalie
	movem.l	a0,-(sp)
	asl.w	#7,d0
	movea.l	#SortCords,a0
	cmpi.w	#$440,SPA(a0,d0.w)
	beq.w	.0
	cmpi.w	#$3E6,SPA(a0,d0.w)
.0
	movem.l	(sp)+,a0
	bne.w	.3
.nogoalie
	cmpi.w	#1,(passdir).w
	ble.w	.dir017
	cmpi.w	#7,(passdir).w
	bne.w	.3
.dir017
	move.w	(pucky).w,d0
	btst	#7,pflags(a3)
	bne.w	.cmppuck
	neg.w	d0	;flips d0 for compare calc
.cmppuck
	cmp.w	#$D8,d0	;compares location of puck
	blt.w	.3
	bset	#4,(sflags5).w	;set flag for in-close top shelf shooting
.3
	bra.w	*+4

doshot	;Shoot the puck
	movem.l	d0-d7/a0-a3,-(sp)
	bclr	#0,(GameFlags).w
	beq.w	.0
	bclr	#3,(sflags).w
	bra.w	.4
.0
	move.b	pflags(a3),(byte_FFC364).w
	bclr	#4,(gmode2).w
	btst	#1,pflags3(a3)	;check if player on breakaway
	beq.w	.cont
	bset	#4,(gmode2).w	;set if breakaway
.cont
	bsr.w	shotdiradj
	move.w	#5,-(sp)	;#SFXshotwiff - sound effect
	move.w	SCnum(a3),(shotplayer).w
	bclr	#3,(sflags).w
	bset	#5,pflags(a3)
	btst	#3,pflags3(a3)	;check if shooting one timer
	bne.w	.2
	move.w	(puckc).w,d0	;puck carrier SCnum into d0
	cmp.w	SCnum(a3),d0	;is player puck carrier?
	bne.w	.3
.2
	move.w	#$18,(sp)	;#SFXshotfh
	bset	#4,(sflags2).w
	cmpi.w	#$FB6,SPA(a3)
	bne.w	.nbh
	move.w	#$14,(sp)	;#SFXshotbh
	move.w	(passspeed).w,d0
	lsr.w	#2,d0	;sub 25% for backhand shots
	sub.w	d0,(passspeed).w
.nbh
	btst	#3,pflags3(a3)	;check if shooting one timer
	beq.w	.cont2
	movem.l	d0-d1,-(sp)	;push d0-d1 on stack
	move.w	#$1F,d0	;1F into d0 - one timer min speed
	move.w	d0,(passspeed).w	;make passspeed start with a higher value
	movem.l	(sp)+,d0-d1	;Pop off stack d0-d1
.cont2
	clr.w	d0
	move.b	$6D(a3),d0
	lsr.b	#1,d0	;divide by 2
	movea.l	a3,a0	;move a3 address into a0
	jsr	(makepde).l	;scale d0 based on energy level
	addi.w	#$14,d0	;add 14 to d0
	mulu.w	(passspeed).w,d0	;shot speed ranged by energy level
	mulu.w	#$5249,d0
	swap	d0	;swaps the upper and lower words of d0
	move.w	d0,(passspeed).w	;move d0 into passspeed
	btst	#0,$6D(a3)
	beq.w	.even
	asr.w	#4,d0	;divide by 16
	add.w	(passspeed).w,d0	;add passspeed to d0
.even
	lsr.w	#4,d0	;divide by 16 (d0 is passspeed)
	neg.w	d0	;negative
	addq.w	#3,d0	;add 3 to d0
	bpl.w	.nbh2
	clr.w	d0	;clear if negative
.nbh2
	add.w	d0,(sp)	;add to stack current value (Shot SFX)
	st	(puckc).w	;clear puck carrier
	move.b	#$10,nopuck(a3)	;5E = nopuck - no puck collision till 0
	move.w	SCnum(a3),(lastplayer).w
	move.w	#$11E,d1
	btst	#7,pflags(a3)
	bne.w	.7
	neg.w	d1	;flip d1 if shooting down
.7
	move.w	(passdir).w,d2	;passdir into d2
	asl.w	#2,d2	;mult by 4
	lea	unk_F874(pc),a0	;table of shot directions
	move.w	(a0,d2.w),d0
	move.w	2(a0,d2.w),d2	;z offset
	sub.w	(puckx).w,d0
	sub.w	(pucky).w,d1
	movem.w	d0-d2,-(sp)	;push d0-d2(dx,dy,z offset) on stack
	muls.w	d0,d0
	muls.w	d1,d1
	add.l	d1,d0
	jsr	(sroot).l
	tst.w	d0	;distance in pix to goal
	bne.w	.8
	addq.w	#1,d0
.8
	move.w	d0,d3	;straight line distance from puck to spot aiming for with passdir
	btst	#4,(gmode).w
	bne.w	.perf
	cmp.w	#$C8,d3	;C8 = 200 decimal
	bhi.w	.notperf
	jsr	(sub_1D9352).l	;checks if shooting team's G pulled
	bmi.w	.perf
	btst	#0,(gmode2).w	;check if shootout
	bne.w	.perf
	moveq	#$10,d0	;start value for ShA calc
	add.b	$6E(a3),d0	;shotacc(a3)
	jsr	(randomd0).l
	cmp.w	#$E,d0	;chance of perfect shot
	bgt.w	.perf
.notperf
	clr.w	d0
	move.b	$6E(a3),d0
	lsr.w	#1,d0	;divide by 2
	move.b	d0,-(sp)	;push on stack
	move.w	(passspeed).w,d0	;move passspeed into d0
	lsr.w	#4,d0	;divide by 16
	sub.b	(sp)+,d0	;shotacc(a3) / 2
	addi.b	#$10,d0	;add $10 to d0
	mulu.w	d3,d0	;mult straight line distance with d0
	lsr.w	#6,d0	;shot accuracy adjust - divide by 64
	cmp.w	#$FA,d3	;250 pixels straight line distance
	bhi.w	.10
	lsr.w	#1,d0	;extra shot accuracy adjust
.10
	cmp.w	#$96,d0
	blt.w	.11
	move.w	#$96,d0
.11
	move.w	d0,-(sp)	;push adjusting value on stack
	jsr	(randomd0s).l
	asr.w	#2,d0
	add.w	d0,2(sp)	;add result to x diff
	move.w	(sp),d0	;move adjusting value into d0
	cmp.w	#$3C,d0	;compare to $3C (max adjustment in Y)
	bls.w	.lessx
	moveq	#$3C,d0
	move.w	d0,(sp)
.lessx
	tst.w	4(sp)
	bpl.w	.13
	lsr.w	#1,d0
.13
	jsr	(randomd0s).l
	asr.w	#2,d0
	add.w	d0,4(sp)	;add to y diff
	move.w	(sp)+,d0	;pop adj value
	lsr.w	#1,d0	;divide by 2
	jsr	(randomd0).l
	asr.w	#2,d0
	add.w	d0,4(sp)	;add to Z diff
.perf
	move.w	(passspeed).w,d2	;shot speed
	muls.w	#$44,d2	;1024/15
	muls.w	(sp)+,d2	;mult by x dist
	divs.w	d3,d2	;divide d2 by straight line distance
	move.w	d2,(puckvx).w	;move into puckvx
	move.w	(passspeed).w,d2
	muls.w	#$44,d2	;1024/15
	muls.w	(sp)+,d2	;mult by y dist
	divs.w	d3,d2	;divide d2 by straight line distance
	move.w	d2,(puckvy).w	;move into puckvy
	move.w	#$8000,d1	;this is the highest negative puckvy possible
	btst	#7,pflags(a3)
	beq.w	.15
	clr.w	d1
.15
	eor.w	d2,d1	;EOR - checking to see if exceeding maximum puckvy
	bpl.w	.16
	move.w	#$3810,(puckvy).w	;move into puckvy
	btst	#7,pflags(a3)
	bne.w	.16
	move.w	#$C7F0,(puckvy).w	;move into puckvy (shooting on bottom net)
.16
	move.w	(sp)+,d1	;pix height in goal
	beq.w	.3
	mulu.w	(passspeed).w,d1
	mulu.w	#$44,d1	;1024/15
	divu.w	d3,d1	;d3 = distance in pix to goal
	mulu.w	#$B33,d3	;(1024*42)/15
	divu.w	(passspeed).w,d3	;divide by passspeed
	add.w	d1,d3
	cmp.w	#$1800,d3
	bls.w	.1
	move.w	#$1800,d3	;set max puckvz
.1
	move.w	d3,(puckvz).w
	bclr	#4,(sflags5).w
	beq.w	.3
	btst	#3,pflags3(a3)
	bne.w	.3
	jsr	(sub_1D6622).l
.3
	jsr	(sfx).l
.4
	movem.l	(sp)+,d0-d7/a0-a3
	rts

unk_F874
	dc.b	$00,$00,$00,$0C,$00,$10,$00,$0C,$00,$10,$00,$06,$00,$10,$00,$00
	dc.b	$00,$00,$00,$00,$FF,$F0,$00,$00,$FF,$F0,$00,$06,$FF,$F0,$00,$0C
	dc.b	$00,$00,$00,$06

setpassmode	;Start the pass mode (B button)
	move.w	facedir(a3),(passdir).w
	andi.w	#7,(passdir).w
	btst	#2,(BA_PS_flags).w
	beq.w	.0
	bclr	#2,(gmode2).w
	bset	#5,(BA_PS_flags).w
	bne.w	rtss7
	bclr	#5,(gmode2).w
	move.w	#$64,(passmodetimer).w
.0
	bset	#2,(sflags).w	;#sfspdir - set pass dir mode

rtss	;The shared rts of setpassmode and passmode
	rts

passmode
	btst	#4,d2	;has b button changed?
	bne.w	dopass	;yes
	btst	#3,(sflags5).w
	bne.w	dopass
	btst	#3,d0	;look for dpad
	bne.s	rtss
	andi.w	#7,d0	;pass first 3 bits of d0
	move.w	d0,(passdir).w	;new pass dir
	bset	#3,d0

dopass	;Pass the puck
	movem.l	d0-d5/a0-a1,-(sp)
	bclr	#2,(sflags).w
	st	(puckc).w	;player is not puck handler anymore
	move.b	#$10,nopuck(a3)	;$5E = nopuck
	move.w	SCnum(a3),(lastplayer).w
	btst	#1,(GameFlags).w
	beq.w	.0
	addq.b	#8,nopuck(a3)
.0
	bclr	#3,(sflags5).w
	beq.w	.noot
	jsr	(sub_1D6718).l
	move.w	#9,(onetimerheight).w
	btst	#2,(sflags6).w
	beq.w	.1
	move.w	#$20,(onetimerheight).w
.1
	jsr	(sub_1D66AC).l
	bra.w	.8
.noot
	moveq	#8,d0	;moves 8 into d0
	tst.w	position(a3)	;checks if goalie
	beq.w	.calc
	move.b	$6F(a3),d0
.calc
	asl.w	#2,d0	;d0 = passacc for player, 8 for goalie
	asr.w	#1,d0
	addi.w	#$A0,d0
	move.w	d0,(passspeed).w	;Passspeed = PassAcc (0 to 30 decimal) * 2 + A0 (160 decimal)
	btst	#0,$6F(a3)
	beq.w	.4
	asr.w	#4,d0	;divide d0 by 16
	add.w	d0,(passspeed).w	;add d0 to passspeed
.4
	moveq	#-1,d4
	moveq	#5,d3	;Set total number of players (6 total, set to 5)
	movea.w	#(SortCords-M68K_RAM),a1	;start of the home players on ice
	cmpi.w	#6,SCnum(a3)	;compares 6 to offset 52 from a3 (current player with puck) to check if player is away team or home team
	blt.w	.5
	adda.w	#$300,a1
	btst	#2,(BA_PS_flags).w
	bne.w	.7
.5
	cmpa.l	a1,a3	;Check to see if passing to self
	beq.w	.next
	tst.w	position(a1)	;position(a1)
	ble.w	.next
	btst	#2,pflags2(a1)	;check if player is unavailable
	bne.w	.next
	move.w	(a1),d0	;X Position of receiving player
	sub.w	(puckx).w,d0	;sub puckx from d0
	move.w	Ypos(a1),d1	;Y position of receiving player
	sub.w	(pucky).w,d1	;sub pucky from d1
	movem.w	d0-d1,-(sp)	;push to stack
	jsr	(vtoa).l
	movem.w	(sp)+,d1-d2	;pop from stack d1 is dX, d2 is dY
	sub.w	(passdir).w,d0	;sub passdir from d0
	btst	#4,(GameFlags).w
	beq.w	.2
	clr.w	d0
.2
	andi.w	#7,d0
	asl.b	#5,d0	;Multiply d0 by 32 (224 decimal is max)
	ext.w	d0	;sign extend d0 byte to d0 word
	asl.w	#3,d0	;mult d0 by 8 (700 decimal max)
	muls.w	d0,d0	;square d0 = max is 490000 decimal
	btst	#1,(GameFlags).w
	bne.w	.3
	cmp.l	#loc_10000,d0
	bhi.w	.next
.3
	muls.w	d1,d1	;square d1 (dX)
	muls.w	d2,d2	;square d2 (dY)
	add.l	d1,d2	;add together
	btst	#1,(GameFlags).w
	bne.w	.6
	add.l	d0,d2
.6
	cmp.l	d4,d2	;compare d4 to d2
	bhi.w	.next
	move.l	d2,d4	;move d2 into d4
	movea.l	a1,a0	;move a1 address into a0 (receiving player)
.next
	adda.w	#$80,a1	;Skip to next player (80 hex is length of player struct)
	dbf	d3,.5
	tst.l	d4	;check if there's a player to pass to
	bmi.w	.7
	bsr.w	passtoa0
	bra.w	.8
.7
	move.w	SCnum(a3),(word_FFD238).w
	move.w	(passdir).w,d0	;just hit puck in pass dir not to any player
	asl.w	#2,d0
	movea.l	#dirtab,a0
	move.w	2(a0,d0.w),d1	;y inc
	muls.w	(passspeed).w,d1
	moveq	#$A,d2
	asl.l	d2,d1
	divs.w	#$BB8,d1
	add.w	Yvel(a3),d1
	move.w	d1,(puckvy).w
	move.w	(a0,d0.w),d1
	muls.w	(passspeed).w,d1
	asl.l	d2,d1
	divs.w	#$BB8,d1
	add.w	Xvel(a3),d1
	move.w	d1,(puckvx).w
	move.w	#$1000,d0
	jsr	(randomd0).l
	move.w	d0,(puckvz).w
	btst	#1,(GameFlags).w
	beq.w	.8
	clr.w	(puckvz).w
	move.w	(puckvx).w,d0
	asr.w	#2,d0
	move.w	d0,(puckvx).w
	move.w	(puckvy).w,d0
	asr.w	#2,d0
	move.w	d0,(puckvy).w
.8
	bclr	#4,(GameFlags).w
	tst.w	position(a3)	;$34 = position
	bne.w	.notgoalie
	tst.w	(puckvy).w
	btst	#7,pflags(a3)
	beq.w	.g0
	bmi.w	.nvy
	bra.w	.notgoalie
.g0
	bmi.w	.notgoalie
.nvy
	neg.w	(puckvy).w	;negative velocity on puck
.notgoalie
	move.w	(puckvx).w,d0
	move.w	(puckvy).w,d1
	jsr	(vtoa).l
	move.w	#2,d1
	tst.w	position(a3)	;$34 = position
	beq.w	.9
	move.w	#$B6C,d1
	btst	#1,(GameFlags).w
	beq.w	.13
	move.w	#$A70,d1
.13
	jsr	(sub_16D36).l
	beq.w	.9
	move.w	#$B1A,d1
	btst	#1,(GameFlags).w
	beq.w	.9
	move.w	#$A70,d1
.9
	jsr	(SetSPA).l
	bset	#5,pflags(a3)
	moveq	#$C,d0
	sub.b	(puckvz).w,d0
	lsr.w	#2,d0
	andi.w	#3,d0
	addi.w	#$10,d0
	btst	#1,(GameFlags).w
	bne.w	.14
	move.w	d0,-(sp)	;#SFXpass
	jsr	(sfx).l
.14
	movem.l	(sp)+,d0-d5/a0-a1
	rts

passtoa0	;Pass the puck to player a0
	st	(word_FFD238).w
	jsr	(loadTeamStruct).l
	addq.w	#1,$12(a2)	;add 1 to total pass attempts
	move.w	SCnum(a0),(passplayer).w
	move.w	(passspeed).w,d5	;passspeed = pix/sec
	asr.w	#2,d5	;divides pass speed by 4
	exg	a0,a3	;tell pass recipient to get puck - swaps a3 and a0 for assinsert
	moveq	#$13,d0
	jsr	(assinsert).l
	exg	a0,a3
	btst	#4,(sflags10).w
	beq.w	.0
	cmpi.w	#$11E,(pucky).w
	bgt.w	.13
	cmpi.w	#$FEE2,(pucky).w
	blt.w	.13
.0
	move.l	a0,-(sp)	;This routine uses passspeed and player's a0 x/y speed to determine the x/y velocity of the puck so it will meet player a0
	jsr	(GetHot).l
	add.w	(a0),d0	;Xpos
	sub.w	(puckx).w,d0
	add.w	Ypos(a0),d1
	sub.w	(pucky).w,d1
	movem.w	d0-d1,-(sp)
	movem.w	(sp),d2-d3	;pop d0-d1 off into d2-d3
	asr.w	#2,d2	;d2 divide by 4
	asr.w	#2,d3	;d3 divide by 4
	move.w	Xvel(a0),d0
	muls.w	#$F0,d0	;#(16 * 60)/4 = $F0 xpix / (1/4) sec
	swap	d0	;swap upper and lower bytes
	move.w	Yvel(a0),d1
	muls.w	#$F0,d1
	swap	d1	;swap upper and lower bytes
	movem.w	d0-d1,-(sp)	;push on stack
	muls.w	d2,d0	;d0 = (d2 = Xpos puck / 4) * d0 (x pix per 1/4 sec)
	muls.w	d3,d1	;d1 = (d3 = Ypos puck /4) * d1 (y pix per 1/4 sec)
	add.w	d1,d0	;add d1 to d0
	asl.w	#1,d0	;d0 mult by 2
	move.w	d0,d4	;j = move d0 into d4
	movem.w	(sp),d0-d1	;pop d0 and d1 off stack
	muls.w	d0,d0	;(x pix per 1/4 sec)^2
	muls.w	d1,d1	;(y pix per 1/4 sec)^2
	muls.w	d5,d5	;passspeed^2
	neg.l	d5	;negative d5
	add.l	d0,d5	;add d0 to d5
	add.l	d1,d5	;k = add d1 to d5
	muls.w	d2,d2
	muls.w	d3,d3
	add.l	d2,d3	;a^2 = add d2 to d3
	muls.w	d5,d3	;multiply k * a^2
	asl.l	#2,d3	;divide by 4
	move.w	d4,d0	;d0 = j
	muls.w	d0,d0	;j^2
	sub.l	d3,d0	;j^2 - ((k*a^2)/4)
	jsr	(sroot).l
	moveq	#1,d3	;limit infinite loop
	asr.w	#2,d5	;k divide by 4
	bne.w	.1
	moveq	#1,d5	;no div by zero
.1
	move.w	d0,d2
	neg.w	d0
	sub.w	d4,d2
	ext.l	d2
	divs.w	d5,d2
	dbpl	d3,.1
	bne.w	.2
	addq.w	#1,d2	;can't be zero
.2
	cmp.w	#$18,d2	;limit to 3 sec.
	bls.w	.3
	moveq	#$18,d2	;d2 = time in 1/8 sec to intersection
.3
	btst	#1,(GameFlags).w
	beq.w	.4
	asl.w	#2,d2
.4
	move.b	d2,(puckvz).w
	cmp.w	#$C,d2
	blt.w	.6
	move.b	#$C,(puckvz).w
.6
	btst	#1,(GameFlags).w
	beq.w	.5
	clr.w	(puckvz).w
.5
	move.w	d2,d0
	asl.w	#3,d0
	subi.w	#$A,d0
	move.b	d0,temp1(a0)	;$40 = temp1
	subq.w	#6,d0
	move.b	d0,(puckx+nopuck).w
	movem.w	(sp)+,d0-d1
	muls.w	d2,d0
	asr.l	#1,d0
	add.w	(sp)+,d0	;x distance
	move.w	(puckx).w,temp3(a0)
	add.w	d0,temp3(a0)
	muls.w	d2,d1
	asr.l	#1,d1
	add.w	(sp)+,d1	;y distance
	move.w	(pucky).w,temp4(a0)
	add.w	d1,temp4(a0)
	mulu.w	#$78,d2	;$78 = 60*2
	swap	d0
	divs.w	d2,d0
	btst	#4,(sflags10).w
	beq.w	.12
	swap	d1
	divs.w	d2,d1
	movem.w	d2,-(sp)
	move.w	(puckvx).w,d2
	eor.w	d0,d2
	movem.w	(sp)+,d2
	bmi.w	.12
	movem.w	d2,-(sp)
	move.w	(puckvy).w,d2
	eor.w	d1,d2
	movem.w	(sp)+,d2
	bmi.w	.12
	movem.w	d2-d5,-(sp)
.7
	move.w	d0,d2
	move.w	d1,d3
	move.w	(puckvx).w,d4
	move.w	(puckvy).w,d5
	tst.w	d2
	bpl.w	.8
	neg.w	d2
	neg.w	d4
.8
	cmp.w	d2,d4
	blt.w	.10
	tst.w	d3
	bpl.w	.9
	neg.w	d3
	neg.w	d5
.9
	cmp.w	d3,d5
	bgt.w	.11
.10
	move.w	d0,d2
	asr.w	#3,d2
	sub.w	d2,d0
	move.w	d1,d2
	asr.w	#3,d2
	sub.w	d2,d1
	bra.s	.7
.11
	movem.w	(sp)+,d2-d5
	move.w	d0,(puckvx).w
	move.w	d1,(puckvy).w
	bra.w	.13
.12
	move.w	d0,(puckvx).w
	swap	d1
	divs.w	d2,d1
	move.w	d1,(puckvy).w
.13
	rts

sub_FD14
	movem.l	d0-d7/a0-a5,-(sp)
	bsr.w	sub_10070
	move.w	(puckx).w,d0
	cmp.w	#$32,d0
	bgt.w	.0
	cmp.w	#$FFCE,d0
	blt.w	.1
	move.w	#1,d7
	bra.w	.2
.0
	move.w	#2,d7
	bra.w	.2
.1
	clr.w	d7
.2
	movea.l	#SortCords,a5
	move.w	(word_FFD23A).w,d6
	bmi.w	.3
	cmpi.w	#6,(word_FFC74A).w
	bne.w	.3
	bsr.w	sub_FD80
.3
	movea.l	#SortCords+$300,a5
	move.w	(word_FFD23C).w,d6
	bmi.w	.4
	cmpi.w	#6,(word_FFCAE8).w
	bne.w	.4
	bsr.w	sub_FD80
.4
	movem.l	(sp)+,d0-d7/a0-a5
	rts

sub_FD80
	move.w	d7,-(sp)
	asl.w	#7,d6
	movea.l	#SortCords,a3
	adda.w	d6,a3
	move.w	$34(a3),d6
	bmi.w	.15
	tst.b	$65(a3)
	bmi.w	.0
	clr.w	d6
	move.b	$65(a3),d6
.0
	move.w	d6,d4
	lsl.b	#2,d6
	or.b	d7,d6
	andi.w	#$1F,d6
	asl.w	#2,d6
	movea.l	#$FEAA,a0
	movea.l	(a0,d6.w),a0
	cmpa.l	#0,a0
	beq.w	.15
	movem.l	d0/d5-d7/a3/a5,-(sp)
	cmp.w	#1,d4
	bne.w	.6
	movea.l	a5,a3
	movea.l	#SortCords,a5
	asl.w	#7,d6
	adda.w	d6,a5
	move.w	#5,d6
.1
	cmpi.b	#3,$65(a3)
	beq.w	.2
	tst.b	$65(a3)
	bpl.w	.3
	cmpi.w	#3,$34(a3)
	bne.w	.3
.2
	move.w	$14(a3),d7
	bra.w	.4
.3
	adda.w	#$80,a3
	dbf	d6,.1
	bra.w	.11
.4
	move.w	$14(a5),d0
	btst	#7,$62(a5)
	bne.w	.5
	neg.w	d0
	neg.w	d7
.5
	cmp.w	d7,d0
	blt.w	.10
	bra.w	.11
.6
	cmp.w	#2,d4
	bne.w	.11
	movea.l	a5,a3
	movea.l	#SortCords,a5
	asl.w	#7,d6
	adda.w	d6,a5
	move.w	#5,d6
.7
	cmpi.b	#5,$65(a3)
	beq.w	.8
	tst.b	$65(a3)
	bpl.w	.9
	cmpi.w	#5,$34(a3)
	bne.w	.9
.8
	move.w	$14(a3),d7
	bra.s	.4
.9
	adda.w	#$80,a3
	dbf	d6,.7
	bra.w	.11
.10
	movem.l	(sp)+,d0/d5-d7/a3/a5
	bra.w	.15
.11
	movem.l	(sp)+,d0/d5-d7/a3/a5
	move.w	#5,d5
.12
	clr.w	d1
	move.b	$65(a5),d1
	bpl.w	.13
	move.w	$34(a5),d1
	bmi.w	.14
.13
	move.b	(a0,d1.w),d2
	bmi.w	.14
	move.b	d2,$65(a5)
.14
	adda.w	#$80,a5
	dbf	d5,.12
.15
	move.w	(sp)+,d7
	rts
	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	dc.b	$00,$00,$FF,$59,$00,$00,$FF,$59,$00,$00,$FF,$59,$00,$00,$00,$00
	dc.b	$00,$00,$FF,$60,$00,$00,$FF,$60,$00,$00,$FF,$60,$00,$00,$00,$00
	dc.b	$00,$00,$FF,$1A,$00,$00,$FF,$28,$00,$00,$FF,$21,$00,$00,$00,$00
	dc.b	$00,$00,$FF,$2F,$00,$00,$FF,$3D,$00,$00,$FF,$36,$00,$00,$00,$00
	dc.b	$00,$00,$FF,$44,$00,$00,$FF,$52,$00,$00,$FF,$4B,$00,$00,$00,$00
	dc.b	$00,$00,$FF,$2F,$00,$00,$FF,$3D,$00,$00,$FF,$36,$00,$00,$00,$00
	dc.b	$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$05,$03,$04,$FF,$FF,$FF
	dc.b	$FF,$04,$03,$FF,$FF,$FF,$FF,$FF,$04,$03,$FF,$FF,$FF,$FF,$FF,$FF
	dc.b	$05,$04,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$04,$05,$03
	dc.b	$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$05,$04,$FF,$FF
	dc.b	$03,$FF,$01,$FF,$FF,$FF,$FF,$FF,$05,$FF,$FF,$02,$FF,$FF,$48,$E7
	dc.b	$70,$80,$0C,$78,$00,$02,$D2,$68,$67,$00,$00,$44,$4A,$6B,$00,$34
	dc.b	$6B,$00,$00,$3C,$42,$40,$10,$2B,$00,$65,$6A,$00,$00,$06,$30,$2B
	dc.b	$00,$34,$32,$2B,$00,$36,$12,$33,$10,$38,$20,$7C,$00,$00,$FF,$C2
	dc.b	$B2,$30,$00,$00,$67,$00,$00,$18,$20,$7C,$00,$00,$FF,$C9,$B2,$30
	dc.b	$00,$00,$67,$00,$00,$0A,$10,$30,$00,$00,$60,$00,$00,$06,$30,$3C
	dc.b	$00,$00,$4C,$DF,$01,$0E,$4E,$75,$00,$01,$01,$04,$06,$04,$06,$00
	dc.b	$02,$02,$03,$05,$03,$05

sub_FFD0
	tst.w	(puckc).w
	bmi.w	locret_10054
	movem.l	d0-d4/a0-a3,-(sp)
	move.w	(puckc).w,d0
	asl.w	#7,d0	;#scsize
	movea.w	#(SortCords-M68K_RAM),a3
	adda.w	d0,a3
	movea.l	#SortCords,a0
	btst	#6,$62(a3)
	beq.w	.0
	adda.w	#$300,a0
.0
	move.w	(pucky).w,d0

loc_10000
	move.w	#$76,d1
	btst	#7,$62(a3)
.0
	beq.w	.1
	neg.w	d0
.1
	cmp.w	d1,d0
	blt.w	.2
	tst.w	$34(a3)
	bne.w	.5
	bra.w	.3
.2
	neg.w	d0
	cmp.w	d1,d0
	blt.w	.5
	move.b	$62(a3),d0
	move.b	$62(a0),d1
	eor.b	d1,d0
	btst	#6,d0
	beq.w	.5
	bra.w	.5
.3
	move.w	#5,d1
.4
	st	$65(a0)
	adda.w	#$80,a0
	dbf	d1,.4
.5
	movem.l	(sp)+,d0-d4/a0-a3

locret_10054
	rts

sub_10056
	movem.l	d1/a0,-(sp)
	move.w	#5,d1
.0
	st	$65(a0)
	adda.w	#$80,a0
	dbf	d1,.0
	movem.l	(sp)+,d1/a0
	rts

sub_10070
	movem.l	d0-d1/a0-a1,-(sp)
	movea.l	#SortCords,a0
	bsr.w	sub_1008E
	movea.l	#SortCords+$300,a0
	bsr.w	sub_1008E
	movem.l	(sp)+,d0-d1/a0-a1
	rts

sub_1008E
	movea.l	a0,a1
	clr.w	d2
	move.w	#5,d0
.0
	clr.w	d1
	move.b	$65(a0),d1
	bpl.w	.1
	move.w	$34(a0),d1
	bmi.w	.2
.1
	bset	d1,d2
	beq.w	.2
	movea.l	a1,a0
	bsr.s	sub_10056
	bra.w	.3
.2
	adda.w	#$80,a0
	dbf	d0,.0
.3
	rts

DefaultRosters
	movem.l	d0-d7/a0-a6,-(sp)
	move.w	#0,d1
	movea.l	#$FFFF1550,a6
	movea.l	#$FFFF1ACC,a5
	movea.l	#$FFFF1B00,a4
.team
	clr.w	d2
	movea.l	a6,a0
	move.w	#$1A,d5
.clr
	move.w	#$8000,(a0)+
	dbf	d5,.clr
	movea.l	a6,a0
	movea.l	a4,a2
	movea.l	#TeamList,a1
	move.w	d1,d0
	asl.w	#2,d0
	movea.l	(a1,d0.w),a1
	adda.w	(a1),a1
	bra.w	.store
.player
	cmpi.w	#2,(a1)
	beq.w	.counts
	addq.w	#1,d2
.store
	move.b	d1,(a0)+
	move.b	d2,(a0)+
	adda.w	(a1),a1
	move.b	(a1),d4
	move.b	d4,(a2)+
	addq.w	#8,a1
	bra.s	.player
.counts
	movem.l	d1-d7/a0,-(sp)
	move.w	d1,d7
	movea.l	#TeamList,a0
	asl.w	#2,d7
	movea.l	(a0,d7.w),a0
	adda.w	$A(a0),a0
	move.w	(a0),d1
	clr.w	d0
.goalies
	addq.w	#1,d0
	asl.w	#4,d1
	bne.s	.goalies
	movea.l	a5,a0
	move.b	d2,(a0)
	addq.b	#1,(a0)
	andi.b	#3,d0
	move.b	d0,1(a0)
	movem.l	(sp)+,d1-d7/a0
	adda.l	#$36,a6
	adda.l	#$1B,a4
	addq.l	#2,a5
	addq.w	#1,d1
	cmp.w	#$1A,d1
	blt.w	.team
	movem.l	(sp)+,d0-d7/a0-a6
	rts
	;Not decoded in the listing and not referenced from it: kept as bytes
	dc.b	$48,$E7,$F1,$A0,$61,$00,$00,$4E,$22,$48,$4C,$DF,$05,$8F,$4E,$75

FormatPlayerNameD7
	movem.l	d0-d3/d7-a0/a2,-(sp)
	bsr.w	sub_101BE
	move.l	a0,-(sp)
	movea.w	#(TextBuffer-M68K_RAM),a1
	adda.w	(a0),a0
	jsr	(GetJerseyNumber).l
	move.b	(jerseynum+1).w,d0
	jsr	(ConvertByteToDigits).l
	move.b	#$20,(a1)+
	movea.l	(sp)+,a0
	move.w	(a0)+,d0
	lea	-2(a0,d0.w),a2
.skipfirst
	cmpi.b	#$20,(a0)+
	bne.s	.skipfirst
.copy
	move.b	(a0)+,(a1)+
	cmpa.l	a0,a2
	bne.s	.copy
	jsr	(FinalizeTextBuffer).l
	movem.l	(sp)+,d0-d3/d7-a0/a2
	rts

sub_101BE
	movem.l	d0/d7/a2,-(sp)
	bra.w	loc_101CE

GetPlayerNamePointer	;a0 = name string of player d0 (roster offset) of team struct a2 (GetRosterName)
	movem.l	d0/d7/a2,-(sp)
	move.w	$28(a2),d7

loc_101CE
	jsr	(GetRosterName).l
	movea.l	a1,a0
	movem.l	(sp)+,d0/d7/a2
	rts

GetCreatedName
	movem.l	d0-d1/d5-d7/a0,-(sp)
	bra.w	GetRosterNameTail
	;Not decoded in the listing and not referenced from it: kept as bytes
	dc.b	$4E,$75

GetRosterName	;a1 = name String of player d0 of team d7 (season roster aware)
	movem.l	d0-d1/d5-d7/a0,-(sp)
	btst	#4,(sflags11).w
	beq.w	.season
	move.w	d7,d6
	movea.l	#TeamList,a1
	asl.w	#2,d6
	movea.l	(a1,d6.w),a1
	adda.w	(a1),a1
	bra.w	.next
.skip
	adda.w	(a1),a1
	addq.w	#8,a1
.next
	dbf	d0,.skip
	movem.l	(sp)+,d0-d1/d5-d7/a0
	rts
.season
	cmp.w	#$1B,d7
	ble.w	.team
	add.w	d0,d0
	ext.l	d0
	addi.l	#$DB4,d0
	bra.w	.0
.team
	move.w	d7,d6
	mulu.w	#$36,d7
	add.w	d0,d0
	ext.l	d0
	add.l	d7,d0
	addi.l	#$1550,d0
.0
	movea.l	#$FFFFBF7E,a0
	movea.l	#SaveRAM,a1
	add.w	d0,d0
	move.b	1(a1,d0.w),(a0)
	move.b	3(a1,d0.w),1(a0)
	move.w	(a0),d0

GetRosterNameTail
	move.w	d0,-(sp)
	andi.w	#$1F00,d0
	cmp.w	#$1E00,d0
	bne.w	.team
	move.w	(sp)+,d0
	andi.w	#$FF,d0
	asl.w	#5,d0
	ext.l	d0
	addi.l	#$12CE,d0
	moveq	#$20,d1
	movea.l	#$FFFFDD8A,a0
	jsr	(ReadSRAM).l
	movea.l	a0,a1
	bra.w	.done
.team
	move.w	(sp)+,d0
	move.w	d0,d6
	lsr.w	#8,d6
	andi.w	#$1F,d6
	andi.w	#$FF,d0
	movea.l	#TeamList,a1
	asl.w	#2,d6
	movea.l	(a1,d6.w),a1
	adda.w	(a1),a1
	bra.w	.next
.skip
	adda.w	(a1),a1
	addq.w	#8,a1
.next
	dbf	d0,.skip
.done
	movem.l	(sp)+,d0-d1/d5-d7/a0
	rts

GetJerseyNumber	;The jersey number byte of player d0 of team d7
	movem.l	d0-d1/a0-a1,-(sp)
	btst	#4,(sflags11).w
	beq.w	.0
	move.w	d7,-(sp)
	movea.l	#TeamList,a0
	asl.w	#2,d7
	movea.l	(a0,d7.w),a0
	adda.w	(a0),a0
	bra.w	.next
.skip
	adda.w	(a0),a0
	addq.w	#8,a0
.next
	dbf	d0,.skip
	adda.w	(a0),a0
	clr.w	(jerseynum).w
	move.b	(a0),(jerseynum+1).w
	move.w	(sp)+,d7
	bra.w	.2
.0
	cmp.w	#$1C,d7
	beq.w	.1
	move.w	d7,d1
	muls.w	#$1B,d1
	ext.l	d1
	ext.l	d0
	add.l	d1,d0
	addi.l	#$1B00,d0
	add.l	d0,d0
	movea.l	#SaveRAM,a0
	move.w	(a0,d0.w),d0
	andi.w	#$FF,d0
	move.w	d0,(jerseynum).w
	bra.w	.2
.1
	jsr	(GetRosterName).l
	adda.w	(a1),a1
	clr.w	d0
	move.b	(a1),d0
	move.w	d0,(jerseynum).w
.2
	movem.l	(sp)+,d0-d1/a0-a1
	rts
	;Not decoded in the listing and not referenced from it: kept as bytes
	dc.b	$48,$E7,$C0,$00,$30,$07,$72,$36,$C0,$C1,$06,$80,$00,$00,$15,$50
	dc.b	$4E,$B9,$00,$02,$41,$E8,$4C,$DF,$00,$03,$4E,$75,$48,$E7,$C0,$00
	dc.b	$30,$07,$72,$36,$C0,$C1,$06,$80,$00,$00,$15,$50,$4E,$B9,$00,$02
	dc.b	$41,$88,$4E,$B9,$00,$02,$41,$AA,$4C,$DF,$00,$03,$4E,$75,$08,$38
	dc.b	$00,$04,$C3,$54,$66,$00,$00,$28,$48,$E7,$81,$80,$E5,$40,$48,$C0
	dc.b	$20,$7C,$00,$20,$2A,$A0,$CE,$FC,$00,$02,$DE,$87,$DE,$80,$30,$30
	dc.b	$78,$00,$02,$40,$00,$1F,$B0,$7C,$00,$1E,$4C,$DF,$01,$81,$4E,$75

sub_103AA
	movem.l	d1/d6-d7/a0-a1,-(sp)
	btst	#4,(sflags11).w
	beq.w	.1
	move.w	d7,d6
	movea.l	#TeamList,a1
	asl.w	#2,d6
	movea.l	(a1,d6.w),a1
	adda.w	4(a1),a1	;city
	adda.w	(a1),a1
	adda.w	(a1),a1
	adda.w	(a1),a1	;arena
	adda.w	(a1),a1
	move.w	d0,d1
	asr.w	#1,d0
	move.b	(a1,d0.w),d0
	btst	#0,d1
	bne.w	.0
	lsr.w	#4,d0
.0
	andi.w	#$F,d0
	bra.w	.5
.1
	cmp.w	#$1B,d7
	ble.w	.team
	add.w	d0,d0
	ext.l	d0
	addi.l	#$DB4,d0
	bra.w	.2
.team
	move.w	d7,d6
	mulu.w	#$36,d7
	add.w	d0,d0
	ext.l	d0
	add.l	d7,d0
	addi.l	#$1550,d0
.2
	movea.l	#$FFFFBF7E,a0
	movea.l	#SaveRAM,a1
	add.w	d0,d0
	move.b	1(a1,d0.w),(a0)
	move.b	3(a1,d0.w),1(a0)
	move.w	(a0),d0
	move.w	d0,-(sp)
	andi.w	#$1F00,d0
	cmp.w	#$1E00,d0
	bne.w	.3
	move.w	(sp)+,d0
	andi.w	#$FF,d0
	asl.w	#5,d0
	ext.l	d0
	addi.l	#$12CE,d0
	moveq	#$20,d1
	movea.l	#$FFFFDD8A,a0
	jsr	(ReadSRAM).l
	adda.w	(a0),a0
	addq.w	#8,a0
	move.b	(a0),d0
	ext.w	d0
	bra.w	.5
.3
	move.w	(sp)+,d0
	move.w	d0,d6
	lsr.w	#8,d6
	andi.w	#$1F,d6
	andi.w	#$FF,d0
	movea.l	#TeamList,a1
	asl.w	#2,d6
	movea.l	(a1,d6.w),a1
	adda.w	4(a1),a1	;city
	adda.w	(a1),a1
	adda.w	(a1),a1
	adda.w	(a1),a1	;arena
	adda.w	(a1),a1
	move.w	d0,d6
	lsr.b	#1,d6
	move.b	(a1,d6.w),d6
	btst	#0,d0
	bne.w	.4
	lsr.b	#4,d6
.4
	andi.w	#$F,d6
	clr.w	d0
	move.b	d6,d0
.5
	movem.l	(sp)+,d1/d6-d7/a0-a1
	rts
	;Not decoded in the listing and not referenced from it: kept as bytes
	dc.b	$48,$E7,$C0,$00,$30,$07,$C0,$FC,$00,$36,$06,$80,$00,$00,$15,$50
	dc.b	$72,$36,$4E,$B9,$00,$02,$41,$E8,$4C,$DF,$00,$03,$4E,$75,$48,$E7
	dc.b	$C0,$00,$30,$07,$C0,$FC,$00,$36,$06,$80,$00,$00,$15,$50,$72,$36
	dc.b	$4E,$B9,$00,$02,$41,$88,$4E,$B9,$00,$02,$41,$AA,$4C,$DF,$00,$03
	dc.b	$4E,$75

sub_104EE
	movem.l	d0/d7-a1,-(sp)
	mulu.w	#$36,d7
	add.w	d0,d0
	ext.l	d0
	add.l	d7,d0
	addi.l	#$1550,d0
	movea.l	#SaveRAM,a1
	add.w	d0,d0
	move.b	1(a1,d0.w),(a0)
	move.b	3(a1,d0.w),1(a0)
	movem.l	(sp)+,d0/d7-a1
	rts

sub_1051A
	movem.l	d0-d7/a0-a6,-(sp)
	move.l	a0,(TempLegSpd).w
	clr.w	d0
	move.b	(a0),d0
	movea.l	#$FFFF5208,a5
	movea.l	#$FFFF5244,a4
	bsr.w	sub_10688
	clr.w	d1
	movea.l	(TempLegSpd).w,a0
	move.b	1(a0),d1
	bsr.w	sub_105B0
	move.b	d2,2(a0)
	clr.w	d0
	move.b	1(a0),d0
	movea.l	#$FFFF55F0,a5
	movea.l	#$FFFF562C,a4
	bsr.w	sub_10688
	clr.w	d1
	movea.l	(TempLegSpd).w,a0
	move.b	(a0),d1
	bsr.w	sub_105B0
	movea.l	(TempLegSpd).w,a0
	move.b	d2,3(a0)
	btst	#7,(GameFlags).w
	beq.w	.0
	btst	#2,(dword_FFDD7E+2).w
	beq.w	.0
	move.b	2(a0),d0
	move.b	3(a0),d1
	cmp.b	d0,d1
	bne.w	.0
	btst	#2,(vcount).w
	beq.w	.1
	addq.b	#1,3(a0)
	bra.w	.0
.1
	addq.b	#1,2(a0)
.0
	movem.l	(sp)+,d0-d7/a0-a6
	rts

sub_105B0
	move.w	d1,(TempMaxSpd).w
	movea.l	#unk_107F9,a1
	move.b	(a1,d1.w),d1
	sub.w	d1,d3
	movea.l	#AwShots,a2
	move.w	(TempMaxSpd).w,d4
	move.w	d3,-(sp)
	move.w	d4,$28(a2)
	movea.l	#TeamList,a1
	asl.w	#2,d4
	move.l	(a1,d4.w),(dword_FFCAE2).w
	move.l	(GAttribOverallMask).l,d4
	clr.w	d0
	jsr	(sub_1D7DF8).l
	muls.w	#$64,d0
	divs.w	d1,d0
	movea.l	#unk_10760,a0
	clr.w	d1
	move.b	(a0,d0.w),d1
	move.w	(sp)+,d3
	sub.w	d1,d3
	movea.l	(TempLegSpd).w,a0
	movea.l	#unk_10813,a1
	move.w	(TempMaxSpd).w,d0
	cmp.b	(a0),d0
	beq.w	.0
	movea.l	#unk_1082D,a1
.0
	move.b	(a1,d0.w),d1
	ext.w	d1
	add.w	d1,d3
	bpl.w	.1
	clr.w	d3
.1
	cmp.w	#$64,d3
	ble.w	.2
	move.w	#$64,d3
.2
	movea.l	#unk_10670,a1
	move.w	d3,d0
	clr.w	d3
.3
	cmp.b	(a1,d3.w),d0
	ble.w	.4
	addq.w	#1,d3
	bra.s	.3
.4
	muls.w	#$A,d3
	movea.l	#unk_10847,a1
	adda.l	d3,a1
	move.w	#$64,d0
	jsr	(randomd0).l
	clr.w	d2
.5
	cmp.b	(a1,d2.w),d0
	ble.w	locret_10686
	addq.w	#1,d2
	bra.s	.5

unk_10670
	dc.b	$09,$13,$18,$1D,$21,$24,$27,$2A,$2D,$30,$33,$36,$39,$3C,$3F,$42
	dc.b	$46,$4B,$50,$5A,$64,$FF

locret_10686
	rts

sub_10688
	movem.l	d0-d2/d4-d7/a0-a6,-(sp)
	move.w	d0,(TempWord1).w
	movea.l	#$202AA0,a6
	move.w	d0,d1
	muls.w	#$6C,d1
	adda.l	d1,a6
	movea.l	#$FFFFC8E2,a0
	move.w	#$6F,d1
.0
	clr.l	(a0)+
	dbf	d1,.0
	movea.l	#tmstruct,a2
	move.w	d0,$28(a2)
	movea.l	#TeamList,a0
	asl.w	#2,d0
	move.l	(a0,d0.w),(dword_FFC744).w
	move.l	(PAttribOverallMask).l,d4
	bsr.w	GetGoalieCount
	move.w	d0,-(sp)
	bsr.w	GetPlayerCount
	sub.w	(sp),d0
	subq.w	#1,d0
	move.w	d0,d2
	move.w	(sp)+,d0
	movem.l	a4-a5,-(sp)
.1
	btst	#6,1(a6)
	bne.w	.2
	movem.l	d0/d2/d4,-(sp)
	movem.l	a4-a6,-(sp)
	jsr	(sub_1D7DF8).l
	muls.w	#$64,d0
	divs.w	d1,d0
	movem.l	(sp)+,a4-a6
	move.w	d0,(a5)+
	movem.l	(sp)+,d0/d2/d4
	move.b	d0,(a4)
.2
	addq.w	#1,a4
	addq.w	#1,d0
	addq.w	#4,a6
	dbf	d2,.1
	move.b	#$FF,(a4)
	movem.l	(sp)+,a4-a5
	bsr.w	sub_10CB2
	move.w	#$D,d0
	clr.w	d3
	movea.l	#unk_10760,a2
.3
	move.w	(a5)+,d2
	move.b	(a2,d2.w),d2
	add.w	d2,d3
	dbf	d0,.3
	move.w	(TempWord1).w,d0
	movea.l	#unk_107DF,a1
	clr.w	d1
	move.b	(a1,d0.w),d1
	sub.w	d1,d3
	movea.l	#unk_107C5,a1
	clr.w	d1
	move.b	(a1,d0.w),d1
	add.w	d1,d3
	movem.l	(sp)+,d0-d2/d4-d7/a0-a6
	rts

unk_10760
	dc.b	$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
	dc.b	$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
	dc.b	$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
	dc.b	$01,$01,$01,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
	dc.b	$02,$02,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03
	dc.b	$03,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$05,$05,$05,$05,$05
	dc.b	$06,$06,$06,$06,$06

unk_107C5
	dc.b	$1B,$2D,$28,$2C,$2B,$23,$32,$1D,$22,$21,$1F,$20,$2A,$1A,$25,$19
	dc.b	$2E,$30,$31,$24,$2F,$1C,$27,$26,$29,$1E

unk_107DF
	dc.b	$1D,$26,$28,$26,$26,$21,$26,$1D,$1D,$20,$23,$22,$23,$20,$2A,$1D
	dc.b	$26,$2B,$27,$22,$22,$1F,$25,$25,$23,$22

unk_107F9
	dc.b	$02,$05,$06,$05,$06,$04,$06,$01,$05,$03,$01,$02,$06,$02,$04,$01
	dc.b	$05,$02,$04,$02,$04,$03,$03,$03,$06,$01

unk_10813
	dc.b	$01,$02,$02,$02,$01,$01,$03,$01,$01,$02,$00,$02,$02,$01,$01,$00
	dc.b	$03,$03,$03,$01,$03,$01,$02,$01,$02,$01

unk_1082D
	dc.b	$FD,$00,$FE,$FF,$00,$FE,$00,$FE,$00,$FE,$FF,$FD,$FF,$FD,$FF,$FD
	dc.b	$00,$00,$00,$FF,$00,$FE,$FD,$FE,$FE,$FD

unk_10847
	dc.b	$0A,$19,$2E,$43,$52,$5C,$62,$64,$64,$64,$0A,$18,$2C,$40,$4E,$59
	dc.b	$61,$64,$64,$64,$09,$17,$2A,$3D,$4B,$56,$60,$64,$64,$64,$09,$16
	dc.b	$28,$3B,$49,$55,$60,$64,$64,$64,$08,$14,$25,$38,$46,$53,$5F,$64
	dc.b	$64,$64,$07,$12,$1E,$31,$45,$52,$5E,$63,$64,$64,$07,$11,$1C,$2F
	dc.b	$43,$50,$5C,$63,$64,$64,$06,$0F,$1A,$2D,$41,$4E,$5A,$62,$64,$64
	dc.b	$06,$0F,$1A,$2C,$3E,$4C,$59,$62,$64,$64,$05,$0D,$17,$29,$3B,$49
	dc.b	$57,$61,$64,$64,$05,$0C,$15,$23,$35,$48,$57,$61,$64,$64,$04,$0A
	dc.b	$12,$20,$32,$45,$54,$60,$64,$64,$04,$0A,$12,$1E,$30,$43,$52,$5F
	dc.b	$64,$64,$03,$08,$0F,$1B,$2D,$40,$4F,$5D,$63,$64,$03,$08,$0F,$1B
	dc.b	$2C,$3D,$4C,$5B,$62,$64,$02,$06,$0D,$19,$2A,$3B,$4A,$59,$61,$64
	dc.b	$02,$05,$0B,$15,$23,$36,$49,$58,$60,$64,$01,$03,$09,$13,$21,$3E
	dc.b	$47,$56,$5F,$64,$01,$03,$09,$12,$1F,$32,$45,$54,$5E,$64,$00,$01
	dc.b	$06,$0F,$1C,$2F,$42,$52,$5D,$64,$00,$00,$04,$0C,$19,$2C,$3F,$50
	dc.b	$5C,$64,$FF

SimGameStats
	movem.l	d0-d7/a0-a6,-(sp)
	move.w	(vcount).w,d0
	jsr	(randomd0).l
	movea.l	#tmstruct,a1
	move.w	#$39D,d0
.loop
	clr.w	(a1)+
	dbf	d0,.loop
	clr.w	d0
	move.b	(a0),d0
	move.w	d0,(HomeTeam).w
	clr.w	d0
	move.b	1(a0),d0
	move.w	d0,(VisTeam).w
	movea.l	#tmstruct,a1
	movea.l	#AwShots,a2
	move.w	(HomeTeam).w,$28(a1)
	move.w	(VisTeam).w,$28(a2)
	movem.l	a2,-(sp)
	movea.l	#tmstruct,a2
	jsr	(sub_1E8840).l
	movea.l	#AwShots,a2
	jsr	(sub_1E8840).l
	movem.l	(sp)+,a2
	clr.w	d0
	move.b	2(a0),d0
	move.w	d0,$C(a1)
	move.w	d0,(rosterscroll).w
	move.w	(HomeTeam).w,d1
	move.w	(VisTeam).w,d2
	bsr.w	sub_10C6A
	move.w	d0,(a1)
	movea.l	#$FFFF5208,a5
	movea.l	#$FFFF5244,a4
	bsr.w	sub_10BAC
	bsr.w	sub_10C00
	movea.l	#$FFFF5668,a6
	bsr.w	sub_10A08
	clr.w	d0
	move.b	3(a0),d0
	move.w	d0,$C(a2)
	move.w	d0,(rosterscroll).w
	move.w	(VisTeam).w,d1
	move.w	(HomeTeam).w,d2
	bsr.w	sub_10C6A
	move.w	d0,(a2)
	movea.l	a2,a1
	movea.l	#$FFFF55F0,a5
	movea.l	#$FFFF562C,a4
	bsr.w	sub_10BAC
	bsr.w	sub_10C00
	movea.l	#$FFFF56A4,a6
	bsr.w	sub_10A08
	bsr.w	SimGoalieStats
	jsr	(sub_10CF2).l
	movem.l	(sp)+,d0-d7/a0-a6
	rts

sub_10A08
	movem.l	d0-d7/a0-a6,-(sp)
	move.w	#$C0,d0
	jsr	(randomd0).l
	asr.w	#5,d0
	movea.l	#unk_10AFA,a3
	add.b	(a3,d1.w),d0
	cmp.b	#1,d0
	ble.w	.0
	asr.b	#1,d0
.0
	move.l	a1,-(sp)
	addq.w	#6,a1
	move.w	d0,(a1)
	movea.l	(sp)+,a1
	move.w	d1,$28(a1)
	movem.l	d1/a0-a1,-(sp)
	movea.l	#TeamList,a0
	asl.w	#2,d1
	move.l	(a0,d1.w),-(sp)
	adda.w	#$1E,a1
	move.l	(sp)+,(a1)
	movem.l	(sp)+,d1/a0-a1
	movem.l	a4/a6,-(sp)
	move.l	(PAttribAggressMask).l,d4
	movea.l	a1,a2
.1
	clr.w	d0
	move.b	(a4)+,d0
	bmi.w	.2
	movem.l	d2-d7/a0-a6,-(sp)
	bset	#4,(sflags13).w
	jsr	(sub_1D7DF8).l
	bclr	#4,(sflags13).w
	movem.l	(sp)+,d2-d7/a0-a6
	move.w	d0,(a6)+
	bra.s	.1
.2
	movem.l	(sp)+,a4/a6
	move.l	a5,-(sp)
	movea.l	a6,a5
	bsr.w	sub_10CB2
	movea.l	(sp)+,a5
	movem.l	d0-d7/a0-a6,-(sp)
	move.w	6(a1),d6
	move.w	d6,d7
	subq.w	#1,d7
	movea.l	#unk_10CA3,a3
	bra.w	.7
.3
	move.w	#$64,d0
	jsr	(randomd0).l
	clr.w	d5
.4
	cmp.b	(a3,d5.w),d0
	ble.w	.5
	addq.w	#1,d5
	bra.s	.4
.5
	clr.w	d0
	move.b	(a4,d5.w),d0
	move.w	d0,d1
	asl.w	#1,d1
	addi.w	#$6C,d1
	tst.w	(a1,d1.w)
	bne.w	.7
	move.l	a1,-(sp)
	adda.w	#$114,a1
	addq.b	#2,(a1,d0.w)
	cmp.w	d7,d6
	bne.w	.6
	addq.b	#3,(a1,d0.w)
.6
	movea.l	(sp)+,a1
.7
	dbf	d6,.3
	movem.l	(sp)+,d0-d7/a0-a6
	movem.l	(sp)+,d0-d7/a0-a6
	rts

unk_10AFA
	dc.b	$04,$04,$06,$09,$07,$07,$06,$08,$04,$05,$06,$05,$04,$05,$04,$04
	dc.b	$04,$06,$04,$05,$06,$07,$04,$07,$08,$08

SimGoalieStats
	movem.l	d0-d7/a0-a6,-(sp)
	move.w	(HomeTeam).w,d7
	movea.l	#tmstruct,a1
	movea.l	#AwShots,a2
	bsr.w	SimGoalie
	move.w	(VisTeam).w,d7
	movea.l	#AwShots,a1
	movea.l	#tmstruct,a2
	bsr.w	SimGoalie
	movem.l	(sp)+,d0-d7/a0-a6
	rts

SimGoalie
	jsr	(GetGoalieCountD7).l
	subq.w	#1,d0
	bsr.w	PickSimGoalie
	move.w	d0,d3
	add.w	d3,d3
	addi.w	#$14C,d3
	addi.w	#$E10,(a1,d3.w)
	move.w	(a2),d4
	cmp.w	#$FF,d4
	ble.w	.0
	move.w	#$FF,d4
.0
	move.w	d0,d3
	addi.w	#$F8,d3
	move.b	d4,(a1,d3.w)
	move.w	$C(a2),d4
	move.w	d0,d3
	addi.w	#$C0,d3
	move.b	d4,(a1,d3.w)
	rts

PickSimGoalie
	movem.l	d1-d7,-(sp)
	clr.w	d1
	move.w	#$64,d0
	jsr	(randomd0).l
	cmp.w	#$2D,d0
	bgt.w	.0
	move.w	#1,d1
.0
	move.w	d1,d0
	movem.l	(sp)+,d1-d7
	rts

sub_10BAC
	movem.l	d0-d7/a0-a6,-(sp)
	move.w	(rosterscroll).w,d6
	movea.l	#unk_10CA3,a3
	bra.w	.3
.0
	move.w	#$64,d0
	jsr	(randomd0).l
	clr.w	d5
.1
	cmp.b	(a3,d5.w),d0
	ble.w	.2
	addq.w	#1,d5
	bra.s	.1
.2
	clr.w	d0
	move.b	(a4,d5.w),d0
	move.w	d0,d1
	asl.w	#1,d1
	addi.w	#$6C,d1
	tst.w	(a1,d1.w)
	bne.s	.0
	move.l	a1,-(sp)
	adda.w	#$C0,a1
	addq.b	#1,(a1,d0.w)
	movea.l	(sp)+,a1
.3
	dbf	d6,.0
	movem.l	(sp)+,d0-d7/a0-a6
	rts

sub_10C00
	movem.l	d0-d7/a0-a6,-(sp)
	move.w	(rosterscroll).w,d6
	move.w	#$64,d0
	jsr	(randomd0).l
	addi.w	#$64,d0
	muls.w	d0,d6
	divs.w	#$64,d6
	movea.l	#unk_10C94,a3
	bra.w	.3
.0
	move.w	#$64,d0
	jsr	(randomd0).l
	clr.w	d5
.1
	cmp.b	(a3,d5.w),d0
	ble.w	.2
	addq.w	#1,d5
	bra.s	.1
.2
	clr.w	d0
	move.b	(a4,d5.w),d0
	move.w	d0,d1
	asl.w	#1,d1
	addi.w	#$6C,d1
	tst.w	(a1,d1.w)
	bne.w	.3
	move.l	a1,-(sp)
	adda.w	#$DC,a1
	addq.b	#1,(a1,d0.w)
	movea.l	(sp)+,a1
.3
	dbf	d6,.0
	movem.l	(sp)+,d0-d7/a0-a6
	rts

sub_10C6A
	movem.l	d1-d7/a0-a6,-(sp)
	movea.l	#unk_107F9,a1
	clr.w	d3
	move.b	(a1,d2.w),d3
	sub.w	d3,d0
	move.w	d0,-(sp)
	move.w	#$14,d0
	jsr	(randomd0).l
	addi.w	#$1E,d0
	add.w	(sp)+,d0
	movem.l	(sp)+,d1-d7/a0-a6
	rts

unk_10C94
	dc.b	$0C,$18,$24,$2E,$36,$3E,$46,$4C,$52,$56,$5A,$5E,$60,$62,$64

unk_10CA3
	dc.b	$0D,$19,$22,$2B,$34,$3B,$42,$48,$4E,$54,$58,$5C,$60,$62,$64
