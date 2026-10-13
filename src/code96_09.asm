;	Penalties (AddPenalty, PenaltyManager, chkprogress, the penalty shot checks, the ref window, the penalty box and
;	the power play box), the line energy, the shot stats, the intermission and the other games' scores, and the
;	collision and check code (checkcoll, checkplcoll, checkcx, checkint, CCStart, checkagr, holdcheck).

PrintBigChar	;Print big font char d0 (printbigtext) through the unk_1C01C table
	subi.w	#$20,d0
	btst	#6,(sflags13).w
	beq.w	.0
	cmp.b	#$3A,d0
	bne.w	.0
	move.b	#$2E,d1
	clr.w	d2
	bra.w	.1
.0
	movea.l	#unk_232C8,a0
	clr.w	d2
	move.b	(a0,d0.w),d1
.1
	ext.w	d1
	asl.w	#1,d1
	movea.l	(bigfontptr).w,a0
	adda.l	4(a0),a0
.loop
	move.w	4(a0,d1.w),d3
	bsr.w	PutBigTile
	move.w	(a0),d7
	asl.w	#1,d7
	add.w	d7,d1
	move.w	4(a0,d1.w),d3
	sub.w	d7,d1
	addq.w	#1,d5
	bsr.w	PutBigTile
	subq.w	#1,d5
	addq.w	#1,d4
	addq.w	#2,d1
	dbf	d2,.loop
	rts

PutBigTile	;Write tile d3 + d6 at column d4, row d5 of the map at VmMap1 + printm
	add.w	d6,d3
	movem.l	d1/a0,-(sp)
	move.w	d5,d0
	movea.l	#$FFFFB004,a0
	adda.w	(printm).w,a0
	move.w	2(a0),d1
	asl.w	d1,d0
	add.w	d4,d0
	asl.w	#1,d0
	add.w	(a0),d0
	bsr.w	Vmaddr
	move.w	d3,(a0)
	movem.l	(sp)+,d1/a0
	rts

unk_1C01C	;PrintBigChar: the char table
	dc.b	$00,$01,$F8,$4A,$00,$01,$C0,$50,$00,$01,$C0,$62,$00,$01,$C0,$88
	dc.b	$00,$01,$C0,$9A,$00,$01,$C0,$AC,$00,$01,$C0,$BE,$00,$01,$C0,$D0
	dc.b	$00,$01,$C0,$40,$61,$00,$00,$20,$61,$00,$00,$0A,$61,$00,$00,$3E
	dc.b	$60,$00,$00,$4C,$10,$19,$53,$43,$02,$40,$00,$03,$E5,$40,$59,$40
	dc.b	$31,$C0,$B0,$46,$4E,$75,$1C,$19,$02,$46,$00,$07,$53,$43,$E6,$5E
	dc.b	$31,$C6,$B0,$44,$08,$38,$00,$02,$C3,$54,$66,$00,$00,$0A,$DC,$78
	dc.b	$B0,$14,$60,$00,$00,$06,$DC,$78,$B0,$18,$4E,$75,$42,$40,$10,$19
	dc.b	$53,$43,$31,$C0,$B0,$40,$38,$38,$B0,$40,$60,$00,$F8,$B2,$42,$40
	dc.b	$10,$19,$53,$43,$31,$C0,$B0,$42,$3A,$38,$B0,$42,$60,$00,$F8,$A0
	dc.b	$10,$19,$48,$80,$53,$43,$D1,$78,$B0,$40,$38,$38,$B0,$40,$60,$00
	dc.b	$F8,$8E,$10,$19,$48,$80,$53,$43,$D1,$78,$B0,$42,$3A,$38,$B0,$42
	dc.b	$60,$00,$F8,$7C,$42,$40,$10,$19,$53,$43,$31,$F8,$B0,$16,$B0,$14
	dc.b	$23,$FC,$00,$1B,$89,$C8,$FF,$FF,$B0,$10,$B0,$7C,$00,$02,$67,$00
	dc.b	$00,$1C,$B0,$7C,$00,$03,$66,$00,$00,$12,$31,$F8,$B0,$1A,$B0,$14
	dc.b	$23,$FC,$00,$1B,$9E,$D8,$FF,$FF,$B0,$10,$4E,$75,$31,$F8,$B0,$18
	dc.b	$B0,$14,$23,$FC,$00,$1B,$94,$16,$FF,$FF,$B0,$10,$4E,$75

printbigz1	;printbig1 with the String after the call
	move.l	a1,-(sp)
	movea.l	4(sp),a1
	bsr.w	printbig1
	move.l	a1,4(sp)
	movea.l	(sp)+,a1
	rts

printbigz2	;printbig2 with the String after the call
	move.l	a1,-(sp)
	movea.l	4(sp),a1
	bsr.w	printbig2
	move.l	a1,4(sp)
	movea.l	(sp)+,a1
	rts

printbig1	;printbigcur with the font map unk_1B89C8 (chars word_FFB016)
	bclr	#2,(sflags11).w
	move.l	#unk_1B89C8,(bigfontptr).l
	move.w	(word_FFB016).w,(word_FFB014).w
	jmp	printbigcur

printbig2	;printbigcur with the font map unk_1B9416 (chars BigFontChars)
	bclr	#2,(sflags11).w
	move.l	#unk_1B9416,(bigfontptr).l
	move.w	(BigFontChars).w,(word_FFB014).w
	jmp	printbigcur
	;After printbig2: code that nothing in the listing reaches.
	;Code the listing does not decode: kept as bytes
	dc.b	$31,$C4,$B0,$1C,$24,$7C,$00,$17,$9A,$7E,$60,$00,$F5,$AE

sub_1C184	;DecompressGraphicsPlain of unk_91B8E (the framer tiles) at char d4 (framercset)
	movea.l	#unk_91B8E,a2
	move.w	d4,(framercset).w
	bra.w	DecompressGraphicsPlain

AddPenalty	;Add penalty d0 (Penaltylist offset) for player a3. Ignored while the clock is stopped
	btst	#0,(gmode).w
	bne.w	rtss2
	cmp.w	#$C,d0
	beq.w	AddPenalty2
	cmpi.w	#3,(gsp).w
	nop
	nop
	tst.w	(OptPen).w
	beq.w	rtss2
	btst	#2,pflags2(a3)
	bne.w	rtss2
	btst	#5,(gmode).w
	bne.w	AddPenalty2
	cmp.w	#$10,d0
	beq.w	rtss2

AddPenalty2	;Forced penalties like faceoff and game over. d0 = penalty number, a3 = player
	btst	#4,(sflags9).w
	bne.w	rtss2
	btst	#7,(sflags).w
	bne.w	rtss2
	movem.l	d1/a0-a1,-(sp)
	cmp.w	#$E,d0	;goal and up
	blt.w	.nonoise
	addi.w	#$C8,(crowdlevel).w	;200
	addq.w	#5,(ChkCnt).w
	move.w	#$C,-(sp)	;song $C for the home team
	btst	#6,pflags(a3)
	beq.w	.0
	addi.w	#$14,(CwdExciteLvl).w	;visitors: +20 excitement
	move.w	#$B,(sp)	;song $B
.0
	jsr	(song).l
.nonoise
	movea.w	#(PenBuf-M68K_RAM),a1
	moveq	#$1F,d1	;MaxPen-1
.2
	tst.w	(a1)+
	dbeq	d1,.2
	bne.w	.noplayer
	move.b	$53(a3),-(a1)
	move.b	d0,-(a1)
	movea.l	#$E818,a0
	adda.w	(a0,d0.w),a0
	tst.b	1(a0)	;penalty minutes
	beq.w	.noplayer
	bmi.w	.noplayer
	btst	#6,pflags(a3)
	bne.w	.3
	bset	#1,(sflags9).w
	bra.w	.setpenflag
.3
	bset	#2,(sflags9).w
.setpenflag
	bset	#4,pflags2(a3)	;pflags2 bit 4
	beq.w	.noplayer
	clr.w	(a1)	;player already has a penalty, drop this one
.noplayer
	movem.l	(sp)+,d1/a0-a1
	rts

PenaltyManager	;Called periodically. d7 = elapsed time since last call: checkfornewpen, chkprogress, updatepentime, UpdatePA
	bsr.w	updatepentime
	bsr.w	checkfornewpen
	bsr.w	chkprogress
	bra.w	UpdatePA

chkprogress	;Control the progress of the ref and the game through penalty events. While BA_PS_flags bit 2 is set run
	;PenaltyShotBox (bit 7) or the msgtimer count down and erase the message area
	btst	#2,(BA_PS_flags).w
	beq.w	.3
	btst	#7,(BA_PS_flags).w
	bne.w	.sops
	tst.w	(msgtimer).w
	bmi.w	.3
	subq.w	#1,(msgtimer).w
	bpl.w	.ex
	movem.l	d0-d7/a0-a6,-(sp)
	bclr	#2,(sflags2).w
	bclr	#7,(gmode2).w
	bsr.w	printz
	String	$FF,$03,$02
	moveq	#$1B,d0
	moveq	#8,d1
	btst	#0,(gmode2).w
	beq.w	.0
	move.w	#$C,d1	;12 rows when gmode2 bit 0 is set
.0
	move.l	#$7FF,d2	;blank tile
	jsr	(eraser).l
	movem.l	(sp)+,d0-d7/a0-a6
	bra.w	.ex
.sops
	jsr	(PenaltyShotBox).l
	bclr	#7,(BA_PS_flags).w
.ex
	rts
.3
	btst	#2,(gmode).w	;gmpen: penalty called
	beq.w	rtss2
	tst.w	(Pencntdwn).w
	bmi.w	InProgress
	sub.w	d7,(Pencntdwn).w
	bpl.w	rtss2
	movea.l	#$FFFFC3A6,a0
.1
	tst.w	(a0)+
	bne.s	.1
	subq.l	#4,a0
	cmpa.l	#$FFFFC3A6,a0
	blt.w	.2
	cmpi.b	#$2E,(a0)
	bne.w	.2
	jsr	(ClearMessageLine).l
.2
	bclr	#3,(gmode).w
	movea.w	#(PenBuf-M68K_RAM),a0
.4
	tst.w	(a0)+	;any penalty with minutes
	beq.w	rtss2
	clr.w	d0
	move.b	-2(a0),d0
	movea.l	#$E818,a1
	adda.w	(a1,d0.w),a1
	tst.b	1(a1)	;penalty minutes
	beq.s	.4
	bmi.s	.4
	bset	#2,(sflags2).w
	bset	#4,(sflags9).w
	btst	#6,(sflags).w
	bne.w	.5
	move.w	#$96,(xc1).w
	move.w	#0,(yc1).w
	bset	#6,(sflags).w
.5
	move.w	(ExtraChars).w,d4	;load horizontal ref tiles
	movea.l	#unk_98F38,a2
	bsr.w	DecompressGraphicsPlain
	st	(puckc).w
	movea.w	#(puckx-M68K_RAM),a3
	moveq	#$1A,d0
	bsr.w	assinsert
	move.w	#$1C20,$40(a3)	;temp1 = 120*60
	st	(RefStep).w
	clr.w	(RefCnt).w
	bsr.w	UpdatePA
	move.w	#$32,(RefCnt).w	;50
	move.w	#5,d0
	bsr.w	PushRef
	move.w	#$18,(palcount).w
	rts

sub_1C3C6	;d0 = the unk_EBF8 word of penalty d0 when it is not negative
	movem.l	d1-d3/a0,-(sp)
	movea.l	#$EBF8,a0
	move.w	(a0,d0.w),d1
	bmi.w	.0
	move.w	d1,d0
.0
	movem.l	(sp)+,d1-d3/a0
	rts

PenShotChk	;A breakaway shooter hit: a penalty shot when penalty d0 allows one (PenShotPenalties); d0 = the penalty
	movem.l	d1-d3/a0,-(sp)
	btst	#1,pflags3(a2)	;breakaway
	beq.w	.loop
	btst	#0,(gmode).w
	bne.w	.loop
	btst	#3,(BA_PS_flags).w
	beq.w	.0
.loop
	move.w	#$FFFF,d1
	bra.w	.end
.0
	movea.l	#$EBC2,a0
	move.w	(a0,d0.w),d1
	bmi.w	.end
	move.w	SCnum(a2),d2	;SCnum
	movem.w	d0-d1,-(sp)
	move.w	d2,d0
	jsr	(getBAplayerInfo).l
	movem.w	(sp)+,d0-d1
	bpl.w	.found
	bclr	#3,(BA_PS_flags).w
	bra.s	.loop
.found
	move.w	d1,(pspenalty).w
	move.w	d1,d0	;return the penalty shot penalty
.end
	movem.l	(sp)+,d1-d3/a0
	rts

getBAplayerInfo	;Keep the breakaway shooter, team, goalie and checker for the penalty shot; N clear when set
	movem.l	d1-d3/a1,-(sp)
	tst.w	(OptPen).w
	beq.w	.noPen
	bset	#3,(BA_PS_flags).w
	movem.w	d0,-(sp)
	move.w	#5,d1
	move.w	#0,d2
	cmp.w	#5,d0
	bgt.w	.findgoalie
	move.w	#$B,d1
	move.w	#1,d2
.findgoalie
	move.w	d1,d0
	jsr	(getGoalieSCnum).l
	tst.w	d0
	bpl.w	.goaliein
	movem.w	(sp)+,d0	;no goalie
	bclr	#3,(BA_PS_flags).w
	bra.w	.end
.goaliein
	move.w	d0,d1	;d1 = goalie's SCnum
	move.w	(sp)+,d0	;d0 now back to player checked on breakaway SCnum
	move.w	d0,(BA_Sktr_SCnum).w
	movea.l	#SortCords,a1
	move.w	d0,d3
	asl.w	#7,d3	;scsize
	move.w	#0,(BA_Team).w
	btst	#6,$62(a1,d3.w)
	beq.w	.2
	move.w	#1,(BA_Team).w
.2
	move.w	#0,(BA_Skater_Offset).w
	move.b	$67(a1,d3.w),(BA_Skater_Offset+1).w
	move.w	d1,(BA_Goalie_SCnum).w
	asl.w	#7,d1	;scsize
	move.w	#0,(BA_Goalie_Offset).w
	move.b	$67(a1,d1.w),(BA_Goalie_Offset+1).w
	move.w	#0,(BA_Checker_Offset).w
	move.b	$67(a3),(BA_Checker_Offset+1).w
.end
	movem.l	(sp)+,d1-d3/a1
	rts
.noPen
	move.w	#$FFFF,d1	;N set: no penalty shot
	bra.s	.end

InProgress	;Ref in progress: update the graphics, stats and penalty information
	tst.w	(RefCnt).w
	bpl.w	rtss2
	tst.w	(RefStep).w
	bpl.w	rtss2
	movem.l	d0/a0-a3,-(sp)
.top
	movea.w	#(PenBuf-M68K_RAM),a0
	tst.w	(a0)+
	beq.w	.exit
.1
	tst.w	(a0)+
	bne.s	.1
	subq.w	#4,a0
	bclr	#7,1(a0)	;player who is guilty
	bne.w	.Sa
	movem.l	a3,-(sp)
	clr.w	d1
	move.b	1(a0),d1
	asl.w	#7,d1	;scsize
	movea.w	#(SortCords-M68K_RAM),a3
	adda.w	d1,a3
	tst.w	$34(a3)
	movem.l	(sp)+,a3
	bpl.w	.ex
	clr.w	(a0)
	bra.w	.ex
.Sa
	clr.w	d0
	move.b	(a0),d0
	movea.l	#$E818,a1
	adda.w	(a1,d0.w),a1
	bclr	#5,(sflags5).w
	clr.w	d2
	move.b	1(a1),d2	;penalty minutes
	beq.w	.10
	bmi.w	.10
	cmp.b	#5,d2
	bne.w	.3
	bset	#5,(sflags5).w
.3
	movem.l	d0-d1/a1-a4,-(sp)
	bsr.w	GetPeriodTimeRemaining
	movea.w	#(PenSum-M68K_RAM),a4
	adda.w	(PenSumLength).w,a4
	cmpi.w	#$EC,(PenSumLength).w	;log full: keep overwriting the last entry
	beq.w	.full
	addq.w	#4,(PenSumLength).w
.full
	move.w	d0,(a4)+	;time
	move.b	(a0),(a4)+	;penalty
	clr.w	d1
	move.b	1(a0),d1
	asl.w	#7,d1	;scsize
	movea.w	#(SortCords-M68K_RAM),a3
	adda.w	d1,a3
	clr.w	d0
	movea.w	#(tmstruct-M68K_RAM),a2
	lea	$39E(a2),a1	;tmsize: visitors
	btst	#6,$62(a3)
	beq.w	.5
	bset	#7,-1(a4)	;log: visitors
	move.w	#$8000,d0
	exg	a1,a2
.5
	addq.w	#1,6(a2)
	add.w	d2,8(a2)
	move.b	$67(a3),d0
	move.b	d0,(a4)	;log: player
	move.w	d0,(TempPlOffset).w
	ext.w	d0
	addi.w	#$114,d0
	add.b	d2,(a2,d0.w)
	subi.w	#$114,d0
	asl.w	#1,d0
	ext.w	d2
	mulu.w	#$3C,d2	;60
	bset	#$D,d2	;tmpdst bit 13
	tst.w	$6C(a2,d0.w)
	bmi.w	.st
	btst	#4,$6C(a2,d0.w)
	beq.w	.st
	bset	#$C,d2	;keep byte bit 4 (word bit 12) of an old penalty time
.st
	move.w	d2,$6C(a2,d0.w)
	andi.w	#$EFFF,d2
	moveq	#$38,d1	;(MaxRos-1)*2+2
.ctop
	subq.w	#2,d1	;same time on the other team
	bmi.w	.8
	move.w	$6C(a1,d1.w),d3
	andi.w	#$EFFF,d3
	cmp.w	d3,d2
	bne.s	.ctop
	btst	#5,(sflags5).w
	beq.s	.ctop
.8
	movem.l	a0,-(sp)
	lea	$A4(a2),a0
	moveq	#$1A,d1
.pl
	tst.b	(a0)+
	dbmi	d1,.pl
	move.b	d0,-1(a0)
	st	(a0)
	movem.l	(sp)+,a0
	move.w	#$C,d0
	bsr.w	assreplace
	movem.l	(sp)+,d0-d1/a1-a4
	bsr.w	SetPA
	bra.w	.ex
.10
	clr.w	(a0)
	btst	#4,(sflags9).w
	bne.w	.top
	btst	#7,(sflags).w
	bne.w	.top
	bsr.w	SetPA
	bra.w	.ex
.exit
	movea.w	#(tmstruct-M68K_RAM),a2
	bsr.w	coinsearch
	adda.w	#$39E,a2
	bsr.w	coinsearch
	bclr	#2,(gmode).w
	movea.w	#(puckx-M68K_RAM),a3
	bclr	#6,(BA_PS_flags).w
	move.w	#$1B,d0
	btst	#3,(BA_PS_flags).w
	beq.w	.0
	move.w	#$1E,d0
.0
	bsr.w	assreplace
.ex
	movem.l	(sp)+,d0/a0-a3
	rts

coinsearch	;a2 = team. Count the players kept off the ice by penalties (coincidental penalties)
	moveq	#6,d1
	moveq	#$36,d0	;(MaxRos-1)*2
.loop
	tst.w	$6C(a2,d0.w)
	ble.w	.nap
	bclr	#5,$6C(a2,d0.w)
	btst	#6,$6C(a2,d0.w)	;coincidental
	bne.w	.nap
	btst	#4,$6C(a2,d0.w)
	bne.w	.nap
	cmp.w	#4,d1	;never below 4 players
	beq.w	.nap
	subq.w	#1,d1
.nap
	subq.w	#2,d0
	bpl.s	.loop
	move.w	d1,$24(a2)
	rts

checkfornewpen	;Look for a new penalty (entered through AddPenalty / AddPenalty2)
	btst	#7,(sflags).w	;gmclock: clock stopped
	bne.w	rtss2
	btst	#4,(sflags9).w
	bne.w	rtss2
	movea.w	#(PenBuf-M68K_RAM),a0
.0
	tst.w	(a0)+
	beq.w	rtss2
	btst	#2,(gmode).w
	bne.w	.iscalled
	clr.w	d0
	move.b	-2(a0),d0
	movea.l	#$E818,a1
	adda.w	(a1,d0.w),a1
	tst.b	1(a1)	;time for penalty
	beq.w	.callit
	move.w	(puckc).w,d0
	bmi.w	.3
	subq.w	#6,d0
	move.b	-1(a0),d1	;player penalized
	ext.w	d1
	subq.w	#6,d1
	eor.w	d1,d0
	bmi.w	.3
.callit
	bsr.w	Stop4Pen
.iscalled
	bset	#7,-1(a0)
	bne.s	.0
	clr.w	d0
	move.b	-2(a0),d0	;penalty called
	movea.l	#$E818,a1
	adda.w	(a1,d0.w),a1
	clr.w	d1
	move.b	(a1),d1	;delay for stopping action
	asl.w	#5,d1
	cmp.w	(Pencntdwn).w,d1
	ble.s	.0
	move.w	d1,(Pencntdwn).w
	bra.s	.0
.3
	bset	#3,(gmode).w
	bne.s	.0
	addq.w	#4,(ChkCnt).w
	move.w	#$2C,d0
	bsr.w	SetPA
	bra.w	.0

Stop4Pen	;a0 = Penaltylist penalty + 2. Stop the clock, set the faceoff spot from the penalty type, blow the whistle
	;and start the ref (SetPA)
	bset	#0,(gmode).w
	bne.w	.5
	clr.w	d0
	clr.w	d1
	cmpi.b	#$E,-2(a0)	;goal: center ice
	beq.w	.0
	move.w	(ltx).w,d0
	move.w	(lty).w,d1
	cmpi.b	#6,-2(a0)	;OOP
	beq.w	.0
	move.w	(puckx).w,d0
	move.w	(pucky).w,d1
	cmpi.b	#$C,-2(a0)	;icing
	bne.w	.0
	move.l	a3,-(sp)
	movea.w	#(SortCords-M68K_RAM),a3
	move.b	-1(a0),d1
	ext.w	d1
	asl.w	#7,d1	;scsize
	adda.w	d1,a3
	move.w	#$258,d1	;600
	btst	#7,$62(a3)
	movea.l	(sp)+,a3
	beq.w	.0
	neg.w	d1
.0
	movem.w	d0-d1,-(sp)
	cmp.w	#$51,d0
	blt.w	.1
	move.w	#$51,d0
.1
	cmp.w	#$FFAF,d0
	bgt.w	.2
	move.w	#$FFAF,d0
.2
	cmp.w	#$B0,d1
	blt.w	.3
	move.w	#$D8,d1
	move.w	#$51,d0
	tst.w	(sp)
	bpl.w	.3
	neg.w	d0
.3
	cmp.w	#$FF50,d1
	bgt.w	.4
	move.w	#$FF28,d1
	move.w	#$51,d0
	tst.w	(sp)
	bpl.w	.4
	neg.w	d0
.4
	move.w	d0,(fox).w
	move.w	d1,(foy).w
	addq.w	#4,sp
	jsr	(limitfo).l
.5
	clr.w	(Pencntdwn).w
	bset	#2,(gmode).w
	jsr	(stop_current_song).l
	move.w	#3,-(sp)	;whistle
	jsr	(sfx).l
	move.w	#$A,d0
	bra.w	SetPA

UpdatePA	;Animate the ref in the ref window (RefCnt, SetPA2)
	tst.w	(RefCnt).w
	bmi.w	rtss2
	sub.w	d7,(RefCnt).w
	bpl.w	.contplay
	bsr.w	SetPA2
.contplay
	cmpi.w	#4,(RefPen).w	;check if cont playoffs
	bne.w	.0
	bsr.w	ShowThreeStars
.0
	sub.w	d7,(penmsgtimer).w
	bpl.w	rtss2
	move.w	#$7FFF,(penmsgtimer).w
	bsr.w	sub_1CC32
	bsr.w	printz
	String	$BF,$11,$0B
	bsr.w	GetPlayerName
	move.w	(a1),d0
	lsr.w	#1,d0
	sub.w	d0,(printx).w
	bra.w	print

SetPA	;Start ref animation d0 (penalty number)
	move.w	d0,(RefPen).w
	cmp.w	#$38,d0
	blt.w	.0
	rts
.0
	clr.w	(RefStep).w
	bsr.w	prefmes
	cmp.w	#$E,d0	;goal
	bne.w	.1
	bsr.w	ShowGoalBox
.1
	btst	#0,(gmode2).w
	beq.w	.2
	btst	#3,(gmode2).w
	beq.w	.2
	jsr	(sub_1D82A2).l
.2
	move.w	#$7FFF,(penmsgtimer).w
	btst	#7,(sflags).w
	beq.w	SetPA2
	btst	#4,(sflags9).w
	beq.w	SetPA2
	move.w	#$3C,(penmsgtimer).w	;60

SetPA2	;Update the ref animation: next frame / delay pair from the Penaltylist animation
	movem.l	d0-d2/a0-a1,-(sp)
	moveq	#$40,d0	;clear ref window
	tst.w	(RefStep).w
	bmi.w	.pr
	move.w	(RefStep).w,d0
	addq.w	#2,(RefStep).w
	move.w	(RefPen).w,d1
	movea.l	#$E818,a0
	adda.w	(a0,d1.w),a0
	addq.w	#2,a0
	adda.w	(a0),a0
	move.w	(a0,d0.w),d0
	bpl.w	.0
	neg.w	d0	;negative = last frame
	st	(RefStep).w
.0
	clr.w	d1
	move.b	d0,d1
	asl.w	#3,d1
	move.w	d1,(RefCnt).w
	btst	#0,(gmode2).w
	beq.w	.1
	btst	#3,(gmode2).w
	beq.w	.1
	move.w	d0,-(sp)
	move.w	(RefCnt).w,d0
	add.w	d0,d0
	move.w	d0,(RefCnt).w
	move.w	(sp)+,d0
.1
	lsr.w	#8,d0
.pr
	bsr.w	PushRef
	movem.l	(sp)+,d0-d2/a0-a1
	rts

PushRef	;Tell vblank what to display: ref frame d0
	movem.l	d0-d2/a0-a1,-(sp)
	cmp.w	#$40,d0
	beq.w	.clearit
	mulu.w	#$70,d0	;refwidth*refheight*2
	movea.l	#unk_97E72,a0
	btst	#4,(sflags9).w
	beq.w	.m1
	movea.l	#unk_98F30,a0
.m1
	adda.l	4(a0),a0
	addq.w	#4,a0
	adda.w	d0,a0
	movea.w	#(unk_FFC44C-M68K_RAM),a1
	move.w	(ExtraChars).w,d2
	ori.w	#$8000,d2	;priority
	moveq	#$37,d0	;(refheight*refwidth)-1
.1
	move.w	(a0)+,(a1)
	add.w	d2,(a1)+
	dbf	d0,.1
	bset	#1,(sflags2).w
	bra.w	.ex
.clearit
	btst	#7,(sflags).w
	bne.w	.4
	btst	#4,(sflags9).w
	bne.w	.4
	movea.w	#(unk_FFC44C-M68K_RAM),a1
	moveq	#$37,d0	;(refheight*refwidth)-1
.3
	move.w	#$7FF,(a1)+	;blank tile
	dbf	d0,.3
	bset	#1,(sflags2).w
.4
	moveq	#-1,d0
	bsr.w	prefmes
.ex
	movem.l	(sp)+,d0-d2/a0-a1
	rts

prefmes	;Print the penalty message: the player, the penalty and its length (PenaltyTimeTxt)
	movem.l	d0-d2/a1-a2,-(sp)
	btst	#7,(sflags).w
	bne.w	.1
	btst	#4,(sflags9).w
	bne.w	.1
	tst.w	d0
	bpl.w	.0
	bsr.w	printz
	String	$BF,$00,$0A
	moveq	#$D,d0
	moveq	#3,d1
	move.w	#$7FF,d2
	bsr.w	eraser
	bra.w	.8
.0
	bsr.w	printz
	String	$BF,$05,$0A
	movea.l	#$E818,a1
	adda.w	(a1,d0.w),a1
	addq.w	#2,a1
	move.w	(a1),d0
	subq.w	#2,d0	;empty string
	beq.w	.8
	lsr.w	#1,d0
	sub.w	d0,(printx).w
	bpl.w	.nb0
	clr.w	(printx).w
.nb0
	move.w	(a1),d0
	tst.b	-1(a1,d0.w)
	bne.w	.2
	subq.w	#1,d0
.2
	moveq	#3,d1
	bsr.w	Framer
	subq.w	#2,(printy).w
	addq.w	#1,(printx).w
	bsr.w	print
	bra.w	.8
.1
	tst.w	d0
	bmi.w	.8
	cmpi.w	#$3E8,(glovecords).w
	bne.w	.3
	cmpi.w	#$3E8,(word_FFBF16).w
	beq.w	.4
.3
	jsr	(ClearMessageLine).l
.4
	move.w	d0,-(sp)
	jsr	(printz).l
	String	$BF,$0B,$02
	move.w	#$14,d0
	move.w	#8,d1
	jsr	(Framer).l
	jsr	(printbigz2).l
	String	$F8,$04,$01,$0C,$03,'                  '
	move.w	#$15,(printx).w
	move.w	#3,(printy).w
	move.w	(sp)+,d0
	movea.l	#$E818,a1
	adda.w	(a1,d0.w),a1
	addq.w	#2,a1
	move.w	(a1),d0
	lsr.w	#1,d0
	sub.w	d0,(printx).w
	bsr.w	printbig2
	movea.l	#$FFFFC3A6,a1
.5
	tst.w	(a1)+
	bne.s	.5
	move.w	-4(a1),d0
	move.w	d0,-(sp)
	andi.w	#$7F,d0
	movea.l	#tmstruct,a2
	cmp.w	#6,d0
	blt.w	.6
	movea.l	#AwShots,a2
.6
	asl.w	#7,d0
	movea.l	#SortCords,a1
	adda.w	d0,a1
	clr.w	d0
	move.b	$67(a1),d0
	jsr	(GetPlayerNumInitial).l
	jsr	(printz).l
	String	$BF,$0C,$06
	cmpi.b	#$20,2(a1)
	beq.w	.7
	addq.w	#1,(printx).w
.7
	jsr	(print).l
	jsr	(printz).l
	String	$BF,$11,$05,'penalty'
	move.w	#$D,(printx).w
	movea.l	$1E(a2),a1
	adda.w	4(a1),a1
	adda.w	(a1),a1
	jsr	(print).l
	jsr	(printz).l
	String	$2E
	jsr	(printz).l
	String	$BF,$0D,$07
	move.w	(sp)+,d0
	lsr.w	#8,d0
	andi.w	#$FF,d0
	movea.l	#$E818,a1
	adda.w	(a1,d0.w),a1
	move.w	(a1),d0
	andi.w	#$FF,d0
	movea.l	#PenaltyTimeTxt,a1
	jsr	(SkipStrings).l
	jsr	(print).l
.8
	movem.l	(sp)+,d0-d2/a1-a2
	rts

PenaltyTimeTxt	;prefmes: the penalty lengths
	String	'penalty error '
	String	'1 minute minor'
	String	'2 minute minor'
	String	'3 minute minor'
	String	'4 minute db minor'
	String	'5 minute major'

sub_1CC32	;Erase the penalty message window
	jsr	(printz).l
	String	$BF,$0B,$02
	move.w	#$14,d0
	move.w	#8,d1
	move.w	#$7FF,d2
	jsr	(eraser).l
	rts

PenGoalStuff	;Do this stuff after a goal: a1 = scored on team, a2 = scoring team. Clears PenBuf, lets the first penalized
	;player of the scored on team out (RemovePlayerFromList), erases the message box
	movem.l	d0-d2/a0,-(sp)
.0
	cmpi.w	#6,$24(a1)
.3
	bne.w	.1
.4
	jsr	(ClearPenaltyBuffer).l
.1
	move.w	$24(a2),d2
.5
	cmp.w	$24(a1),d2
.6
	ble.w	.ex
	lea	$A4(a1),a0
.2
	clr.w	d2
	move.b	(a0)+,d2
.7
	bmi.w	.ex
.8
	btst	#6,$6C(a1,d2.w)
	bne.s	.2
.9
	clr.w	$6C(a1,d2.w)
.10
	jsr	(RemovePlayerFromList).l
.11
	bset	#0,(sflags9).w
	addq.w	#1,$24(a1)
	addq.w	#1,2(a2)
.12
	bset	#0,(tmstruct+$30).w
.13
	bset	#0,(AwShots+$30).w
.ex
	movem.l	(sp)+,d0-d2/a0
	rts

ClearPenaltyBuffer	;Clear PenBuf
	moveq	#$1F,d0
	movea.w	#(PenBuf-M68K_RAM),a0
.loop
	clr.w	(a0)+
	dbf	d0,.loop
	rts

updatepentime	;Update the time remaining on all penalized players, once a second (Penaltytimer); sets sflags3 bit 6 on that
	;tick. chkatop, updatePPTeamTime, then ProcessPenaltyList for both teams
	bclr	#6,(sflags3).w
	btst	#0,(gmode).w
	bne.w	rtss2
	sub.w	d7,(Penaltytimer).w
	bpl.w	rtss2
	addi.w	#$18,(Penaltytimer).w
	bset	#6,(sflags3).w
	bsr.w	chkatop
	jsr	(sub_1D8618).l
	movea.w	#(tmstruct-M68K_RAM),a2
	bsr.w	ProcessPenaltyList
	adda.w	#$39E,a2

ProcessPenaltyList	;a2 = team. Walk the penalty box list: count down the penalty time of each player in it
	lea	$A4(a2),a0
	movea.w	#(mesarea-M68K_RAM),a1
	moveq	#2,d1
	moveq	#2,d3

loc_1CD04
	clr.w	d0
	move.b	(a0)+,d0
	bmi.w	.done
	btst	#6,$6C(a2,d0.w)
	bne.w	loc_1CD76
	subq.w	#1,d1
	bmi.s	loc_1CD04
	move.w	d0,(a1)+
	subq.w	#1,$6C(a2,d0.w)
	bne.w	.cont
	bsr.w	RemovePlayerFromList
.cont
	bra.s	loc_1CD04
.done
	move.w	(mesarea).w,d0
	cmp.w	#1,d1
	beq.w	sub_1CD50
	tst.w	d1
	bne.w	.3
	bsr.w	sub_1CD50
	bra.w	.two
.3
	cmp.w	#$FFFF,d1
	bne.w	rtss2
.two
	move.w	(TextBuffer).w,d0

sub_1CD50	;ProcessPenaltyList: a player d0 whose time is nearly up beeps; at 0 he is released (releasepl)
	cmpi.w	#5,$6C(a2,d0.w)
	bgt.w	rtss2
	move.w	#1,-(sp)
	tst.w	$6C(a2,d0.w)
	bne.w	.6
	bsr.w	releasepl
	move.w	#2,(sp)
.6
	jsr	(sfx).l
	rts

loc_1CD76
	subq.w	#1,$6C(a2,d0.w)
	btst	#3,$6C(a2,d0.w)
	beq.s	loc_1CD04
	btst	#4,$6C(a2,d0.w)
	bne.w	.clr
	move.w	#$1000,$6C(a2,d0.w)
	bra.w	RemovePlayerFromList
.clr
	clr.w	$6C(a2,d0.w)

RemovePlayerFromList	;Remove the entry before a0 from a penalty box list by shifting the rest down. Return a0 = removed slot
	moveq	#-1,d2
.shift
	addq.w	#1,d2
	move.b	(a0,d2.w),-1(a0,d2.w)
	bpl.s	.shift
	subq.w	#1,a0
	rts

chkatop	;Attack time of possession stat update. Called once a second from updatepentime
	moveq	#0,d1
	move.w	(pucky).w,d0
	cmp.w	#$76,d0
	bgt.w	.0
	move.l	#$39E,d1
	neg.w	d0
	cmp.w	#$76,d0
	blt.w	rtss2
.0
	btst	#1,(gmode).w
	beq.w	.1
	eori.w	#$39E,d1
.1
	movea.w	#(tmstruct-M68K_RAM),a2
	addq.w	#1,$A(a2,d1.w)
	rts

releasepl	;The player's penalty time is up, so let him out (if appropriate). a2 = team, d0 = player * 2
	movem.l	d0-d3/a0-a3,-(sp)
	movea.w	$22(a2),a3
	suba.w	#$80,a3
.0
	adda.w	#$80,a3
	tst.w	$34(a3)
	bpl.s	.0
	move.w	d0,d3
	lsr.w	#1,d3
	move.w	$24(a2),d1
	addq.w	#1,$24(a2)
	bset	#0,(tmstruct+$30).w
	bset	#0,(AwShots+$30).w
	movea.l	#unk_23426,a0
	tst.w	$26(a2)
	bpl.w	.gin
	addq.w	#1,a0
.gin
	clr.w	$34(a3)
	move.b	(a0,d1.w),$35(a3)
	bsr.w	sub_1FE58
	bsr.w	setplayer
	bset	#2,$63(a3)
	movem.l	(sp)+,d0-d3/a0-a3
	rts

GetLowestPen	;a2 = shorthanded team, a3 = team on the power play. d0 = power play time left from the penalty box times
	clr.w	d0
	clr.w	d3
	lea	$A4(a2),a0
.getstatus
	clr.w	d2
	move.b	(a0)+,d2
	bmi.w	.1
	move.w	$6C(a2,d2.w),d2
	btst	#$E,d2
	bne.s	.getstatus
	sub.w	d3,d2
	add.w	d2,d0
	move.w	d2,d3
	bra.s	.getstatus
.1
	cmpi.w	#6,$24(a3)
	beq.w	rtss2
	sub.w	d3,d0
	lea	$A4(a3),a0
	clr.w	d2
.2
	move.b	(a0)+,d2
	bmi.w	rtss2
	btst	#6,$6C(a3,d2.w)
	bne.s	.2
	cmp.w	$6C(a3,d2.w),d0
	blt.w	rtss2
	add.w	d3,d0
	rts

updatepwrplay	;The power play box: the team and the time left (GetLowestPen). Called once a second
	btst	#7,(gmode).w
	bne.w	rtss2
	btst	#1,(gmode2).w
	bne.w	rtss2
	btst	#4,(sflags9).w
	bne.w	rtss2
	btst	#2,(sflags12).w
	bne.w	rtss2
	btst	#1,(tmstruct+$30).w
	bne.w	rtss2
	btst	#1,(AwShots+$30).w
	bne.w	rtss2
	movea.w	#(tmstruct-M68K_RAM),a2
	lea	$39E(a2),a3
	move.w	$24(a2),d0
	sub.w	$24(a3),d0
	beq.w	sub_1CFCE
	bpl.w	.0
	btst	#6,(sflags2).w
	bne.w	.1
	bsr.w	sub_1CFCE
	bset	#6,(sflags2).w
	bra.w	.1
.0
	exg	a2,a3
	btst	#6,(sflags2).w
	beq.w	.1
	bsr.w	sub_1CFCE
	bclr	#6,(sflags2).w
.1
	btst	#5,(sflags2).w
	beq.w	.2
	bclr	#3,(sflags12).w
	bne.w	.4
.2
	bset	#5,(sflags2).w
	bne.w	.5
	addq.w	#1,4(a3)
.4
	movem.l	d0-d1/a3,-(sp)
	bsr.w	sub_1D004
	movem.l	(sp)+,d0-d1/a3
	cmpa.w	#(tmstruct-M68K_RAM),a3
	bne.w	.3
.home
	bra.w	.5
.3
	bra.s	.home
.5
	bclr	#7,(sflags11).w
	beq.w	.6
	bsr.w	sub_1D004
.6
	jsr	(printz).l
	String	$BF,$17,$19
	jsr	(printbigz1).l
	String	$2B
	bsr.w	GetLowestPen
	bsr.w	PushTime
	cmpi.b	#$20,3(a1)
	bne.w	.7
	move.b	#$7A,3(a1)
.7
	bsr.w	printbig1
	jsr	(printbigz1).l
	String	$2A
	movea.l	$1E(a3),a0
	movea.w	#(mesarea-M68K_RAM),a3
	move.w	#2,(a3)
	bsr.w	appendz
	String	$BF,$14,$19
	adda.w	4(a0),a0
	adda.w	(a0),a0
	movea.l	a0,a1
	bsr.w	appstring
	movea.w	a3,a1
	bsr.w	print
	bsr.w	printz
	String	$BF,$14,$1A,'PP'
	bset	#3,(disflags).w
	rts

sub_1CFCE	;With sflags2 bit 5 set, clear it and erase the power play box (sub_1CFE4)
	bclr	#5,(sflags2).w
	beq.w	rtss2
	bsr.w	sub_1CFE4
	bset	#3,(disflags).w
	rts

sub_1CFE4	;Erase the power play box
	jsr	(printz).l
	String	$BF,$13,$18
	move.w	#$C,d0
	move.w	#4,d1
	move.w	#$7FF,d2
	jsr	(eraser).l
	rts

sub_1D004	;Draw the power play box frame (Framer)
	jsr	(printz).l
	String	$BF,$13,$18
	move.w	#$C,d0
	move.w	#4,d1
	jmp	Framer

sub_1D01E	;Called from the faceoff and pause code.
	;Code the listing does not decode: kept as bytes
	dc.b	$48,$E7,$FF,$FE,$08,$B8,$00,$07,$C3,$3A,$31,$FC,$03,$E8,$BD,$30
	dc.b	$4E,$B9,$00,$01,$54,$D8,$61,$00,$43,$78,$08,$38,$00,$00,$C3,$3A
	dc.b	$66,$00,$00,$1C,$61,$00,$EB,$4A,$00,$06,$FF,$00,$00,$00,$70,$20
	dc.b	$72,$1C,$34,$3C,$07,$FF,$61,$00,$E9,$20,$61,$00,$00,$08,$4C,$DF
	dc.b	$7F,$FF,$4E,$75

nullsub_4
	rts

EASNLogo	;Draw the EASN logo
	bsr.w	printz
	String	$BF,$01,$15
	movea.l	#unk_13D59E,a1
	adda.l	4(a1),a1
	movea.w	#$772,a2
	clr.w	d0
	clr.w	d1
	move.w	(a1),d2
	move.w	2(a1),d3
	move.w	(EASNcset).w,d4
	clr.w	d5
	bra.w	dobitmap
	;The rest of EASNLogo.
	;Code the listing does not decode: kept as bytes
	dc.b	$48,$E7,$FF,$F0,$08,$F8,$00,$03,$BF,$B2,$61,$C6,$61,$00,$EA,$F0
	dc.b	$00,$06,$BE,$14,$08,$00,$34,$7C,$C7,$26,$61,$00,$00,$1A,$61,$00
	dc.b	$EA,$DE,$00,$06,$BE,$05,$08,$00,$34,$7C,$CA,$C4,$61,$00,$00,$08
	dc.b	$4C,$DF,$0F,$FF,$4E,$75,$41,$EA,$00,$A4,$42,$40,$10,$18,$6B,$00
	dc.b	$00,$10,$08,$32,$00,$06,$00,$6C,$66,$F0,$61,$00,$00,$1E,$60,$EA
	dc.b	$41,$EA,$00,$A4,$42,$40,$10,$18,$6B,$00,$27,$60,$08,$32,$00,$06
	dc.b	$00,$6C,$67,$F0,$61,$00,$00,$04,$60,$EA,$0C,$78,$00,$0A,$B0,$42
	dc.b	$62,$00,$27,$48,$34,$32,$00,$6C,$02,$42,$07,$FF,$3E,$2A,$00,$28
	dc.b	$E2,$48,$4E,$B9,$00,$01,$01,$E6,$D2,$D1,$50,$49,$42,$40,$10,$29
	dc.b	$FF,$F8,$3F,$38,$B0,$40,$32,$7C,$BF,$F4,$61,$00,$5F,$98,$32,$7C
	dc.b	$BF,$F2,$32,$BC,$00,$04,$61,$00,$EA,$68,$30,$02,$61,$00,$EC,$46
	dc.b	$61,$00,$EA,$5E,$31,$DF,$B0,$40,$52,$78,$B0,$42,$4E,$75

linebar	;Draw the energy bar of line d0 for team a2 at printx / printy
	movem.l	d0-d5/a0-a2,-(sp)
	bsr.w	getlinee
	move.w	(printa).w,-(sp)
	move.w	#$8000,(printa).w
	ext.l	d0
	divu.w	#$100,d0
	cmp.w	#$F,d0
	bls.w	.ok
	moveq	#$F,d0
.ok
	moveq	#$F,d1
	sub.w	d0,d1
	clr.w	d0
	movea.l	#unk_13D290,a1
	adda.l	4(a1),a1
	movea.w	#$772,a2
	move.w	(a1),d2
	moveq	#1,d3
	move.w	(energybarchars).w,d4
	moveq	#0,d5
	bsr.w	dobitmap
	move.w	(sp)+,(printa).w
	movem.l	(sp)+,d0-d5/a0-a2
	rts

getlinee	;d0 = line number, a2 = team struct. Return d0 = energy level of this line
	movem.l	d1-d5/a0-a3,-(sp)
	lea	$184(a2),a1
	asl.w	#3,d0
	adda.w	d0,a1
	clr.l	d0
	clr.w	d1
	movea.l	#unk_23426,a0
	move.w	$24(a2),d4
	bra.w	.next
.loop
	clr.w	d5
	move.b	(a0,d4.w),d5
	beq.w	.next
	clr.w	d3
	move.b	(a1,d5.w),d3
	asl.w	#1,d3
	addq.w	#1,d1
	add.w	$32(a2,d3.w),d0
.next
	dbf	d4,.loop
	divu.w	d1,d0
	movem.l	(sp)+,d1-d5/a0-a3
	rts

AvgCline	;Average energy of the current line.
	;Code the listing does not decode: kept as bytes
	dc.b	$48,$E7,$70,$80,$42,$80,$42,$41,$74,$05,$30,$6A,$00,$22,$4A,$68
	dc.b	$00,$34,$6F,$00,$00,$10,$42,$43,$16,$28,$00,$67,$D6,$43,$D0,$72
	dc.b	$30,$34,$52,$41,$D0,$FC,$00,$80,$51,$CA,$FF,$E4,$4A,$41,$67,$00
	dc.b	$00,$04,$80,$C1,$4C,$DF,$01,$0E,$4E,$75

ChkShotStat	;Determine if a shot was taken and add it to the stats (crowd, team, shooter and goalie)
	btst	#0,(gmode).w
	bne.w	rtss2
	btst	#4,(gmode).w
	bne.w	rtss2
	bclr	#4,(sflags2).w
	bne.w	.Cwdupdate
	btst	#0,(sflags4).w
	beq.w	rtss2
	bclr	#3,(sflags8).w
	bne.w	.0
	bset	#3,(sflags8).w
	bra.w	rtss2
.0
	movem.l	d0-d1/a1-a3,-(sp)
	move.l	a4,-(sp)
	movea.l	#$FFFFC4C6,a4
	adda.w	(ScoreSumbytes).w,a4
	movea.l	#tmstruct,a2
	btst	#7,2(a4)
	beq.w	.pllookup
	adda.w	#$39E,a2
.pllookup
	clr.w	d0
	move.b	3(a4),d0
	movea.l	(sp)+,a4
	movea.w	$22(a2),a2
	move.w	#5,d1
.findplayer
	cmp.b	$67(a2),d0
	beq.w	.foundplayer
	adda.w	#$80,a2
	dbf	d1,.findplayer
	bra.w	.ex
.foundplayer
	move.w	$52(a2),d0
	bra.w	.addShot
.Cwdupdate
	movem.l	d0-d1/a1-a3,-(sp)
	addi.w	#$64,(crowdlevel).w
	addi.w	#$A,(CwdExciteLvl).w
	move.w	(shotplayer).w,d0
.addShot
	asl.w	#7,d0
	movea.w	#(SortCords-M68K_RAM),a3
	adda.w	d0,a3
	bsr.w	loadTeamStruct
	addq.w	#1,(a2)
	btst	#5,(sflags2).w
	beq.w	.8
	btst	#6,(sflags2).w
	bne.w	.7
	btst	#6,$62(a3)
	bne.w	.8
.6
	addq.w	#1,$38E(a2)
	bra.w	.8
.7
	btst	#6,$62(a3)
	bne.s	.6
.8
	move.l	a2,-(sp)
	move.w	(gsp).w,d0
	add.w	d0,d0
	adda.w	d0,a2
	addq.w	#1,$384(a2)
	movea.l	(sp)+,a2
	clr.w	d0
	move.b	$67(a3),d0
	addi.w	#$F8,d0
	addq.b	#1,(a2,d0.w)
	move.w	$26(a1),d0
	bmi.w	.ex
	addi.w	#$F8,d0
	addq.b	#1,(a1,d0.w)
.ex
	movem.l	(sp)+,d0-d1/a1-a3
	rts

loadTeamStruct	;a2 = the team struct of player a3
	movea.w	#(tmstruct-M68K_RAM),a2
	lea	$39E(a2),a1
	btst	#6,$62(a3)
	beq.w	rtss2
	exg	a1,a2
	rts

SetupTeamForIntermission	;Reset the bench (ResetBench), then for each team SetupTeamLine
	bsr.w	ResetBench
	movea.w	#(tmstruct-M68K_RAM),a2
	lea	$39E(a2),a3
	bsr.w	SetupTeamLine
	exg	a2,a3

SetupTeamLine	;The line of team a3 back on the ice (sub_1D3A6 first)
	bsr.w	sub_1D3A6
	clr.w	$16(a3)
	tst.w	(OptLine).w
	bne.w	rtss2
	move.w	$24(a3),d0
	sub.w	$24(a2),d0
	beq.w	rtss2
	move.w	#3,$16(a3)
	tst.w	d0
	bpl.w	rtss2
	move.w	#5,$16(a3)
	rts

RestoreTeamEnergy	;Restore the energy of team a2.
	;Code the listing does not decode: kept as bytes
	dc.b	$70,$36,$0C,$72,$FF,$FD,$00,$6C,$66,$00,$00,$10,$0C,$72,$FF,$FC
	dc.b	$00,$6C,$66,$00,$00,$06,$60,$00,$00,$08,$35,$BC,$10,$00,$00,$34
	dc.b	$55,$40,$6A,$DE,$4E,$75

sub_1D3A6	;Every roster player of team a2 not in the penalty box gets energy $1000; -3 becomes -2 (the bench)
	moveq	#$36,d0
.0
	cmpi.w	#$FFFC,$6C(a2,d0.w)
	beq.w	.1
	move.w	#$1000,$34(a2,d0.w)
	cmpi.w	#$FFFD,$6C(a2,d0.w)
	bne.w	.1
	move.w	#$FFFE,$6C(a2,d0.w)
.1
	subq.w	#2,d0
	bpl.s	.0
	rts

Intermission	;Before the period: at game over (gsp 4) the records (UpdateRecords), then the intermission screens
	cmpi.w	#4,(gsp).w
	bne.w	.1
	move.w	#0,(gameclock).w
	jsr	(UpdateRecords).l
	btst	#7,(GameFlags).w
	beq.w	.1
	movem.l	a2,-(sp)
	jsr	(sub_11510).l
	cmpa.l	#0,a2
	beq.w	.0
	move.b	(byte_FFC733).w,2(a2)
	move.b	(byte_FFCAD1).w,3(a2)
	jsr	(sub_112DA).l
	jsr	(sub_10CF2).l
.0
	movem.l	(sp)+,a2
.1
	bsr.w	SetupTeamForIntermission
	moveq	#$F,d0
	movea.w	#(SortCords-M68K_RAM),a0
.clr
	clr.w	(a0)
	adda.w	#$80,a0
	dbf	d0,.clr
	move.w	(gsp).w,d0
	tst.w	(OptPlayMode).w
	beq.w	.2
	addq.w	#5,d0
.2
	asl.w	#2,d0
	lea	unk_1D4A6(pc),a0
	movea.l	(a0,d0.w),a0
	btst	#0,(gmode2).w
	beq.w	.3
	movea.l	#unk_239D4,a0
.3
	bset	#0,(sflags).w
	movea.l	#SetupPauseScreen,a1
	jsr	(InitMenuState).l
	move.w	#$A8C,(word_FFDDC4).w
.4
	tst.w	(demoflag).w
	bne.w	.periodic
	subq.w	#1,(word_FFDDC4).w
	bmi.w	.5
.periodic
	jsr	(vcountwait).l
	jsr	(sub_1B282).l
	jsr	(ProcessInputWithRepeat).l
	jsr	(HandleMenuInput).l
	bne.s	.4
.5
	jsr	(forceblack).l
	rts
	dc.b	$4E,$75

unk_1D4A6	;Intermission table
	dc.b	$00,$02,$3A,$58,$00,$02,$3B,$A8,$00,$02,$3B,$A8,$00,$02,$3B,$A8
	dc.b	$00,$02,$3C,$BC,$00,$02,$3A,$F4,$00,$02,$3B,$A8,$00,$02,$3B,$A8
	dc.b	$00,$02,$3B,$A8,$00,$02,$3D,$88

sub_1D4CE	;Early in the playoffs (gamelevel 0-1): random goals for the other games of the day (SetScore)
	cmpi.w	#1,(gamelevel).w
	bgt.w	rtss2
	bsr.w	GetShifter
	movea.w	#(gsstruct-M68K_RAM),a0
	moveq	#$10,d0
	mulu.w	d1,d0
	adda.w	d0,a0
.top
	cmp.w	(gamenum).w,d1
	beq.w	.2
	btst	#2,$E(a0)
	bne.w	.2
	clr.w	8(a0)
	moveq	#3,d0
	bsr.w	randomd0
	bra.w	.1
.0
	bsr.w	SetScore
.1
	dbf	d0,.0
.2
	suba.w	#$10,a0
	dbf	d1,.top
	rts

UpdateScores	;Update the ticker score values of the other games (SetScore). Called from PeriodOver
	bsr.w	GetShifter
	move.w	d1,(TickerNum).w
	movea.w	#(gsstruct-M68K_RAM),a0
	moveq	#$10,d0
	mulu.w	d1,d0
	adda.w	d0,a0
.top
	cmp.w	(gamenum).w,d1
	beq.w	.next
	bclr	#1,$E(a0)
	btst	#2,$E(a0)
	bne.w	.next
	bsr.w	SetScore
.next
	suba.w	#$10,a0
	dbf	d1,.top
	rts

SetScore	;Add to the score of the game in a0. After period 3 a game within one goal goes to OT (gsper 3) and asks for a
	;highlight
	cmpi.w	#4,8(a0)
	bge.w	rtss2
	movem.l	d0-d1/a0-a1,-(sp)
	cmpi.w	#3,8(a0)
	bne.w	.o
	move.w	#5,8(a0)
	move.w	$A(a0),d0
	sub.w	$C(a0),d0
	cmp.w	#1,d0
	bgt.w	.ex
	cmp.w	#$FFFF,d0
	blt.w	.ex
	move.w	#3,8(a0)
	bset	#1,$E(a0)
	bra.w	.ex
.o
	addq.w	#1,8(a0)
	move.w	(a0),d0
	move.w	2(a0),d1
	bsr.w	sub_1D5BC
	add.w	d0,$A(a0)
	move.w	2(a0),d0
	move.w	(a0),d1
	bsr.w	sub_1D5BC
	add.w	d0,$C(a0)
.ex
	movem.l	(sp)+,d0-d1/a0-a1
	rts

sub_1D5BC	;SetScore: the goal weights of the teams of the game (sctab rows by team rating)
	asl.w	#2,d0
	movea.w	#TeamList,a1
	movea.l	(a1,d0.w),a1
	adda.w	8(a1),a1
	move.b	(a1),d0
	andi.w	#$70,d0
	lsr.w	#1,d0
	lea	sctab(pc),a1
	move.l	(a1,d0.w),(nibblebuffer).w
	move.l	4(a1,d0.w),(nibblebuffer+4).w
	asl.w	#2,d1
	movea.w	#TeamList,a1
	movea.l	(a1,d1.w),a1
	adda.w	8(a1),a1
	move.b	(a1),d0
	andi.w	#7,d0
	asl.w	#3,d0
	lea	sctab(pc),a1
	move.l	(a1,d0.w),d1
	add.l	d1,(nibblebuffer).w
	move.l	4(a1,d0.w),d1
	add.l	d1,(nibblebuffer+4).w
	moveq	#4,d0
	bra.w	WeightedRandomSelect

sctab	;Weights for 0, 1, 2, 3 goals, 8 rows
	dc.w	$2B,$1E,$17,$4
	dc.w	$27,$20,$18,$5
	dc.w	$23,$21,$1A,$6
	dc.w	$1E,$22,$1E,$6
	dc.w	$1A,$24,$1E,$8
	dc.w	$16,$25,$1F,$A
	dc.w	$13,$26,$1F,$C
	dc.w	$F,$26,$20,$F
	;After sctab: code that nothing in the listing reaches.
	;Code the listing does not decode: kept as bytes
	dc.b	$76,$FF,$0C,$78,$01,$E0,$C4,$BE,$6E,$00,$21,$EE,$36,$38,$D0,$26
	dc.b	$6B,$00,$21,$E6,$53,$78,$D0,$26,$B6,$78,$CF,$C4,$67,$EE,$70,$10
	dc.b	$C0,$C3,$30,$7C,$CF,$44,$D0,$C0,$08,$28,$00,$01,$00,$0E,$66,$DC
	dc.b	$08,$28,$00,$02,$00,$0E,$66,$D4,$4E,$75,$4A,$43,$6B,$00,$21,$BA
	dc.b	$61,$00,$01,$2A,$61,$00,$E3,$18,$52,$78,$B0,$40,$59,$78,$B0,$42
	dc.b	$3F,$38,$B0,$40,$61,$00,$4E,$3A,$31,$FC,$A0,$00,$B0,$44,$61,$00
	dc.b	$E4,$DC,$00,$1A,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
	dc.b	$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$31,$D7,$B0,$40
	dc.b	$70,$01,$D0,$78,$CF,$CA,$4A,$78,$D2,$54,$66,$00,$00,$04,$42,$40
	dc.b	$43,$FA,$00,$7E,$61,$00,$01,$02,$30,$28,$00,$08,$53,$40,$22,$7C
	dc.b	$00,$02,$33,$84,$61,$00,$00,$FA,$30,$11,$E2,$48,$44,$40,$D0,$57
	dc.b	$06,$40,$00,$17,$31,$C0,$B0,$40,$61,$00,$E4,$94,$31,$FC,$80,$00
	dc.b	$B0,$44,$30,$28,$00,$02,$32,$28,$00,$0C,$61,$00,$00,$10,$30,$10
	dc.b	$32,$28,$00,$0A,$61,$00,$00,$06,$54,$4F,$4E,$75,$31,$EF,$00,$04
	dc.b	$B0,$40,$52,$78,$B0,$42,$32,$7C,$07,$7E,$E5,$40,$22,$71,$00,$00
	dc.b	$D2,$E9,$00,$04,$61,$00,$E4,$58,$31,$EF,$00,$04,$B0,$40,$06,$78
	dc.b	$00,$15,$B0,$40,$30,$01,$72,$02,$61,$00,$E6,$C0,$60,$00,$E4,$40
	dc.b	$00,$12,$45,$41,$20,$48,$6F,$63,$6B,$65,$79,$20,$4E,$69,$67,$68
	dc.b	$74,$00,$00,$18,$53,$74,$61,$6E,$6C,$65,$79,$20,$43,$75,$70,$20
	dc.b	$51,$75,$61,$6C,$69,$66,$69,$65,$72,$00,$00,$0E,$51,$75,$61,$72
	dc.b	$74,$65,$72,$66,$69,$6E,$61,$6C,$00,$18,$53,$74,$61,$6E,$6C,$65
	dc.b	$79,$20,$43,$75,$70,$20,$53,$65,$6D,$69,$66,$69,$6E,$61,$6C,$00
	dc.b	$61,$00,$00,$0A,$34,$3C,$07,$FF,$60,$00,$E1,$BA,$61,$00,$E3,$CE
	dc.b	$00,$06,$BD,$03,$17,$00,$08,$38,$00,$00,$C3,$3A,$66,$00,$00,$0C
	dc.b	$61,$00,$E3,$BA,$00,$06,$BF,$03,$17,$00,$70,$1A,$72,$05,$4E,$75

PrintBigListItem	;printbig String d0 of the String list a1 (SkipStrings).
	;Code the listing does not decode: kept as bytes
	dc.b	$61,$00,$00,$0E,$60,$00,$E7,$04

PrintSmallListItem	;printsmall String d0 of the String list a1 (SkipStrings).
	;Code the listing does not decode: kept as bytes
	dc.b	$61,$00,$00,$06,$60,$00,$E2,$50

SkipStrings	;a1 = String d0 of the String list a1
	bra.w	.1
.0
	adda.w	(a1),a1
.1
	dbf	d0,.0
	rts

checkcoll	;d2 = new x coord, d3 = new y coord, a3 = struct of object. Check wall collision (around the hot spot and the
	;end of the stick) and player collisions, then move a3 in the OOlist sort order by its y. If a player
	;collision set collflag, restore the old x/y instead. Called from updateplayers.
	clr.w	(collflag).w
	btst	#7,(sflags).w
	beq.w	.0
	exg	d2,d3
.0
	btst	#2,pflags(a3)
	bne.w	.ex
	movem.l	d0-d7,-(sp)
	move.w	(a3),d2
	move.w	Ypos(a3),d3
	move.w	$4A(a3),(wcradiusx).w
	move.w	$4C(a3),(wcradiusy).w
	bsr.w	checkwallcoll
	move.w	$4E(a3),d0
	or.w	$50(a3),d0
	bne.w	.xx
	cmpi.w	#$B,SCnum(a3)
	bgt.w	.xx
	movem.l	(sp),d0-d7
	move.l	a3,-(sp)
	bsr.w	GetHot
	move.w	(a3),d2
	move.w	Ypos(a3),d3
	add.w	d0,d2
	add.w	d1,d3
	move.w	#1,(wcradiusx).w
	move.w	#1,(wcradiusy).w
	bsr.w	checkwallcoll
.xx
	movem.l	(sp)+,d0-d7
	bsr.w	checkplcoll
.ex
	tst.w	(collflag).w
	bne.w	.restoreold
	move.w	SCnum(a3),d0
	asl.w	#1,d0
	movea.w	#(OOlistpos-M68K_RAM),a0
	movea.w	#(OOlist-M68K_RAM),a1
	movea.w	#(Ylist-M68K_RAM),a2
	move.w	(a0,d0.w),d1
.2
	cmp.w	#$F,d1
	beq.w	.cl2
	clr.w	d4
	move.b	1(a1,d1.w),d4
	cmp.w	(a2,d4.w),d3
	ble.w	.cl2
	addq.w	#1,(a0,d0.w)
	subq.w	#1,(a0,d4.w)
	move.b	d4,(a1,d1.w)
	move.b	d0,1(a1,d1.w)
	addq.w	#1,d1
	bra.s	.2
.cl2
	move.w	(a0,d0.w),d1
	beq.w	.ex2
.4
	clr.w	d4
	move.b	-1(a1,d1.w),d4
	cmp.w	(a2,d4.w),d3
	bge.w	.ex2
	subq.w	#1,(a0,d0.w)
	addq.w	#1,(a0,d4.w)
	move.b	d4,(a1,d1.w)
	move.b	d0,-1(a1,d1.w)
	subq.w	#1,d1
	bne.s	.4
.ex2
	move.w	d3,(a2,d0.w)
	rts
.restoreold
	move.w	$1C(a3),(a3)
	move.w	$20(a3),Ypos(a3)
	rts

checkplcoll	;Check collision with other players. d2/d3 = x/y cords, a3 = struct. Walk up and down the OOlist from a3 and
	;call checkcx for each object within $10 in y. Called from checkcoll
	btst	#5,pflags2(a3)
	bne.w	.ex
	cmpi.w	#$B,SCnum(a3)
	bgt.w	.ex
	move.w	SCnum(a3),d0
	asl.w	#1,d0
	movea.w	#(OOlistpos-M68K_RAM),a0
	movea.w	#(OOlist-M68K_RAM),a1
	movea.w	#(Ylist-M68K_RAM),a2
	move.w	(a0,d0.w),d1
.0
	cmp.w	#$F,d1
	beq.w	.cl
	clr.w	d4
	move.b	1(a1,d1.w),d4
	move.w	(a2,d4.w),d5
	sub.w	d3,d5
	cmp.w	#$10,d5
	bgt.w	.cl
	bsr.w	checkcx
	addq.w	#1,d1
	bra.s	.0
.cl
	move.w	(a0,d0.w),d1
	beq.w	.ex
.2
	clr.w	d4
	move.b	-1(a1,d1.w),d4
	move.w	d3,d5
	sub.w	(a2,d4.w),d5
	cmp.w	#$10,d5
	bgt.w	.ex
	bsr.w	checkcx
	subq.w	#1,d1
	bne.s	.2
.ex
	rts

checkcx	;d4 = obj. # * 2 for possible collision so check x range and distance for collision. d2 = x, d5 = delta y, a3
	;= moving object.
	movem.l	d0-d7/a0-a3,-(sp)
	asl.w	#6,d4
	movea.l	#SortCords,a2
	adda.w	d4,a2
	btst	#2,pflags(a2)
	bne.w	loc_1DB62
	btst	#5,pflags2(a2)
	bne.w	loc_1DB62
	cmpi.w	#$B,SCnum(a2)
	bgt.w	loc_1DB62
	move.w	(a2),d0
	btst	#7,(sflags).w
	beq.w	.0
	move.w	Ypos(a2),d0
.0
	sub.w	d2,d0
	cmp.w	#$FFF0,d0
	blt.w	loc_1DB62
	cmp.w	#$10,d0
	bgt.w	loc_1DB62
	muls.w	d5,d5
	muls.w	d0,d0
	add.l	d5,d0
	cmp.l	#$100,d0
	bgt.w	loc_1DB62
	move.w	#0,(word_FFBFF0).w
	move.b	pflags(a3),d6
	move.b	pflags(a2),d0
	eor.b	d0,d6
	move.w	Xvel(a3),d0
	sub.w	Xvel(a2),d0
	move.w	Yvel(a3),d1
	sub.w	Yvel(a2),d1
	move.w	(a3),d2
	sub.w	(a2),d2
	neg.w	d2
	move.w	Ypos(a3),d3
	sub.w	Ypos(a2),d3
	neg.w	d3
	movem.w	d0-d1,-(sp)
	muls.w	d3,d1
	muls.w	d2,d0
	add.l	d0,d1
	bmi.w	loc_1DBB6
	asr.l	#4,d1
	btst	#6,d6
	beq.w	.not
	move.w	d1,d4
	lsr.w	#8,d4
	cmp.w	#5,d4
	bgt.w	.g40
	moveq	#5,d4
.g40
	add.w	d4,impact(a3)
	add.w	d4,impact(a2)
	btst	#0,pflags2(a2)
	bne.w	.2
	move.w	SCnum(a3),impactp(a2)
.2
	btst	#0,pflags2(a3)
	bne.w	.3
	move.w	SCnum(a2),impactp(a3)
.3
	cmp.w	#$14,d4
	blt.w	.4
	move.w	(puckc).w,d0
	cmp.w	SCnum(a3),d0
	beq.w	.1
	cmp.w	SCnum(a2),d0
	bne.w	.4
.1
	jsr	(sub_887E4).l
.4
	bsr.w	checkint
	bsr.w	sub_1DCC0
	jsr	(checkfight).l
.not
	move.w	d1,d4
	movem.w	(sp)+,d0-d1
	tst.w	(collflag).w
	bmi.w	loc_1DB62
	movem.l	d0/a0,-(sp)
	movea.l	a3,a0
	bsr.w	sub_1DB68
	movea.l	a2,a0
	bsr.w	sub_1DB68
	movem.l	(sp)+,d0/a0
	muls.w	d2,d1
	muls.w	d3,d0
	sub.l	d1,d0
	asr.l	#4,d0
	move.w	d0,d5
	clr.w	d0
	move.b	$68(a3),d0
	tst.w	position(a3)
	bne.w	.6
	move.b	#$78,d0
.6
	tst.w	position(a2)
	bne.w	.5
	clr.b	d0
.5
	addi.w	#$8C,d0
	clr.w	d1
	move.b	$68(a2),d1
	tst.w	position(a2)
	bne.w	.7
	move.b	#$78,d1
.7
	tst.w	position(a3)
	bne.w	.8
	clr.b	d1
.8
	addi.w	#$8C,d1
	move.w	(word_FFBFF0).w,d7
	mulu.w	d1,d7
	lsr.w	#4,d7
	add.w	d0,d1
	sub.w	d7,d0
	muls.w	d4,d0
	divs.w	d1,d0
	move.w	(word_FFBFF0).w,d1
	muls.w	d4,d1
	asr.w	#4,d1
	add.w	d0,d1
	movem.w	d2-d3,-(sp)
	muls.w	d5,d3
	muls.w	d0,d2
	add.l	d2,d3
	asr.l	#4,d3
	tst.w	position(a3)
	beq.w	.9
	add.w	Xvel(a2),d3
.9
	tst.w	position(a3)
	bne.w	.10
	asr.w	#2,d3
.10
	move.w	d3,Xvel(a3)
	movem.w	(sp),d2-d3
	muls.w	d5,d2
	muls.w	d0,d3
	sub.l	d2,d3
	asr.l	#4,d3
	tst.w	position(a3)
	beq.w	.11
	add.w	Yvel(a2),d3
.11
	tst.w	position(a3)
	bne.w	.12
	asr.w	#2,d3
.12
	move.w	d3,Yvel(a3)
	movem.w	(sp)+,d2-d3
	muls.w	d1,d2
	asr.l	#4,d2
	add.w	d2,Xvel(a2)
	muls.w	d1,d3
	asr.l	#4,d3
	add.w	d3,Yvel(a2)
	st	(collflag).w

loc_1DB62
	movem.l	(sp)+,d0-d7/a0-a3
	rts

sub_1DB68	;A pad controlled puck carrier a0 that is nearly stopped (a check target)
	tst.w	position(a0)
	beq.w	.2
	btst	#3,pflags(a0)
	beq.w	.2
	move.w	(puckc).w,d0
	cmp.w	SCnum(a0),d0
	bne.w	.2
	move.w	Xvel(a0),d0
	bpl.w	.0
	neg.w	d0
.0
	cmp.w	#2,d0
	bgt.w	.2
	move.w	Yvel(a0),d0
	bpl.w	.1
	neg.w	d0
.1
	cmp.w	#2,d0
	bgt.w	.2
	st	(puckc).w
	move.b	#$1E,nopuck(a0)
.2
	rts

loc_1DBB6
	addq.w	#4,sp
	bra.s	loc_1DB62

checkint	;Check for interference penalty. player a2 interferes with a3 or vice-versa; goalie is only player who can
	;cause an interference call. Called from checkcx. .ci (checkint .1): a2 = goalie, a3 = player interfering with
	;goalie. a3 falls. The penalty ($22) needs a3 in the crease area, a CPU player or a pad player's joystick
	;player, and randomd0($1E - aggres) <= 5
	move.l	d0,-(sp)
	bsr.w	.1
	exg	a2,a3
	bsr.w	.1
	exg	a2,a3
	move.l	(sp)+,d0
	rts
.1
	tst.w	position(a2)
	bne.w	rtss2
	btst	#0,(gmode).w
	bne.w	rtss2
	move.w	(puckc).w,d0
	cmp.w	SCnum(a3),d0
	beq.w	.0
	cmpi.w	#$19,impact(a3)
	ble.w	rtss2
.0
	cmpi.w	#2,impact(a3)
	ble.w	rtss2
	exg	a2,a3
	bsr.w	FallDown
	exg	a2,a3
	cmpi.w	#$14,impact(a2)
	ble.w	rtss2
	btst	#4,pflags2(a3)
	bne.w	rtss2
	cmpi.w	#3,(gsp).w
	beq.w	rtss2
	tst.w	position(a2)
	bne.w	rtss2
	move.w	#1,d0
	btst	#6,pflags(a3)
	beq.w	.control
	move.w	#2,d0
.control
	cmp.w	(cont1team).w,d0
	beq.w	.4
	cmp.w	(cont2team).w,d0
	beq.w	.4
	cmp.w	(cont3team).w,d0
	beq.w	.4
	cmp.w	(cont4team).w,d0
	bne.w	.5
.4
	btst	#3,pflags(a3)
	beq.w	rtss2
.5
	move.w	Ypos(a2),d0
	btst	#7,pflags(a2)
	beq.w	.6
	neg.w	d0
.6
	cmp.w	#$EF,d0
	blt.w	rtss2
	cmp.w	#$11E,d0
	bgt.w	rtss2
	move.w	(a2),d0
	cmp.w	#$14,d0
	bgt.w	rtss2
	cmp.w	#$FFEC,d0
	blt.w	rtss2
	move.w	#$28,d0
	sub.b	$74(a3),d0
	bsr.w	randomd0
	cmp.w	#4,d0
	bhi.w	rtss2
	btst	#4,(gmode).w
	bne.w	rtss2
	moveq	#$22,d0
	jmp	AddPenalty

sub_1DCC0	;A stopped pad controlled puck carrier a2 loses the puck
	movem.l	d0-d4/a0-a3,-(sp)
	btst	#3,pflags(a2)
	beq.w	.0
	tst.w	position(a2)
	beq.w	.0
	move.w	Xvel(a2),d0
	or.w	Yvel(a2),d0
	bne.w	.0
	move.w	(puckc).w,d0
	cmp.w	SCnum(a2),d0
	bne.w	.0
	st	(puckc).w
	move.b	#$14,nopuck(a2)
.0
	bsr.w	CCStart
	exg	a2,a3
	bsr.w	CCStart
	movem.l	(sp)+,d0-d4/a0-a3
	rts

CCStart	;Player a3 is checking player a2
	cmpi.w	#$169C,SPA(a2)
	beq.w	loc_1DF52
	cmpi.w	#$16EE,SPA(a2)
	beq.w	loc_1DF52
	cmpi.w	#$1792,SPA(a2)
	beq.w	loc_1DF52
	cmpi.w	#$216A,SPA(a2)
	beq.w	holdcheck
	cmpi.w	#$52C,SPA(a2)
	beq.w	holdcheck
	cmpi.w	#$2C5C,SPA(a3)
	bne.w	rtss2
	btst	#0,(gmode).w
	beq.w	.nofight
	move.w	#$100,impact(a3)
	move.w	#$100,impact(a2)
.nofight
	move.w	(a2),d0
	sub.w	(a3),d0
	move.w	Ypos(a2),d1
	sub.w	Ypos(a3),d1
	bsr.w	vtoa
	sub.w	facedir(a3),d0
	andi.w	#7,d0
	btst	#3,attribute(a3)
	beq.w	.1
	neg.w	d0
	addq.w	#8,d0
	andi.w	#7,d0
.1
	asl.w	#1,d0
	lea	unk_1DE70(pc),a0
	move.w	(a0,d0.w),d1
	bset	#5,pflags(a3)
	bsr.w	SetSPA
	tst.w	position(a2)
	beq.w	rtss2
	cmp.w	#$14,d4
	blt.w	rtss2
	moveq	#$78,d0
	btst	#3,pflags(a3)
	beq.w	*+4
.0
	sub.b	$68(a3),d0
	add.b	$68(a2),d0
	lsr.w	#1,d0
	exg	a2,a3
	jsr	(sub_1D72F6).l
	exg	a2,a3
	sub.w	impact(a2),d0
	beq.w	.2
	bmi.w	.2
	btst	#4,pflags3(a3)
	bne.w	.2
	bsr.w	randomd0
	clr.w	(TempWord1).w
	move.b	$76(a3),(TempWord1+1).w
	lsr	(TempWord1).w
	cmp.b	(TempWord1+1).w,d0
	ble.w	.2
	bsr.w	checkagr
	cmp.w	#4,d0
	bhi.w	rtss2
	btst	#4,(gmode).w
	bne.w	rtss2
	move.b	(VDP_CNTR).l,d0
	andi.w	#2,d0
	addi.w	#$16,d0
	jsr	(PenShotChk).l
	jmp	AddPenalty
.2
	bsr.w	checkagr
	cmp.w	#3,d0
	bhi.w	.4
	btst	#4,(gmode).w
	bne.w	.4
	move.b	(seed+1).w,d0
	andi.w	#3,d0
	move.l	a0,-(sp)
	movea.l	#unk_1DE80,a0
	add.w	d0,d0
	move.w	(a0,d0.w),d0
	movea.l	(sp)+,a0
	jsr	(PenShotChk).l
	bpl.w	.3
	jsr	(sub_1C3C6).l
.3
	jsr	(AddPenalty).l
.4
	bra.w	FallDown

unk_1DE70	;CCStart table
	dc.b	$15,$26,$14,$94,$14,$94,$14,$94,$14,$94,$15,$26,$15,$26,$15,$26

unk_1DE80	;CCStart table
	dc.b	$00,$1A,$00,$1C,$00,$30,$00,$32

checkagr	;Aggression check
	move.w	#$28,d0
	sub.b	$74(a3),d0
	lsr.b	#1,d0
	mulu.w	#$D,d0
	btst	#3,pflags(a3)
	beq.w	.checkpos
	asl.w	#1,d0
.checkpos
	move.w	(a3),d1
	sub.w	(puckx).w,d1
	cmp.w	#$28,d1
	bgt.w	.0
	cmp.w	#$FFD8,d1
	blt.w	.0
	move.w	Ypos(a3),d1
	sub.w	(pucky).w,d1
	cmp.w	#$28,d1
	bgt.w	.0
	cmp.w	#$FFD8,d1
	blt.w	.0
	asr.w	#1,d0
.0
	bsr.w	randomd0
	btst	#1,pflags3(a2)
	beq.w	.teamchk
	move.w	Ypos(a2),d1
	bpl.w	.2
	neg.w	d1
.2
	subi.w	#$11E,d1
	neg.w	d1
	move.w	#4,d0
	cmp.w	#$70,d1
	bgt.w	.1
	move.w	#3,d0
	cmp.w	#$38,d1
	bgt.w	.1
	move.w	#2,d0
	cmp.w	#$2A,d1
	bgt.w	.1
	move.w	#1,d0
.1
	bsr.w	randomd0
.teamchk
	btst	#6,pflags(a3)
	bne.w	.5
	btst	#2,(sflags9).w
	bne.w	.nopen
	bra.w	.3
.5
	btst	#1,(sflags9).w
	beq.w	.3
.nopen
	move.w	#$7F,d0
.3
	cmpi.w	#3,(gsp).w
	bne.w	.4
	move.w	#$7F,d0
.4
	rts

loc_1DF52
	btst	#5,pflags(a3)
	bne.w	rtss2
	tst.w	position(a3)
	beq.w	rtss2
	btst	#0,pflags2(a3)
	bne.w	rtss2
	move.w	(a3),d0
	sub.w	(a2),d0
	move.w	Ypos(a3),d1
	sub.w	Ypos(a2),d1
	bsr.w	vtoa
	sub.w	facedir(a2),d0
	addq.w	#1,d0
	andi.w	#7,d0
	cmp.w	#2,d0
	bhi.w	rtss2
	move.w	(puckc).w,d0
	cmp.w	SCnum(a3),d0
	bne.w	.holdcheck
	bclr	#3,(sflags).w
.holdcheck
	move.w	Xvel(a3),d0
	add.w	Xvel(a2),d0
	asr.w	#1,d0
	move.w	d0,Xvel(a3)
	move.w	d0,Xvel(a2)
	move.w	Yvel(a3),d0
	add.w	Yvel(a2),d0
	asr.w	#1,d0
	move.w	d0,Yvel(a3)
	move.w	d0,Yvel(a2)
	bset	#5,pflags(a3)
	move.w	#$139E,d1
	cmpi.w	#$16EE,SPA(a2)
	bne.w	.0
	move.w	#$BBE,d1
	move.w	(puckc).w,d0
	cmp.w	SCnum(a3),d0
	bne.w	.0
	st	(puckc).w
	move.b	#$20,nopuck(a3)
.0
	bsr.w	SetSPA
	exg	a2,a3
	bset	#5,pflags(a3)
	move.w	#$16EE,d1
	cmpi.w	#$16EE,SPA(a3)
	beq.w	.1
	move.w	#$164A,d1
	cmpi.w	#$169C,SPA(a3)
	beq.w	.1
	move.w	#$1740,d1
.1
	bsr.w	SetSPA
	bsr.w	checkagr
	cmp.w	#3,d0
	bhi.w	.exit
	btst	#4,(gmode).w
	bne.w	.exit
	move.w	#$24,d0
	cmpi.w	#$164A,SPA(a3)
	beq.w	.2
	move.w	#$1E,d0
.2
	jsr	(PenShotChk).l
	jsr	(AddPenalty).l
.exit
	exg	a2,a3
	st	(collflag).w
	rts

holdcheck	;Player a2 is in a hold animation looking to hold opponent a3. Entered from CCStart. a3 must be within 1
	;direction of where a2 faces. Both get the average velocity, a3 goes to SPA $1F68, a2 to $E42 or $EA6, and
	;checkagr rolls penalty $24 or $1E
	btst	#5,pflags(a3)
	bne.w	rtss2
	tst.w	position(a3)
	beq.w	rtss2
	btst	#0,pflags2(a3)
	bne.w	rtss2
	tst.w	(OptPen).w
	bne.w	.checkdir
	btst	#3,pflags(a2)
	beq.w	.checkdir
	move.w	#$20,d0
	add.b	$76(a2),d0
	sub.b	$69(a3),d0
	btst	#1,(sflags8).w
	bne.w	.0
	btst	#6,(sflags7).w
	beq.w	.1
.0
	subq.b	#2,d0
.1
	bsr.w	randomd0
	cmp.w	#$18,d0
	blt.w	rtss2
.checkdir
	move.w	(a3),d0
	sub.w	(a2),d0
	move.w	Ypos(a3),d1
	sub.w	Ypos(a2),d1
	bsr.w	vtoa
	sub.w	facedir(a2),d0
	addq.w	#1,d0
	andi.w	#7,d0
	cmp.w	#2,d0
	bhi.w	rtss2
	exg	a2,a3
	bsr.w	FallDown
	tst.w	position(a3)
	beq.w	.exit
	bsr.w	checkagr
	cmp.w	#4,d0
	bhi.w	.exit
	move.w	#$20,d0
	jsr	(PenShotChk).l
	jsr	(AddPenalty).l
.exit
	exg	a2,a3
	st	(collflag).w
	rts
