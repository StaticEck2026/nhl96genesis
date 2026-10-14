;	The demo, the pause menu, and the roster columns. demoread reads a pad during a demo.
;	Pausemode runs the pause menu. GetNameandAttrib prints a player's attribute columns.

demoread	;In a demo (no pad on a team): start on a pad starts the pause, any other button ends the demo
	tst.w	(cont1team).w
	bne.w	rtsdemo
	tst.w	(cont2team).w
	bne.w	rtsdemo
	tst.w	(cont3team).w
	bne.w	rtsdemo
	tst.w	(cont4team).w
	bne.w	rtsdemo
	jsr	(ReadJoy1).l
	btst	#7,d1
	beq.w	.0
	jmp	startpause1
.0
	bsr.w	EndDemoOnPress
	jsr	(ReadJoy2).l
	btst	#7,d1
	beq.w	.1
	jmp	startpause2
.1
	tst.w	(FourWayPlay).w
	beq.w	EndDemoOnPress
	jsr	(ReadJoy3).l
	btst	#7,d1
	beq.w	.2
	jmp	startpause3
.2
	bsr.w	EndDemoOnPress
	jsr	(ReadJoy4).l
	btst	#7,d1
	beq.w	EndDemoOnPress
	jmp	startpause4

EndDemoOnPress	;A button d1 ends the demo: demoflag, then back to the title (ExitToOpening)
	tst.w	d1
	beq.w	rtsdemo
	st	(demoflag).w
	move.w	#$64,(setuphome).w
	move.w	#$64,(setupvis).w
	jmp	ExitToOpening

rtsdemo
	rts

startpause	;Pause on (sfpz)
	bset	#0,(sflags).w
	rts

startpause1	;Pause initiated by cont 1
	clr.w	(menupadnum).w
	bra.s	startpause

startpause2	;Pause initiated by cont 2
	move.w	#1,(menupadnum).w
	bra.s	startpause

startpause3	;Pause initiated by cont 3 (4 way play)
	move.w	#2,(menupadnum).w
	bra.s	startpause

startpause4	;Pause initiated by cont 4 (4 way play)
	move.w	#3,(menupadnum).w
	bra.s	startpause

Pausemode	;Game is in pause mode now: restart the sound driver, run the pause menu (HandleMenuInput) until it ends,
	;then restart the sound driver again
	jsr	(forceblack).l
	move.w	d0,-(sp)
	move.w	(vcount).w,d0
.loop
	cmp.w	(vcount).w,d0
	beq.s	.loop
	move.w	(sp)+,d0
	jsr	(SoundOff).l
	move.w	#9,d0
	jsr	(SoundCmd).l
	move.w	#0,d0
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
	move.w	(sflags).w,-(sp)
	bsr.w	seta2
	jsr	(SetMenuPadSide).l
	movea.l	#PauseMenu,a0
	lea	SetupPauseScreen(pc),a1
	btst	#0,(gmode2).w
	beq.w	.0
	movea.l	#ShootoutPauseMenu,a0
	bra.w	.1
.0
	btst	#2,$30(a2)
	beq.w	.1
	movea.l	#PauseMenuNoTimeout,a0
.1
	bsr.w	InitMenuState
.2
	bsr.w	vcountwait
	bsr.w	ReadMenuJoy
	jsr	(ProcessInputWithRepeat).l
	bsr.w	HandleMenuInput
	bne.s	.2
	jsr	(forceblack).l
	move.w	(sp)+,(sflags).w
	jsr	(stop_current_song).l
	move.w	#9,d0
	jsr	(SoundCmd).l
	move.w	#0,d0
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
	jmp	ReturnToGame
	;After Pausemode: code that nothing in the listing reaches.
	;Code the listing does not decode: kept as bytes
	dc.b	$4E,$B9,$00,$01,$D0,$1E,$4E,$B9,$00,$08,$85,$FC,$30,$3C,$00,$09
	dc.b	$4E,$B9,$00,$08,$83,$9E,$30,$3C,$00,$00,$32,$3C,$1B,$24,$20,$7C
	dc.b	$00,$02,$55,$00,$4E,$B9,$00,$08,$83,$9E,$30,$3C,$00,$06,$42,$41
	dc.b	$20,$7C,$00,$02,$70,$26,$4E,$B9,$00,$08,$83,$9E,$30,$3C,$00,$07
	dc.b	$32,$3C,$00,$01,$4E,$B9,$00,$08,$83,$9E,$20,$7C,$00,$C0,$00,$00
	dc.b	$31,$7C,$91,$00,$00,$04,$31,$7C,$92,$00,$00,$04,$08,$F8,$00,$03
	dc.b	$BF,$B2,$08,$B8,$00,$00,$C3,$3A,$4E,$B9,$00,$01,$D0,$62,$4E,$B9
	dc.b	$00,$02,$03,$4A,$31,$FC,$00,$18,$BD,$3C,$4A,$78,$BD,$3C,$6A,$FA
	dc.b	$31,$F8,$B0,$52,$B0,$54,$4E,$75

SetupPauseScreen	;Draw routine for the pause menu: the pause screen, then KillCrowd.
	;Code the listing does not decode: kept as bytes
	dc.b	$4E,$B9,$00,$1E,$29,$70,$4E,$B9,$00,$02,$0E,$28

seta2	;Set a2 to the team struct of the pause pad (menupadnum: cont1team ... cont4team)
	movea.l	#tmstruct,a2
	tst.w	(menupadnum).w
	beq.w	.seta20
	cmpi.w	#1,(menupadnum).w
	beq.w	.1
	cmpi.w	#2,(menupadnum).w
	beq.w	.0
	cmpi.w	#1,(cont4team).w
	bra.w	.seta21
.0
	cmpi.w	#1,(cont3team).w
	bra.w	.seta21
.1
	cmpi.w	#1,(cont2team).w
	bra.w	.seta21
.seta20
	cmpi.w	#1,(cont1team).w
.seta21
	beq.w	.x
	adda.w	#$39E,a2
.x
	rts

InitMenuState	;Start a menu: a0 = item list, a1 = screen draw routine; selection and first shown item 0. Falls into
	;DrawMenuScreen
	move.l	a0,(menulist).w
	move.l	a1,(menudraw).w
	clr.w	(menuitem).w
	clr.w	(word_FFD000).w

DrawMenuScreen	;Call the draw routine, print the items (UpdateMenuSelection), palcount $18
	movea.l	(menudraw).w,a0
	jsr	(a0)
	bsr.w	UpdateMenuSelection
	move.w	#$18,(palcount).w
	rts

SetMenuPrintX	;printx = 5, 9 with disflags bit 1 clear
	move.w	#5,(printx).w
	btst	#1,(disflags).w
	bne.w	rtss8
	addq.w	#4,(printx).w
	rts

HandleMenuInput	;Pause menu pad d1: up / down move the selection, C runs the item handler; start returns with the
	;zero flag set to end the menu
	btst	#7,d1
	bne.w	.2
	btst	#1,d1
	beq.w	.up
	addq.w	#1,(menuitem).w
	bra.w	UpdateMenuSelection
.up
	btst	#0,d1
	beq.w	.sel
	subq.w	#1,(menuitem).w
	bra.w	UpdateMenuSelection
.sel
	btst	#5,d1
	beq.w	.2
	bsr.w	seta2
	move.w	(menuitem).w,d0
	movea.l	(menulist).w,a0
	adda.w	(a0),a0
	adda.w	(a0),a0
	bra.w	.9
.next
	addq.w	#4,a0
.9
	adda.w	(a0),a0
	dbf	d0,.next
	movea.l	(a0),a0
	move.l	a0,-(sp)
	bset	#4,(sflags12).w
	jsr	(a0)
	bclr	#4,(sflags12).w
	movea.l	(sp)+,a0
	bclr	#1,(sflags5).w
	bne.w	.1
	cmpa.l	#TimeoutMenu,a0
	beq.w	.0
	cmpa.l	#SelectGoalieMenu,a0
	beq.w	.0
	cmpa.l	#ManualGoalieMenu,a0
	bne.w	.11
.0
	bsr.w	UpdateMenuSelection
	bra.w	.1
.11
	bsr.w	DrawMenuScreen
.1
	tst.w	(menuitem).w
	rts
.2
	eori	#4,ccr
	rts

UpdateMenuSelection	;Clamp menuitem to the list, scroll word_FFD000 to show it, and print the shown items
	jsr	(printsmallz).l
	String	$FE,$04
	move.w	(menuitem).w,d0
	bpl.w	.1
	clr.w	(menuitem).w
	clr.w	d0
.1
	movea.l	(menulist).w,a0
	adda.w	(a0),a0
	adda.w	(a0),a0
	bra.w	.3
.next
	adda.w	(a0),a0
	addq.w	#4,a0
	tst.w	2(a0)
.3
	dbmi	d0,.next
	addq.w	#1,d0
	sub.w	d0,(menuitem).w
	move.w	(menuitem).w,d0
	cmp.w	(word_FFD000).w,d0
	bge.w	.4
	move.w	d0,(word_FFD000).w
.4
	subq.w	#7,d0
	cmp.w	(word_FFD000).w,d0
	ble.w	.0
	move.w	d0,(word_FFD000).w
.0
	bsr.w	SetMenuPrintX
	move.w	#6,(printy).w
	movea.l	(menulist).w,a1
	jsr	(printbigcur).l
	adda.w	(a1),a1
	move.w	(word_FFD000).w,d0
	bra.w	.7
.skip
	adda.w	(a1),a1
	addq.w	#4,a1
.7
	dbf	d0,.skip
	moveq	#7,d1
	move.w	#4,(printy).w
	bsr.w	SetMenuPrintX
	jsr	(printsmallz).l
	String	$FB,$01,$FA,$02,$20,$FB,$12,$20,$FA,$FE,$FB,$EB
	move.w	(word_FFD000).w,d0
	beq.w	.2
	jsr	(printsmallz).l
	String	$FE,$07,$FB,$01,$FA,$02,$7B,$FB,$12,$7B,$FA,$FE,$FE,$04
.2
	bsr.w	SetMenuPrintX
	jsr	(printsmallz).l
	String	$FB,$02,$FA,$02
	move.l	a1,-(sp)
	movea.l	(menulist).w,a1
	jsr	(printbigcur).l
	cmp.w	(menuitem).w,d0
	bne.w	.nosel
	jsr	(printbigcur).l
.nosel
	movea.l	(sp)+,a1
	bsr.w	PrintMenuItem
	addq.w	#1,d0
	addq.w	#4,a1
	tst.w	2(a1)
	dbmi	d1,.2
	bmi.w	.5
	bsr.w	SetMenuPrintX
	jsr	(printsmallz).l
	String	$FE,$07,$FB,$01,$FC,$14,$7D,$FB,$12,$7D,$FE,$04
	rts
.5
	bsr.w	SetMenuPrintX
	jsr	(printsmallz).l
	String	$FB,$01,$FC,$14,$20,$FB,$12,$20
	rts

PrintMenuItem	;printsmall item String a1; an item that starts with x prints MANUAL GOALIE or AUTO GOALIE
	;(goaliemode1 / goaliemode2 by the pause pad)
	cmpi.b	#$78,2(a1)
	bne.w	.0
	move.l	a1,-(sp)
	movea.l	#.11,a1
	btst	#1,(sflags).w
	beq.w	.13
	tst.w	(goaliemode2).w
	bra.w	.chkgoalie
.13
	tst.w	(goaliemode1).w
.chkgoalie
	beq.w	.print
	movea.l	#.12,a1
.print
	jsr	(printbigcur).l
	movea.l	(sp)+,a1
	adda.w	(a1),a1
	bra.w	.1
.0
	jsr	(printbigcur).l
.1
	rts
.11
	String	'  MANUAL GOALIE   '
.12
	String	'   AUTO GOALIE    '

vcountwait	;Wait for the next vblank
	move.w	d0,-(sp)
	move.w	(oldvcount).w,d0
	move.w	(oldvcount).w,d0
.wait
	cmp.w	(vcount).w,d0
	beq.s	.wait
	move.w	(oldvcount).w,(vcount).w
	move.w	(sp)+,d0
	rts

GetNameandAttrib	;Print player d0's name, then the column d4 picks (attribjmp; above 2 a rating, the jump offset
	;in the low word).
	;Code the listing does not decode: kept as bytes
	dc.b	$48,$E7,$F9,$CC,$3F,$38,$B0,$40,$48,$7A,$00,$5C,$4E,$B9,$00,$02
	dc.b	$2E,$92,$4E,$B9,$00,$01,$BC,$84,$31,$D7,$B0,$40,$06,$78,$00,$18
	dc.b	$B0,$40,$3E,$2A,$00,$28,$3F,$00,$4E,$B9,$00,$01,$03,$AA,$22,$7C
	dc.b	$00,$1D,$E7,$4C,$4E,$B9,$00,$01,$D7,$F2,$4E,$B9,$00,$01,$BC,$84
	dc.b	$30,$1F,$31,$D7,$B0,$40,$06,$78,$00,$1C,$B0,$40,$B8,$7C,$00,$02
	dc.b	$63,$00,$00,$0A,$4E,$B9,$00,$1D,$7D,$F8,$48,$44,$41,$FA,$00,$4A
	dc.b	$D0,$F0,$40,$00,$4E,$D0,$30,$1F,$4C,$DF,$33,$9F,$4E,$75,$48,$E7
	dc.b	$F8,$CC,$48,$7A,$00,$2E,$4E,$B9,$00,$02,$2E,$92,$4E,$B9,$00,$01
	dc.b	$BC,$84,$31,$FC,$00,$1E,$B0,$40,$B8,$7C,$00,$02,$63,$00,$00,$0A
	dc.b	$4E,$B9,$00,$1D,$7D,$F8,$48,$44,$41,$FA,$00,$0E,$D0,$F0,$40,$00
	dc.b	$4E,$D0,$4C,$DF,$33,$1F,$4E,$75

attribjmp	;GetNameandAttrib column handlers, offsets from attribjmp: status, energy, handed, weight, fighting, rating
	dc.w	AttribStatus-attribjmp
	dc.w	AttribEnergy-attribjmp
	dc.w	AttribHanded-attribjmp
	dc.w	AttribWeight-attribjmp
	dc.w	AttribFighting-attribjmp
	dc.w	AttribRating-attribjmp

AttribStatus	;Player d0's status word: Ice, Bench, Inj. P, Inj. G, the games out of an injured player, or penalty time.
	;Code the listing does not decode: kept as bytes
	dc.b	$31,$C0,$DD,$BA,$D0,$40,$30,$32,$00,$6C,$6A,$00,$00,$48,$46,$40
	dc.b	$B0,$7C,$00,$03,$63,$00,$00,$0A,$70,$01,$60,$00,$00,$04,$70,$03
	dc.b	$B0,$7C,$00,$03,$66,$00,$00,$24,$48,$E7,$C1,$00,$32,$38,$DD,$BA
	dc.b	$3E,$2A,$00,$28,$4E,$B9,$00,$1E,$88,$7A,$43,$FA,$00,$7E,$4E,$B9
	dc.b	$00,$01,$D7,$EA,$4C,$DF,$00,$83,$4E,$75,$43,$FA,$00,$3A,$4E,$F9
	dc.b	$00,$01,$D7,$EA,$08,$00,$00,$0C,$66,$C4,$53,$78,$B0,$40,$32,$00
	dc.b	$02,$40,$0F,$FF,$4E,$B9,$00,$01,$BD,$84,$4E,$B9,$00,$01,$BC,$84
	dc.b	$70,$04,$08,$81,$00,$0E,$67,$00,$00,$04,$70,$05,$43,$FA,$00,$08
	dc.b	$4E,$F9,$00,$01,$D7,$EA

StatusTextTbl	;AttribStatus Strings
	String	'Ice     '
	String	'Bench   '
	String	'Injury P'
	String	'Injury G'
	String	'    '
	String	' C  '

InjuryGamesTbl	;AttribStatus Strings for an injury of 0-9 games
	String	'Inj. G  '
	String	'Inj.1G  '
	String	'Inj.2G  '
	String	'Inj.3G  '
	String	'Inj.4G  '
	String	'Inj.5G  '
	String	'Inj.6G  '
	String	'Inj.7G  '
	String	'Inj.8G  '
	String	'Inj.9G  '

AttribEnergy	;Energy / 40, at most 100 (AttribPrintPct).
	;Code the listing does not decode: kept as bytes
	dc.b	$D0,$40,$30,$32,$00,$34,$48,$C0,$80,$FC,$00,$28,$B0,$7C,$00,$64
	dc.b	$6F,$00,$00,$1A,$70,$64,$60,$00,$00,$14

AttribFighting	;Bit 0 of the nibble is the handedness: drop it, then a rating out of d1 - 1.
	;Code the listing does not decode: kept as bytes
	dc.b	$02,$40,$00,$0E,$53,$41

AttribRating	;d0 * 100 / d1. Falls into AttribPrintPct.
	;Code the listing does not decode: kept as bytes
	dc.b	$C0,$FC,$00,$64,$80,$C1,$4E,$B9,$00,$1D,$93,$02

AttribPrintPct	;Print d0 4 wide, then 4 blanks.
	;Code the listing does not decode: kept as bytes
	dc.b	$72,$04,$4E,$B9,$00,$01,$BE,$1C,$4E,$B9,$00,$01,$BC,$84,$4E,$B9
	dc.b	$00,$01,$BC,$72,$00,$06,$20,$20,$20,$20,$4E,$75

AttribHanded	;Bit 0 of d0, flipped: Righty / Lefty (HandedTextTbl).
	;Code the listing does not decode: kept as bytes
	dc.b	$02,$40,$00,$01,$0A,$40,$00,$01,$43,$FA,$00,$08,$4E,$F9,$00,$01
	dc.b	$D7,$EA

HandedTextTbl	;AttribHanded Strings
	String	'Righty  '
	String	'Lefty   '

AttribWeight	;Weight in lb (RatingToWeight).
	;Code the listing does not decode: kept as bytes
	dc.b	$61,$00,$00,$1E,$4E,$B9,$00,$01,$BD,$E8,$4E,$B9,$00,$01,$BC,$84
	dc.b	$4E,$B9,$00,$01,$BC,$72,$00,$08,$20,$6C,$62,$20,$20,$00,$4E,$75

RatingToWeight	;d0 = the weight of rating d0 (WeightTbl).
	;Code the listing does not decode: kept as bytes
	dc.b	$48,$E7,$00,$80,$20,$7C,$00,$01,$54,$70,$D0,$40,$30,$30,$00,$00
	dc.b	$4C,$DF,$01,$00,$4E,$75

WeightTbl	;RatingToWeight: the weight in lb of each rating
	dc.w	140,148,152,164,172,180,188,196
	dc.w	204,212,220,228,236,244,252,260

PlayoffStatsMenu	;Pause menu Playoff Stats: with GameFlags bit 7 set jump to SeasonPlayoffStats, else PlayerStatsList for the team struct
	;of team potree + potreeteam
	btst	#7,(GameFlags).w
	beq.w	.0
	jmp	SeasonPlayoffStats
.0
	movem.l	a2,-(sp)
	jsr	(ReadTeamStats).l
	movea.w	#(potree-M68K_RAM),a0
	move.w	(potreeteam).w,d0
	move.b	(a0,d0.w),d0
	movea.w	#(tmstruct-M68K_RAM),a2
	cmp.w	$28(a2),d0
	beq.w	.1
	adda.w	#$39E,a2
.1
	moveq	#1,d7
	jsr	(PlayerStatsList).l
	movem.l	(sp)+,a2
	rts

loc_154D4	;Jumped to from outside the segment.
	;Code the listing does not decode: kept as bytes
	dc.b	$61,$00,$5A,$7C,$3F,$38,$BF,$B2,$08,$F8,$00,$02,$BF,$B2,$30,$38
	dc.b	$B0,$00,$61,$00,$61,$90,$20,$BC,$00,$00,$00,$00,$30,$3C,$8D,$00
	dc.b	$10,$38,$B0,$00,$E4,$08,$31,$40,$00,$04,$31,$7C,$8C,$00,$00,$04
	dc.b	$31,$FC,$00,$05,$B0,$0E,$31,$DF,$BF,$B2,$08,$F8,$00,$01,$BF,$B2
	dc.b	$38,$38,$B0,$22,$24,$7C,$00,$09,$23,$EC,$08,$38,$00,$04,$C3,$42
	dc.b	$67,$00,$00,$02,$61,$00,$62,$06,$4E,$B9,$00,$1D,$8E,$6C,$4E,$B9
	dc.b	$00,$1D,$8E,$5C,$38,$38,$B0,$1C,$4E,$B9,$00,$02,$43,$A0,$38,$38
	dc.b	$B0,$28,$4E,$B9,$00,$01,$C1,$84,$4E,$B9,$00,$02,$10,$B0,$4E,$B9
	dc.b	$00,$02,$10,$C2,$4E,$B9,$00,$02,$10,$D0,$4E,$B9,$00,$02,$10,$9A
	dc.b	$08,$F8,$00,$07,$C3,$54,$4E,$F9,$00,$02,$15,$B2

TimeoutMenu	;Pause menu Timeout.
	;Code the listing does not decode: kept as bytes
	dc.b	$4E,$B9,$00,$1E,$2E,$AA,$53,$78,$CF,$FE,$53,$78,$D0,$00,$23,$FC
	dc.b	$00,$02,$38,$90,$FF,$FF,$D0,$02,$08,$EA,$00,$02,$00,$30,$61,$00
	dc.b	$65,$FE,$00,$06,$BF,$04,$0C,$00,$70,$16,$72,$06,$61,$00,$69,$26
	dc.b	$00,$1A,$F8,$04,$01,$0C,$06,$F9,$01,$20,$20,$20,$20,$54,$69,$6D
	dc.b	$65,$6F,$75,$74,$F8,$04,$01,$15,$08,$00,$22,$6A,$00,$1E,$D2,$E9
	dc.b	$00,$04,$30,$11,$E2,$48,$91,$78,$B0,$40,$61,$00,$69,$1C,$34,$7C
	dc.b	$C7,$26,$4E,$B9,$00,$01,$D3,$80,$D4,$FC,$03,$9E,$4E,$B9,$00,$01
	dc.b	$D3,$80,$08,$38,$00,$00,$C3,$38,$66,$00,$00,$14,$42,$78,$B0,$4A
	dc.b	$42,$78,$B0,$4C,$30,$3C,$00,$0A,$4E,$B9,$00,$01,$C1,$D2,$70,$78
	dc.b	$60,$00,$5B,$50

SelectGoalieMenu	;Pause menu Change Goalie.
	;Code the listing does not decode: kept as bytes
	dc.b	$4E,$B9,$00,$1E,$2E,$AA,$3F,$38,$CF,$FE,$3F,$38,$D0,$00,$61,$00
	dc.b	$01,$8E,$31,$C0,$D0,$00,$61,$00,$65,$72,$00,$06,$BF,$04,$0C,$00
	dc.b	$70,$18,$72,$03,$D2,$78,$D0,$00,$30,$2A,$00,$26,$6A,$00,$00,$04
	dc.b	$70,$FF,$52,$40,$31,$C0,$CF,$FE,$61,$00,$00,$6E,$61,$00,$01,$C2
	dc.b	$08,$01,$00,$07,$66,$00,$00,$34,$08,$01,$00,$05,$66,$00,$00,$2C
	dc.b	$08,$01,$00,$01,$67,$00,$00,$12,$30,$38,$CF,$FE,$52,$40,$B0,$78
	dc.b	$D0,$00,$6E,$D4,$31,$C0,$CF,$FE,$08,$01,$00,$00,$67,$CA,$53,$78
	dc.b	$CF,$FE,$6A,$C4,$42,$78,$CF,$FE,$60,$BE,$30,$38,$CF,$FE,$53,$40
	dc.b	$6A,$00,$00,$12,$08,$38,$00,$00,$C3,$3C,$67,$00,$00,$08,$31,$FC
	dc.b	$00,$0A,$B7,$9E,$35,$40,$00,$26,$4E,$B9,$00,$01,$FB,$52,$31,$DF
	dc.b	$D0,$00,$31,$DF,$CF,$FE,$4E,$75,$31,$FC,$00,$06,$B0,$42,$32,$38
	dc.b	$D0,$00,$70,$00,$31,$FC,$00,$0B,$B0,$40,$4E,$B9,$00,$01,$BE,$C4
	dc.b	$00,$08,$FE,$04,$FF,$01,$F9,$01,$B0,$78,$CF,$FE,$66,$00,$00,$10
	dc.b	$4E,$B9,$00,$01,$BE,$C4,$00,$08,$FE,$04,$FF,$01,$F9,$02,$61,$00
	dc.b	$67,$E0,$00,$14,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
	dc.b	$20,$20,$20,$20,$20,$20,$4A,$40,$66,$00,$00,$20,$31,$FC,$00,$0B
	dc.b	$B0,$40,$61,$00,$67,$BC,$00,$10,$20,$20,$6E,$6F,$20,$67,$6F,$61
	dc.b	$6C,$69,$65,$20,$20,$00,$60,$00,$00,$4C,$34,$00,$53,$42,$31,$C2
	dc.b	$C4,$C8,$B5,$FC,$FF,$FF,$C7,$26,$67,$00,$00,$06,$50,$F8,$C4,$C8
	dc.b	$4E,$B9,$00,$02,$30,$4C,$31,$FC,$00,$0B,$B0,$40,$4E,$B9,$00,$01
	dc.b	$BE,$C4,$00,$04,$20,$20,$0C,$B9,$00,$1B,$89,$C8,$FF,$FF,$B0,$10
	dc.b	$66,$00,$00,$08,$08,$F8,$00,$06,$C3,$58,$61,$00,$67,$88,$08,$B8
	dc.b	$00,$06,$C3,$58,$54,$78,$B0,$42,$52,$40,$51,$C9,$FF,$48,$4E,$75
