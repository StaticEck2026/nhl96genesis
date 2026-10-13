;	The playoff pass bits (ReadPassBits, EncodePW, WritePassBits and the 5 word arithmetic), the playoff team
;	stats in save RAM, ResolveGames, the Stars of the Game box, the injury, penalty shot and goal boxes, the
;	player name strings (getname, FormatPlayerName and the others) and the exception vectors (crash).

ReadPassBits	;Translate the saved bits at a3 (5 words) to the playoff variables; the 5 words are kept
	moveq	#4,d0
	lea	$A(a3),a0
.save
	move.w	-(a0),-(sp)	;SuperDiv destroys the bits
	dbf	d0,.save
	moveq	#7,d2
	movea.w	#(gsstruct+$70-M68K_RAM),a1
.1
	bclr	#2,$E(a1)
	moveq	#5,d0
	bsr.w	SuperDiv
	move.w	d0,6(a1)
	cmp.w	#4,d0
	bne.w	.nsf0
	bset	#2,$E(a1)
.nsf0
	moveq	#5,d0
	bsr.w	SuperDiv
	move.w	d0,4(a1)
	cmp.w	#4,d0
	bne.w	.3
	bset	#2,$E(a1)
.3
	suba.w	#$10,a1
	dbf	d2,.1
	move.w	#$4000,d0
	bsr.w	SuperDiv
	move.w	d0,(WinBits).w
	move.w	#8,d0
	bsr.w	SuperDiv
	move.w	d0,(pojoy).w
	tst.w	(FourWayPlay).w
	beq.w	.5
	cmpi.w	#1,(pojoy).w
	bne.w	.4
	move.w	#3,(pojoy).w
	bra.w	.5
.4
	cmpi.w	#2,(pojoy).w
	bne.w	.5
	move.w	#4,(pojoy).w
.5
	moveq	#$10,d0
	bsr.w	SuperDiv
	move.w	d0,(potreeteam).w
	moveq	#4,d0
	bsr.w	SuperDiv
	move.w	d0,(gamelevel).w
	moveq	#8,d0
	bsr.w	SuperDiv
	move.w	d0,(bosgames).w
	moveq	#$20,d0
	bsr.w	SuperDiv
	move.w	d0,(postarts).w
	moveq	#4,d0
	lea	(a3),a0
.restore
	move.w	(sp)+,(a0)+	;put the bits back
	dbf	d0,.restore
	rts

EncodePW	;After a playoff game compute winners and save the bits if needed
	tst.w	(OptNOP).w
	beq.w	rtss2
	tst.w	(OptPlayMode).w
	beq.w	rtss2
	cmpi.w	#4,(OptPlayMode).w
	beq.w	rtss2
	bset	#6,(GameFlags).w
	move.w	#1,(OptPlayMode).w	;continue playoffs
	move.w	#1,(TempOptPlayMode).w
	bsr.w	ResolveGames
	bsr.w	maketree
	cmpi.w	#4,(gamelevel).w
	beq.w	.2	;finished playoffs
	btst	#7,(GameFlags).w
	bne.w	.0
	tst.w	(gamenum).w
	bmi.w	.2
.0
	movea.l	#pwddatabuffer,a3
	bsr.w	WritePassBits
	jsr	(WritePassData).l
	bclr	#4,(sflags).w
	move.w	#$FFFF,(lastsfx).w
	move.l	#$FFFF0000,(recbpr).w
	btst	#2,(sflags3).w
	beq.w	.1
	movea.w	#(tpassbits-M68K_RAM),a3
	bsr.w	ReadPassBits
	bsr.w	maketree
.1
	bclr	#6,(GameFlags).w
	jsr	(MakeSRAMChecksum).l
	rts
.2
	movea.w	#(pwddatabuffer-M68K_RAM),a3
	bsr.w	ClrPassBits
	jsr	(WritePassData).l
	bclr	#6,(GameFlags).w
	jsr	(MakeSRAMChecksum).l
	bclr	#4,(sflags).w
	move.w	#$FFFF,(lastsfx).w
	move.l	#$FFFF0000,(recbpr).w
	move.w	#2,(OptPlayMode).w	;new playoffs
	move.w	#2,(TempOptPlayMode).w
	cmpi.w	#7,(bosgames).w
	beq.w	rtss2
	move.w	#3,(OptPlayMode).w	;new playoffs best of 7
	move.w	#3,(TempOptPlayMode).w
	rts

ReadPassData	;Read pwddatabuffer from save RAM (GameFlags bit 7: the season copy)
	movem.l	d0-d7/a0-a6,-(sp)
	move.l	#$E5E,d0
	btst	#7,(GameFlags).w
	beq.w	.0
	moveq	#$4D,d0
.0
	moveq	#$A,d1
	movea.l	#pwddatabuffer,a0
	jsr	(ReadSRAM).l
	movem.l	(sp)+,d0-d7/a0-a6
	rts

WritePassData	;Write pwddatabuffer to save RAM and its checksum (GameFlags bit 7: the season copy, only with
	;dword_FFDD7E bit 2)
	movem.l	d0-d1/a0,-(sp)
	move.l	#$E5E,d0
	btst	#7,(GameFlags).w
	beq.w	.0
	btst	#2,(dword_FFDD7E+2).w
	beq.w	.1
	moveq	#$4D,d0
.0
	moveq	#$A,d1
	movea.l	#pwddatabuffer,a0
	jsr	(WriteSRAM).l
	jsr	(MakeSRAMChecksum).l
.1
	movem.l	(sp)+,d0-d1/a0
	rts

WritePassBits	;Transfer the game variables to the bits at a3
	bsr.w	ClrPassBits
	move.w	(postarts).w,d0
	moveq	#$20,d1
	bsr.w	PushBits
	move.w	(bosgames).w,d0
	moveq	#8,d1
	bsr.w	PushBits
	move.w	(gamelevel).w,d0
	moveq	#4,d1
	bsr.w	PushBits
	move.w	(potreeteam).w,d0
	moveq	#$10,d1
	bsr.w	PushBits
	move.w	(pojoy).w,d0
	moveq	#8,d1
	bsr.w	PushBits
	move.w	(WinBits).w,d0
	move.w	#$4000,d1
	bsr.w	PushBits
	moveq	#5,d1
	moveq	#7,d2
	movea.w	#(gsstruct-M68K_RAM),a1
.0
	move.w	4(a1),d0
	bsr.w	PushBits
	move.w	6(a1),d0
	bsr.w	PushBits
	adda.w	#$10,a1
	dbf	d2,.0
	rts

PushBits	;Bits = bits * d1 + d0. d1 = range 2^1-2^15, d0 = data
	movem.l	d0-d1,-(sp)
	exg	d0,d1
	bsr.w	SuperMult
	clr.l	d0
	move.w	d1,d0
	bsr.w	SuperAdd
	movem.l	(sp)+,d0-d1
	rts

ClrPassBits	;Clear the 5 words of bits at a3
	movea.w	a3,a0
	moveq	#4,d0
.0
	clr.w	(a0)+
	dbf	d0,.0
	rts

SuperAdd	;1 long (d0.L) added to the 5 words at a3
	movem.l	d1/a0,-(sp)
	lea	$A(a3),a0
	moveq	#3,d1
	add.l	d0,-(a0)
	bra.w	.1
.0
	addq.w	#1,-(a0)	;carry into the next word up
.1
	dbcc	d1,.0
	movem.l	(sp)+,d1/a0
	rts

SuperMult	;1 word (d0) multiplied by the 5 words at a3
	movem.l	d1-d4/a0,-(sp)
	movea.w	a3,a0
	moveq	#4,d4
.0
	move.w	(a0),-(sp)
	clr.w	(a0)+
	dbf	d4,.0
	moveq	#4,d4
.1
	move.w	d0,d1
	mulu.w	(sp)+,d1
	lea	2(a3),a0
	adda.w	d4,a0
	adda.w	d4,a0
	move.w	d4,d2
	add.l	d1,-(a0)
	bra.w	.3
.2
	addq.w	#1,-(a0)
.3
	dbcc	d2,.2
	dbf	d4,.1
	movem.l	(sp)+,d1-d4/a0
	rts

SuperDiv	;5 words at a3 divided by 1 word (d0); d0 = remainder on exit
	movem.l	d1-d2/a0,-(sp)
	movea.w	a3,a0
	moveq	#4,d1
	clr.l	d2
.0
	move.w	(a0),d2
	divu.w	d0,d2
	move.w	d2,(a0)+
	dbf	d1,.0
	swap	d2
	move.w	d2,d0
	movem.l	(sp)+,d1-d2/a0
	rts

GetShifter	;Returns d1 = number of games - 1, d2 = first bit of WinBits
	move.l	d0,-(sp)
	moveq	#-16,d2
	moveq	#$10,d1
	move.w	(gamelevel).w,d0
.0
	add.w	d1,d2
	lsr.w	#1,d1
	dbf	d0,.0
	subq.w	#1,d1
	move.l	(sp)+,d0
	rts

AddPlayoffTeamStats	;Add the po team's game stats to its playoff totals in statsbuffer (ReadTeamStats) and write them back
	;to save RAM
	btst	#7,(GameFlags).w
	bne.w	.2
	cmpi.w	#1,(OptPlayMode).w
	blt.w	rtss2
	bsr.w	ReadTeamStats
	movea.w	#(potree-M68K_RAM),a0
	move.w	(potreeteam).w,d2
	move.b	(a0,d2.w),d2
	movea.w	#(tmstruct-M68K_RAM),a2
	cmp.w	$28(a2),d2
	beq.w	.0
	adda.w	#$39E,a2
	cmp.w	$28(a2),d2
	bne.w	.2
.0
	adda.w	#$C0,a2
	moveq	#$6F,d0
	movea.w	#(statsbuffer-M68K_RAM),a1
.1
	clr.w	d1
	move.b	(a2)+,d1
	add.w	d1,(a1)+
	dbf	d0,.1
	bset	#6,(GameFlags).w
	move.w	d2,d7
	jsr	(GetGoalieCountD7).l
	move.w	d0,d6
	move.w	#$1B,d3
	sub.w	d6,d3
	add.w	d6,d6
	clr.w	d7
	moveq	#$A,d2
	move.l	#$7340,d1
	movea.l	#statsbuffer,a0
	adda.w	d6,a0
	jsr	(sub_10F22).l
	moveq	#$A,d2
	move.l	#$7430,d1
	movea.l	#statsbuffer+$38,a0
	adda.w	d6,a0
	jsr	(sub_10F22).l
	moveq	#9,d2
	move.l	#$7520,d1
	movea.l	#statsbuffer+$A8,a0
	adda.w	d6,a0
	jsr	(sub_10F22).l
	asr.w	#1,d6
	move.w	d6,d3
	moveq	#$D,d2
	move.l	#$75F8,d1
	movea.l	#statsbuffer+$70,a0
	jsr	(sub_10F22).l
	moveq	#$D,d2
	move.l	#$761F,d1
	movea.l	#statsbuffer,a0
	jsr	(sub_10F22).l
	bclr	#6,(GameFlags).w
	jsr	(MakeSRAMChecksum).l
.2
	rts

ReadTeamStats	;Read the playoff stat totals of the po team from save RAM into statsbuffer words
	movea.w	#(potree-M68K_RAM),a0
	move.w	(potreeteam).w,d2
	move.b	(a0,d2.w),d2
	move.w	d2,d7
	jsr	(GetGoalieCountD7).l
	move.w	d0,d6
	move.w	#$1B,d3
	sub.w	d6,d3
	add.w	d6,d6
	clr.w	d7
	moveq	#$A,d2
	move.l	#$7340,d1
	movea.l	#statsbuffer,a0
	adda.w	d6,a0
	jsr	(sub_10F02).l
	moveq	#$A,d2
	move.l	#$7430,d1
	movea.l	#statsbuffer+$38,a0
	adda.w	d6,a0
	jsr	(sub_10F02).l
	moveq	#9,d2
	move.l	#$7520,d1
	movea.l	#statsbuffer+$A8,a0
	adda.w	d6,a0
	jsr	(sub_10F02).l
	asr.w	#1,d6
	move.w	d6,d3
	moveq	#$D,d2
	move.l	#$75F8,d1
	movea.l	#statsbuffer+$70,a0
	jsr	(sub_10F02).l
	moveq	#$D,d2
	move.l	#$761F,d1
	movea.l	#statsbuffer,a0
	jsr	(sub_10F02).l
	rts

ResolveGames	;Compute winners and losers for playoff matchups
	tst.w	(gamenum).w
	bmi.w	.1
	move.w	(gamenum).w,d0
	mulu.w	#$10,d0
	movea.w	#(gsstruct-M68K_RAM),a0
	move.w	(HmGoals).w,$A(a0,d0.w)
	move.w	(AwGoals).w,$C(a0,d0.w)
.1
	bsr.w	GetShifter
	movea.w	#(gsstruct-M68K_RAM),a0
	moveq	#$10,d3
	mulu.w	d1,d3
	adda.w	d3,a0
	cmpi.w	#7,(bosgames).w
	beq.w	.notbos
.loop
	cmpi.w	#4,4(a0)
	beq.w	.5
	cmpi.w	#4,6(a0)
	beq.w	.5
	clr.w	d3
	btst	#0,$E(a0)
	beq.w	.0
	eori.w	#2,d3
.0
	move.w	$A(a0),d0
	sub.w	$C(a0),d0
	bpl.w	.4
	eori.w	#2,d3
.4
	btst	#7,(GameFlags).w
	bne.w	.5
	addq.w	#1,4(a0,d3.w)
.5
	suba.w	#$10,a0
	dbf	d1,.loop
	btst	#7,(GameFlags).w
	bne.w	.6
	addq.w	#1,(bosgames).w
.6
	cmpi.w	#7,(bosgames).w
	beq.w	.nextround
	move.w	(gamenum).w,d0
	mulu.w	#$10,d0
	movea.w	#(gsstruct-M68K_RAM),a0
	adda.w	d0,a0
	cmpi.w	#4,4(a0)
	beq.w	.cround
	cmpi.w	#4,6(a0)
	bne.w	rtss2
.cround
	cmpi.w	#3,(gamelevel).w	;finish off rest of round games here
	bge.w	.nextround
	btst	#7,(GameFlags).w
	bne.w	rtss2
	bsr.w	GetShifter
	movea.w	#(gsstruct-M68K_RAM),a0
	moveq	#$10,d3
	mulu.w	d1,d3
	adda.w	d3,a0
.cr0
	cmp.w	(gamenum).w,d1
	beq.w	.crn
	cmpi.w	#4,4(a0)
	beq.w	.crn
	cmpi.w	#4,6(a0)
	beq.w	.crn
	addq.w	#1,4(a0)
	move.l	#$C8,d0	;200
	jsr	(randomd0).l
	andi.w	#1,d0
	beq.s	.cr0
	subq.w	#1,4(a0)
	addq.w	#1,6(a0)
	bra.s	.cr0
.crn
	suba.w	#$10,a0
	dbf	d1,.cr0
	movea.w	#(tpassbits-M68K_RAM),a3
	bsr.w	WritePassBits
	bset	#2,(sflags3).w
.nextround
	clr.w	(bosgames).w	;advance to next round
	bsr.w	GetShifter
	movea.w	#(gsstruct-M68K_RAM),a0
	moveq	#$10,d3
	mulu.w	d1,d3
	adda.w	d3,a0
	clr.w	d3
.loop2
	cmpi.w	#4,4(a0)
	beq.w	.2
	bset	d1,d3
.2
	clr.w	4(a0)
	clr.w	6(a0)
	suba.w	#$10,a0
	dbf	d1,.loop2
	moveq	#1,d1
	asl.w	d2,d1
	subq.w	#1,d1
	and.w	d1,(WinBits).w
	asl.w	d2,d3
	or.w	d3,(WinBits).w
	addq.w	#1,(gamelevel).w
	rts
.notbos
	clr.w	d3	;solve for no best of 7 playoffs (much simpler)
.loop3
	move.w	$A(a0),d0
	cmp.w	$C(a0),d0
	bhi.w	.3
	bset	d1,d3
.3
	btst	#0,$E(a0)
	beq.w	.nb2
	bchg	d1,d3
.nb2
	suba.w	#$10,a0
	dbf	d1,.loop3
	moveq	#1,d1
	asl.w	d2,d1
	subq.w	#1,d1
	and.w	d1,(WinBits).w
	asl.w	d2,d3
	or.w	d3,(WinBits).w
	addq.w	#1,(gamelevel).w
	rts

ShowThreeStars	;End of game Stars of the Game box. Waits for RefCnt <= $40 and runs once (gmode bit 7); then disflags
	;bit 3 and a vblank. Frames the box, then the three best star scores (TakeTopStarScore)
	cmpi.w	#$40,(RefCnt).w
	bgt.w	rtss2
	bset	#7,(gmode).w
	bne.w	rtss2
	jsr	(sub_1E7A78).l
	jsr	(sub_1CFE4).l
	movem.l	d0/a1,-(sp)
	bset	#3,(disflags).w
	move.w	(vcount).w,d0
.loop2
	cmp.w	(vcount).w,d0
	beq.s	.loop2
	movem.l	(sp)+,d0/a1
	movem.l	d0-d5/a0-a4,-(sp)
	bsr.w	printz
	String	$BF,$02,$0E
	moveq	#$1C,d0
	moveq	#9,d1
	bsr.w	Framer
	bsr.w	printbigz2
	String	$F8,$04,$01,$03,$10,'    Stars of the Game     ',$F8,$04,$01,$03,$0F
	bsr.w	CalcStarScores
	move.w	#$12,(printy).w
	moveq	#2,d2
.loop
	bsr.w	TakeTopStarScore
.0
	move.w	#$1A,(printx).w
	addq.w	#1,(printy).w
	movea.l	$1E(a2),a1
	adda.w	4(a1),a1
	adda.w	(a1),a1
	bsr.w	print
	bsr.w	getname
	move.w	#3,(printx).w
	bsr.w	print
	dbf	d2,.loop
	move.w	(HmGoals).w,d0
	sub.w	(AwGoals).w,d0
	ble.w	.nosong
	move.w	#$F,-(sp)
	jsr	(song).l
.nosong
	movem.l	(sp)+,d0-d5/a0-a4
	rts

TakeTopStarScore	;Take the highest star score at ThreeStars (home team first) and clear it. Returns d0 = player slot, a2 =
	;its team struct
	movem.l	d1-d2/a1/a4,-(sp)
.0
	movea.w	#(ThreeStars-M68K_RAM),a4
	clr.l	d0
	moveq	#$37,d2
.find
	cmp.l	(a4)+,d0
	bge.w	.next
	lea	-4(a4),a1
	move.l	(a1),d0
.next
	dbf	d2,.find
	clr.l	(a1)
	move.w	a1,d0
	subi.w	#(ThreeStars-M68K_RAM),d0
	lsr.w	#2,d0
	movea.w	#(tmstruct-M68K_RAM),a2
	cmp.w	#$1C,d0
	blt.w	.home
	subi.w	#$1C,d0
	adda.w	#$39E,a2
.home
	movem.l	(sp)+,d1-d2/a1/a4
	rts

CalcStarScores	;Star score for every roster slot of both teams to ThreeStars (home team first).
	;Code the listing does not decode: kept as bytes
	dc.b	$38,$7C,$D1,$30,$4E,$B9,$00,$01,$48,$A2,$3A,$00,$DA,$42,$34,$7C
	dc.b	$C7,$26,$47,$EA,$03,$9E,$61,$00,$00,$48,$34,$4B,$47,$EA,$FC,$62
	dc.b	$61,$00,$00,$3E,$0C,$78,$00,$03,$C4,$BC,$66,$00,$00,$32,$4A,$43
	dc.b	$67,$00,$00,$2C,$30,$7C,$C4,$C6,$D0,$F8,$C4,$CA,$42,$40,$08,$28
	dc.b	$00,$07,$00,$02,$67,$00,$00,$06,$06,$40,$00,$1C,$D0,$28,$00,$03
	dc.b	$E5,$40,$30,$7C,$D1,$30,$21,$BC,$7F,$FF,$FF,$FF,$00,$00,$4E,$75

CalcTeamStarScores	;Star scores of team a2 (a3 = other team) to (a4)+, one long per roster slot.
	;Code the listing does not decode: kept as bytes
	dc.b	$32,$4A,$36,$2A,$00,$0C,$96,$6B,$00,$0C,$48,$C3,$78,$1B,$4E,$B9
	dc.b	$00,$01,$57,$A2,$44,$40,$D0,$44,$28,$83,$B8,$40,$62,$00,$00,$3C
	dc.b	$42,$41,$12,$2A,$00,$C0,$C2,$FC,$2A,$F8,$D3,$94,$42,$41,$12,$2A
	dc.b	$00,$DC,$C2,$FC,$27,$74,$D3,$94,$42,$41,$12,$2A,$00,$F8,$C2,$FC
	dc.b	$00,$0A,$4A,$43,$66,$00,$00,$0E,$C2,$FC,$00,$64,$D3,$94,$42,$81
	dc.b	$D2,$69,$01,$4C,$D3,$94,$60,$00,$00,$3A,$BA,$69,$01,$4C,$62,$00
	dc.b	$00,$32,$42,$41,$12,$2A,$00,$C0,$C2,$FC,$00,$64,$42,$42,$14,$2A
	dc.b	$00,$F8,$67,$00,$00,$1E,$82,$C2,$B2,$7C,$00,$04,$62,$00,$00,$14
	dc.b	$06,$94,$00,$00,$7D,$00,$4A,$41,$66,$00,$00,$08,$06,$94,$00,$01
	dc.b	$24,$F8,$54,$49,$52,$4A,$58,$4C,$51,$CC,$FF,$7E,$4E,$75

ShowInjuryBox	;The injury message (CheckInjury): "Injured player", "Out for period", "game" or n "games", then the player
	;(GetPlayerNumInitial)
	movem.l	d0-d2/a0-a4,-(sp)
	bsr.w	printz
	String	$BF,$0B,$02
	moveq	#$12,d0
	moveq	#6,d1
	bsr.w	Framer
	btst	#3,(sflags13).w
	bne.w	.1
	btst	#5,(sflags7).w
	bne.w	.0
	bsr.w	printbigz2
	String	$F8,$04,$01,$0C,$03,'Injured player  '
	jsr	(printz).l
	String	$BF,$0C,$06,'Out for period',$BF,$0C,$05
	bra.w	.4
.0
	bsr.w	printbigz2
	String	$F8,$04,$01,$0C,$03,'Injured player  '
	jsr	(printz).l
	String	$BF,$0C,$06,'Out for game',$BF,$0C,$05
	bra.w	.4
.1
	bsr.w	printbigz2
	String	$F8,$04,$01,$0C,$03,'Injured player  '
	jsr	(printz).l
	String	$BF,$0C,$06,'Out for '
	move.w	(injurygames).w,d0
	move.w	#1,d1
	jsr	(PushNumberWidth).l
	jsr	(print).l
	cmpi.w	#1,(injurygames).w
	bgt.w	.2
	jsr	(printz).l
	String	' game'
	bra.w	.3
.2
	jsr	(printz).l
	String	' games'
.3
	jsr	(printz).l
	String	$BF,$0C,$05
.4
	bsr.w	GetPlayerNumInitial
	bsr.w	print
	btst	#0,(puck_pflags2).w
	beq.w	.5
	bsr.w	printz
	String	$BF,$14,$06,'the game'
.5
	movem.l	(sp)+,d0-d2/a0-a4
	rts

PenaltyShotBox	;In a shootout ShootoutModeBox; else the "PENALTY SHOT!" box: the shooter, the penalty (Penaltylist) and " by"
	;the checker
	bset	#7,(gmode2).w
	btst	#0,(gmode2).w
	beq.w	.box
	jmp	ShootoutModeBox
.box
	movem.l	d0-d2/a0-a4,-(sp)
	move.w	#$FFFF,d0
.0
	jsr	(prefmes).l
	bsr.w	printz
	String	$BF,$06,$02
	moveq	#$15,d0
	moveq	#8,d1
.1
	bsr.w	Framer
	lea	PenShotBigTxt(pc),a1
.3
	jsr	(printbig2).l
	move.w	(BA_Sktr_SCnum).w,d0
	asl.w	#7,d0
	movea.l	#SortCords,a2
	adda.w	d0,a2
	clr.w	d0
	move.b	$67(a2),d0
	movea.l	#tmstruct,a2
	tst.w	(BA_Team).w
	beq.w	.5
.4
	movea.l	#AwShots,a2
.5
	bsr.w	FormatPlayerNumInitial
	bsr.w	print
	bsr.w	printz
	String	$BF,$07,$07
	movem.l	a1/a3,-(sp)
	move.w	(pspenalty).w,d0
	movea.l	#Penaltylist,a1
	adda.w	(a1,d0.w),a1
	lea	2(a1),a1
	bsr.w	print
	movem.l	(sp)+,a1/a3
	bsr.w	printz
	String	' by',$BF,$07,$08
	move.w	(BA_Checker_Offset).w,d0
	movea.l	#AwShots,a2
	tst.w	(BA_Team).w
	beq.w	.2
	movea.l	#tmstruct,a2
.2
	jsr	(FormatPlayerNumInitial).l
	jsr	(print).l
	movem.l	(sp)+,d0-d2/a0-a4
	rts

PenShotBigTxt	;PenaltyShotBox big text
	String	$F8,$04,$01,$07,$03,'   PENALTY SHOT    ',$F8,$04,$01,$07,$05

ShowGoalBox	;Goal box: close both line change boxes (lcfound2), then the scorer and the assists from ScoreSum
	;(PrintPlayerGoals / PrintPlayerAssists), the goalie counts (CountGoalies)
	movem.l	d0-d2/a0-a4,-(sp)
	btst	#2,(BA_PS_flags).w
	beq.w	.0
	bset	#2,(sflags2).w
.0
	movea.w	#(tmstruct-M68K_RAM),a2
	jsr	(lcfound2).l
	adda.w	#$39E,a2
	jsr	(lcfound2).l
	jsr	(loc_1E78C4).l
	movea.w	#(ScoreSum-6-M68K_RAM),a4
	adda.w	(ScoreSumbytes).w,a4
	bsr.w	printz
	String	$BF,$0B,$02
	moveq	#$13,d0
	move.w	#5,d1
	tst.b	4(a4)
	bmi.w	.4
	addq.w	#2,d1
	tst.b	5(a4)
	bmi.w	.4
	addq.w	#1,d1
.4
	bsr.w	Framer
	jsr	(CountGoalies).l
	movea.w	#(tmstruct-M68K_RAM),a2
	move.w	(homegoalies).w,(recwins).w
	btst	#7,2(a4)
	beq.w	.1
	adda.w	#$39E,a2
	move.w	(awaygoalies).w,(recwins).w
.1
	lea	GoalBigTxt(pc),a1
	bclr	#0,(sflags9).w
	beq.w	.2
	lea	PPGoalBigTxt(pc),a1
.2
	clr.w	d0
	move.b	3(a4),d0
	addi.w	#$C0,d0
	cmpi.b	#3,(a2,d0.w)
	bne.w	.print
	movem.w	d1,-(sp)
	clr.w	d1
	move.b	3(a4),d1
	cmp.w	(recwins).w,d1
	movem.w	(sp)+,d1
	blt.w	.print
	adda.w	(a1),a1
	move.w	d0,-(sp)
	move.w	$28(a2),d0
	cmp.w	(HomeTeam).w,d0
	bne.w	.3
	move.w	#0,d0
	jsr	(nullsub_7).l
.3
	move.w	(sp)+,d0
.print
	jsr	(printbig2).l
	clr.w	d0
	move.b	3(a4),d0
	move.w	d0,-(sp)
	move.w	#$C,(printx).w
	bsr.w	FormatPlayerName
	bsr.w	print
	move.w	(sp)+,d0
	movem.w	d1,-(sp)
	clr.w	d1
	move.b	3(a4),d1
	cmp.w	(recwins).w,d1
	movem.w	(sp)+,d1
	blt.w	.5
	jsr	(PrintPlayerGoals).l
.5
	clr.w	d0
	move.b	4(a4),d0
	bmi.w	.6
	bclr	#5,(sflags4).w
	bne.w	.6
	bsr.w	printz
	String	$BF,$0E,$06,'Assist by:',$BF,$0C,$07
	move.w	d0,-(sp)
	bsr.w	FormatPlayerName
	bsr.w	print
	move.w	(sp)+,d0
	jsr	(PrintPlayerAssists).l
	clr.w	d0
	move.b	5(a4),d0
	bmi.w	.6
	bsr.w	printz
	String	$BF,$0C,$08
	move.w	d0,-(sp)
	bsr.w	FormatPlayerName
	bsr.w	print
	move.w	(sp)+,d0
	jsr	(PrintPlayerAssists).l
.6
	bclr	#5,(sflags4).w
	movem.l	(sp)+,d0-d2/a0-a4
	rts

GoalBigTxt	;printbig Strings for ShowGoalBox: GOAL!, then HAT TRICK!
	String	$F8,$04,$01,$0C,$03,'      GOAL!      ',$F8,$04,$01,$0C,$05
	String	$F8,$04,$01,$0C,$03,'   HAT TRICK!    ',$F8,$04,$01,$0C,$05

PPGoalBigTxt	;The same after a power play: PP GOAL!, then HAT TRICK!
	String	$F8,$04,$01,$0C,$03,'    PP GOAL!     ',$F8,$04,$01,$0C,$05
	String	$F8,$04,$01,$0C,$03,'   HAT TRICK!    ',$F8,$04,$01,$0C,$05

box	;Fill a $14 x $C rectangle at printz position $FF,$B,2 with char $7FF (eraser)
	bsr.w	printz
	String	$FF,$0B,$02
	moveq	#$14,d0
	moveq	#$C,d1
	move.l	#$7FF,d2
	bra.w	eraser

GetPlayerName	;a1 = mesarea "NN First Last" (getname) for player TempPlOffset (bit 15 set: away team)
	movem.l	d0/a2,-(sp)
	movea.w	#(tmstruct-M68K_RAM),a2
	move.w	(TempPlOffset).w,d0
	bpl.w	.0
	andi.w	#$FF,d0
	adda.w	#$39E,a2
.0
	bsr.w	getname
	movem.l	(sp)+,d0/a2
	rts

getname	;a1 = mesarea "NN First Last" for player d0 of team struct a2.
	movem.l	d0-d3/d7-a0/a2-a3,-(sp)
	move.w	$28(a2),d7
	jsr	(GetJerseyNumber).l
	jsr	(GetPlayerNamePointer).l
	move.l	a0,-(sp)
	movea.w	#(mesarea-M68K_RAM),a3
	move.w	#4,(a3)
	lea	2(a3),a1
	adda.w	(a0),a0
	move.w	(jerseynum).w,d0
	bsr.w	ConvertByteToDigits
	bsr.w	appendz
	String	$20
	movea.l	(sp)+,a1
	bsr.w	appstring
	movea.w	#(mesarea-M68K_RAM),a1
	movem.l	(sp)+,d0-d3/d7-a0/a2-a3
	rts

GetPlayerNumInitial	;GetPlayerName with FormatPlayerNumInitial ("NN F. Last")
	movem.l	d0/a2,-(sp)
	movea.w	#(tmstruct-M68K_RAM),a2
	move.w	(TempPlOffset).w,d0
	bpl.w	.0
	andi.w	#$FF,d0
	adda.w	#$39E,a2
.0
	bsr.w	FormatPlayerNumInitial
	movem.l	(sp)+,d0/a2
	rts

FormatPlayerNumInitialShort	;a1 = mesarea string "NN F.Last" for player d0 of team a2, built in TextBuffer.
	;Code the listing does not decode: kept as bytes
	dc.b	$48,$E7,$F1,$A0,$3E,$2A,$00,$28,$4E,$B9,$00,$01,$02,$B8,$4E,$B9
	dc.b	$00,$01,$01,$C6,$2F,$08,$32,$7C,$BF,$F4,$D0,$D0,$30,$38,$DD,$AA
	dc.b	$61,$00,$01,$AA,$12,$FC,$00,$20,$20,$5F,$30,$18,$45,$F0,$00,$FE
	dc.b	$12,$D8,$12,$FC,$00,$2E,$0C,$18,$00,$20,$66,$FA,$12,$D8,$B5,$C8
	dc.b	$66,$FA,$61,$00,$01,$6E,$4C,$DF,$05,$8F,$4E,$75

FormatPlayerNumInitial	;a1 = mesarea string "NN F. Last" for player d0 of team a2, built in TextBuffer. Called from PenaltyShotBox
	;and others
	movem.l	d0-d3/d7-a0/a2,-(sp)
	move.w	$28(a2),d7
	jsr	(GetJerseyNumber).l
	jsr	(GetPlayerNamePointer).l
	move.l	a0,-(sp)
	movea.w	#(TextBuffer-M68K_RAM),a1
	adda.w	(a0),a0
	move.w	(jerseynum).w,d0
	bsr.w	ConvertByteToDigits
	move.b	#$20,(a1)+
	movea.l	(sp)+,a0
	move.w	(a0)+,d0
	lea	-2(a0,d0.w),a2
	move.b	(a0)+,(a1)+
	move.w	#$2E20,(a1)+
.skipfirst
	cmpi.b	#$20,(a0)+
	bne.s	.skipfirst
.copy
	move.b	(a0)+,(a1)+
	cmpa.l	a0,a2
	bne.s	.copy
	bsr.w	FinalizeTextBuffer
	movem.l	(sp)+,d0-d3/d7-a0/a2
	rts

GetPlayerNumLast	;GetPlayerName with FormatPlayerName ("NN Last").
	;Code the listing does not decode: kept as bytes
	dc.b	$48,$E7,$80,$20,$34,$7C,$C7,$26,$30,$38,$C4,$C8,$6A,$00,$00,$0A
	dc.b	$02,$40,$00,$FF,$D4,$FC,$03,$9E,$61,$00,$00,$08,$4C,$DF,$04,$01
	dc.b	$4E,$75

FormatPlayerName	;a1 = mesarea string "NN Last" for player d0 of team a2, built in TextBuffer. Called from ShowGoalBox and
	;others
	movem.l	d0-d3/d7-a0/a2,-(sp)
	move.w	$28(a2),d7
	jsr	(GetJerseyNumber).l
	jsr	(GetPlayerNamePointer).l
	move.l	a0,-(sp)
	movea.w	#(TextBuffer-M68K_RAM),a1
	adda.w	(a0),a0
	move.w	(jerseynum).w,d0
	bsr.w	ConvertByteToDigits
	move.b	#$20,(a1)+
	movea.l	(sp)+,a0
	move.w	(a0)+,d0
	lea	-2(a0,d0.w),a2
.skip
	cmpi.b	#$20,(a0)+
	bne.s	.skip
.copy
	move.b	(a0)+,(a1)+
	cmpa.l	a0,a2
	bne.s	.copy
	bsr.w	FinalizeTextBuffer
	movem.l	(sp)+,d0-d3/d7-a0/a2
	rts

FormatPlayerNameLast	;FormatPlayerNameShort without the leading space ("Last", space padded). Branches into FormatLastName.
	;Code the listing does not decode: kept as bytes
	dc.b	$48,$E7,$F0,$A0,$4E,$B9,$00,$01,$01,$C6,$32,$7C,$BF,$F4,$60,$00
	dc.b	$00,$14

FormatPlayerNameShort	;a1 = mesarea string " Last" for player d0 of team a2, space padded to 12 characters.
	;Code the listing does not decode: kept as bytes
	dc.b	$48,$E7,$F0,$A0,$4E,$B9,$00,$01,$01,$C6,$32,$7C,$BF,$F4,$12,$FC
	dc.b	$00,$20

FormatLastName	;Skip the first name, copy the last name, pad; branched to from FormatPlayerNameLast.
	;Code the listing does not decode: kept as bytes
	dc.b	$30,$18,$45,$F0,$00,$FE,$0C,$18,$00,$20,$66,$FA,$12,$D8,$B5,$C8
	dc.b	$67,$00,$00,$0E,$4A,$10,$66,$F4,$60,$00,$00,$06,$12,$FC,$00,$20
	dc.b	$B2,$FC,$C0,$00,$6D,$F6,$61,$00,$00,$66,$4C,$DF,$05,$0F,$4E,$75

GetPlayerInitial	;GetPlayerName with FormatPlayerInitial ("F. Last").
	;Code the listing does not decode: kept as bytes
	dc.b	$48,$E7,$80,$20,$34,$7C,$C7,$26,$30,$38,$C4,$C8,$6A,$00,$00,$0A
	dc.b	$02,$40,$00,$FF,$D4,$FC,$03,$9E,$61,$00,$00,$08,$4C,$DF,$04,$01
	dc.b	$4E,$75

FormatPlayerInitial	;a1 = mesarea "F. Last" for player d0 of team a2.
	;Code the listing does not decode: kept as bytes
	dc.b	$48,$E7,$F0,$A0,$4E,$B9,$00,$01,$01,$C6,$2F,$08,$32,$7C,$BF,$F4
	dc.b	$D0,$D0,$10,$10,$20,$5F,$30,$18,$45,$F0,$00,$FE,$12,$D8,$12,$FC
	dc.b	$00,$2E,$12,$FC,$00,$20,$0C,$18,$00,$20,$66,$FA,$12,$D8,$B5,$C8
	dc.b	$66,$FA,$61,$00,$00,$08,$4C,$DF,$05,$0F,$4E,$75

FinalizeTextBuffer	;mesarea length word = a1 - mesarea, with a 0 pad byte when odd. Returns a1 = mesarea. Called from the
	;FormatPlayerName routines
	move.w	a1,d0
	subi.w	#(mesarea-M68K_RAM),d0
	btst	#0,d0
	beq.w	.even
	clr.b	(a1)+
	addq.w	#1,d0
.even
	movea.w	#(mesarea-M68K_RAM),a1
	move.w	d0,(a1)
	rts

ConvertByteToDigits	;Converts decimal number in d0 to ascii: two ascii digits of bcd byte d0 to (a1)+, a leading 0 becomes a space
	;($F0 + '0')
	move.w	d0,-(sp)
	lsr.b	#4,d0
	andi.b	#$F,d0
	bne.w	.0
	move.b	#$F0,d0
.0
	addi.b	#$30,d0
	move.b	d0,(a1)+
	move.w	(sp)+,d0
	andi.w	#$F,d0
	addi.b	#$30,d0
	move.b	d0,(a1)+
	rts

PushNumberWidthZero	;PushNumberWidth with leading zeros: d0 as d1 digits to PushWidthBuf (a String).
	;Code the listing does not decode: kept as bytes
	dc.b	$48,$E7,$F0,$00,$32,$7C,$C0,$58,$74,$01,$92,$42,$60,$00,$00,$06
	dc.b	$C4,$FC,$00,$0A,$51,$C9,$FF,$FA,$76,$30,$48,$C0,$80,$C2,$66,$00
	dc.b	$00,$10,$B4,$7C,$00,$01,$67,$00,$00,$08,$30,$03,$60,$00,$00,$06
	dc.b	$76,$30,$D0,$43,$12,$C0,$48,$40,$84,$FC,$00,$0A,$66,$DC,$20,$09
	dc.b	$04,$40,$C0,$56,$08,$00,$00,$00,$67,$00,$00,$06,$42,$19,$52,$40
	dc.b	$32,$7C,$C0,$56,$32,$80,$4C,$DF,$00,$0F,$4E,$75

AdrErr	;Vector 3: "Address Error", the access address and the pc (crash)
	move	#$2700,sr
	jsr	(printcurz).l
	String	$BD,$00,$00,'Address Error'
	move.l	$A(sp),d0
	move.l	2(sp),d1
	bra.w	crash

InvOpCode	;Vector 4: "Illegal Instruction" and the pc (crash)
	move	#$2700,sr
	bsr.w	printcurz
	String	$BD,$00,$00,'Illegal Instruction'
	move.l	2(sp),d0
	move.l	d0,d1
	bra.w	crash

DivBy0	;Vector 5: "Division by zero" and the pc, falls into crash
	move	#$2700,sr
	bsr.w	printcurz
	String	$BD,$00,$00,'Division by zero'
	move.l	2(sp),d0
	move.l	d0,d1

crash	;Print d1 then d0 as hex, set the vdp up, copy 8 longs from the unk_923E4 palette + $20 to cram $20 and
	;hang. Branched to from AdrErr and InvOpCode, falls in from DivBy0
	movea.w	#(mesarea-M68K_RAM),a0
	move.w	#$18,(a0)+
	move.b	#$BD,(a0)+
	move.b	#0,(a0)+
.0
	move.b	#2,(a0)+
	move.l	d1,-(sp)
.1
	bsr.w	.ri
	move.b	#$BD,(a0)+
	move.b	#0,(a0)+
	move.b	#4,(a0)+
	move.l	(sp)+,d0
.2
	bsr.w	.ri
	movea.w	#(mesarea-M68K_RAM),a1
.3
	jsr	(printcur).l
	movea.l	#VDP_DATA,a0
.4
	move.w	#$9100,4(a0)
	move.w	#$9206,4(a0)
	move.w	#$8F02,4(a0)
	move.l	#$C0200000,4(a0)
	movea.l	#unk_923E4,a1
	adda.l	(a1),a1
.5
	adda.w	#$20,a1
	moveq	#7,d0
.6
	move.l	(a1)+,(a0)
	dbf	d0,.6
.7
	bra.w	.7
.ri
	moveq	#7,d2
.8
	rol.l	#4,d0
	move.w	d0,d1
	andi.w	#$F,d1
	addi.w	#$30,d1
	cmp.w	#$39,d1
	ble.w	.9
	addq.w	#7,d1
.9
	move.b	d1,(a0)+
	dbf	d2,.8
	rts
