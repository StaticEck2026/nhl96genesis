;	The season playoff stats screen helpers (SeasonPlayoffStats in code96_15: PStats...) and the playoff menu
;	screen (PlayoffMenuScreen, ClearPlayoffSave).

WaitAnyPad	;Wait for a press on pad 1 or 2 (3 and 4 with FourWayPlay); d1 = the buttons
	move.l	#$5460,d6
.wait
	move.w	#$64,d6
	move.w	(vcount).w,d1
	sub.w	(oldvcount).w,d1
	beq.s	.wait
	jsr	(sub_12640).l
	move.w	(vcount).w,(oldvcount).w
	jsr	(ReadJoy1).l
	jsr	(ProcessInputWithRepeat).l
	tst.w	d1
	beq.w	.1
	bra.w	.exit
.1
	jsr	(ReadJoy2).l
	jsr	(ProcessInputWithRepeat).l
	tst.w	d1
	beq.w	.2
	bra.w	.exit
.2
	tst.w	(FourWayPlay).w
	beq.w	.4
	jsr	(ReadJoy3).l
	jsr	(ProcessInputWithRepeat).l
	tst.w	d1
	beq.w	.3
	bra.w	.exit
.3
	jsr	(ReadJoy4).l
	jsr	(ProcessInputWithRepeat).l
	tst.w	d1
	beq.w	.4
	bra.w	.exit
.4
	dbf	d6,.wait
.exit
	rts

PStatsArrows	;SeasonPlayoffStats: the scroll marks { (word_FFBF58 above 0) and } (more rows below)
	movem.l	d0-d7/a0-a6,-(sp)
	tst.w	(word_FFBF58).w
	beq.w	.0
	jsr	(printcurz).l
	String	$8F,$02,$0B,$7B
	bra.w	.1
.0
	jsr	(printcurz).l
	String	$8F,$02,$0B,$20
.1
	move.w	(word_FFBF5A).w,d1
	cmp.w	(word_FFBF5E).w,d1
	bge.w	.2
	jsr	(printcurz).l
	String	$8F,$02,$17,$7D
	bra.w	.3
.2
	jsr	(printcurz).l
	String	$8F,$02,$17,$20
.3
	movem.l	(sp)+,d0-d7/a0-a6
	rts

PStatsClearList	;SeasonPlayoffStats: erase the list area
	movem.l	d0-d7/a0-a6,-(sp)
	move.w	#$24,d0
	move.w	#$D,d1
	move.w	#$7FF,d2
	ori.w	#$8000,d2
	jsr	(printz).l
	String	$BF,$02,$0B
	jsr	(eraser).l
	movem.l	(sp)+,d0-d7/a0-a6
	rts

PStatsSetup	;SeasonPlayoffStats: vram, fonts and the screen bitmaps, the heading, the team block and the help
	bset	#5,(sflags12).w
	move.l	#unk_12D46,(vbint).w
	bclr	#0,(disflags).w
	bset	#2,(disflags).w
	bclr	#1,(disflags).w
	move.w	#0,(VSCRLPM).w
	move.w	#$B400,(VSPRITES).w
	move.w	#$B800,(VmMap3).w
	move.w	#5,(Map3col1).w
	move.w	#$C000,(VmMap2).w
	move.w	#6,(Map2col1).w
	move.w	#$E000,(VmMap1).w
	move.w	#6,(Map1col1).w
	move.w	#0,d0
	bset	#5,(disflags).w
	jsr	(setVram).l
	bclr	#5,(disflags).w
	jsr	(orjoy).l
	move.w	#1,d4
	movea.l	#unk_18B4F8,a1
	jsr	(sub_1217A).l
	move.w	d4,(smallfontchars).w
	movea.l	#RosterFont+8,a2
	jsr	(DecompressGraphicsPlain).l
	move.w	d4,(word_FFB01E).w
	movea.l	#SmallFontMap2+8,a2
	jsr	(DecompressGraphicsPlain).l
	move.l	#RosterFont,(smallfontptr).w
	move.w	d4,(BigFontChars).w
	movea.l	#BigFontMap4+8,a2
	jsr	(DecompressGraphicsPlain).l
	bset	#2,(sflags11).w
	move.w	d4,(word_FF2712).l
	addi.w	#$20,d4
	jsr	(printsmallz).l
	String	$FF,$01,$FD,$00,$FC
	moveq	#$28,d0
	moveq	#$1C,d1
	move.w	#$7FF,d2
	jsr	(eraser).l
	jsr	(printz).l
	String	$BF,$00,$00
	movea.l	#unk_18948A,a0
	movea.l	a0,a1
	movea.l	a0,a2
	adda.l	(a2)+,a0
	adda.l	(a2)+,a1
	clr.w	d0
	clr.w	d1
	moveq	#$28,d2
	moveq	#$1C,d3
	moveq	#8,d5
	jsr	(dobitmap).l
	jsr	(printz).l
	String	$BF,$0B,$01
	movea.l	#unk_18ACD8,a0
	btst	#2,(dword_FFDD7E+2).w
	beq.w	.0
	jsr	(printz).l
	String	$BF,$0B,$01
	movea.l	#unk_18B916,a0
.0
	movea.l	a0,a1
	movea.l	a0,a2
	adda.l	(a2)+,a0
	adda.l	(a2)+,a1
	clr.w	d0
	clr.w	d1
	move.w	(a1),d2
	move.w	2(a1),d3
	moveq	#8,d5
	jsr	(dobitmap).l
	bsr.w	PStatsHelp
	jsr	(printz).l
	String	$FE,$00,$00
	movea.l	#unk_170B0C,a0
	movea.l	a0,a1
	movea.l	a0,a2
	adda.l	(a2)+,a0
	adda.l	(a2)+,a1
	clr.w	d0
	clr.w	d1
	moveq	#$40,d2
	moveq	#$1C,d3
	moveq	#1,d5
	jsr	(dobitmap).l
	bsr.w	PStatsHeading
	bsr.w	PStatsCategory
	bsr.w	PStatsTeamBlock
	bsr.w	PStatsPalette
	move	#$2500,sr
	rts

PStatsTeamBlock	;SeasonPlayoffStats: the team block of the shown team (DrawSetupTeamBlock)
	move.w	d7,-(sp)
	jsr	(printz).l
	String	$BF,$01,$05
	move.w	(word_FF2712).l,d4
	move.w	(word_FF2720).l,d7
	btst	#2,(dword_FFDD7E+2).w
	beq.w	.0
	jsr	(GetPOSlotTeam).l
.0
	jsr	(DrawSetupTeamBlock).l
	move.w	(sp)+,d7

PStatsHeading	;SeasonPlayoffStats: the column heading, players or goalies (word_FFBF56 4 and up)
	cmpi.w	#4,(word_FFBF56).w
	bge.w	.0
	jsr	(printbigz).l
	String	$F8,$04,$01,$04,$08,'#  PLAYER         g   a   p   pim'
	bra.w	.1
.0
	jsr	(printbigz).l
	String	$F8,$04,$01,$04,$08,'#  GOALIE        s     sh    sp  '
.1
	rts

PStatsHelp	;SeasonPlayoffStats: the button help lines
	cmpi.w	#4,(word_FFBF56).w
	bge.w	.1
	move.w	(smallfontchars).w,-(sp)
	move.w	(word_FFB01E).w,(smallfontchars).w
	jsr	(printcurz).l
	String	$8F,$04,$19,'{}-SCROLL LIST   A/C-TEAMS',$8F,$04,$1A,'[]-CATEGORY      B-GOALIES'
	move.w	(sp)+,(smallfontchars).w
	bra.w	.0
.1
	move.w	(smallfontchars).w,-(sp)
	move.w	(word_FFB01E).w,(smallfontchars).w
	jsr	(printcurz).l
	String	$8F,$04,$19,'{}-SCROLL LIST   A/C-TEAMS',$8F,$04,$1A,'[]-CATEGORY      B-PLAYERS'
	move.w	(sp)+,(smallfontchars).w
.0
	rts

PStatsCategory	;SeasonPlayoffStats: the name of category word_FFBF56 (PStatsCategoryTxt)
	jsr	(printz).l
	String	$BF,$15,$05
	movea.l	#PStatsCategoryTxt,a1
	move.w	(word_FFBF56).w,d0
	jsr	(SkipStrings).l
	jsr	(printbig).l
	rts

PStatsCategoryTxt	;PStatsCategory: the category names
	dc.b	$00,$12,$20,$20,$20,$20,$20,$67,$6F,$61,$6C,$73,$20,$20,$20,$20
	dc.b	$20,$00,$00,$12,$20,$20,$20,$20,$61,$73,$73,$69,$73,$74,$73,$20
	dc.b	$20,$20,$20,$00,$00,$12,$20,$20,$20,$20,$20,$70,$6F,$69,$6E,$74
	dc.b	$73,$20,$20,$20,$20,$00,$00,$12,$70,$65,$6E,$61,$6C,$74,$79,$20
	dc.b	$6D,$69,$6E,$75,$74,$65,$73,$00,$00,$12,$20,$20,$20,$20,$20,$73
	dc.b	$61,$76,$65,$73,$20,$20,$20,$20,$20,$00,$00,$12,$20,$20,$20,$20
	dc.b	$20,$73,$68,$6F,$74,$73,$20,$20,$20,$20,$20,$00,$00,$12,$73,$61
	dc.b	$76,$65,$20,$70,$65,$72,$63,$65,$6E,$74,$61,$67,$65,$00

PStatsBuildList	;SeasonPlayoffStats: the player or goalie list of the shown team, sorted by category
	movem.l	d0-d7/a0-a6,-(sp)
	move.w	(word_FF2720).l,d7
	btst	#2,(dword_FFDD7E+2).w
	beq.w	.0
	jsr	(GetPOSlotTeam).l
.0
	cmpi.w	#4,(word_FFBF56).w
	bge.w	.9
	jsr	(GetPlayerCountD7).l
	move.w	d0,-(sp)
	jsr	(GetGoalieCountD7).l
	move.w	d0,d1
	sub.w	(sp)+,d0
	neg.w	d0
	move.w	d0,(word_FF2714).l
	movea.l	#$FFFF1388,a0
	bra.w	.2
.1
	move.w	d1,(a0)+
	addq.w	#1,d1
.2
	dbf	d0,.1
	btst	#2,(dword_FFDD7E+2).w
	beq.w	.3
	jsr	(GetTeamPOSlot).l
.3
	move.w	(word_FF2714).l,d3
	movea.l	#$FFFF193A,a0
	move.l	#$268,d1
	moveq	#$C,d2
	move.l	#$120,d4
	btst	#2,(dword_FFDD7E+2).w
	beq.w	.4
	move.l	#$448,d1
	moveq	#$A,d2
	move.l	#$F0,d4
.4
	jsr	(sub_10F02).l
	movea.l	#$FFFF1A02,a0
	move.l	#$1FA8,d1
	moveq	#$C,d2
	move.w	(word_FF2714).l,d3
	move.l	#$120,d4
	btst	#2,(dword_FFDD7E+2).w
	beq.w	.5
	move.l	#$1348,d1
	moveq	#$A,d2
	move.l	#$F0,d4
.5
	jsr	(sub_10F02).l
	movea.l	#$FFFF193A,a1
	movea.l	#$FFFF1A02,a2
	movea.l	#$FFFF1ACA,a0
	move.w	(word_FF2714).l,d3
	bra.w	.7
.6
	move.w	(a1)+,d0
	add.w	(a2)+,d0
	move.w	d0,(a0)+
.7
	dbf	d3,.6
	movea.l	#$FFFF1B92,a0
	move.l	#$3CE8,d1
	moveq	#$A,d2
	move.w	(word_FF2714).l,d3
	move.l	#$F0,d4
	btst	#2,(dword_FFDD7E+2).w
	beq.w	.8
	move.l	#$2248,d1
	moveq	#9,d2
	move.l	#$D8,d4
.8
	jsr	(sub_10F02).l
	bra.w	.18
.9
	jsr	(GetGoalieCountD7).l
	move.w	d0,(word_FF2714).l
	movea.l	#$FFFF1388,a0
	clr.w	d1
	bra.w	.11
.10
	move.w	d1,(a0)+
	addq.w	#1,d1
.11
	dbf	d0,.10
	btst	#2,(dword_FFDD7E+2).w
	beq.w	.12
	jsr	(GetTeamPOSlot).l
.12
	movea.l	#$FFFF1C5A,a0
	move.w	(word_FF2714).l,d3
	move.l	#$598C,d1
	moveq	#$E,d2
	moveq	#$2A,d4
	btst	#2,(dword_FFDD7E+2).w
	beq.w	.13
	move.l	#$3268,d1
	moveq	#$E,d2
	moveq	#$2A,d4
.13
	jsr	(sub_10F02).l
	movea.l	#$FFFF1D22,a0
	move.l	#$5548,d1
	moveq	#$E,d2
	move.w	(word_FF2714).l,d3
	moveq	#$2A,d4
	btst	#2,(dword_FFDD7E+2).w
	beq.w	.14
	move.l	#$2FC8,d1
	moveq	#$E,d2
	moveq	#$2A,d4
.14
	jsr	(sub_10F02).l
	movea.l	#$FFFF1C5A,a0
	movea.l	#$FFFF1D22,a1
	movea.l	#$FFFF1DEA,a2
	move.w	(word_FF2714).l,d3
	bra.w	.17
.15
	move.w	(a1)+,d0
	sub.w	(a0),d0
	move.w	d0,(a0)+
	move.w	-2(a1),d1
	beq.w	.16
	mulu.w	#$64,d0
	divu.w	d1,d0
.16
	move.w	d0,(a2)+
.17
	dbf	d3,.15
.18
	movea.l	#PStatsColumns,a0
	move.w	(word_FFBF56).w,d0
	asl.w	#2,d0
	movea.l	(a0,d0.w),a0
	movea.l	#$FFFF1388,a1
	move.w	(a1),d0
	add.w	d0,d0
	suba.w	d0,a0
.19
	clr.w	(TempWord1).w
	clr.w	d0
	move.w	(word_FF2714).l,d5
	subq.w	#2,d5
.20
	move.w	d0,d1
	add.w	d1,d1
	move.w	(a1,d1.w),d2
	move.w	2(a1,d1.w),d3
	add.w	d2,d2
	add.w	d3,d3
	move.w	(a0,d2.w),d4
	cmp.w	(a0,d3.w),d4
	bge.w	.21
	st	(TempWord1).w
	move.w	(a1,d1.w),d2
	move.w	2(a1,d1.w),d3
	move.w	d2,2(a1,d1.w)
	move.w	d3,(a1,d1.w)
.21
	addq.w	#1,d0
	dbf	d5,.20
	tst.w	(TempWord1).w
	bne.s	.19
	movem.l	(sp)+,d0-d7/a0-a6
	rts

PStatsColumns	;PStatsPrintValue: the stat offsets of each category
	dc.b	$FF,$FF,$19,$3A,$FF,$FF,$1A,$02,$FF,$FF,$1A,$CA,$FF,$FF,$1B,$92
	dc.b	$FF,$FF,$1C,$5A,$FF,$FF,$1D,$22,$FF,$FF,$1D,$EA

PStatsPrintList	;SeasonPlayoffStats: print the rows of the list
	movem.l	d0-d7/a0-a6,-(sp)
	jsr	(printz).l
	String	$8F,$00,$00
	clr.w	d6
	move.w	#$B,(printy).w
.0
	clr.w	(word_FF1EB2).l
	cmpi.w	#4,(word_FFBF56).w
	blt.w	.1
	move.w	#4,(word_FF1EB2).l
.1
	movea.l	#PStatsColumns,a5
	move.w	(word_FF1EB2).l,d0
	asl.w	#2,d0
	movea.l	(a5,d0.w),a5
	move.w	#4,(printx).w
	movea.l	#unk_1DAE32,a1
	jsr	(printcur).l
	move.w	d6,d0
	add.w	(word_FFBF58).w,d0
	cmp.w	(word_FF2714).l,d0
	blt.w	.2
	move.w	d6,d0
	add.w	(word_FFBF58).w,d0
	cmp.w	(word_FFBF5E).w,d0
	bge.w	.11
	move.w	d0,(word_FFBF5E).w
	bra.w	.11
.2
	move.w	#4,(printx).w
	movea.l	#$FFFF1388,a0
	move.w	d6,d0
	add.w	(word_FFBF58).w,d0
	add.w	d0,d0
	move.w	(a0,d0.w),d0
	ext.l	d0
	move.w	d0,-(sp)
	move.w	(word_FF2720).l,d7
	btst	#2,(dword_FFDD7E+2).w
	beq.w	.3
	jsr	(GetPOSlotTeam).l
.3
	jsr	(FormatPlayerNameD7).l
	jsr	(printcur).l
	cmpi.w	#4,(word_FFBF56).w
	bge.w	.5
	move.w	(word_FF2720).l,d7
	btst	#2,(dword_FFDD7E+2).w
	beq.w	.4
	jsr	(GetPOSlotTeam).l
.4
	jsr	(GetGoalieCountD7).l
	sub.w	d0,(sp)
.5
	move.w	#$15,(printx).w
	cmpi.w	#4,(word_FFBF56).w
	blt.w	.6
	move.w	#$14,(printx).w
.6
	move.w	(sp),d0
	bsr.w	PStatsPrintValue
	beq.w	.10
	move.w	#$19,(printx).w
	cmpi.w	#4,(word_FFBF56).w
	blt.w	.7
	move.w	#$1A,(printx).w
.7
	move.w	(sp),d0
	bsr.w	PStatsPrintValue
	beq.w	.10
	move.w	#$1D,(printx).w
	cmpi.w	#4,(word_FFBF56).w
	blt.w	.8
	move.w	#$20,(printx).w
.8
	move.w	(sp),d0
	bsr.w	PStatsPrintValue
	beq.w	.10
	move.w	#$21,(printx).w
	cmpi.w	#4,(word_FFBF56).w
	blt.w	.9
	move.w	#0,(printx).w
.9
	move.w	(sp),d0
	bsr.w	PStatsPrintValue
.10
	tst.w	(sp)+
.11
	addq.w	#1,(printy).w
	addq.w	#1,d6
	cmp.w	(word_FFBF5C).w,d6
	blt.w	.0
	movem.l	(sp)+,d0-d7/a0-a6
	rts

PStatsPrintValue	;SeasonPlayoffStats: print stat column word_FF1EB2 of player d0
	move.w	d0,-(sp)
	move.w	(word_FF1EB2).l,d0
	asl.w	#2,d0
	movea.l	#PStatsColumns,a0
	movea.l	(a0,d0.w),a0
	move.w	(sp)+,d0
	add.w	d0,d0
	move.w	(a0,d0.w),d0
	move.w	#3,d1
	cmpi.w	#4,(word_FF1EB2).l
	blt.w	.0
	cmpi.w	#6,(word_FF1EB2).l
	beq.w	.0
	move.w	#4,d1
.0
	jsr	(PushNumberWidth).l
	bsr.w	PStatsMark
	addq.w	#1,(word_FF1EB2).l
	cmpi.w	#4,(word_FF1EB2).l
	beq.w	.1
	cmpi.w	#7,(word_FF1EB2).l
.1
	rts

PStatsMark	;SeasonPlayoffStats: print a value, highlighted in the column of the category
	move.w	(printa).w,-(sp)
	move.w	(word_FFBF56).w,d0
	cmp.w	(word_FF1EB2).l,d0
	bne.w	.0
	jsr	(printsmallz).l
	String	$FE,$05
.0
	jsr	(printcur).l
	move.w	(sp)+,(printa).w
	rts

PStatsPalette	;The palette of unk_17C2AE to palfadenew+$20
	movem.l	a0-a1,-(sp)
	movea.l	#unk_17C2AE,a0
	movea.l	#palfadenew+$20,a1
	move.w	#7,d0
.pal
	move.l	(a0)+,(a1)+
	dbf	d0,.pal
	movem.l	(sp)+,a0-a1
	rts

PlayoffMenuScreen	;The playoff menu screen: the playoff tree from save RAM (ReadPassData, ReadPassBits, maketree), then the
	;menu loop of unk_1DC03C; item 0 can clear the saved playoffs (ClearPlayoffSave)
	movem.l	d0-d7/a0-a6,-(sp)
	move.w	#$FFFF,(word_FFDDBE).w
	move.w	(GameFlags).w,-(sp)
	bclr	#7,(GameFlags).w
	jsr	(ReadPassData).l
	move.w	(sp)+,(GameFlags).w
	movea.l	#pwddatabuffer,a3
	jsr	(ReadPassBits).l
	move.w	(gamelevel).w,d0
	or.w	(bosgames).w,d0
	beq.w	.0
	move.w	(GameFlags).w,-(sp)
	bclr	#7,(GameFlags).w
	jsr	(maketree).l
	move.w	(sp)+,(GameFlags).w
	movea.l	#potree,a0
	move.w	(potreeteam).w,d2
	move.b	(a0,d2.w),d2
	clr.w	(word_FFDDBE).w
	move.b	d2,(word_FFDDBE+1).w
.0
	clr.w	(carddelay).w
	bsr.w	PlayoffMenuInit
	bsr.w	PlayoffMenuSetup
	movea.l	#unk_190380,a0
	jsr	(sub_1218A).l
	jsr	(PStatsPalette).l
	move.w	#$18,(palcount).w
	bclr	#2,(disflags).w
.draw
	bsr.w	PlayoffMenuDraw
.frame
	move.w	(vcount).w,d0
.loop2
	cmp.w	(vcount).w,d0
	beq.s	.loop2
	jsr	(sub_12640).l
	cmpi.w	#$5460,(carddelay).w
	jsr	(sub_1B282).l
	jsr	(ProcessInputWithRepeat).l
	tst.w	d1
	beq.w	.1
	clr.w	(carddelay).w
.1
	btst	#7,d1
	bne.w	.3
	btst	#5,d1
	bne.w	.3
	btst	#1,d1
	beq.w	.9
	cmpi.w	#6,(menuitem).w
	beq.s	.frame
	addq.w	#1,(menuitem).w
	bra.s	.draw
.9
	btst	#0,d1
	beq.w	.2
	tst.w	(menuitem).w
	beq.s	.frame
	subq.w	#1,(menuitem).w
	bra.s	.draw
.2
	bra.s	.draw
.3
	cmpi.l	#unk_1DC03C,(menulist).l
	beq.w	.5
	tst.w	(menuitem).w
	bne.w	.4
	bsr.w	ClearPlayoffSave
.4
	move.l	#$772,(dword_FFDDAC).w
	move.l	#unk_1DC03C,(menulist).l
	clr.w	(menuitem).w
	clr.w	(word_FFD000).w
	move.w	#6,(word_FFD00A).w
	move.w	#$D,(word_FFB03C).w
	move.w	#6,(word_FFB03E).w
	jsr	(printsmallz).l
	String	$FF,$01,$FD,$0C,$FC,$0B
	move.w	#$11,d0
	move.w	#$D,d1
	move.w	#$7FF,d2
	jsr	(eraser).l
	bsr.w	PlayoffMenuInit
	bra.w	.draw
.5
	movea.l	#PlayoffMenuRoutines,a0
	move.w	(menuitem).w,d0
	asl.w	#2,d0
	move.l	(a0,d0.w),(dword_FFDDAC).w
	cmpi.l	#unk_122A4,(dword_FFDDAC).w
	beq.w	.7
	cmpi.l	#ClearPlayoffSave,(dword_FFDDAC).l
	bne.w	.6
	move.l	#unk_1DC10E,(menulist).l
	clr.w	(menuitem).w
	clr.w	(word_FFD000).w
	move.w	#2,(word_FFD00A).w
	move.w	#$12,(word_FFB03C).w
	move.w	#$F,(word_FFB03E).w
	jsr	(printsmallz).l
	String	$FF,$01,$FD,$0C,$FC,$0B
	move.w	#$11,d0
	move.w	#$D,d1
	move.w	#$7FF,d2
	jsr	(eraser).l
	jsr	(printsmallz).l
	String	$FE,$07,$F9,$00,$FD,$0E,$FC,$0B,'Reset Rosters'
	bra.w	.draw
.6
	cmpi.l	#$772,(dword_FFDDAC).w
	beq.w	.draw
	movea.l	(dword_FFDDAC).w,a0
	bset	#6,(sflags11).w
	jsr	(a0)
	bclr	#6,(sflags11).w
	bra.w	.0
.7
	movem.l	(sp)+,d0-d7/a0-a6
	rts

PlayoffMenuRoutines	;PlayoffMenuScreen: the routine of each menu item
	dc.b	$00,$1D,$C1,$58,$00,$1D,$C1,$40,$00,$1D,$C1,$48,$00,$1D,$C1,$50
	dc.b	$00,$1D,$BF,$8A,$00,$1E,$2E,$FC,$00,$01,$22,$A4

PlayoffMenuDraw	;PlayoffMenuScreen: draw the menu (PrintMenuList2)
	movem.l	d0-d7/a0-a6,-(sp)
	jsr	(printz).l
	String	$8F,$00,$00
	jsr	(PrintMenuList2).l
	movem.l	(sp)+,d0-d7/a0-a6
	rts

PlayoffMenuInit	;PlayoffMenuScreen: menulist = unk_1DC03C, item 0
	move.l	#unk_1DC03C,(menulist).l
.0
	clr.w	(menuitem).w
	clr.w	(word_FFD000).w
	move.w	#7,(word_FFD00A).w
	move.w	#$D,(word_FFB03C).w
	move.w	#$B,(word_FFB03E).w
	rts

PlayoffMenuSetup	;PlayoffMenuScreen: vram and the screen bitmaps
	bset	#5,(sflags12).w
	move.l	#unk_12D46,(vbint).w
	bclr	#0,(disflags).w
	bset	#2,(disflags).w
	bclr	#1,(disflags).w
	move.w	#0,(VSCRLPM).w
	move.w	#$B400,(VSPRITES).w
	move.w	#$B800,(VmMap3).w
	move.w	#5,(Map3col1).w
	move.w	#$C000,(VmMap2).w
	move.w	#6,(Map2col1).w
	move.w	#$E000,(VmMap1).w
	move.w	#6,(Map1col1).w
	move.w	#0,d0
	bset	#5,(disflags).w
	jsr	(setVram).l
	bclr	#5,(disflags).w
	jsr	(orjoy).l
	move.w	#1,d4
	movea.l	#unk_190380,a1
	jsr	(sub_1217A).l
	move.w	d4,(smallfontchars).w
	movea.l	#RosterFont+8,a2
	jsr	(DecompressGraphicsPlain).l
	move.w	d4,(word_FFB01E).w
	movea.l	#SmallFontMap2+8,a2
	jsr	(DecompressGraphicsPlain).l
	move.l	#RosterFont,(smallfontptr).w
	move.w	d4,(word_FFB014).w
	movea.l	#BigFontMap2+8,a2
	jsr	(DecompressGraphicsPlain).l
	bclr	#2,(sflags11).w
	jsr	(printsmallz).l
	String	$FF,$01,$FD,$00,$FC
	moveq	#$28,d0
	moveq	#$1C,d1
	move.w	#$7FF,d2
	jsr	(eraser).l
	jsr	(printz).l
	String	$BF,$00,$00
	movea.l	#unk_18E932,a0
	movea.l	a0,a1
	movea.l	a0,a2
	adda.l	(a2)+,a0
	adda.l	(a2)+,a1
	clr.w	d0
	clr.w	d1
	moveq	#$28,d2
	moveq	#$1C,d3
	moveq	#$C,d5
	jsr	(dobitmap).l
	jsr	(printz).l
	String	$BF,$0B,$01
	movea.l	#unk_18E152,a0
	movea.l	a0,a1
	movea.l	a0,a2
	adda.l	(a2)+,a0
	adda.l	(a2)+,a1
	clr.w	d0
	clr.w	d1
	move.w	(a1),d2
	move.w	2(a1),d3
	moveq	#8,d5
	jsr	(dobitmap).l
	jsr	(printz).l
	String	$FE,$00,$00
	movea.l	#ControllerBgMap,a0
	movea.l	a0,a1
	movea.l	a0,a2
	adda.l	(a2)+,a0
	adda.l	(a2)+,a1
	clr.w	d0
	clr.w	d1
	moveq	#$40,d2
	moveq	#$1C,d3
	moveq	#1,d5
	jsr	(dobitmap).l
	move	#$2500,sr
	rts

ClearPlayoffSave	;Clear the saved playoffs in save RAM ($E68 and $DB4)
	bset	#6,(GameFlags).w
	move.l	#$E68,d0
	moveq	#$66,d1
	jsr	(ClearSRAMBytes).l
	move.l	#$DB4,d0
	moveq	#$32,d1
	jsr	(ClearSRAMBytes).l
	movem.l	d0/a0,-(sp)
	move.w	#$13,d0
	movea.l	#$201B68,a0
.0
	move.b	#$80,1(a0)
	addq.w	#4,a0
	dbf	d0,.0
	movem.l	(sp)+,d0/a0
	movem.l	a0-a2,-(sp)
	movea.l	#$201B68,a1
	clr.w	d1
	clr.w	d0
	move.b	($202A9D).l,d0
	bra.w	.2
.1
	move.b	d1,3(a1)
	move.b	#$1E,1(a1)
	addq.b	#1,($201BB9).l
	addq.l	#4,a1
	addq.w	#1,d1
.2
	dbf	d0,.1
	move.b	#$80,1(a1)
	move.b	#0,3(a1)
	movem.l	(sp)+,a0-a2
	jsr	(DefaultRosters).l
	move.l	#$1550,d0
	move.l	#$86E,d1
	movea.l	#$FFFF1550,a0
	jsr	(WriteSRAM).l
	jsr	(sub_11582).l
	bclr	#6,(GameFlags).w
	jsr	(MakeSRAMChecksum).l
	rts
