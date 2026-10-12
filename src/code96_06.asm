;	The player frame update: replay recording and play-back (ReplayMode and its helpers, mostly bytes), updateplayers,
;	updateanim, the window scroll, the pad player switches (chgplayer, setcplayer, restorepl, setpads) and the
;	bench, penalty box, celebration and goalie assignments (bytes, labelled at their asstab entries).

GetGoalieCountD7	;d0 = goalies on team d7: the low 2 bits of byte 3 of its save RAM SRTeamCounts entry, or 2 with sflags11 bit 4
	movem.l	d1/d7-a0,-(sp)
	btst	#4,(sflags11).w
	bne.w	.1
	movea.l	#SaveRAM+SRTeamCounts,a0
	mulu.w	#4,d7
	clr.w	d0
	move.b	3(a0,d7.w),d0
	andi.w	#3,d0
.0
	movem.l	(sp)+,d1/d7-a0
	rts
.1
	move.w	#2,d0
	bra.s	.0

GetGoalieCount	;d0 = goalies on team a2 (GetGoalieCountD7 with d7 = the team number)
	movem.l	d1/d7-a0,-(sp)
	move.w	$28(a2),d7
	bsr.s	GetGoalieCountD7
	movem.l	(sp)+,d1/d7-a0
	rts

GetPlayerCountD7	;d0 = players on team d7: byte 1 of its save RAM SRTeamCounts entry, or with sflags11 bit 4 from the
	;roster in TeamList (records until a length word of 2)
	movem.l	d7-a0,-(sp)
	btst	#4,(sflags11).w
	bne.w	.2
	movea.l	#SaveRAM+SRTeamCounts,a0
	mulu.w	#4,d7
	clr.w	d0
	move.b	1(a0,d7.w),d0
.0
	movem.l	(sp)+,d7-a0
	rts
.2
	movea.l	#TeamList,a0
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
	bra.s	.0

GetPlayerCount	;d0 = players on team a2 (GetPlayerCountD7 with d7 = the team number)
	movem.l	d7-a0,-(sp)
	move.w	$28(a2),d7
	bsr.s	GetPlayerCountD7
	movem.l	(sp)+,d7-a0
	rts

WaitVSyncAndReadInput	;Wait for the next vblank, read the menu pad (ReadMenuJoy) until a new button press.
	;Code the listing does not decode: kept as bytes
	dc.b	$32,$38,$B0,$52,$B2,$78,$B0,$52,$67,$FA,$61,$00,$04,$C8,$61,$00
	dc.b	$5A,$E4,$4A,$01,$67,$EA,$4E,$75

ReplayMode	;Instant replay play-back control and display code. Pause menu INSTANT REPLAY.
	;Code the listing does not decode: kept as bytes
	dc.b	$08,$B8,$00,$00,$C3,$44,$61,$00,$57,$2E,$4E,$B9,$00,$08,$85,$FC
	dc.b	$30,$3C,$00,$09,$4E,$B9,$00,$08,$83,$9E,$30,$3C,$00,$00,$32,$3C
	dc.b	$1B,$24,$20,$7C,$00,$02,$55,$00,$4E,$B9,$00,$08,$83,$9E,$30,$3C
	dc.b	$00,$06,$42,$41,$20,$7C,$00,$02,$70,$26,$4E,$B9,$00,$08,$83,$9E
	dc.b	$30,$3C,$00,$07,$32,$3C,$00,$01,$4E,$B9,$00,$08,$83,$9E,$3F,$38
	dc.b	$BF,$B2,$08,$F8,$00,$03,$C3,$3C,$08,$B8,$00,$04,$C3,$42,$4E,$B9
	dc.b	$00,$1E,$27,$42,$4E,$B9,$00,$01,$5C,$F8,$08,$B8,$00,$05,$C3,$3A
	dc.b	$08,$B8,$00,$05,$C3,$3E,$50,$F8,$BE,$6C,$28,$78,$B0,$4E,$61,$00
	dc.b	$05,$44,$4A,$47,$66,$F8,$4E,$B9,$00,$02,$13,$AE,$4E,$B9,$00,$02
	dc.b	$03,$4A,$08,$B8,$00,$01,$C3,$3E,$42,$B8,$BE,$AE,$42,$B8,$BE,$B2
	dc.b	$42,$B8,$BE,$B6,$31,$FC,$00,$18,$BD,$3C,$7E,$01
loc_158C8	;Jumped to from later in ReplayMode
	dc.b	$30,$38,$B0,$52,$90,$78,$B0,$54,$BE,$40,$62,$F4,$31,$F8,$B0,$52
	dc.b	$B0,$54,$4A,$78,$DC,$A8,$6B,$00,$00,$14,$9F,$78,$DC,$A8,$6A,$00
	dc.b	$00,$0C,$42,$78,$DC,$A8,$4E,$B9,$00,$01,$5D,$2A,$48,$E7,$80,$10
	dc.b	$26,$7C,$FF,$FF,$B6,$5E,$37,$7C,$00,$01,$00,$08,$26,$7C,$FF,$FF
	dc.b	$B6,$DE,$37,$7C,$00,$01,$00,$08,$4C,$DF,$08,$01,$7E,$01,$61,$00
	dc.b	$03,$C0,$08,$38,$00,$00,$C3,$44,$67,$00,$00,$12,$02,$40,$FF,$F0
	dc.b	$00,$40,$00,$08,$02,$41,$FF,$F0,$02,$43,$FF,$F0,$3A,$7C,$BE,$56
	dc.b	$08,$38,$00,$05,$C3,$3E,$67,$00,$00,$0C,$3A,$01,$02,$45,$00,$0F
	dc.b	$67,$00,$01,$88,$08,$00,$00,$03,$66,$00,$01,$80,$0C,$55,$FF,$60
	dc.b	$6E,$00,$00,$0A,$3A,$BC,$00,$00,$60,$00,$00,$02,$0C,$6D,$FE,$B0
	dc.b	$00,$14,$6E,$00,$00,$08,$3B,$7C,$00,$00,$00,$14,$08,$F8,$00,$05
	dc.b	$C3,$3A,$66,$00,$00,$0C,$3A,$B8,$BD,$32,$3B,$78,$BD,$2E,$00,$14
	dc.b	$3A,$00,$02,$45,$00,$07,$0A,$45,$00,$04,$32,$7C,$B0,$5E,$50,$C3
	dc.b	$08,$B8,$00,$05,$C3,$3E,$67,$00,$00,$06,$36,$2D,$00,$16,$30,$15
	dc.b	$32,$2D,$00,$14,$74,$0B,$28,$3C,$00,$00,$01,$00,$48,$A7,$C0,$00
	dc.b	$B6,$69,$00,$52,$67,$00,$00,$58,$4C,$97,$00,$03,$90,$51,$92,$69
	dc.b	$00,$14,$4E,$B9,$00,$01,$A3,$EE,$08,$00,$00,$03,$66,$00,$00,$40
	dc.b	$90,$45,$52,$40,$02,$40,$00,$07,$B0,$7C,$00,$02,$62,$00,$00,$30
	dc.b	$4C,$97,$00,$03,$90,$51,$92,$69,$00,$14,$C1,$C0,$C3,$C1,$D0,$81
	dc.b	$B0,$BC,$00,$00,$00,$04,$63,$00,$00,$16,$B0,$84,$62,$00,$00,$10
	dc.b	$28,$00,$3B,$69,$00,$52,$00,$16,$08,$F8,$00,$05,$C3,$3E,$D2,$FC
	dc.b	$00,$80,$51,$CA,$FF,$9C,$58,$4F,$08,$38,$00,$05,$C3,$3E,$67,$00
	dc.b	$00,$22,$30,$2D,$00,$16,$EF,$40,$36,$7C,$B0,$5E,$D6,$C0,$78,$04
	dc.b	$61,$00,$13,$30,$61,$00,$04,$BC,$4E,$B9,$00,$02,$03,$4A,$60,$00
	dc.b	$FE,$80,$08,$F8,$00,$05,$C3,$3A,$0A,$45,$00,$04,$E5,$45,$41,$FA
	dc.b	$00,$5A,$30,$30,$50,$00,$D0,$55,$B0,$7C,$00,$96,$6E,$00,$00,$0C
	dc.b	$B0,$7C,$FF,$6A,$6D,$00,$00,$04,$3A,$80,$32,$30,$50,$02,$D2,$6D
	dc.b	$00,$14,$B2,$7C,$01,$3C,$6E,$00,$00,$0E,$B2,$7C,$FE,$C4,$6D,$00
	dc.b	$00,$06,$3B,$41,$00,$14,$36,$4D,$42,$6D,$00,$18,$02,$B8,$00,$0F
	dc.b	$FF,$FF,$BE,$AA,$00,$B8,$00,$E0,$00,$00,$BE,$AA,$61,$00,$04,$54
	dc.b	$4E,$B9,$00,$02,$03,$4A,$60,$00,$FE,$18,$00,$00,$00,$02,$00,$02
	dc.b	$00,$02,$00,$02,$00,$00,$00,$02,$FF,$FE,$00,$00,$FF,$FE,$FF,$FE
	dc.b	$FF,$FE,$FF,$FE,$00,$00,$FF,$FE,$00,$02,$50,$ED,$00,$18,$08,$01
	dc.b	$00,$05,$67,$00,$00,$12,$08,$38,$00,$00,$C3,$44,$66,$00,$00,$08
	dc.b	$08,$78,$00,$01,$C3,$3E,$08,$03,$00,$06,$67,$00,$00,$30,$08,$38
	dc.b	$00,$00,$C3,$44,$66,$00,$00,$26,$61,$00,$02,$DE,$61,$00,$02,$DA
	dc.b	$61,$00,$02,$D6,$61,$00,$02,$D2,$4E,$B9,$00,$02,$13,$AE,$4E,$B9
	dc.b	$00,$02,$03,$4A,$7E,$01,$08,$B8,$00,$01,$C3,$3E,$08,$38,$00,$00
	dc.b	$C3,$44,$66,$00,$00,$52,$08,$03,$00,$04,$67,$00,$00,$4A,$08,$03
	dc.b	$00,$06,$67,$00,$00,$2A,$08,$B8,$00,$05,$C3,$3E,$08,$B8,$00,$05
	dc.b	$C3,$3A,$2F,$00,$20,$38,$BE,$AA,$02,$80,$00,$0F,$FF,$FF,$00,$80
	dc.b	$00,$E0,$00,$00,$21,$C0,$BE,$AA,$20,$1F,$60,$00,$FD,$64,$61,$00
	dc.b	$02,$AA,$4E,$B9,$00,$02,$13,$AE,$4E,$B9,$00,$02,$03,$4A,$E3,$47
	dc.b	$08,$B8,$00,$01,$C3,$3E,$08,$38,$00,$01,$C3,$3E,$67,$00,$00,$1A
	dc.b	$50,$F8,$C0,$64,$61,$00,$02,$84,$3F,$38,$C0,$64,$4E,$B9,$00,$08
	dc.b	$84,$70,$4E,$B9,$00,$02,$13,$AE,$4E,$B9,$00,$02,$03,$4A,$08,$38
	dc.b	$00,$00,$C3,$44,$66,$00,$00,$24,$08,$01,$00,$07,$67,$00,$FD,$12
	dc.b	$4E,$B9,$00,$01,$5D,$48,$08,$B8,$00,$01,$C3,$3E,$08,$F8,$00,$00
	dc.b	$C3,$44,$66,$00,$00,$06,$60,$00,$FC,$F8,$08,$01,$00,$07,$66,$00
	dc.b	$00,$40,$08,$01,$00,$06,$66,$00,$00,$32,$08,$01,$00,$04,$66,$00
	dc.b	$00,$3A,$08,$01,$00,$05,$67,$00,$FC,$D8,$08,$F8,$00,$06,$C3,$42
	dc.b	$08,$B8,$00,$00,$C3,$44,$4E,$B9,$00,$01,$5D,$C2,$61,$00,$02,$0C
	dc.b	$4E,$B9,$00,$02,$13,$AE,$60,$00,$FC,$B8,$4E,$F9,$00,$01,$58,$C8
	dc.b	$42,$78,$CF,$FE,$08,$F8,$00,$01,$C3,$44,$61,$00,$53,$2E,$00,$B8
	dc.b	$F0,$00,$00,$00,$BE,$AA,$08,$B8,$00,$05,$C3,$3A,$28,$78,$B0,$4E
	dc.b	$08,$B8,$00,$04,$C3,$42,$61,$00,$03,$30,$4E,$B9,$00,$02,$13,$AE
	dc.b	$08,$B8,$00,$03,$C3,$3C,$31,$DF,$BF,$B2,$4E,$B9,$00,$01,$54,$D8
	dc.b	$4E,$B9,$00,$02,$10,$B0,$4E,$B9,$00,$02,$10,$C2,$4E,$B9,$00,$02
	dc.b	$10,$D0,$4E,$B9,$00,$02,$10,$EC,$31,$FC,$FF,$FF,$D2,$A2,$30,$3C
	dc.b	$00,$00,$32,$3C,$1B,$24,$20,$7C,$00,$02,$55,$00,$4E,$B9,$00,$08
	dc.b	$83,$9E,$30,$3C,$00,$09,$4E,$B9,$00,$08,$83,$9E,$30,$3C,$00,$06
	dc.b	$42,$41,$20,$7C,$00,$02,$70,$26,$4E,$B9,$00,$08,$83,$9E,$30,$3C
	dc.b	$00,$07,$32,$3C,$00,$00,$4E,$B9,$00,$08,$83,$9E,$08,$38,$00,$04
	dc.b	$BF,$B2,$67,$00,$00,$0E,$4E,$B9,$00,$02,$11,$08,$4E,$B9,$00,$02
	dc.b	$10,$FA,$4E,$B9,$00,$02,$03,$4A,$31,$FC,$00,$18,$BD,$3C,$4E,$75

ReadMenuJoy	;Read the menu pad: pad menupadnum (ReadJoy1-4)
	tst.w	(menupadnum).w
	beq.w	ReadJoy1
	cmpi.w	#1,(menupadnum).w
	beq.w	ReadJoy2
	cmpi.w	#2,(menupadnum).w
	beq.w	ReadJoy3
	bra.w	ReadJoy4

ShowReplayIcon	;Show the replay icon and start the $F0 frame replayicontimer timer.
	;Code the listing does not decode: kept as bytes
	dc.b	$31,$FC,$00,$F0,$DC,$A8,$61,$00,$5E,$8E,$00,$06,$BF,$01,$01,$00
	dc.b	$42,$40,$42,$41,$74,$0D,$76,$06,$38,$38,$B0,$30,$3A,$3C,$00,$00
	dc.b	$22,$7C,$00,$14,$0A,$FE,$D3,$E9,$00,$04,$34,$7C,$07,$72,$60,$00
	dc.b	$59,$6A

EraseReplayIcon	;Erase the replay icon (replayicontimer ran out).
	;Code the listing does not decode: kept as bytes
	dc.b	$4E,$B9,$00,$01,$BB,$8E,$00,$06,$BF,$01,$01,$00,$30,$3C,$00,$0D
	dc.b	$32,$3C,$00,$06,$34,$3C,$07,$FF,$4E,$F9,$00,$01,$B9,$76

ShowReplayBanner	;Erase the replay icon, show the replay banner and stop the replayicontimer timer.
	;Code the listing does not decode: kept as bytes
	dc.b	$4E,$B9,$00,$01,$5D,$2A,$50,$F8,$DC,$A8,$61,$00,$5E,$3A,$00,$06
	dc.b	$BF,$02,$00,$00,$70,$00,$72,$00,$74,$14,$76,$08,$38,$38,$B0,$3A
	dc.b	$3A,$3C,$00,$00,$22,$7C,$00,$14,$12,$28,$D3,$E9,$00,$04,$34,$7C
	dc.b	$07,$72,$61,$00,$59,$16,$4E,$B9,$00,$01,$C1,$1A,$00,$20,$F8,$04
	dc.b	$01,$07,$01,$6F,$70,$74,$69,$6F,$6E,$73,$FD,$07,$FA,$02,$72,$65
	dc.b	$76,$65,$72,$73,$65,$20,$61,$6E,$67,$6C,$65,$00,$4E,$B9,$00,$01
	dc.b	$C1,$2C,$00,$16,$FD,$05,$FC,$05,$73,$74,$61,$72,$74,$20,$2D,$20
	dc.b	$74,$6F,$20,$67,$61,$6D,$65,$00,$4E,$75

EraseReplayBanner	;Erase the area ShowReplayBanner drew.
	;Code the listing does not decode: kept as bytes
	dc.b	$4E,$B9,$00,$01,$BB,$8E,$00,$06,$BF,$02,$00,$00,$30,$3C,$00,$14
	dc.b	$32,$3C,$00,$08,$34,$3C,$07,$FF,$4E,$F9,$00,$01,$B9,$76

suba4	;a4 = current replay frame. Back up 1 frame and set video parameters for display.
	;Code the listing does not decode: kept as bytes
	dc.b	$B9,$FC,$FF,$FF,$00,$00,$66,$00,$00,$12,$08,$38,$00,$04,$C3,$3A
	dc.b	$67,$00,$00,$18,$28,$7C,$FF,$FF,$AF,$64,$98,$FC,$00,$64,$B9,$F8
	dc.b	$B0,$4E,$66,$00,$01,$6C,$D8,$FC,$00,$64,$61,$00,$01,$64,$42,$47
	dc.b	$4E,$75,$08,$B8,$00,$06,$C3,$42,$67,$00,$00,$9E,$48,$E7,$FF,$FE
	dc.b	$08,$78,$00,$04,$C3,$42,$3F,$38,$BD,$32,$3F,$38,$BD,$2E,$61,$00
	dc.b	$51,$4C,$4E,$B9,$00,$01,$51,$E0,$4E,$B9,$00,$01,$51,$E0,$42,$78
	dc.b	$BD,$32,$42,$78,$BD,$2E,$31,$FC,$07,$D0,$BD,$30,$30,$3C,$00,$01
	dc.b	$4E,$B9,$00,$02,$03,$4A,$4E,$B9,$00,$01,$51,$E0,$51,$C8,$FF,$F2
	dc.b	$31,$DF,$BD,$2E,$31,$DF,$BD,$32,$30,$3C,$00,$01,$4E,$B9,$00,$02
	dc.b	$03,$4A,$4E,$B9,$00,$01,$51,$E0,$51,$C8,$FF,$F8,$48,$E7,$00,$80
	dc.b	$20,$7C,$FF,$FF,$B6,$5E,$31,$7C,$00,$01,$00,$08,$D0,$FC,$00,$80
	dc.b	$31,$7C,$00,$01,$00,$08,$4C,$DF,$01,$00,$61,$00,$00,$C4,$08,$38
	dc.b	$00,$05,$C3,$3A,$67,$00,$00,$02,$4E,$B9,$00,$01,$5C,$F8,$31,$FC
	dc.b	$00,$64,$BD,$3C,$4C,$DF,$7F,$FF,$42,$47,$08,$38,$00,$02,$C3,$3C
	dc.b	$67,$00,$00,$16,$48,$E7,$00,$08,$61,$00,$00,$1A,$B9,$F8,$B0,$4E
	dc.b	$4C,$DF,$10,$00,$67,$00,$04,$18,$B9,$F8,$B0,$4E,$67,$00,$04,$10
	dc.b	$61,$00,$00,$8E,$D8,$FC,$00,$64,$B9,$FC,$FF,$FF,$AF,$64,$66,$00
	dc.b	$03,$FE,$28,$7C,$FF,$FF,$00,$00,$4E,$75

UpdateCameraPos	;Camera struct a5 = object a3 x/y (negated for the reverse angle), Hpos/Vpos clamped.
	;Code the listing does not decode: kept as bytes
	dc.b	$48,$E7,$E0,$00,$30,$13,$08,$38,$00,$07,$C3,$42,$67,$00,$00,$04
	dc.b	$44,$40,$3A,$80,$32,$2B,$00,$14,$08,$38,$00,$07,$C3,$42,$67,$00
	dc.b	$00,$04,$44,$41,$3B,$41,$00,$14,$B0,$7C,$00,$3C,$6D,$00,$00,$06
	dc.b	$30,$3C,$00,$3C,$B0,$7C,$FF,$C4,$6E,$00,$00,$06,$30,$3C,$FF,$C4
	dc.b	$31,$C0,$BD,$32,$B2,$7C,$00,$F8,$6D,$00,$00,$06,$32,$3C,$00,$F8
	dc.b	$B2,$7C,$FF,$18,$6E,$00,$00,$06,$32,$3C,$FF,$18,$31,$C1,$BD,$2E
	dc.b	$4C,$DF,$00,$07,$4E,$75

RevReplayAdj	;Set sflags4 bit 7 for a reverse angle replay, then fall into the frame restore.
	;Code the listing does not decode: kept as bytes
	dc.b	$08,$38,$00,$04,$C3,$42,$67,$00,$00,$08,$08,$F8,$00,$07,$C3,$42
	dc.b	$48,$E7,$E0,$82,$2C,$7C,$00,$1D,$57,$9E,$20,$4C,$72,$0F,$36,$7C
	dc.b	$B0,$5E,$34,$28,$00,$02,$02,$42,$01,$FF,$08,$02,$00,$08,$67,$00
	dc.b	$00,$06,$00,$42,$FE,$00,$08,$38,$00,$04,$C3,$42,$67,$00,$00,$04
	dc.b	$44,$42,$36,$82,$24,$10,$E6,$82,$EC,$42,$08,$02,$00,$09,$67,$00
	dc.b	$00,$06,$00,$42,$FC,$00,$08,$38,$00,$04,$C3,$42,$67,$00,$00,$0E
	dc.b	$44,$42,$B2,$7C,$00,$00,$66,$00,$00,$04,$54,$42,$37,$42,$00,$14
	dc.b	$34,$10,$E6,$42,$02,$42,$07,$FF,$08,$38,$00,$04,$C3,$42,$67,$00
	dc.b	$00,$3E,$E3,$42,$34,$36,$20,$00,$53,$42,$0C,$6B,$00,$0F,$00,$52
	dc.b	$66,$00,$00,$10,$B4,$7C,$02,$99,$67,$00,$00,$08,$37,$7C,$FC,$00
	dc.b	$00,$14,$B4,$7C,$00,$01,$6D,$00,$00,$0E,$B4,$7C,$07,$42,$6C,$00
	dc.b	$00,$06,$60,$00,$00,$0A,$34,$10,$E6,$42,$02,$42,$07,$FF,$37,$42
	dc.b	$00,$06,$B4,$7C,$07,$3A,$6D,$00,$00,$1A,$B4,$7C,$07,$3F,$6C,$00
	dc.b	$00,$12,$08,$38,$00,$04,$C3,$42,$67,$00,$00,$08,$37,$7C,$01,$90
	dc.b	$00,$14,$08,$38,$00,$04,$C3,$42,$67,$00,$00,$18,$B4,$7C,$02,$13
	dc.b	$6D,$00,$00,$10,$B4,$7C,$02,$22,$6E,$00,$00,$08,$37,$7C,$01,$90
	dc.b	$00,$14,$34,$10,$E6,$42,$02,$42,$18,$00,$02,$6B,$E7,$FF,$00,$04
	dc.b	$85,$6B,$00,$04,$08,$38,$00,$04,$C3,$42,$67,$00,$00,$1C,$34,$2B
	dc.b	$00,$06,$B4,$7C,$05,$E3,$6D,$00,$00,$10,$B4,$7C,$06,$8B,$6C,$00
	dc.b	$00,$08,$08,$6B,$00,$03,$00,$04,$34,$2B,$00,$06,$B4,$7C,$02,$13
	dc.b	$6D,$00,$00,$10,$B4,$7C,$02,$22,$6E,$00,$00,$08,$08,$AB,$00,$03
	dc.b	$00,$04,$58,$48,$D6,$FC,$00,$80,$51,$C9,$FE,$C8,$74,$05,$36,$7C
	dc.b	$B0,$5E,$17,$58,$00,$70,$10,$10,$02,$40,$00,$0F,$B0,$7C,$00,$0F
	dc.b	$66,$00,$00,$04,$70,$FF,$37,$40,$00,$34,$D6,$FC,$00,$80,$10,$18
	dc.b	$E8,$08,$17,$40,$00,$70,$10,$10,$E9,$00,$81,$2B,$00,$70,$10,$18
	dc.b	$E8,$08,$02,$40,$00,$0F,$B0,$7C,$00,$0F,$66,$00,$00,$04,$70,$FF
	dc.b	$37,$40,$00,$34,$D6,$FC,$00,$80,$51,$CA,$FF,$B8,$10,$18,$48,$80
	dc.b	$31,$C0,$B7,$76,$10,$18,$48,$80,$31,$C0,$B7,$F6,$10,$18,$48,$80
	dc.b	$31,$C0,$C0,$64,$42,$47,$1E,$18,$30,$18,$31,$C0,$BE,$AC,$31,$D8
	dc.b	$B8,$B0,$31,$D8,$BF,$16,$31,$D8,$BF,$14,$11,$D8,$C3,$EC,$42,$40
	dc.b	$10,$18,$00,$40,$FF,$00,$31,$C0,$BE,$AA,$08,$38,$00,$05,$C3,$3A
	dc.b	$67,$00,$00,$26,$36,$4D,$08,$38,$00,$05,$C3,$3E,$67,$00,$00,$12
	dc.b	$42,$6D,$00,$18,$30,$2D,$00,$16,$EF,$40,$36,$7C,$B0,$5E,$D6,$C0
	dc.b	$61,$00,$FD,$88,$60,$00,$00,$22,$31,$D8,$BD,$32,$31,$D8,$BD,$2E
	dc.b	$08,$38,$00,$04,$C3,$42,$67,$00,$00,$10,$44,$78,$BD,$32,$44,$78
	dc.b	$BD,$2E,$4E,$B9,$00,$01,$61,$A4,$08,$B8,$00,$07,$C3,$42,$4C,$DF
	dc.b	$41,$07,$4E,$75

ClampReplayView	;Clamp Hpos to -$3C..$3C and Vpos to -$C8..$100.
	;Code the listing does not decode: kept as bytes
	dc.b	$3F,$00,$30,$3C,$00,$3C,$B0,$78,$BD,$32,$6D,$00,$00,$0E,$30,$3C
	dc.b	$FF,$C4,$B0,$78,$BD,$32,$6F,$00,$00,$06,$31,$C0,$BD,$32,$30,$3C
	dc.b	$01,$00,$B0,$78,$BD,$2E,$6D,$00,$00,$0E,$30,$3C,$FF,$38,$B0,$78
	dc.b	$BD,$2E,$6F,$00,$00,$06,$31,$C0,$BD,$2E,$30,$1F,$4E,$75

updatereplay	;Called every frame to save replay events, d7 = elapsed frames
	btst	#4,(gmode).w	;check if highlight
	bne.w	rtss8	;exit if so
	btst	#2,(sflags2).w	;check if replay record disabled
	beq.w	.0	;branch if not
	tst.w	(replaydelay).w
	beq.w	.rec
	subq.w	#1,(replaydelay).w
	bpl.w	.0
	clr.w	(replaydelay).w
	bra.w	.rec
.0
	addi.l	#$64,(recbpr).w
	cmpi.l	#replayend,(recbpr).w
	bne.w	.rec
	bset	#4,(sflags).w
	move.l	#M68K_RAM,(recbpr).w
.rec
	movea.l	(recbpr).w,a0
	moveq	#$F,d2
	movea.w	#(SortCords-M68K_RAM),a3
.top
	clr.l	(a0)
	move.w	(a3),d1
	andi.w	#$1FF,d1
	move.w	d1,2(a0)
	clr.l	d1
	move.w	Ypos(a3),d1
	asl.w	#6,d1
	asl.l	#3,d1
	or.l	d1,(a0)
	move.w	frame(a3),d1
	asl.w	#3,d1
	or.w	d1,(a0)
	move.w	attribute(a3),d1
	andi.w	#$1800,d1
	asl.w	#3,d1
	or.w	d1,(a0)
	addq.w	#4,a0
	adda.w	#$80,a3
	dbf	d2,.top
	moveq	#5,d2
	movea.w	#(SortCords-M68K_RAM),a3
.loop
	move.b	$70(a3),(a0)+
	move.w	position(a3),d0
	bpl.w	.n0
	moveq	#$F,d0
.n0
	andi.w	#$F,d0
	move.b	d0,(a0)
	adda.w	#$80,a3
	move.b	$70(a3),d0
	asl.w	#4,d0
	or.b	d0,(a0)+
	move.b	$70(a3),d0
	lsr.b	#4,d0
	move.b	d0,(a0)
	move.w	position(a3),d0
	bpl.w	.n1
	moveq	#$F,d0
.n1
	asl.w	#4,d0
	or.b	d0,(a0)+
	adda.w	#$80,a3
	dbf	d2,.loop
	move.b	(byte_FFB777).w,(a0)+
	move.b	(byte_FFB7F7).w,(a0)+
	move.b	(lastsfx+1).w,(a0)+
	bset	#7,(lastsfx+1).w
	move.b	d7,(a0)+
	move.w	(PadControlBits+2).w,(a0)+
	move.w	(crowdframe).w,(a0)+
	move.w	(glovecords).w,(a0)+
	move.w	(glovecords+2).w,(a0)+
	move.b	(PBnum).w,(a0)+
	move.w	d0,-(sp)
	move.w	(PadControlBits).w,d0
	move.b	d0,(a0)+
	move.w	(sp)+,d0
	move.w	(Hpos).w,(a0)+
	move.w	(Vpos).w,(a0)+

rtss8	;The shared rts of updatereplay; other routines branch to it
	rts

updateplayers	;This routine calls all collision/animation/assignment code for all players. d7 = elapsed frames
	btst	#7,(sflags).w
	bne.w	.16
	ori.l	#$F,(PadControlBits).w
	cmpi.w	#5,(puckz).w
	bgt.w	.14
.13
	clr.w	(word_FFDCC6).w
	bra.w	.16
.14
	move.w	(word_FFDCCA).w,d0
	cmp.w	(puckz).w,d0
	beq.w	.15
	move.w	(puckz).w,(word_FFDCCA).w
	bra.s	.13
.15
	addq.w	#1,(word_FFDCC6).w
	cmpi.w	#$10,(word_FFDCC6).w
	blt.w	.16
	clr.w	(word_FFDCC6).w
	subq.w	#1,(puckz).w
.16
	bclr	#6,(sflags7).w
	move.w	(CurCrowdMeter).w,d0
	cmp.w	(word_FFC374).w,d0
	blt.w	.17
	bset	#6,(sflags7).w
.17
	jsr	(sub_1D92EC).l
	tst.w	(puckc).w
	bmi.w	.18
	bclr	#7,(byte_FFC34C).w
	bclr	#1,(sflags6).w
	move.w	(puckc).w,d0
	asl.w	#7,d0
	movea.l	#SortCords,a3
	adda.w	d0,a3
	btst	#1,pflags3(a3)
	beq.w	.18
	bclr	#4,(gmode2).w
.18
	movea.w	#(SortCords-M68K_RAM),a3
.19
	move.l	(a3),OldXpos(a3)	;Xpos, oldXpos
	move.l	Ypos(a3),OldYpos(a3)	;Ypos, oldYpos
	move.l	Zpos(a3),OldZpos(a3)	;Zpos, oldZpos
	btst	#5,pflags3(a3)	;falling down?
	beq.w	.20	;branch if not
	clr.w	Xvel(a3)	;clear Xvel
	clr.w	Yvel(a3)	;clear Yvel
	tst.w	SPAnum(a3)	;check animation index
	bne.w	.0	;branch if index not 0
	jsr	(PlaceBoardFall).l
	bra.w	.20
.0
	cmpi.w	#SPAboardmidl,SPA(a3)
	beq.w	.9
	cmpi.w	#SPAboardmidr,SPA(a3)
	beq.w	.8
	cmpi.w	#SPAboardleft,SPA(a3)
	beq.w	.7
	cmpi.w	#SPAboardtop,SPA(a3)
	beq.w	.1
	cmpi.w	#SPAboardbot,SPA(a3)
	beq.w	.4
	bra.w	.20
.1
	move.w	#$124,d0
	cmpi.w	#$56,(FallXPos).w
	bgt.w	.2
	cmpi.w	#$FFAA,(FallXPos).w
	bgt.w	.3
.2
	move.w	#$116,d0
.3
	move.w	d0,Ypos(a3)
	bra.w	.20
.4
	move.w	#$FEDC,d0
	cmpi.w	#$56,(FallXPos).w
	bgt.w	.5
	cmpi.w	#$FFAA,(FallXPos).w
	bgt.w	.6
.5
	move.w	#$FEEA,d0
.6
	move.w	d0,Ypos(a3)
	bra.w	.20
.7
	move.w	#$90,(a3)
	btst	#3,attribute(a3)
	beq.w	.20
	move.w	#$FF70,(a3)
	bra.w	.20
	dc.b	$36,$BC,$00,$96,$08,$2B,$00,$03,$00,$04,$67,$00,$00,$2E,$36,$BC
	dc.b	$FF,$6A,$60,$00,$00,$26
.8
	move.w	#$FF70,(a3)
	btst	#3,attribute(a3)
	beq.w	.20
	move.w	#$90,(a3)
	bra.w	.20
.9
	move.w	#$FF6A,(a3)
	btst	#3,attribute(a3)
	beq.w	*+4
.20
	tst.w	position(a3)
	bmi.w	.32
	move.w	SCnum(a3),d0
	cmp.w	(puckc).w,d0
	beq.w	.top2
	bclr	#1,pflags3(a3)
.top2
	bsr.w	updateanim
	sub.b	d7,nopuck(a3)	;no puck control
	bpl.w	.np
	clr.b	nopuck(a3)	;clear upper byte of nopuck
.np
	sub.b	d7,$5F(a3)	;subtract # of frames from nopuck+1
	bpl.w	.np2
	clr.b	$5F(a3)	;clear lower byte of nopuck
.np2
	btst	#6,(sflags3).w	;check if penalty timer is up
	beq.w	.21
	clr.w	d0
	move.b	$67(a3),d0	;player offset on roster
	bmi.w	.21
	add.w	d0,d0
	addi.w	#$14C,d0
	jsr	(loadTeamStruct).l
	addq.w	#1,(a2,d0.w)	;add 1 to TOI for player
.21
	cmpi.w	#SPA17E4,SPA(a3)
	blt.w	.22
	cmpi.w	#SPA1F76,SPA(a3)
	ble.w	.done
.22
	move.w	(word_FFD284).w,d4
	tst.w	(PalMode).w
	beq.w	.23
	move.w	(word_FFD286).w,d4
.23
	cmpi.w	#2,(word_FFD268).w
	bne.w	.24
	btst	#3,pflags(a3)
	beq.w	.24
	addq.w	#2,d4
.24
	mulu.w	d7,d4
	cmpi.w	#SPA2B88,SPA(a3)
	beq.w	.done
	tst.w	Zpos(a3)
	bne.w	.29
	moveq	#6,d2
	btst	#0,pflags(a3)
	beq.w	.25
	moveq	#9,d2
.25
	move.w	Xvel(a3),d0
	beq.w	.27
	asr.w	d2,d0
	bne.w	.26
	moveq	#1,d0
.26
	sub.w	d0,Xvel(a3)
.27
	move.w	Yvel(a3),d0
	beq.w	.29
	asr.w	d2,d0
	bne.w	.28
	moveq	#1,d0
.28
	sub.w	d0,Yvel(a3)
.29
	move.w	Xvel(a3),d0
	beq.w	.30
	muls.w	d4,d0
	add.l	d0,(a3)
.30
	move.w	Yvel(a3),d0
	beq.w	.31
	muls.w	d4,d0
	add.l	d0,Ypos(a3)
.31
	tst.w	Zpos(a3)
	bmi.w	.done
	bne.w	.10
	tst.w	Zvel(a3)
	beq.w	.done
.10
	asl.w	#1,d4
	sub.w	d4,Zvel(a3)
	asl.w	#1,d4
	sub.w	d4,Zvel(a3)
	lsr.w	#2,d4
	move.w	Zvel(a3),d0
	muls.w	d4,d0
	add.l	d0,Zpos(a3)
	bpl.w	.done
	clr.l	Zpos(a3)
	neg.w	Zvel(a3)
	asr	Zvel(a3)
	moveq	#5,d0
	sub.b	Zvel(a3),d0
	bpl.w	.11
	clr.w	d0
.11
	cmp.w	#3,d0
	bhi.w	.done
	clr.w	d0
	addi.w	#$2C,d0
	move.w	d0,-(sp)
	jsr	(sfx).l
.done
	move.w	SCnum(a3),d6	;SCnum
	cmp.w	(puckc).w,d6	;check if puck carrier
	bne.w	.tp
	btst	#0,pflags2(a3)
	bne.w	.tp
	btst	#7,(sflags).w
	bne.w	.tp	;not puck carrier
	moveq	#-2,d4
	bsr.w	setpads
.tp
	btst	#0,(sflags2).w	;sf2faceoff- check for faceoff
	bne.w	.tp2	;branch if faceoff
	tst.w	(holdreset).w
	beq.w	.tp2
	subq.w	#1,(holdreset).w
	beq.w	.12
	bpl.w	.tp2
.12
	clr.w	(holdreset).w
	move.w	#$F0F,(bholdtimer).w
	move.w	#$F0F,(bholdtimer34).w
.tp2
	jsr	(updatepadinput).l
.32
	adda.w	#$80,a3	;SCstruct size
	cmpi.w	#$F,SCnum-SCstruct(a3)	;compare Sortobjs-1 to SCnum-SCstruct
	blt.w	.19	;loop for all Sort objects
	rts

updateanim	;Frame switch control on struct a3. Called from updateplayers
	tst.w	SPA(a3)	;test SPA
	bne.w	.ia	;branch if not 0
	bclr	#5,pflags(a3)	;clear anim lock
	bclr	#1,pflags2(a3)	;clear anim in progress
	rts
.ia
	movea.l	#SPAlist,a0	;animation data tables
	adda.w	SPA(a3),a0	;add SPA to a0 address
	move.w	$10(a0),d1
	move.w	facedir(a3),d0
	btst	#7,(sflags).w
	beq.w	.2
	cmpi.w	#$C,SCnum(a3)
	bge.w	.2
	subq.w	#2,d0
	andi.w	#7,d0
.2
	btst	#3,attribute(a3)	;x flip flag
	beq.w	.nox	;branch if no flip
	neg.w	d0	;negate d0
	addq.w	#8,d0	;add 8 to d0 for flipping
	andi.w	#7,d0	;pass first 3 bits
.nox
	asl.w	#1,d0	;mult by 2
	adda.w	(a0,d0.w),a0	;add the direction offset: a0 = this direction's frame,time pairs
	move.w	SPAnum(a3),d0	;SPANum into d0 (index into animation)
	move.w	(a0,d0.w),d2	;the new SPF frame of this animation
	tst.w	SPAcnt(a3)	;check if SPAcnt is 0 (time for a new frame)
	bmi.w	.1	;branch if so (SPAcnt is negative)
	sub.w	d7,SPAcnt(a3)	;sub frames elasped from SPAcnt
	bpl.w	.cframe	;branch if SPAcnt is positive
	btst	#0,(gmode).w
	beq.w	.3
	cmpi.w	#SPA3300,SPA(a3)
	bne.w	.3
	cmpi.w	#8,SPAnum(a3)
	bne.w	.3
	move.w	#$2F,-(sp)
	jsr	(sfx).l
.3
	btst	#4,(sflags9).w
	beq.w	.4
	cmpi.w	#SPA0AA2,SPA(a3)
	bne.w	.4
	cmpi.w	#$10,SPAnum(a3)
	bne.w	.4
	move.w	#$30,-(sp)
	jsr	(sfx).l
.4
	addq.w	#4,SPAnum(a3)	;add 4 to SPAnum (set for next index)
	addq.w	#4,d0	;add 4 to d0 (currently holds current index)
	tst.w	-2(a0,d0.w)	;the frame time for the previous frame
	bpl.w	.1	;branch if positive (not the end of the animation)
	cmpi.w	#SPA037A,SPA(a3)
	bne.w	.5
	bset	#1,(sflags12).w
.5
	clr.w	d0	;loop from the start
	clr.w	SPAnum(a3)
	bclr	#5,pflags(a3)	;clear animation lock
	bclr	#1,pflags2(a3)
	bclr	#5,pflags3(a3)
	btst	#0,d1
	bne.w	.1
	clr.w	SPA(a3)	;clear SPA
.1
	move.w	2(a0,d0.w),d0	;move frame time for animation frame into d0
	bpl.w	.0	;branch if positive
	neg.w	d0	;make d0 positive (this is the case if final frame)
.0
	move.w	d0,SPAcnt(a3)	;move d0 into SPAcnt
.cframe
	sub.b	d7,$66(a3)	;sub frames elapsed from glitch - limit minimum time between frame switches
	bpl.w	.rtss	;branch if glitch is positive still
	clr.b	$66(a3)	;clear glitch
	cmp.w	frame(a3),d2	;compare frame to d2
	beq.w	.rtss	;branch if equal
	move.w	d2,frame(a3)	;move d2 into frame
	move.b	#4,$66(a3)	;move 4 into glitch - /60 sec min frame switch time
.rtss
	rts

LockScroll	;xc1 / yc1 = Hpos / Vpos, sflags bit 6
	move.w	(Vpos).w,(yc1).w
	move.w	(Hpos).w,(xc1).w
	bset	#6,(sflags).w
	rts

checkwindow	;Scroll the window one step toward xc1 / yc1 (sflags bit 6) or the puck carrier
	move.w	(yc1).w,d2
	move.w	(xc1).w,d3
	btst	#6,(sflags).w
	bne.w	.dd
	movea.w	#(puckx-M68K_RAM),a3
	move.w	(puckc).w,d0
	bmi.w	.ok
	asl.w	#7,d0
	movea.w	#(SortCords-M68K_RAM),a3
	adda.w	d0,a3
	move.w	d7,d0
	add.w	d0,d0
	btst	#7,pflags(a3)
	beq.w	.gd
	add.w	d0,(yleader).w
	cmpi.w	#$32,(yleader).w
	blt.w	.ok
	move.w	#$32,(yleader).w
	bra.w	.ok
.gd
	sub.w	d0,(yleader).w
	cmpi.w	#$FFCE,(yleader).w
	bgt.w	.ok
	move.w	#$FFCE,(yleader).w
.ok
	move.w	Yvel(a3),d2
	asr.w	#7,d2
	add.w	Ypos(a3),d2
	add.w	(yleader).w,d2
	move.w	(a3),d3
	move.w	d2,(yc1).w
	move.w	d3,(xc1).w
.dd
	move.w	d2,d0
	sub.w	(Vpos).w,d0
	cmp.w	#$FFF6,d0
	bge.w	.3
	move.w	d2,d1
	subi.w	#$FFF6,d1
	cmp.w	#$FF18,d1
	bgt.w	.4
	move.w	#$FF18,d1
	bra.w	.4
.3
	cmp.w	#$A,d0
	ble.w	.2x
	move.w	d2,d1
	subi.w	#$A,d1
	cmp.w	#$F8,d1
	blt.w	.4
	move.w	#$F8,d1
.4
	sub.w	(Vpos).w,d1
	beq.w	.2x
	asr.w	#4,d1
	bne.w	.9
	addq.w	#1,d1
.9
	add.w	d1,(Vpos).w
.2x
	move.w	d3,d0
	sub.w	(Hpos).w,d0
	cmp.w	#$FFD8,d0
	bge.w	.7
	move.w	d3,d1
	subi.w	#$FFD8,d1
	cmp.w	#$FFC4,d1
	bge.w	.8
	move.w	#$FFC4,d1
	bra.w	.8
.7
	cmp.w	#$28,d0
	ble.w	.1
	move.w	d3,d1
	subi.w	#$28,d1
	cmp.w	#$3C,d1
	ble.w	.8
	move.w	#$3C,d1
.8
	sub.w	(Hpos).w,d1
	beq.w	.1
	asr.w	#4,d1
	bne.w	.0
	addq.w	#1,d1
.0
	add.w	d1,(Hpos).w
.1
	rts

getGoalieSCnum	;d0 = SCnum of the goalie of the team of player d0 (the first position 0 going down
	;from player d0), -1 none
	movem.l	d1/a0,-(sp)
	movea.l	#SortCords,a0
	asl.w	#7,d0
	adda.w	d0,a0
	move.w	#5,d1
.0
	tst.w	position(a0)
	beq.w	.1
	suba.w	#$80,a0
	dbf	d1,.0
	move.w	#$FFFF,d0
	bra.w	.end
.1
	move.w	SCnum(a0),d0
.end
	movem.l	(sp)+,d1/a0
	rts
	;The burst code again; nothing reaches this copy.
	;Code the listing does not decode: kept as bytes
	dc.b	$4E,$B9,$00,$01,$FB,$24,$4A,$78,$D2,$64,$66,$00,$00,$1A,$04,$40
	dc.b	$00,$BA,$4E,$B9,$00,$01,$FB,$44,$08,$38,$00,$04,$C3,$4A,$67,$00
	dc.b	$00,$06,$30,$3C,$10,$00,$EE,$48,$32,$00,$34,$2B,$00,$54,$E5,$42
	dc.b	$20,$7C,$00,$01,$AE,$60,$C1,$F0,$20,$00,$C3,$F0,$20,$02,$D1,$6B
	dc.b	$00,$28,$D3,$6B,$00,$2A,$4E,$75

burst	;C button speed burst: take $BA energy unless OptLine is set, add a facedir push to Xvel / Yvel and set
	;SPAburst. Jumped to from doinput
	jsr	(getpde).l	;get players energy
	tst.w	(OptLine).w
	bne.w	.0
	subi.w	#$BA,d0
	jsr	(setpde).l	;decrease players energy
	btst	#4,(sflags7).w
	beq.w	.0
	move.w	#$1000,d0
.0
	lsr.w	#7,d0	;d0 will be $1000 with lines off
	move.w	d0,d1	;energy = speed increase (check violence)
	move.w	facedir(a3),d2	;facedir
	asl.w	#2,d2
	movea.l	#dirtab,a0
	muls.w	(a0,d2.w),d0
	muls.w	2(a0,d2.w),d1
	add.w	d0,Xvel(a3)
	add.w	d1,Yvel(a3)
	bset	#5,pflags(a3)
	move.w	#SPAburst,d1
	bra.w	SetSPA

holdplayer	;Hold check (SPAhook, SPAHold with the stick up); a puck carrier the checked player stops loses the puck.
	;Jumped to from doinput
	bset	#5,pflags(a3)	;lock animation
	move.w	#SPAhook,d1	;move anim into d1 - normal hold check
	tst.w	impact(a3)	;check if impact = 0
	beq.w	SetSPA
	movea.w	#(SortCords-M68K_RAM),a0	;move SortCord into a0
	move.w	impactp(a3),d0	;move last impact player into d0
	asl.w	#7,d0	;calc offset
	adda.w	d0,a0	;add offset to a0
	bset	#5,pflags(a3)	;lock animation
	move.w	#SPAhook,d1	;move anim into d1 - normal hold check
	tst.w	impact(a3)	;check if impact = 0
	beq.w	.2	;set anim if 0
	btst	#4,pflags3(a0)
	bne.w	.0
	cmpi.w	#$76,(a0)
	bgt.w	.0
	cmpi.w	#$FF8A,(a0)
	blt.w	.0
	cmpi.w	#$136,Ypos(a0)
	bgt.w	.0
	cmpi.w	#$FECA,Ypos(a0)
	blt.w	.0
	bra.w	.1
.0
	move.w	#SPA16EE,d1
	bra.w	.2
.1
	move.w	Ypos(a3),d0	;move Ypos checker into d0
	sub.w	Ypos(a0),d0	;sub Ypos of player
	btst	#7,pflags(a3)	;check goal checker is shooting at
	beq.w	.air	;jump if bottom
	neg.w	d0	;make d0 negative
.air
	bmi.w	.2
	move.w	#SPAHold,d1	;set anim - hold check stick in air
.2
	btst	#3,pflags(a0)
	beq.w	SetSPA
	tst.w	position(a0)
	beq.w	SetSPA
	move.w	(puckc).w,d0
	cmp.w	SCnum(a0),d0
	bne.w	SetSPA
	move.w	Xvel(a0),d0
	or.w	Yvel(a0),d0
	bne.w	SetSPA
	st	(puckc).w
	move.b	#$1E,nopuck(a0)
	bra.w	SetSPA

chgplayer	;The pad d4 takes the nearest free skater to where the puck is going (not a goalie, not locked or
	;unavailable; in a penalty shot / shootout only BA_Sktr_SCnum or BA_Goalie_SCnum), or sweep checks when it is the
	;same one. Jumped to from doinput
	btst	#6,(sflags5).w	;Check bit 6
	bne.w	.6
	movem.l	d0-d6/a0-a1,-(sp)
	move.w	(puckvx).w,d0	;lead puck slightly
	asr.w	#8,d0
	add.w	(puckx).w,d0
	move.w	(puckvy).w,d1
	asr.w	#8,d1
	add.w	(pucky).w,d1
	movem.w	d0-d1,-(sp)
	moveq	#5,d2
	move.w	d4,d3
	moveq	#-1,d5
	movea.l	#c1playernum,a0
	move.w	(a0,d4.w),d6
	movea.w	#(SortCords-M68K_RAM),a0	;start of search
	movea.w	#(cont1team-M68K_RAM),a1
	cmpi.w	#1,(a1,d4.w)
	beq.w	.t1
	adda.w	#$300,a0	;controller is on other team
.t1
	movea.w	#(c1playernum-M68K_RAM),a1
.top
	tst.w	position(a0)	;position
	bne.w	.3
	tst.w	(puckc).w
	bmi.w	.3
	movem.w	d1,-(sp)
	move.w	SCnum(a0),d1	;SCnum
	cmp.w	(a1,d4.w),d1
	movem.w	(sp)+,d1
	beq.w	.4
.3
	tst.w	position(a0)	;position
	ble.w	.next	;cant switch to goalie
.4
	btst	#2,pflags2(a0)	;#pf2unav
	bne.w	.next	;this player is unavailable for some reason
	movem.w	d1,-(sp)
	move.w	SCnum(a0),d1	;SCnum
	cmp.w	(a1,d4.w),d1
	movem.w	(sp)+,d1
	beq.w	.0
	btst	#3,pflags(a0)	;is player controlled?
	bne.w	.next	;yes branch
.0
	btst	#2,(BA_PS_flags).w
	beq.w	.1
	movem.l	d0,-(sp)
	move.w	(BA_Sktr_SCnum).w,d0
	cmp.w	SCnum(a0),d0
	movem.l	(sp)+,d0
	beq.w	.1
	movem.l	d0,-(sp)
	move.w	(BA_Goalie_SCnum).w,d0
	cmp.w	SCnum(a0),d0
	movem.l	(sp)+,d0
	bne.w	.next
.1
	movem.w	d1,-(sp)	;the pad's own player may be locked
	move.w	SCnum(a0),d1
	cmp.w	(a1,d4.w),d1
	movem.w	(sp)+,d1
	beq.w	.2
	btst	#5,pflags(a0)
	bne.w	.next
.2
	movem.w	(sp),d0-d1
	sub.w	(a0),d0	;Xpos
	muls.w	d0,d0
	sub.w	Ypos(a0),d1	;Ypos
	muls.w	d1,d1
	add.l	d1,d0
	cmp.l	d5,d0
	bhi.w	.next
	btst	#3,pflags(a0)
	beq.w	.5
	move.w	SCnum(a0),d1
	cmp.w	(a1,d4.w),d1
	bne.w	.next
	btst	#5,pflags(a0)
	beq.w	.5
	cmpi.w	#SPA2576,SPA(a0)
	beq.w	.next
	cmpi.w	#SPA26C8,SPA(a0)
	beq.w	.next
.5
	move.w	SCnum(a0),d1
	move.l	d0,d5
	move.w	d1,d6
.next
	adda.w	#$80,a0	;size of SCstruct
	dbf	d2,.top
	tst.l	d5
	bpl.w	.found
	tst.w	(a1,d4.w)
	bpl.w	.found
	tst.w	d6
	bpl.w	.found
	addq.w	#4,sp
	pea	(.ex).l
	rts
.found
	addq.w	#4,sp
	pea	(.ex).l
	cmp.w	(a1,d4.w),d6
	beq.w	.7	;player is same so sweep check
	move.w	d6,d0	;d0 now is new player
	jmp	setcplayer
.ex
	movem.l	(sp)+,d0-d6/a0-a1
.6
	rts
.7
	btst	#5,pflags(a3)
	beq.w	.8
	rts
.8
	tst.w	position(a3)
	beq.w	.9
	jmp	Sweepcheck
.9
	bset	#5,pflags(a3)
	move.w	#$52C,d1
	jmp	SetSPA

setcplayer	;Give pad d4 (0 / 2 / 4 / 6) player d0: restorepl the old one, then c1playernum + d4 = d0.
	;Jumped to from chgplayer
	movem.l	d0/a0-a1,-(sp)
	movea.l	#c1playernum,a0
	cmp.w	(a0,d4.w),d0
	beq.w	.x
	movem.w	d0-d1,-(sp)
	subq.w	#6,d0
	move.w	(a0,d4.w),d1
	bpl.w	.0
	movem.w	(sp)+,d0-d1
	bra.w	.1
.0
	subq.w	#6,d1
	eor.w	d0,d1
	movem.w	(sp)+,d0-d1
	bmi.w	.2
.1
	asr.w	#1,d4
	movea.l	#unk_FFC38C,a1
	st	(a1,d4.w)
	add.w	d4,d4
	move.w	(a0,d4.w),d1
	jsr	(restorepl).l
	move.w	d0,(a0,d4.w)
.x
	movem.l	(sp)+,d0/a0-a1
	rts
.2
	bra.s	.x

setc1player	;Give pad 1 player d0 (setcplayer, d4 = 0)
	move.w	d4,-(sp)
	clr.w	d4
	bsr.s	setcplayer
	move.w	(sp)+,d4
	rts

setc2player	;Give pad 2 player d0 (setcplayer, d4 = 2)
	move.w	d4,-(sp)
	move.w	#2,d4
	bsr.s	setcplayer
	move.w	(sp)+,d4
	rts

setc3player	;Give pad 3 player d0 (setcplayer, d4 = 4)
	move.w	d4,-(sp)
	move.w	#4,d4
	bsr.s	setcplayer
	move.w	(sp)+,d4
	rts

setc4player	;Give pad 4 player d0 (setcplayer, d4 = 6)
	move.w	d4,-(sp)
	move.w	#6,d4
	bsr.w	setcplayer
	move.w	(sp)+,d4
	rts

Sweepcheck	;Sweep check animation for player a3 (SPA052C for a goalie, else SPA216A)
	move.w	#SPA216A,d1
	tst.w	position(a3)
	bne.w	.0
	move.w	#SPA052C,d1
.0
	bset	#5,pflags(a3)
	bra.w	SetSPA

restorepl	;d1 = old player (back to the computer), d0 = new player (joystick controlled)
	movem.l	a0,-(sp)
	movea.l	#SortCords,a0
	tst.w	d1
	blt.w	.spd
	cmp.w	#$B,d1
	bgt.w	.spd
	asl.w	#7,d1	;multiply d0 by 80 hex (SCsize)
	btst	#3,pflags2(a0,d1.w)	;#pfnp - no joystick pad
	beq.w	.cont
	lsr.w	#7,d1	;divide by 80 hex
	move.w	d1,d0
	bra.w	.ex
.cont
	bclr	#3,pflags(a0,d1.w)	;#pfjoycon
	btst	#3,pflags3(a0,d1.w)	;bit 3, pflags3
	bne.w	.spd
	bset	#1,pflags(a0,d1.w)	;#pfna - new assignment
.spd
	tst.w	d0	;checks if d0 0 or higher
	blt.w	.ex
	cmp.w	#$B,d0	;checks if d0 11 or less
	bgt.w	.ex
	move.w	d0,d1	;copies d0 into d1
	asl.w	#7,d1
	btst	#2,(BA_PS_flags).w
	bne.w	.chkgoalie
	btst	#0,(gmode2).w
	beq.w	.3
.chkgoalie
	tst.w	position(a0,d1.w)
	bne.w	.3
	btst	#6,pflags(a0,d1.w)	;check if home or away
	beq.w	.0
	tst.w	(goaliemode2).w
	bra.w	.1
.0
	tst.w	(goaliemode1).w
.1
	beq.w	.3
	bra.w	.ex	;the goalie stays with the computer
.3
	bset	#3,pflags(a0,d1.w)	;set pfjoycon for SCNum
.ex
	movem.l	(sp)+,a0
	rts

sub_16D36	;Direction d0 made relative to facedir and the x flip, then tested against the mask $1E (or $F0 when
	;flipped): the zero flag
	movem.l	d0-d1,-(sp)
	move.w	#8,d1
	sub.w	facedir(a3),d1
	andi.w	#7,d1
	add.w	d1,d0
	andi.w	#7,d0
	btst	#3,attribute(a3)
	beq.w	.0
	btst	d0,#$1E
	movem.l	(sp)+,d0-d1
	rts
.0
	btst	d0,#$F0
	movem.l	(sp)+,d0-d1
	rts

setpads	;Put SCnum of a3 in the d4 nibble of PadControlBits; d4 = -2 puck carrier, 0 / 2 / 4 / 6 pads.
	;In a shootout only for a pad controlled player (pflags bit 3) or the puck carrier
	movem.l	d0-d1,-(sp)
	btst	#0,(gmode2).w
	beq.w	.0
	btst	#3,pflags(a3)
	bne.w	.0
	move.w	(puckc).w,d0	;puck carrier SCnum into d0
	cmp.w	SCnum(a3),d0	;is player puck carrier?
	bne.w	.1
.0
	moveq	#2,d0
	add.w	d4,d0
	add.w	d0,d0
	moveq	#-16,d1
	rol.l	d0,d1
	and.l	d1,(PadControlBits).w
	clr.l	d1
	move.w	SCnum(a3),d1
	asl.l	d0,d1
	or.l	d1,(PadControlBits).w
.1
	movem.l	(sp)+,d0-d1
	rts

check4bench	;Check if player a3 should go to the bench (called from the assignment code).
	;Code the listing does not decode: kept as bytes
	dc.b	$08,$38,$00,$02,$C3,$40,$66,$F6,$08,$2B,$00,$03,$00,$62,$66,$EE
	dc.b	$08,$2B,$00,$04,$00,$63,$66,$E6,$4A,$2B,$00,$60,$6A,$00,$00,$08
	dc.b	$4A,$2B,$00,$61,$6B,$D8,$10,$2B,$00,$61,$B0,$2B,$00,$67,$67,$00
	dc.b	$00,$2A,$30,$2B,$00,$36,$0C,$33,$00,$0B,$00,$38,$67,$C0,$30,$2B
	dc.b	$00,$52,$B0,$78,$B7,$BE,$67,$B6,$58,$4F,$08,$EB,$00,$02,$00,$63
	dc.b	$42,$6B,$00,$40,$70,$0B,$60,$00,$35,$D4,$58,$4F,$08,$AB,$00,$02
	dc.b	$00,$63,$08,$AB,$00,$02,$00,$62,$50,$EB,$00,$61,$50,$EB,$00,$60
	dc.b	$30,$2B,$00,$34,$4A,$2B,$00,$60,$6A,$00,$00,$08,$4E,$F9,$00,$01
	dc.b	$FE,$58,$10,$2B,$00,$60,$48,$80,$37,$40,$00,$34,$4E,$F9,$00,$01
	dc.b	$FE,$58

assbench	;asstab entry: player a3 should go to the bench.
	;Code the listing does not decode: kept as bytes
	dc.b	$08,$2B,$00,$05,$00,$62,$66,$00,$FF,$64,$0C,$6B,$00,$64,$00,$40
	dc.b	$67,$00,$01,$0E,$61,$00,$FF,$58,$08,$2B,$00,$04,$00,$63,$66,$00
	dc.b	$35,$5E,$08,$AB,$00,$01,$00,$62,$67,$00,$00,$2C,$37,$7C,$00,$08
	dc.b	$00,$42,$70,$50,$08,$2B,$00,$06,$00,$62,$66,$00,$00,$04,$44,$40
	dc.b	$37,$40,$00,$46,$37,$7C,$00,$96,$00,$44,$44,$6B,$00,$44,$51,$6B
	dc.b	$00,$44,$42,$6B,$00,$40,$10,$2B,$00,$61,$B0,$2B,$00,$67,$67,$00
	dc.b	$01,$0E,$9F,$6B,$00,$40,$6A,$00,$00,$EC,$50,$6B,$00,$40,$30,$2B
	dc.b	$00,$14,$90,$6B,$00,$46,$B0,$7C,$00,$28,$6E,$00,$00,$D8,$B0,$7C
	dc.b	$FF,$D8,$6D,$00,$00,$D0,$30,$13,$90,$6B,$00,$44,$B0,$7C,$00,$20
	dc.b	$6E,$00,$00,$C2,$32,$3C,$08,$56,$4A,$6B,$00,$34,$66,$00,$00,$06
	dc.b	$32,$3C,$06,$40,$61,$00,$37,$2E,$08,$EB,$00,$02,$00,$62,$0C,$6B
	dc.b	$00,$04,$00,$54,$67,$00,$00,$0C,$52,$6B,$00,$54,$02,$6B,$00,$07
	dc.b	$00,$54,$42,$6B,$00,$2A,$37,$7C,$F8,$00,$00,$28,$B0,$7C,$00,$10
	dc.b	$6E,$00,$00,$4C,$42,$6B,$00,$28,$0C,$6B,$00,$04,$00,$54,$66,$00
	dc.b	$00,$3E,$37,$7C,$F8,$00,$00,$28,$37,$7C,$00,$02,$00,$54,$32,$3C
	dc.b	$0D,$BC,$36,$BC,$FF,$62,$42,$6B,$00,$28,$4A,$6B,$00,$34,$66,$00
	dc.b	$00,$0E,$32,$3C,$0E,$40,$36,$BC,$FF,$62,$42,$6B,$00,$28,$61,$00
	dc.b	$36,$C4,$08,$EB,$00,$05,$00,$62,$37,$7C,$00,$64,$00,$40,$4E,$75
	dc.b	$42,$6B,$00,$06,$42,$40,$10,$2B,$00,$67,$D0,$40,$20,$7C,$FF,$FF
	dc.b	$C7,$26,$08,$2B,$00,$06,$00,$62,$67,$00,$00,$06,$D0,$FC,$03,$9E
	dc.b	$31,$BC,$FF,$FE,$00,$6C,$16,$2B,$00,$61,$61,$00,$00,$28,$4E,$F9
	dc.b	$00,$01,$FE,$A0,$08,$2B,$00,$02,$00,$62,$66,$C2,$30,$2B,$00,$44
	dc.b	$32,$2B,$00,$46,$20,$7C,$00,$01,$87,$3A,$60,$00,$30,$A4,$08,$AB
	dc.b	$00,$02,$00,$63,$10,$2B,$00,$60,$48,$80,$37,$40,$00,$34,$4E,$B9
	dc.b	$00,$01,$FE,$58,$50,$EB,$00,$61,$50,$EB,$00,$60,$4E,$75

asseben	;asstab entry: player a3 should exit the bench area.
	;Code the listing does not decode: kept as bytes
	dc.b	$08,$2B,$00,$05,$00,$62,$66,$F6,$08,$AB,$00,$01,$00,$62,$67,$00
	dc.b	$00,$54,$42,$6B,$00,$28,$42,$6B,$00,$2A,$30,$2B,$00,$52,$5D,$40
	dc.b	$6B,$00,$00,$04,$52,$40,$C1,$FC,$00,$0E,$37,$40,$00,$14,$36,$BC
	dc.b	$00,$96,$44,$53,$37,$7C,$00,$02,$00,$54,$08,$EB,$00,$05,$00,$62
	dc.b	$32,$3C,$0D,$7A,$36,$BC,$FF,$62,$42,$6B,$00,$28,$4A,$6B,$00,$34
	dc.b	$66,$00,$00,$0E,$32,$3C,$0D,$FE,$36,$BC,$FF,$62,$42,$6B,$00,$28
	dc.b	$60,$00,$35,$E4,$37,$7C,$00,$04,$00,$54,$08,$AB,$00,$02,$00,$62
	dc.b	$08,$AB,$00,$05,$00,$63,$08,$AB,$00,$02,$00,$63,$42,$6B,$00,$58
	dc.b	$37,$7C,$10,$00,$00,$28,$60,$00,$33,$68

asspenalty	;asstab entry: player a3 goes to the penalty box.
	;Code the listing does not decode: kept as bytes
	dc.b	$08,$2B,$00,$05,$00,$62,$66,$00,$FF,$6C,$08,$AB,$00,$01,$00,$62
	dc.b	$67,$00,$00,$70,$08,$EB,$00,$02,$00,$63,$61,$00,$01,$36,$78,$FE
	dc.b	$61,$00,$FC,$F0,$37,$7C,$00,$08,$00,$42,$70,$0B,$12,$38,$C3,$EC
	dc.b	$08,$2B,$00,$06,$00,$62,$66,$00,$00,$06,$E8,$49,$44,$40,$02,$41
	dc.b	$00,$0F,$B2,$7C,$00,$02,$63,$00,$00,$04,$72,$02,$56,$41,$C3,$C0
	dc.b	$37,$41,$00,$46,$32,$3C,$00,$26,$08,$2B,$00,$06,$00,$62,$66,$00
	dc.b	$00,$06,$32,$3C,$FF,$BE,$37,$41,$00,$46,$37,$7C,$00,$8E,$00,$44
	dc.b	$42,$6B,$00,$40,$08,$EB,$00,$05,$00,$63,$42,$6B,$00,$4E,$42,$6B
	dc.b	$00,$50,$30,$2B,$00,$14,$90,$6B,$00,$46,$B0,$7C,$00,$0C,$6E,$00
	dc.b	$00,$B0,$B0,$7C,$FF,$F4,$6D,$00,$00,$A8,$30,$13,$90,$6B,$00,$44
	dc.b	$B0,$7C,$FF,$E8,$6D,$00,$00,$9A,$9F,$6B,$00,$40,$6A,$00,$FE,$C6
	dc.b	$50,$6B,$00,$40,$08,$EB,$00,$02,$00,$62,$32,$3C,$08,$56,$61,$00
	dc.b	$34,$FC,$74,$06,$08,$2B,$00,$00,$00,$77,$67,$00,$00,$04,$74,$02
	dc.b	$B4,$6B,$00,$54,$67,$00,$00,$0C,$52,$6B,$00,$54,$02,$6B,$00,$07
	dc.b	$00,$54,$42,$6B,$00,$2A,$37,$7C,$10,$00,$00,$28,$B0,$7C,$FF,$F8
	dc.b	$6D,$00,$FE,$82,$42,$6B,$00,$28,$B4,$6B,$00,$54,$66,$00,$FE,$76
	dc.b	$08,$EB,$00,$05,$00,$62,$37,$7C,$00,$02,$00,$54,$36,$BC,$00,$8E
	dc.b	$37,$7C,$00,$26,$00,$14,$08,$2B,$00,$06,$00,$62,$66,$00,$00,$08
	dc.b	$37,$7C,$FF,$BE,$00,$14,$08,$AB,$00,$03,$00,$04,$32,$3C,$0A,$A2
	dc.b	$61,$00,$34,$8A,$08,$AB,$00,$04,$00,$63,$70,$0D,$60,$00,$32,$44
	dc.b	$30,$2B,$00,$44,$32,$2B,$00,$46,$20,$7C,$00,$01,$F8,$4A,$60,$00
	dc.b	$2E,$A8,$08,$2B,$00,$03,$00,$62,$67,$00,$FE,$1A,$42,$44,$30,$2B
	dc.b	$00,$52,$B0,$78,$C3,$84,$67,$00,$F8,$86,$78,$02,$B0,$78,$C3,$86
	dc.b	$67,$00,$F8,$7C,$38,$3C,$00,$04,$B0,$78,$C3,$88,$67,$00,$F8,$70
	dc.b	$38,$3C,$00,$06,$60,$00,$F8,$68

assdopen	;asstab entry: player a3 serves his penalty.
	;Code the listing does not decode: kept as bytes
	dc.b	$08,$2B,$00,$05,$00,$62,$66,$00,$00,$26,$08,$AB,$00,$01,$00,$62
	dc.b	$67,$00,$00,$1C,$70,$10,$08,$2B,$00,$06,$00,$62,$67,$00,$00,$04
	dc.b	$70,$01,$D1,$38,$C3,$EC,$50,$EB,$00,$34,$42,$6B,$00,$06,$4E,$75

assepen	;asstab entry: player a3 leaves the penalty box.
	;Code the listing does not decode: kept as bytes
	dc.b	$08,$2B,$00,$05,$00,$62,$66,$00,$FD,$B4,$08,$AB,$00,$01,$00,$62
	dc.b	$67,$00,$00,$68,$08,$EB,$00,$02,$00,$62,$08,$EB,$00,$02,$00,$63
	dc.b	$70,$10,$72,$C4,$08,$2B,$00,$06,$00,$62,$67,$00,$00,$06,$70,$01
	dc.b	$44,$41,$91,$38,$C3,$EC,$37,$41,$00,$14,$42,$6B,$00,$28,$42,$6B
	dc.b	$00,$2A,$36,$BC,$00,$94,$36,$BC,$00,$8E,$37,$7C,$00,$26,$00,$14
	dc.b	$08,$2B,$00,$06,$00,$62,$66,$00,$00,$08,$37,$7C,$FF,$BE,$00,$14
	dc.b	$37,$7C,$00,$04,$00,$54,$08,$EB,$00,$05,$00,$62,$32,$3C,$0A,$F4
	dc.b	$61,$00,$33,$92,$4E,$F9,$00,$02,$13,$AE,$32,$3C,$08,$56,$61,$00
	dc.b	$33,$84,$37,$7C,$00,$04,$00,$54,$50,$EB,$00,$61,$50,$EB,$00,$60
	dc.b	$08,$AB,$00,$03,$00,$62,$08,$AB,$00,$02,$00,$62,$08,$AB,$00,$05
	dc.b	$00,$63,$08,$AB,$00,$02,$00,$63,$37,$7C,$F0,$00,$00,$28,$60,$00
	dc.b	$30,$FE

assgoaliebreakwait	;asstab entry: in a shootout or penalty shot park the idle goalie off the ice.
	;Code the listing does not decode: kept as bytes
	dc.b	$08,$2B,$00,$05,$00,$62,$66,$00,$00,$50,$08,$38,$00,$02,$C3,$40
	dc.b	$66,$00,$00,$12,$08,$38,$00,$00,$C3,$48,$66,$00,$00,$08,$4E,$71
	dc.b	$60,$00,$30,$DA,$42,$6B,$00,$28,$42,$6B,$00,$2A,$48,$E7,$80,$80
	dc.b	$20,$7C,$FF,$FF,$B0,$5E,$30,$38,$D2,$D6,$EF,$40,$D0,$C0,$37,$7C
	dc.b	$01,$91,$00,$14,$08,$28,$00,$07,$00,$62,$66,$00,$00,$08,$37,$7C
	dc.b	$FE,$6F,$00,$14,$4C,$DF,$01,$01,$4E,$75,$4E,$75

donothing	;Unless locked or pad controlled, player a3 just skates (jumped to from the fight and assignment code).
	;Code the listing does not decode: kept as bytes
	dc.b	$08,$2B,$00,$05,$00,$62,$66,$F6,$08,$2B,$00,$03,$00,$62,$66,$EE
	dc.b	$70,$08,$60,$00,$32,$F8

assstanley	;asstab entry: player a3 skates with the Stanley Cup overhead.
	;Code the listing does not decode: kept as bytes
	dc.b	$08,$2B,$00,$05,$00,$62,$66,$E0,$08,$AB,$00,$01,$00,$62,$67,$00
	dc.b	$00,$22,$37,$7C,$00,$5A,$00,$44,$4A,$78,$BD,$32,$6A,$00,$00,$06
	dc.b	$44,$6B,$00,$44,$37,$78,$BD,$2E,$00,$46,$32,$3C,$0C,$A0,$61,$00
	dc.b	$32,$B0,$30,$2B,$00,$44,$90,$53,$32,$2B,$00,$46,$92,$6B,$00,$14
	dc.b	$61,$00,$30,$78,$B0,$7C,$00,$07,$6E,$9E,$34,$00,$37,$42,$00,$54
	dc.b	$60,$00,$37,$D0

assscore	;asstab entry: player a3 celebrates a goal.
	;Code the listing does not decode: kept as bytes
	dc.b	$08,$2B,$00,$05,$00,$62,$66,$8C,$08,$AB,$00,$01,$00,$62,$67,$00
	dc.b	$00,$24,$61,$00,$00,$A2,$37,$7C,$00,$08,$00,$42,$37,$7C,$00,$5A
	dc.b	$00,$44,$4A,$78,$BD,$32,$6A,$00,$00,$06,$44,$6B,$00,$44,$37,$78
	dc.b	$BD,$2E,$00,$46,$20,$7C,$00,$01,$F8,$4A,$30,$2B,$00,$44,$32,$2B
	dc.b	$00,$46,$08,$38,$00,$00,$C3,$48,$67,$00,$00,$2A,$4A,$78,$DC,$C4
	dc.b	$67,$00,$00,$10,$53,$78,$DC,$C4,$66,$00,$00,$08,$08,$F8,$00,$02
	dc.b	$C3,$3C,$0C,$53,$00,$96,$6E,$00,$00,$0A,$0C,$53,$FF,$6A,$6E,$00
	dc.b	$00,$04,$42,$41,$9F,$6B,$00,$40,$6A,$00,$00,$48,$08,$EB,$00,$05
	dc.b	$00,$62,$32,$3C,$0C,$7E,$08,$38,$00,$00,$D2,$79,$67,$00,$00,$06
	dc.b	$32,$3C,$0D,$0E,$30,$38,$BF,$0A,$B0,$6B,$00,$52,$66,$00,$00,$14
	dc.b	$32,$3C,$0C,$30,$08,$38,$00,$03,$D2,$79,$66,$00,$00,$06,$32,$3C
	dc.b	$0D,$28,$61,$00,$31,$D8,$70,$78,$61,$00,$3C,$64,$37,$40,$00,$40
	dc.b	$4E,$75,$08,$2B,$00,$03,$00,$62,$67,$00,$2B,$FE,$4E,$75,$4E,$75
	dc.b	$4E,$75

assgoaliectrl	;asstab entry: the goalie of a pad.
	;Code the listing does not decode: kept as bytes
	dc.b	$08,$2B,$00,$03,$00,$62,$66,$00,$00,$06,$60,$00,$2F,$58,$08,$2B
	dc.b	$00,$01,$00,$62,$66,$00,$00,$94,$48,$A7,$C0,$00,$30,$13,$32,$2B
	dc.b	$00,$14,$B2,$7C,$00,$AA,$6E,$00,$00,$22,$B2,$7C,$FF,$56,$6D,$00
	dc.b	$00,$1A,$08,$38,$00,$00,$C3,$38,$66,$00,$00,$10,$3F,$00,$30,$3C
	dc.b	$00,$08,$4E,$B9,$00,$01,$C1,$D2,$30,$1F,$90,$78,$BD,$32,$92,$78
	dc.b	$BD,$2E,$08,$AB,$00,$02,$00,$64,$B0,$7C,$00,$74,$6D,$00,$00,$0C
	dc.b	$08,$EB,$00,$02,$00,$64,$60,$00,$00,$34,$B0,$7C,$FF,$8C,$6E,$00
	dc.b	$00,$0C,$08,$EB,$00,$02,$00,$64,$60,$00,$00,$22,$B2,$7C,$00,$64
	dc.b	$6D,$00,$00,$0C,$08,$EB,$00,$02,$00,$64,$60,$00,$00,$10,$B2,$7C
	dc.b	$FF,$9C,$6E,$00,$00,$08,$08,$EB,$00,$02,$00,$64,$4C,$9F,$00,$03
	dc.b	$08,$2B,$00,$02,$00,$64,$66,$00,$00,$C6,$08,$2B,$00,$05,$00,$62
	dc.b	$66,$00,$00,$B0,$61,$00,$F8,$9E,$08,$AB,$00,$01,$00,$62,$67,$00
	dc.b	$00,$10,$42,$6B,$00,$40,$37,$7C,$00,$08,$00,$42,$50,$EB,$00,$46
	dc.b	$4E,$B9,$00,$02,$44,$1E,$66,$00,$00,$08,$4E,$B9,$00,$02,$43,$DA
	dc.b	$08,$2B,$00,$01,$00,$63,$66,$00,$00,$7A,$08,$38,$00,$00,$C3,$38
	dc.b	$66,$00,$00,$70,$4A,$6B,$00,$48,$6B,$00,$00,$3A,$30,$2B,$00,$52
	dc.b	$B0,$78,$B7,$BE,$67,$00,$00,$0A,$50,$EB,$00,$48,$60,$00,$00,$26
	dc.b	$9F,$6B,$00,$48,$6A,$00,$00,$1E,$08,$38,$00,$02,$C3,$40,$67,$00
	dc.b	$00,$0C,$08,$F8,$00,$04,$C3,$40,$60,$00,$00,$0A,$70,$08,$4E,$B9
	dc.b	$00,$01,$C1,$D2,$9F,$2B,$00,$40,$6A,$00,$00,$28,$10,$2B,$00,$6C
	dc.b	$67,$00,$00,$0E,$08,$38,$00,$06,$C3,$4A,$67,$00,$00,$04,$53,$00
	dc.b	$E4,$08,$17,$40,$00,$40,$30,$2B,$00,$52,$B0,$78,$B7,$BE,$67,$00
	dc.b	$00,$02,$4E,$75

assgoaliecpu	;asstab entry: the computer goalie.
	;Code the listing does not decode: kept as bytes
	dc.b	$08,$2B,$00,$03,$00,$62,$66,$00,$FE,$94,$31,$F8,$B7,$5E,$DC,$AA
	dc.b	$08,$38,$00,$00,$C3,$42,$67,$00,$00,$60,$08,$2B,$00,$01,$00,$63
	dc.b	$66,$00,$00,$56,$08,$38,$00,$01,$C3,$42,$67,$00,$00,$34,$08,$38
	dc.b	$00,$03,$C3,$42,$66,$00,$00,$42,$0C,$6B,$00,$89,$00,$06,$66,$00
	dc.b	$00,$38,$0C,$6B,$00,$8D,$00,$06,$66,$00,$00,$2E,$08,$F8,$00,$03
	dc.b	$C3,$42,$3F,$3C,$00,$1C,$4E,$B9,$00,$08,$84,$70,$60,$00,$00,$1A
	dc.b	$32,$3C,$03,$7A,$08,$38,$00,$01,$C3,$56,$66,$00,$00,$0C,$61,$00
	dc.b	$2F,$E6,$08,$EB,$00,$01,$00,$63,$08,$2B,$00,$05,$00,$62,$66,$00
	dc.b	$00,$78,$61,$00,$F7,$6C,$08,$AB,$00,$01,$00,$62,$67,$00,$00,$10
	dc.b	$42,$6B,$00,$40,$37,$7C,$00,$08,$00,$42,$50,$EB,$00,$46,$0C,$53
	dc.b	$00,$34,$6E,$00,$00,$32,$0C,$53,$FF,$CC,$6D,$00,$00,$2A,$0C,$6B
	dc.b	$01,$24,$00,$14,$6E,$00,$00,$20,$0C,$6B,$FE,$DC,$00,$14,$6D,$00
	dc.b	$00,$16,$0C,$6B,$00,$E8,$00,$14,$6E,$00,$00,$30,$0C,$6B,$FF,$18
	dc.b	$00,$14,$6D,$00,$00,$26,$41,$FA,$00,$20,$70,$04,$4A,$53,$6A,$00
	dc.b	$00,$04,$44,$40,$32,$3C,$00,$FA,$08,$2B,$00,$07,$00,$62,$67,$00
	dc.b	$29,$A2,$44,$41,$60,$00,$29,$9C,$4E,$75,$08,$2B,$00,$01,$00,$63
	dc.b	$66,$F6,$08,$38,$00,$00,$C3,$42,$67,$00,$00,$26,$0C,$6B,$00,$8A
	dc.b	$00,$06,$67,$00,$00,$16,$0C,$6B,$00,$8E,$00,$06,$66,$00,$00,$12
	dc.b	$37,$7C,$00,$04,$00,$54,$60,$00,$00,$08,$37,$7C,$00,$00,$00,$54
	dc.b	$32,$3C,$07,$12,$48,$A7,$80,$00,$30,$38,$B7,$72,$90,$6B,$00,$14
	dc.b	$6A,$00,$00,$04,$44,$40,$B0,$7C,$01,$94,$6E,$00,$00,$16,$B0,$7C
	dc.b	$00,$A8,$6E,$00,$00,$06,$60,$00,$00,$0E,$32,$3C,$05,$7E,$60,$00
	dc.b	$00,$06,$32,$3C,$00,$CE,$4C,$9F,$00,$01,$61,$00,$2E,$EA,$08,$38
	dc.b	$00,$02,$C3,$40,$66,$00,$00,$0C,$08,$38,$00,$00,$C3,$38,$66,$00
	dc.b	$FF,$78,$4A,$6B,$00,$48,$6B,$00,$00,$3A,$30,$2B,$00,$52,$B0,$78
	dc.b	$B7,$BE,$67,$00,$00,$0A,$50,$EB,$00,$48,$60,$00,$00,$26,$9F,$6B
	dc.b	$00,$48,$6A,$00,$00,$1E,$08,$38,$00,$02,$C3,$40,$67,$00,$00,$0C
	dc.b	$08,$F8,$00,$04,$C3,$40,$60,$00,$00,$0A,$70,$08,$4E,$B9,$00,$01
	dc.b	$C1,$D2,$9F,$2B,$00,$40,$6A,$00,$03,$C0,$10,$2B,$00,$6C,$67,$00
	dc.b	$00,$0E,$08,$38,$00,$06,$C3,$4A,$67,$00,$00,$04,$53,$00,$E4,$08
	dc.b	$17,$40,$00,$40,$08,$2B,$00,$03,$00,$62,$67,$00,$00,$12,$08,$2B
	dc.b	$00,$02,$00,$64,$66,$00,$00,$08,$70,$1D,$60,$00,$2C,$16,$30,$38
	dc.b	$B7,$72,$32,$2B,$00,$14,$B1,$41,$6A,$00,$00,$18,$42,$40,$34,$3C
	dc.b	$01,$0A,$08,$2B,$00,$07,$00,$62,$67,$00,$03,$22,$44,$42,$60,$00
	dc.b	$03,$1C,$53,$6B,$00,$46,$6A,$00,$00,$08,$37,$7C,$FF,$FF,$00,$46
	dc.b	$30,$2B,$00,$52,$B0,$78,$B7,$BE,$66,$00,$00,$8E,$4A,$6B,$00,$48
	dc.b	$6A,$00,$00,$08,$37,$7C,$00,$5A,$00,$48,$50,$EB,$00,$46,$0C,$6B
	dc.b	$00,$5A,$00,$48,$6E,$00,$01,$0A,$30,$39,$00,$C0,$00,$08,$02,$40
	dc.b	$00,$03,$66,$00,$00,$FC,$70,$05,$30,$7C,$B0,$5E,$08,$2B,$00,$06
	dc.b	$00,$62,$66,$00,$00,$06,$D0,$FC,$03,$00,$08,$28,$00,$02,$00,$63
	dc.b	$66,$00,$00,$30,$32,$38,$B7,$72,$92,$68,$00,$14,$B2,$7C,$00,$1C
	dc.b	$6E,$00,$00,$20,$B2,$7C,$FF,$E4,$6D,$00,$00,$18,$32,$38,$B7,$5E
	dc.b	$92,$50,$B2,$7C,$00,$19,$6E,$00,$00,$0A,$B2,$7C,$FF,$E7,$6E,$00
	dc.b	$00,$B0,$D0,$FC,$00,$80,$51,$C8,$FF,$C2,$31,$FC,$00,$01,$BF,$18
	dc.b	$61,$00,$0D,$68,$60,$00,$00,$9A,$4A,$6B,$00,$46,$66,$00,$00,$92
	dc.b	$4A,$78,$B7,$BE,$6A,$00,$00,$8A,$30,$38,$B7,$5E,$90,$53,$B0,$7C
	dc.b	$00,$14,$6E,$00,$00,$7C,$B0,$7C,$FF,$EC,$6D,$00,$00,$74,$32,$38
	dc.b	$B7,$72,$B2,$7C,$01,$1E,$6E,$00,$00,$68,$B2,$7C,$FE,$E2,$6D,$00
	dc.b	$00,$60,$92,$6B,$00,$14,$B2,$7C,$00,$1E,$6E,$00,$00,$54,$B2,$7C
	dc.b	$FF,$E2,$6D,$00,$00,$4C,$48,$A7,$C0,$00,$30,$38,$B7,$86,$6A,$00
	dc.b	$00,$04,$44,$40,$32,$38,$B7,$88,$6A,$00,$00,$04,$44,$41,$D0,$41
	dc.b	$B0,$7C,$10,$00,$4C,$9F,$00,$03,$6E,$00,$00,$26,$61,$00,$2A,$F2
	dc.b	$37,$40,$00,$54,$17,$7C,$00,$08,$00,$5E,$32,$3C,$04,$9A,$61,$00
	dc.b	$2D,$06,$08,$EB,$00,$01,$00,$63,$06,$78,$00,$96,$B8,$B2,$4E,$75
	dc.b	$30,$7C,$BF,$1A,$36,$3C,$01,$1A,$08,$2B,$00,$07,$00,$62,$67,$00
	dc.b	$00,$06,$58,$48,$44,$43,$0C,$6B,$01,$1A,$00,$14,$6E,$00,$00,$0C
	dc.b	$0C,$6B,$FE,$E6,$00,$14,$6E,$00,$00,$26,$42,$42,$42,$40,$0C,$53
	dc.b	$00,$2C,$6E,$00,$01,$A8,$0C,$53,$FF,$D4,$6D,$00,$01,$A0,$30,$3C
	dc.b	$00,$96,$4A,$53,$6A,$00,$01,$96,$44,$40,$60,$00,$01,$90,$4A,$78
	dc.b	$B7,$BE,$6B,$00,$00,$2E,$30,$2B,$00,$52,$B0,$78,$B7,$BE,$67,$00
	dc.b	$00,$22,$2F,$08,$20,$7C,$FF,$FF,$B0,$5E,$30,$38,$B7,$BE,$EF,$40
	dc.b	$D0,$C0,$30,$38,$B7,$5E,$90,$50,$E2,$40,$D0,$50,$31,$C0,$DC,$AA
	dc.b	$20,$5F,$30,$38,$DC,$AA,$32,$38,$B7,$72,$61,$00,$02,$32,$61,$00
	dc.b	$2A,$40,$61,$00,$02,$54,$30,$38,$C4,$BE,$02,$40,$00,$07,$E9,$40
	dc.b	$06,$40,$00,$A0,$0C,$78,$00,$F1,$B7,$72,$6E,$00,$00,$0C,$0C,$78
	dc.b	$FF,$0F,$B7,$72,$6E,$00,$00,$06,$04,$40,$00,$40,$32,$00,$C1,$F8
	dc.b	$B7,$86,$48,$40,$D0,$78,$DC,$AA,$C3,$F8,$B7,$88,$48,$41,$D2,$78
	dc.b	$B7,$72,$61,$00,$01,$EA,$48,$A7,$C0,$00,$C1,$C0,$C3,$C1,$D0,$81
	dc.b	$B0,$BC,$00,$00,$03,$84,$62,$00,$00,$0A,$4C,$9F,$00,$03,$60,$00
	dc.b	$00,$26,$61,$00,$36,$CC,$74,$01,$D4,$40,$78,$12,$08,$38,$00,$03
	dc.b	$C3,$3A,$67,$00,$00,$04,$50,$44,$4C,$9F,$00,$03,$C3,$C4,$50,$44
	dc.b	$C1,$C4,$81,$C2,$83,$C2,$D2,$43,$34,$01,$08,$38,$00,$00,$C3,$48
	dc.b	$66,$00,$00,$50,$08,$38,$00,$02,$C3,$40,$66,$00,$00,$46,$60,$00
	dc.b	$00,$42,$08,$38,$00,$03,$C3,$3A,$67,$00,$00,$38,$0C,$78,$00,$D0
	dc.b	$B7,$72,$6E,$00,$00,$10,$0C,$78,$FF,$30,$B7,$72,$6D,$00,$00,$06
	dc.b	$60,$00,$00,$20,$0C,$53,$00,$14,$6E,$00,$00,$18,$0C,$53,$FF,$EC
	dc.b	$6D,$00,$00,$10,$08,$38,$00,$01,$C4,$BF,$66,$00,$00,$06,$60,$00
	dc.b	$00,$26,$0C,$68,$00,$22,$00,$02,$62,$00,$00,$62,$0C,$50,$00,$18
	dc.b	$6E,$00,$00,$B8,$0C,$50,$FF,$E8,$6D,$00,$00,$B0,$0C,$68,$00,$0C
	dc.b	$00,$02,$62,$00,$00,$26,$0C,$78,$01,$1E,$B7,$72,$6E,$00,$00,$1C
	dc.b	$0C,$78,$FE,$E2,$B7,$72,$6D,$00,$00,$12,$08,$EB,$00,$01,$00,$63
	dc.b	$66,$00,$00,$08,$4E,$B9,$00,$01,$7C,$58,$30,$10,$0C,$78,$01,$12
	dc.b	$B7,$72,$6E,$00,$00,$0C,$0C,$78,$FE,$EE,$B7,$72,$6E,$00,$00,$0E
	dc.b	$70,$18,$4A,$78,$DC,$AA,$6A,$00,$00,$04,$44,$40,$32,$02,$48,$A7
	dc.b	$C0,$00,$10,$2B,$00,$28,$48,$80,$44,$40,$D0,$5F,$90,$53,$12,$2B
	dc.b	$00,$2A,$48,$81,$44,$41,$D2,$5F,$92,$6B,$00,$14,$B0,$7C,$00,$04
	dc.b	$6E,$00,$00,$1E,$B0,$7C,$FF,$FC,$6D,$00,$00,$16,$B2,$7C,$00,$04
	dc.b	$6E,$00,$00,$0E,$B2,$7C,$FF,$FC,$6D,$00,$00,$06,$42,$40,$42,$41
	dc.b	$61,$00,$28,$AE,$17,$40,$00,$43,$14,$2B,$00,$43,$48,$82,$B4,$7C
	dc.b	$00,$07,$6F,$00,$30,$04,$60,$00,$32,$C0,$4A,$78,$B7,$BE,$6A,$9C
	dc.b	$08,$38,$00,$02,$BF,$BA,$66,$94,$32,$7C,$C7,$26,$45,$E9,$03,$9E
	dc.b	$08,$2B,$00,$06,$00,$62,$67,$00,$00,$04,$C3,$4A,$0C,$A9,$00,$00
	dc.b	$13,$24,$00,$2A,$6D,$00,$FF,$76,$0C,$AA,$00,$00,$09,$C4,$00,$2A
	dc.b	$6D,$00,$FF,$6A,$0C,$78,$00,$F6,$B7,$72,$6E,$00,$00,$0C,$0C,$78
	dc.b	$FF,$0A,$B7,$72,$6E,$00,$FF,$56,$4A,$78,$B7,$88,$08,$2B,$00,$07
	dc.b	$00,$62,$67,$00,$00,$06,$0A,$3C,$00,$08,$6B,$00,$FF,$40,$30,$38
	dc.b	$B7,$86,$6A,$00,$00,$04,$44,$40,$32,$38,$B7,$88,$6A,$00,$00,$04
	dc.b	$44,$41,$B2,$40,$6D,$00,$FF,$26,$70,$0F,$60,$00,$27,$F6,$34,$38
	dc.b	$B7,$BE,$B4,$6B,$00,$52,$66,$00,$00,$04,$42,$40,$B2,$7C,$01,$19
	dc.b	$6D,$00,$00,$06,$32,$3C,$01,$19,$B2,$7C,$FE,$E7,$6E,$00,$00,$06
	dc.b	$32,$3C,$FE,$E7,$92,$43,$4E,$75
