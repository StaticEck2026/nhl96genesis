;	The award winner records, the season injuries (RandomInjuryGames, SetInjuryGames, SetSeasonInjuries,
;	GetInjuryGames), the opening screens new in 96, and ValidationRoutine (the ROM checksum).

GetAwardWinner	;d0 = the 4-byte winner record of award word_FFD034 (save RAM $D94 + award * 4, read to ThreeStars)
	movea.l	#ThreeStars,a0
	move.l	#$D94,d0
	move.w	(word_FFD034).w,d1
	cmp.w	#8,d1
	bne.w	.0
	clr.w	d1
.0
	mulu.w	#4,d1
	add.l	d1,d0
	move.w	#4,d1
	jsr	(ReadSRAM).l
	move.l	(a0),d0
	rts

sub_1E827A	;Called from Opening2: player records of three lists to save RAM
	movem.l	d0-d7/a0-a6,-(sp)
	move.w	#2,(word_FFBF56).w
	jsr	(sub_1DA9EA).l
	movea.l	#$201B28,a6
	move.w	(word_FF1388).l,d0
	ext.l	d0
	divu.w	#$1B,d0
	move.w	d0,d7
	swap	d0
	clr.w	4(a6)
	move.w	d7,6(a6)
	movea.l	#$FFFFDDAA,a0
	jsr	(sub_104EE).l
	move.b	(jerseynum).w,1(a6)
	move.b	(jerseynum+1).w,3(a6)
	addq.l	#8,a6
	move.w	(word_FF1388).l,d0
	ext.l	d0
	divu.w	#$1B,d0
	move.w	d0,d7
	swap	d0
	clr.w	4(a6)
	move.w	d7,6(a6)
	movea.l	#$FFFFDDAA,a0
	jsr	(sub_104EE).l
	move.b	(jerseynum).w,1(a6)
	move.b	(jerseynum+1).w,3(a6)
	addq.l	#8,a6
	movea.l	#$FFFF1388,a5
.0
	move.w	(a5),d0
	ext.l	d0
	divu.w	#$1B,d0
	move.w	d0,d7
	swap	d0
	movem.w	d0,-(sp)
	jsr	(sub_103AA).l
	move.w	d0,d1
	movem.w	(sp)+,d0
	cmp.w	#1,d1
	beq.w	.1
	cmp.w	#2,d1
	beq.w	.1
	addq.l	#2,a5
	bra.s	.0
.1
	clr.w	4(a6)
	move.w	d7,6(a6)
	movea.l	#$FFFFDDAA,a0
	jsr	(sub_104EE).l
	move.b	(jerseynum).w,1(a6)
	move.b	(jerseynum+1).w,3(a6)
	addq.l	#8,a6
	move.w	#3,(word_FFBF56).w
	jsr	(sub_1DA9EA).l
	move.w	(word_FF1388).l,d0
	ext.l	d0
	divu.w	#$1B,d0
	move.w	d0,d7
	swap	d0
	clr.w	4(a6)
	move.w	d7,6(a6)
	movea.l	#$FFFFDDAA,a0
	jsr	(sub_104EE).l
	move.b	(jerseynum).w,1(a6)
	move.b	(jerseynum+1).w,3(a6)
	adda.l	#$10,a6
	move.l	a6,-(sp)
	movea.l	#$FFFFD168,a0
	jsr	(sub_1161E).l
	jsr	(StandingsPoints).l
	movea.l	(sp)+,a6
	move.w	#$19,d6
	clr.w	d7
	clr.w	d5
	movea.l	#$FFFFD132,a0
.2
	clr.w	d0
	move.b	(a0)+,d0
	cmp.w	d0,d5
	bge.w	.3
	move.b	-1(a0),d5
	move.b	d7,(jerseynum+1).w
.3
	addq.w	#1,d7
	dbf	d6,.2
	move.b	(jerseynum+1).w,7(a6)
	clr.b	5(a6)
	bclr	#6,(GameFlags).w
	jsr	(MakeSRAMChecksum).l
	movem.l	(sp)+,d0-d7/a0-a6
	rts

sub_1E83E6	;Called from SeasonAwards: the award winner records to save RAM
	movem.l	d0-d7/a0-a6,-(sp)
	move.w	#2,(word_FFBF56).w
	jsr	(sub_1DA9EA).l
	movea.l	#$201B48,a6
	move.w	(word_FF1388).l,d0
	btst	#1,(sflags11).w
	beq.w	.0
	move.w	($201B56).l,d7
	andi.w	#$FF,d7
	jsr	(GetGoalieCountD7).l
	move.w	d0,d1
	move.w	#3,d0
	jsr	(randomd0).l
	add.w	d1,d0
	bra.w	.1
.0
	ext.l	d0
	divu.w	#$1B,d0
	move.w	d0,d7
	swap	d0
.1
	clr.w	4(a6)
	move.w	d7,6(a6)
	movea.l	#$FFFFDDAA,a0
	jsr	(sub_104EE).l
	move.b	(jerseynum).w,1(a6)
	move.b	(jerseynum+1).w,3(a6)
	btst	#1,(sflags11).w
	beq.w	.2
	movem.l	d0-d7/a0-a6,-(sp)
	move.w	#5,(StandingsMode).w
	jsr	(StandingsGroups).l
	movea.l	#$FFFFD168,a0
	jsr	(sub_1161E).l
	jsr	(StandingsPoints).l
	jsr	(SortStandings).l
	clr.w	d7
	move.b	(StandingsList).w,d7
	movea.l	#$201B58,a6
	move.b	d7,7(a6)
	clr.b	5(a6)
	move.w	#4,(StandingsMode).w
	jsr	(StandingsGroups).l
	movea.l	#$FFFFD168,a0
	jsr	(sub_1161E).l
	jsr	(StandingsPoints).l
	jsr	(SortStandings).l
	clr.w	d7
	move.b	(StandingsList).w,d7
	movea.l	#$201B58,a6
	move.b	d7,$F(a6)
	clr.b	$D(a6)
	movem.l	(sp)+,d0-d7/a0-a6
	bra.w	.6
.2
	jsr	(maketree).l
	movea.l	#$201B58,a6
	movea.l	#$FFFFCFEE,a0
	movea.l	#StandingsGroup4,a1
	move.b	(a1)+,d1
	subq.w	#1,d1
.3
	move.b	(a1)+,d0
	cmp.b	(a0),d0
	beq.w	.4
	dbf	d1,.3
	bra.w	.5
.4
	move.b	1(a0),7(a6)
	clr.b	5(a6)
	move.b	(a0),$F(a6)
	clr.b	$D(a6)
	bra.w	.6
.5
	move.b	(a0),7(a6)
	clr.b	5(a6)
	move.b	1(a0),$F(a6)
	clr.b	$D(a6)
.6
	bclr	#6,(GameFlags).w
	jsr	(MakeSRAMChecksum).l
	movem.l	(sp)+,d0-d7/a0-a6
	rts

sub_1E8544	;Called from Opening2 (dword_FFDD7E bit 3): a screen with the texts unk_1E877A / unk_1E8788
	btst	#3,(dword_FFDD7E+2).w
	beq.w	.3
	movem.l	d0-d7/a0-a6,-(sp)
	move.l	#unk_1E2E76,(vbint).w
	bclr	#0,(disflags).w
	bset	#2,(disflags).w
	bclr	#1,(disflags).w
	move.w	#0,(VSCRLPM).w
	move.w	#$B800,(VSPRITES).w
	move.w	#$B800,(VmMap3).w
	move.w	#5,(Map3col1).w
	move.w	#$C000,(VmMap2).w
	move.w	#6,(Map2col1).w
	move.w	#$E000,(VmMap1).w
	move.w	#6,(Map1col1).w
	move.w	#0,d0
	bclr	#5,(disflags).w
	jsr	(setVram).l
	move.w	(VSCRLPM).w,d0
	jsr	(Vmaddr).l
	move.w	#0,(a0)
	move.w	#0,d0
	move.w	d0,(a0)
	jsr	(orjoy).l
	move.w	#1,d4
	move.w	d4,(word_FFB016).w
	movea.l	#BigFontMap+8,a2
	jsr	(DecompressGraphicsWithCallback).l
	dc.b	$04,$F3,$45,$67,$89,$CB,$CA,$9F	;remap table
	bclr	#2,(sflags11).w
	jsr	(printsmallz).l
	String	$FF,$01,$FD,$00,$FC
	moveq	#$28,d0
	moveq	#$1C,d1
	move.w	#$7FF,d2
	jsr	(eraser).l
	jsr	(printz).l
	String	$BF,$00,$00
	movea.l	#unk_1CAEFA,a0
	movea.l	a0,a1
	movea.l	a0,a2
	adda.l	(a2)+,a0
	adda.l	(a2)+,a1
	clr.w	d0
	clr.w	d1
	moveq	#$28,d2
	moveq	#$1C,d3
	moveq	#$F,d5
	jsr	(dobitmap).l
	movea.l	#unk_1CCBA8,a0
	clr.l	d0
	move.b	(dword_FFDD82+2).w,d0
	asl.w	#5,d0
	adda.l	d0,a0
	move.w	#7,d1
	movea.l	#$FFFFBD3E,a1
.0
	move.l	(a0)+,(a1)+
	dbf	d1,.0
	jsr	(printz).l
	String	$AF,$1D,$15
	movea.l	#SmallLogoPtrs,a0
	clr.w	d0
	move.b	(dword_FFDD82+2).w,d0
	asl.w	#2,d0
	movea.l	(a0,d0.w),a0
	movea.l	a0,a1
	movea.l	a0,a2
	adda.l	(a2)+,a0
	adda.l	(a2)+,a1
	clr.w	d0
	clr.w	d1
	moveq	#5,d2
	moveq	#5,d3
	moveq	#0,d5
	jsr	(dobitmap).l
	jsr	(printz).l
	String	$FE,$00,$00
	movea.l	#unk_1C6C4C,a0
	movea.l	a0,a1
	movea.l	a0,a2
	adda.l	(a2)+,a0
	adda.l	(a2)+,a1
	clr.w	d0
	clr.w	d1
	moveq	#$28,d2
	moveq	#$1C,d3
	moveq	#0,d5
	jsr	(dobitmap).l
	jsr	(printz).l
	String	$AF,$14,$16
	movea.l	#$77E,a1
	clr.w	d0
	move.b	(dword_FFDD82+2).w,d0
	asl.w	#2,d0
	movea.l	(a1,d0.w),a1
	adda.w	4(a1),a1
	cmp.w	#0,d0
	bne.w	.1
	movea.l	#unk_1E877A,a1
.1
	move.w	(a1),d0
	subq.w	#2,d0
	asr.w	#1,d0
	sub.w	d0,(printx).w
	move.w	(word_FFB016).w,(word_FFB014).w
	move.l	#BigFontMap,(bigfontptr).w
	jsr	(printbigcur).l
	jsr	(printz).l
	String	$AF,$14,$18
	movea.l	#$77E,a1
	clr.w	d0
	move.b	(dword_FFDD82+2).w,d0
	asl.w	#2,d0
	movea.l	(a1,d0.w),a1
	adda.w	4(a1),a1
	adda.w	(a1),a1
	adda.w	(a1),a1
	cmp.w	#0,d0
	bne.w	.2
	movea.l	#unk_1E8788,a1
.2
	move.w	(a1),d0
	subq.w	#2,d0
	asr.w	#1,d0
	sub.w	d0,(printx).w
	move.w	(word_FFB016).w,(word_FFB014).w
	move.l	#BigFontMap,(bigfontptr).w
	jsr	(printbigcur).l
	move.w	#$18,(palcount).w
	bclr	#2,(disflags).w
	move	#$2500,sr
	move.w	(vcount).w,d0
.loop2
	cmp.w	(vcount).w,d0
	beq.s	.loop2
	jsr	(orjoy).l
	btst	#7,d1
	beq.s	.loop2
	movem.l	(sp)+,d0-d7/a0-a6
.3
	rts

unk_1E877A	;Used from sub_1E8544
	String	'mighty ducks'

unk_1E8788	;Used from sub_1E8544
	String	'of anaheim'

RandomInjuryGames	;setInjuryType in a season: a random games count (SetInjuryGames), not when sflags13 bit 2 is set
	btst	#2,(sflags13).w
	bne.w	.0
	move.w	#$64,d0
	jsr	(randomd0).l
	cmp.w	#$1E,d0
	blt.w	.0
	movem.w	d1,-(sp)
	clr.w	d0
	move.b	#$50,d0
	clr.w	d1
	move.b	(dword_FFDD7E).w,d1
	sub.w	d1,d0
	movem.w	(sp)+,d1
	cmp.w	#2,d0
	blt.w	.0
	subq.w	#1,d0
	cmp.w	#5,d0
	ble.w	.3
	move.w	#5,d0
.3
	jsr	(randomd0).l
	addq.w	#1,d0
	movem.l	d1/d7,-(sp)
	move.w	$28(a0),d7
	move.w	(TempPlOffset).w,d1
	andi.w	#$FF,d1
	bset	#2,(sflags13).w
	jsr	(SetInjuryGames).l
	movem.l	(sp)+,d1/d7
.0
	rts

SetInjuryGames	;Injury games d0 for player d1 of team d7 (save RAM bits); sflags13 bit 3 and injurygames
	movem.l	d0-d7/a0-a7,-(sp)
	bset	#3,(sflags13).w
	move.w	d0,(injurygames).w
	ext.l	d0
	mulu.w	#$51,d7
	mulu.w	#3,d1
	addi.l	#$EDF0,d1
	add.l	d7,d1
	moveq	#3,d2
	jsr	(WriteSRAMBits).l
	bclr	#6,(GameFlags).w
	jsr	(MakeSRAMChecksum).l
	movem.l	(sp)+,d0-d7/a0-a7
	rts

SetSeasonInjuries	;The players of team a2 with injury games left (save RAM bits) are out ($FFFC)
	movem.l	d0-d4/a0/a2,-(sp)
	move.w	$28(a2),d1
	mulu.w	#$51,d1
	addi.l	#$EDF0,d1
	moveq	#3,d2
	adda.w	#$6C,a2
	move.w	#$1A,d3
.0
	jsr	(ReadSRAMBits).l
	tst.w	d0
	beq.w	.1
	move.w	#$FFFC,(a2)
.1
	addq.w	#2,a2
	addq.l	#3,d1
	dbf	d3,.0
	movem.l	(sp)+,d0-d4/a0/a2
	rts

GetInjuryGames	;d0 = the injury games of player d1 of team d7 (save RAM bits)
	;Code the listing does not decode: kept as bytes
	dc.b	$48,$E7,$61,$00,$CE,$FC,$00,$51,$C2,$FC,$00,$03,$06,$81,$00,$00
	dc.b	$ED,$F0,$D2,$87,$74,$03,$4E,$B9,$00,$00,$97,$5A,$4C,$DF,$00,$86
	dc.b	$4E,$75

sub_1E889C	;Called from Opening: a screen
	move	#$2700,sr
	move.w	(VDP_CNTR).l,(seed).w
	move.w	(VDP_CNTR).l,(seed+2).w
	bset	#5,(sflags12).w
	move.l	#unk_12D46,(vbint).w
	bclr	#0,(disflags).w
	bclr	#1,(disflags).w
	move.w	#5,(Map3col1).w
	move.w	#$A000,(VmMap2).w
	move.w	#7,(Map2col1).w
	move.w	#$C000,(VmMap1).w
	move.w	#7,(Map1col1).w
	move.w	#$F000,(VmMap3).w
	move.w	#$F800,(VSPRITES).w
	move.w	#$FC00,(VSCRLPM).w
	move.w	#0,d0
	jsr	(setVram).l
	jsr	(printz).l
	String	$FF,$00,$00
	moveq	#$28,d0
	moveq	#$1C,d1
	move.l	#$7FF,d2
	jsr	(eraser).l
	jsr	(printz).l
	String	$FE,$00,$00
	moveq	#$28,d0
	moveq	#$1C,d1
	move.l	#$7FF,d2
	jsr	(eraser).l
	move.w	#1,d4
	jsr	(printz).l
	String	$FE,$00,$00
	movea.l	#unk_88A18,a0
	movea.l	a0,a1
	movea.l	a0,a2
	adda.l	(a2)+,a0
	adda.l	(a2)+,a1
	clr.w	d0
	clr.w	d1
	move.w	(a1),d2
	move.w	2(a1),d3
	move.w	#$F,d5
	jsr	(dobitmap).l
	move	#$2500,sr
	bclr	#2,(disflags).w
	move.w	#0,-(sp)
	jsr	(song).l
	move.w	#$18,(palcount).w
	move.w	#$384,(carddelay).w
.0
	bsr.w	sub_1E89F0
	subq.w	#1,(carddelay).w
	bmi.w	.1
	jsr	(sub_1B282).l
	btst	#7,d1
	beq.s	.0
.1
	rts

sub_1E89A8	;A vblank handler
	;Code the listing does not decode: kept as bytes
	dc.b	$48,$E7,$FF,$FE,$08,$38,$00,$02,$BF,$B2,$66,$00,$00,$2C,$30,$7C
	dc.b	$B0,$5E,$32,$38,$B0,$00,$30,$3C,$01,$C0,$4E,$B9,$00,$01,$B3,$EC
	dc.b	$20,$7C,$00,$C0,$00,$00,$21,$7C,$40,$00,$00,$10,$00,$04,$30,$B8
	dc.b	$BD,$36,$4E,$B9,$00,$01,$AF,$D6,$52,$78,$B0,$52,$4E,$B9,$00,$02
	dc.b	$44,$86,$4C,$DF,$7F,$FF,$4E,$73

sub_1E89F0	;Wait for the next frame (vcount)
	move.w	(vcount).w,d0
.loop
	cmp.w	(vcount).w,d0
	beq.s	.loop
	rts

sub_1E89FC	;Called from Opening: a screen with text pages (sub_1E8BB8)
	move	#$2700,sr
	move.w	(VDP_CNTR).l,(seed).w
	move.w	(VDP_CNTR).l,(seed+2).w
	bset	#5,(sflags12).w
	move.l	#unk_12D46,(vbint).w
	bclr	#0,(disflags).w
	bclr	#1,(disflags).w
	move.w	#5,(Map3col1).w
	move.w	#$A000,(VmMap2).w
	move.w	#7,(Map2col1).w
	move.w	#$C000,(VmMap1).w
	move.w	#7,(Map1col1).w
	move.w	#$F000,(VmMap3).w
	move.w	#$F800,(VSPRITES).w
	move.w	#$FC00,(VSCRLPM).w
	move.w	#0,d0
	jsr	(setVram).l
	jsr	(printz).l
	String	$FF,$00,$00
	moveq	#$28,d0
	moveq	#$1C,d1
	move.l	#$7FF,d2
	jsr	(eraser).l
	jsr	(printz).l
	String	$FE,$00,$00
	moveq	#$28,d0
	moveq	#$1C,d1
	move.l	#$7FF,d2
	jsr	(eraser).l
	move.w	#1,d4
	move.w	d4,(smallfontchars).w
	movea.l	#RosterFont+8,a2
	jsr	(DecompressGraphicsPlain).l
	move.l	#RosterFont,(smallfontptr).w
	jsr	(printz).l
	String	$FE,$00,$00
	movea.l	#unk_911B8,a0
	movea.l	a0,a1
	movea.l	a0,a2
	adda.l	(a2)+,a0
	adda.l	(a2)+,a1
	clr.w	d0
	clr.w	d1
	move.w	(a1),d2
	move.w	2(a1),d3
	moveq	#$F,d5
	jsr	(dobitmap).l
	jsr	(printz).l
	String	$FF,$01,$0E
	movea.l	#unk_8F2C6,a0
	movea.l	a0,a1
	movea.l	a0,a2
	adda.l	(a2)+,a0
	adda.l	(a2)+,a1
	clr.w	d0
	clr.w	d1
	move.w	(a1),d2
	move.w	2(a1),d3
	moveq	#0,d5
	jsr	(dobitmap).l
	jsr	(printz).l
	String	$FF,$02,$00
	movea.l	#unk_90686,a0
	movea.l	a0,a1
	movea.l	a0,a2
	adda.l	(a2)+,a0
	adda.l	(a2)+,a1
	clr.w	d0
	clr.w	d1
	move.w	(a1),d2
	move.w	2(a1),d3
	moveq	#0,d5
	jsr	(dobitmap).l
	move	#$2500,sr
	bclr	#2,(disflags).w
	move.w	#$18,(palcount).w
	clr.w	(word_FFD030).w
	clr.w	(word_FFD032).w
	move.l	#$5732,(setupvalues).w
	bsr.w	sub_1E8BB8
.0
	bsr.w	sub_1E8C52
	jsr	(sub_1B282).l
	tst.w	(word_FFD030).w
	beq.w	.1
	btst	#7,d1
	bne.w	.5
.1
	addq.w	#1,(word_FFD032).w
	tst.w	(word_FFD030).w
	bne.w	.2
	cmpi.w	#$B4,(word_FFD032).w
	blt.w	.4
	bra.w	.3
.2
	cmpi.w	#$258,(word_FFD032).w
	blt.w	.4
.3
	clr.w	(word_FFD032).w
	addq.w	#1,(word_FFD030).w
	cmpi.w	#5,(word_FFD030).w
	beq.w	.5
	bsr.w	sub_1E8BB8
.4
	bra.s	.0
.5
	rts

sub_1E8BB8	;sub_1E89FC: print the text page at setupvalues
	jsr	(printz).l
	String	$AF,$10,$01
	moveq	#$18,d0
	moveq	#$1B,d1
	move.l	#$7FF,d2
	jsr	(eraser).l
	movea.l	(setupvalues).w,a1
	jsr	(printsmallz).l
	String	$F8,$05,$01,$10,$01
.0
	cmpi.w	#2,(a1)
	beq.w	.1
	jsr	(printsmall).l
	jsr	(printsmallz).l
	String	$FD,$10,$FA,$01
	bra.s	.0
.1
	addq.l	#2,a1
	move.l	a1,(setupvalues).w
	rts

sub_1E8C0A	;A vblank handler
	;Code the listing does not decode: kept as bytes
	dc.b	$48,$E7,$FF,$FE,$08,$38,$00,$02,$BF,$B2,$66,$00,$00,$2C,$30,$7C
	dc.b	$B0,$5E,$32,$38,$B0,$00,$30,$3C,$01,$C0,$4E,$B9,$00,$01,$B3,$EC
	dc.b	$20,$7C,$00,$C0,$00,$00,$21,$7C,$40,$00,$00,$10,$00,$04,$30,$B8
	dc.b	$BD,$36,$4E,$B9,$00,$01,$AF,$D6,$52,$78,$B0,$52,$4E,$B9,$00,$02
	dc.b	$44,$86,$4C,$DF,$7F,$FF,$4E,$73

sub_1E8C52	;Wait for the next frame (vcount)
	move.w	(vcount).w,d0
.loop
	cmp.w	(vcount).w,d0
	beq.s	.loop
	rts

sub_1E8C5E	;Called from Opening2: restart the sound driver, then a screen with sprites (sub_1E8F52)
	movem.l	d0-d7/a0-a6,-(sp)
	jsr	(SoundOff).l	;stop the song
	move.w	#9,d0	;restart the sound driver as Begin does
	jsr	(SoundCmd).l
	move.w	#0,d0	;command 0: load the Z80 program
	move.w	#$1B24,d1
	movea.l	#Z80Program,a0
	jsr	(SoundCmd).l
	move.w	#6,d0
	clr.w	d1
	movea.l	#SoundBanks,a0
	jsr	(SoundCmd).l
	move.w	#7,d0
	move.w	#1,d1
	jsr	(SoundCmd).l
	bsr.w	sub_1E8DE4
	move.w	#$B,-(sp)
	jsr	(sfx).l
	move.w	#1,(padiconchars1).w
	clr.w	(word_FFD030).w
	move.w	(vcount).w,d0
.loop2
	cmp.w	(vcount).w,d0
	beq.s	.loop2
	jsr	(sub_1B282).l
	btst	#7,d1
	bne.w	.3
.0
	btst	#0,(disflags).w
	bne.s	.0
	addq.w	#1,(word_FFD030).w
	cmpi.w	#$A,(word_FFD030).w
	blt.w	.1
	clr.w	(word_FFD030).w
	addq.w	#1,(padiconchars1).w
	cmpi.w	#$22,(padiconchars1).w
	blt.w	.1
	move.w	#$11,(padiconchars1).w
.1
	subq.w	#1,(word_FFD032).w
	bpl.w	.2
	move.w	#$A,d0
	jsr	(randomd0).l
	movea.l	#unk_1E8DD0,a0
	add.w	d0,d0
	move.w	(a0,d0.w),(word_FFD032).w
	move.w	#$B,-(sp)
	jsr	(sfx).l
.2
	addq.w	#1,(padiconchars2).w
	movea.w	#(DMAList-M68K_RAM),a5
	jsr	(updatescroll).l
	jsr	(updatesound).l
	movea.w	#(Satt-M68K_RAM),a6	;sprite attribute table area
	moveq	#1,d6	;link counter
	jsr	(sub_1E8F52).l
	cmpa.w	#$C066,a6	;no sprites: one blank sprite
	bne.w	.n
	clr.l	(a6)+
	clr.l	(a6)+
.n
	clr.b	-5(a6)	;end sprite list
	move.l	a6,d0
	subi.l	#$FFFFC066,d0
	lsr.w	#1,d0	;words
	move.w	d0,(Sattsize).w
	move.l	a5,(DMAlistend).w
	bset	#0,(disflags).w	;dfok
	bra.w	.loop2
.3
	jsr	(forceblack).l
	jsr	(KillCrowd).l
	jsr	(SoundOff).l	;stop the song
	move.w	#9,d0	;restart the sound driver as Begin does
	jsr	(SoundCmd).l
	move.w	#0,d0	;command 0: load the Z80 program
	move.w	#$1B24,d1
	movea.l	#Z80Program,a0
	jsr	(SoundCmd).l
	move.w	#6,d0
	clr.w	d1
	movea.l	#SoundBanks,a0
	jsr	(SoundCmd).l
	move.w	#7,d0
	move.w	#0,d1
	jsr	(SoundCmd).l
	movem.l	(sp)+,d0-d7/a0-a6
	rts

unk_1E8DD0	;Used from sub_1E8C5E
	dc.w	$E6,$E1,$EB,$D7,$DC,$F0,$FA,$D2,$F0,$F0

sub_1E8DE4	;sub_1E8C5E: vram, palettes and the screen
	movem.l	d0-d7/a0-a6,-(sp)
	move.l	#$FFFFFFFF,(padcont).w
	move.l	#$FFFFFFFF,(dword_FFBEB2).w
	move.l	#$FFFFFFFF,(dword_FFBEB6).w
	jsr	(forceblack).l
	clr.w	(Vpos).w
	move.w	#$38,(Hpos).w
	clr.w	(printfontset).w
	move.l	#VBlank,(vbint).w
	bset	#1,(disflags).w
	move.w	#$C000,(VmMap2).w
	move.w	#6,(Map2col1).w
	move.w	#$DC00,(VSPRITES).w
	move.w	#$E000,(VmMap1).w
	move.w	#6,(Map1col1).w
	move.w	#$F000,(VmMap3).w
	move.w	#5,(Map3col1).w
	move.w	#$FC00,(VSCRLPM).w
	movea.w	#(palfadenew-M68K_RAM),a0
	moveq	#$1F,d1
.clrpal
	clr.l	(a0)+
	dbf	d1,.clrpal
	clr.w	d1
	move.b	(dword_FFDD82+2).w,d1
	asl.w	#2,d1
	movea.l	#$77E,a2
	movea.l	(a2,d1.w),a2
	clr.w	d1
	adda.w	2(a2),a2	;Palettedata
	adda.w	d1,a2
	movea.w	#(unk_FFBD7E-M68K_RAM),a1
	adda.w	d1,a1
	moveq	#7,d0
.loop
	move.l	(a2)+,(a1)+
	dbf	d0,.loop
	jsr	(setupIceRinkPal).l
	jsr	(setVram_0).l
	move.w	#$800,d0
	move.w	(VmMap1).w,d1
	move.w	#$7FF,d2
	jsr	(DoFill).l
	clr.w	d4
	move.w	d4,(word_FFB022).w
	movea.l	#Rinktilelist+8,a2
	jsr	(DecompressGraphicsPlain).l
	move.w	d4,(animchars).w
	move.w	(animchars).w,d4
	movea.l	#unk_1CCEE8+8,a2
	jsr	(DecompressGraphicsPlain).l
	move.w	d4,(ExtraChars).w
	move.w	(ExtraChars).w,d4
	movea.l	#unk_1D5420+8,a2
	jsr	(DecompressGraphicsPlain).l
	move.w	(disflags).w,-(sp)
	bset	#2,(disflags).w
	move.w	#$7D0,(Oldrow).w
	move.w	(sp)+,(disflags).w
	bclr	#0,(disflags).w
	bclr	#2,(disflags).w
	move	#$2300,sr
	move.w	(vcount).w,d0
.loop2
	cmp.w	(vcount).w,d0
	beq.s	.loop2
	jsr	(printz).l
	String	$FF,$06,$0C
	move.w	(ExtraChars).w,d4
	movea.l	#unk_1D5420,a0
	movea.l	a0,a1
	movea.l	a0,a2
	adda.l	(a2)+,a0
	adda.l	(a2)+,a1
	clr.w	d0
	clr.w	d1
	moveq	#$16,d2
	moveq	#4,d3
	moveq	#8,d5
	bset	#0,(sflags6).w
	jsr	(dobitmap).l
	bclr	#0,(sflags6).w
	move.w	#$18,(palcount).w
	movem.l	(sp)+,d0-d7/a0-a6
	rts

sub_1E8F52	;sub_1E8C5E: the sprites
	movea.l	#unk_1CCEE8,a1
	adda.l	4(a1),a1
	move.w	(Hpos).w,d4
	move.w	(Vpos).w,d5
	move.b	(padiconchars1+1).w,d0
	bra.w	*+4
.0
	ext.w	d0
	beq.w	.1
	cmp.w	#$40,d6
	bge.w	.1
	movem.l	d0-d5,-(sp)
	add.w	d0,d0
	movea.l	a1,a0
	move.w	2(a0,d0.w),d1
	sub.w	(a0,d0.w),d1
	lsr.w	#3,d1
	subq.w	#1,d1
	move.w	d1,-(sp)
	adda.w	(a0,d0.w),a0
	move.w	d4,d0
	addi.w	#$C0,d0
	move.w	d0,d1
	subi.w	#$90,d0
	addi.w	#$80,d1
	move.w	#$170,d2
	sub.w	d5,d2
	move.w	d2,d3
	subi.w	#$80,d2
	addi.w	#$70,d3
	move.w	(sp)+,d4
.loop2
	cmp.w	(a0),d2
	bgt.w	.next
	cmp.w	(a0),d3
	blt.w	.next
	cmp.w	6(a0),d0
	bgt.w	.next
	cmp.w	6(a0),d1
	blt.w	.next
	move.w	(a0),d5
	addi.w	#$70,d5
	sub.w	d2,d5
	move.w	d5,(a6)+
	move.b	2(a0),(a6)+
	andi.b	#$F,-1(a6)
	move.b	d6,(a6)+
	move.b	4(a0),d5
	andi.w	#$F8,d5
	lsl.w	#8,d5
	move.w	d5,-(sp)
	move.w	4(a0),d5
	andi.w	#$7FF,d5
	add.w	(animchars).w,d5
	or.w	(sp)+,d5
	move.w	d5,(a6)+
	move.w	6(a0),d5
	addi.w	#$70,d5
	sub.w	d0,d5
	move.w	d5,(a6)+
	addq.w	#1,d6
	cmp.w	#$40,d6
	beq.w	.x
.next
	addq.w	#8,a0
	dbf	d4,.loop2
.x
	movem.l	(sp)+,d0-d5
.1
	rts
	dc.b	$FF,$FF

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
