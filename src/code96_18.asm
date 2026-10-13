;	The option helpers of SetPlayMode, the options screen animation, the line editor (code the listing does
;	not decode, kept as bytes with labels), ReturnToGame / RestoreGameScreen / ClearOldFrames, and a period
;	screen called from code96_04 (bytes).

SetGoalieModes	;goaliemode1 and goaliemode2 = OptGoalie, not for a season
	cmpi.w	#4,(OptPlayMode).w
	beq.w	.0
	cmpi.w	#5,(OptPlayMode).w
	beq.w	.0
	move.w	(OptGoalie).w,(goaliemode1).w
	move.w	(OptGoalie).w,(goaliemode2).w
.0
	rts

FlipUserRec	;OptUserRec: the menu order to the game value (0 = on)
	eori.w	#1,(OptUserRec).w
	rts

SetLineOption	;OptLine: the menu order to the game value (LineOptionTbl); sflags7 bit 4 for menu value 1
	movea.l	#LineOptionTbl,a0
	move.w	(OptLine).w,d0
	bclr	#4,(sflags7).w
	cmp.w	#1,d0
	bne.w	.0
	bset	#4,(sflags7).w
.0
	move.b	(a0,d0.w),d0
	move.w	d0,(OptLine).w
	rts

SetPenOption	;OptPen: the menu order to the game value (PenOptionTbl)
	movea.l	#PenOptionTbl,a0
	move.w	(OptPen).w,d0
	move.b	(a0,d0.w),d0
	move.w	d0,(OptPen).w
	rts

LineOptionTbl	;SetLineOption: the game value of each line changes row
	dc.b	1,0,0

PenOptionTbl	;SetPenOption: the game value of each penalties row
	dc.b	0,2,1

SetSkillLevel	;word_FFD284 / word_FFD286 (PAL) by skill level OptSkill
	movea.l	#SkillLevelTbl,a0
	movea.l	#SkillLevelPalTbl,a1
	move.w	(OptSkill).w,d0
	add.w	d0,d0
	move.w	(a0,d0.w),(word_FFD284).w
	move.w	(a1,d0.w),(word_FFD286).w
	rts

SkillLevelTbl	;SetSkillLevel: word_FFD284 of each skill level
	dc.w	$15,$15,$14

SkillLevelPalTbl	;SetSkillLevel: word_FFD286 of each skill level
	dc.w	$1D,$1D,$1C

OptionsAnimFrame	;OptionsScreen: draw frame word_FFB8C6 of the animation (unk_1C4C4E, 7 x 7 tiles)
	movem.l	d0-d7/a0-a6,-(sp)
	jsr	(printz).l
	String	$BF,$1F,$01
	move.w	(word_FFB8C4).w,d4
	movea.l	#unk_1C4C4E,a0
	movea.l	a0,a1
	movea.l	a0,a2
	adda.l	(a2)+,a0
	adda.l	(a2)+,a1
	clr.w	d0
	move.w	(word_FFB8C6).w,d1
	mulu.w	#7,d1
	moveq	#7,d2
	moveq	#7,d3
	moveq	#0,d5
	movea.l	#$772,a2
	jsr	(dobitmap).l
	movem.l	(sp)+,d0-d7/a0-a6
	rts

LineEditor	;The line editor screen for team a2
	;Code the listing does not decode: kept as bytes
	dc.b	$08,$EA,$00,$00,$00,$30,$61,$00,$09,$0C,$31,$FC,$00,$18,$BD,$3C
	dc.b	$08,$B8,$00,$02,$BF,$B2,$42,$78,$D0,$30,$42,$78,$D0,$34,$31,$FC
	dc.b	$00,$01,$D0,$3C,$4E,$B9,$00,$01,$BA,$2E,$00,$0A,$FE,$04,$FF,$01
	dc.b	$FD,$00,$FC,$00,$70,$28,$72,$0E,$34,$3C,$07,$FF,$4E,$B9,$00,$01
	dc.b	$B9,$76,$50,$F8,$C0,$60,$61,$00,$04,$B8,$61,$00,$02,$C6,$46,$FC
	dc.b	$25,$00,$4E,$B9,$00,$01,$51,$E0,$4E,$B9,$00,$01,$26,$40,$4E,$B9
	dc.b	$00,$01,$5C,$D8,$4E,$B9,$00,$01,$B3,$20,$08,$01,$00,$07,$66,$00
	dc.b	$06,$14,$08,$01,$00,$05,$66,$00,$00,$54,$70,$01,$08,$01,$00,$01
	dc.b	$66,$00,$00,$1E,$70,$FF,$08,$01,$00,$00,$66,$00,$00,$14,$70,$08
	dc.b	$08,$01,$00,$03,$66,$00,$00,$0A,$70,$F8,$08,$01,$00,$02,$67,$B2
	dc.b	$D0,$78,$D0,$3C,$4A,$78,$D2,$64,$67,$00,$00,$0E,$B0,$7C,$00,$01
	dc.b	$6D,$A0,$B0,$7C,$00,$05,$6E,$9A,$41,$FA,$05,$82,$11,$F0,$00,$08
	dc.b	$D0,$3D,$40,$E7,$61,$00,$02,$4C,$46,$DF,$60,$86,$4E,$B9,$00,$01
	dc.b	$57,$A2,$32,$00,$4E,$B9,$00,$01,$57,$F4,$90,$41,$53,$40,$31,$C0
	dc.b	$D0,$3A,$42,$78,$D0,$34,$42,$78,$D0,$32,$30,$7C,$D1,$30,$42,$42
	dc.b	$11,$81,$20,$00,$BC,$41,$66,$00,$00,$06,$31,$C2,$D0,$32,$52,$41
	dc.b	$52,$42,$51,$C8,$FF,$EC,$40,$E7,$2F,$0A,$61,$00,$04,$DA,$38,$3C
	dc.b	$00,$01,$22,$7C,$00,$1A,$06,$32,$4E,$B9,$00,$01,$21,$7A,$20,$7C
	dc.b	$00,$1A,$06,$32,$4E,$B9,$00,$01,$21,$8A,$4E,$B9,$00,$01,$BB,$8E
	dc.b	$00,$06,$BF,$00,$00,$00,$22,$7C,$00,$19,$E7,$F6,$D3,$E9,$00,$04
	dc.b	$24,$7C,$00,$00,$07,$72,$42,$40,$42,$41,$34,$3C,$00,$28,$36,$3C
	dc.b	$00,$0E,$38,$38,$B0,$34,$7A,$00,$4E,$B9,$00,$01,$B6,$92,$4E,$B9
	dc.b	$00,$01,$BB,$8E,$00,$06,$BF,$0A,$0B,$00,$20,$7C,$00,$19,$C6,$28
	dc.b	$22,$48,$24,$48,$D1,$DA,$D3,$DA,$42,$40,$42,$41,$24,$7C,$00,$00
	dc.b	$07,$72,$34,$11,$36,$29,$00,$02,$7A,$00,$38,$38,$B0,$36,$4E,$B9
	dc.b	$00,$01,$B6,$92,$24,$5F,$4E,$B9,$00,$01,$BE,$D6,$00,$16,$F8,$04
	dc.b	$01,$03,$02,$28,$73,$65,$6C,$65,$63,$74,$20,$70,$6C,$61,$79,$65
	dc.b	$72,$29,$42,$40,$61,$00,$00,$6C,$46,$DF,$46,$FC,$25,$00,$4E,$B9
	dc.b	$00,$01,$51,$E0,$4E,$B9,$00,$01,$26,$40,$4E,$B9,$00,$01,$5C,$D8
	dc.b	$4E,$B9,$00,$01,$B3,$20,$08,$01,$00,$07,$66,$00,$FE,$6A,$08,$01
	dc.b	$00,$05,$66,$00,$00,$72,$70,$01,$08,$01,$00,$01,$66,$00,$00,$2E
	dc.b	$08,$01,$00,$03,$66,$00,$00,$16,$70,$FF,$08,$01,$00,$00,$66,$00
	dc.b	$00,$1C,$08,$01,$00,$02,$66,$00,$00,$04,$60,$AE,$D0,$78,$D0,$30
	dc.b	$6B,$A8,$31,$C0,$D0,$30,$61,$00,$00,$56,$60,$9E,$61,$00,$00,$04
	dc.b	$60,$98,$D0,$78,$D0,$32,$6B,$00,$00,$2C,$B0,$78,$D0,$3A,$6E,$00
	dc.b	$00,$24,$31,$C0,$D0,$32,$B0,$78,$D0,$34,$6E,$00,$00,$06,$31,$C0
	dc.b	$D0,$34,$59,$40,$B0,$78,$D0,$34,$6F,$00,$00,$06,$31,$C0,$D0,$34
	dc.b	$60,$00,$00,$1C,$4E,$75,$36,$7C,$D1,$30,$D6,$F8,$D0,$32,$10,$13
	dc.b	$52,$00,$34,$38,$D0,$3C,$61,$00,$05,$60,$60,$00,$FD,$DA

PrintAttribHeader	;Player list column header (PAttribColumns page DispAttribCtr), then 6 rows of names, selected row highlighted
	;Code the listing does not decode: kept as bytes
	dc.b	$4E,$B9,$00,$01,$BB,$8E,$00,$06,$BF,$17,$02,$00,$22,$7C,$00,$02
	dc.b	$34,$2E,$30,$38,$D0,$30,$60,$00,$00,$06,$D2,$D1,$58,$49,$4A,$51
	dc.b	$5B,$C8,$FF,$F8,$6A,$00,$00,$08,$53,$78,$D0,$30,$60,$DE,$4E,$B9
	dc.b	$00,$01,$BE,$EC,$28,$11,$36,$7C,$D1,$30,$34,$38,$D0,$34,$32,$38
	dc.b	$D0,$3A,$92,$42,$B2,$7C,$00,$04,$63,$00,$00,$04,$72,$04,$31,$FC
	dc.b	$00,$04,$B0,$42,$4E,$B9,$00,$01,$BA,$2E,$00,$24,$FE,$07,$FD,$02
	dc.b	$FA,$01,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
	dc.b	$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$FD,$02,$00,$B4,$78
	dc.b	$D0,$32,$66,$00,$00,$0C,$4E,$B9,$00,$01,$BA,$2E,$00,$04,$FE,$06
	dc.b	$42,$40,$10,$33,$20,$00,$4E,$B9,$00,$01,$51,$FA,$52,$42,$51,$C9
	dc.b	$FF,$B4,$4E,$75

DrawLineIcons	;Draw the line icons for the cursor's line, then the selected player box
	;Code the listing does not decode: kept as bytes
	dc.b	$7A,$06,$41,$FA,$00,$79,$30,$38,$D0,$3C,$E6,$48,$D0,$C0,$4A,$78
	dc.b	$D2,$64,$67,$00,$00,$04,$53,$48,$10,$10,$B0,$38,$C0,$60,$67,$00
	dc.b	$00,$0A,$11,$C0,$C0,$60,$61,$00,$01,$2C,$0B,$38,$C0,$60,$67,$00
	dc.b	$00,$06,$61,$00,$00,$50,$51,$CD,$FF,$F2,$4E,$B9,$00,$01,$BE,$D6
	dc.b	$00,$18,$F8,$04,$01,$15,$0C,$20,$20,$20,$20,$20,$20,$20,$20,$20
	dc.b	$20,$20,$20,$20,$20,$20,$20,$00,$4E,$B9,$00,$01,$BB,$8E,$00,$06
	dc.b	$BF,$1E,$0C,$00,$30,$06,$4E,$B9,$00,$02,$2F,$B2,$30,$11,$E2,$48
	dc.b	$91,$78,$B0,$40,$4E,$B9,$00,$01,$BE,$EC,$4E,$75,$01,$07,$07,$07
	dc.b	$18,$18,$60,$60,$70,$06,$C0,$C5,$41,$FA,$02,$74,$D0,$C0,$4A,$78
	dc.b	$D2,$64,$67,$00,$00,$04,$5D,$48,$4E,$B9,$00,$01,$BB,$8E,$00,$06
	dc.b	$BF,$00,$00,$00,$31,$D0,$B0,$40,$31,$E8,$00,$02,$B0,$42,$57,$78
	dc.b	$B0,$42,$54,$78,$B0,$40,$30,$05,$22,$7C,$00,$02,$33,$42,$4E,$B9
	dc.b	$00,$01,$D7,$F2,$08,$F8,$00,$02,$C3,$54,$4E,$B9,$00,$01,$BE,$EC
	dc.b	$4E,$B9,$00,$01,$BE,$D6,$00,$08,$20,$4C,$69,$6E,$65,$00,$4E,$B9
	dc.b	$00,$01,$BA,$2E,$00,$06,$FE,$07,$FF,$01,$31,$D0,$B0,$40,$38,$05
	dc.b	$E7,$44,$52,$44,$31,$E8,$00,$02,$B0,$42,$53,$78,$B0,$42,$36,$28
	dc.b	$00,$04,$47,$EA,$01,$84,$31,$D0,$B0,$40,$4E,$B9,$00,$01,$BA,$2E
	dc.b	$00,$06,$FA,$01,$FE,$07,$42,$40,$10,$33,$40,$00,$53,$40,$4E,$B9
	dc.b	$00,$1E,$26,$44,$B8,$78,$D0,$3C,$66,$00,$00,$12,$3C,$00,$3E,$38
	dc.b	$B0,$44,$4E,$B9,$00,$01,$BA,$2E,$00,$04,$FE,$06,$4E,$B9,$00,$01
	dc.b	$BA,$40,$4E,$B9,$00,$01,$BA,$2E,$00,$04,$FE,$07,$52,$44,$51,$CB
	dc.b	$FF,$B6,$4E,$75,$4E,$B9,$00,$01,$BA,$2E,$00,$08,$FF,$01,$FD,$02
	dc.b	$FC,$11,$70,$24,$72,$07,$34,$3C,$07,$FF,$4E,$B9,$00,$01,$B9,$76
	dc.b	$4E,$B9,$00,$01,$BE,$D6,$00,$28,$F8,$04,$01,$05,$0F,$20,$20,$20
	dc.b	$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
	dc.b	$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$00,$33,$F9
	dc.b	$00,$1E,$21,$2A,$FF,$FF,$B0,$42,$33,$F9,$00,$1E,$21,$28,$FF,$FF
	dc.b	$B0,$40,$4A,$78,$D2,$64,$67,$00,$00,$0C,$33,$F9,$00,$1E,$21,$22
	dc.b	$FF,$FF,$B0,$40,$4E,$B9,$00,$01,$BA,$2E,$00,$22,$FE,$07,$FB,$FD
	dc.b	$FA,$00,$4C,$44,$FB,$FE,$FA,$01,$52,$44,$FB,$FE,$FA,$01,$4C,$57
	dc.b	$FB,$FE,$FA,$01,$43,$20,$FB,$FE,$FA,$01,$52,$57,$4E,$75,$61,$00
	dc.b	$00,$E4,$48,$E7,$FC,$E0,$2F,$0A,$4E,$B9,$00,$01,$BB,$8E,$00,$06
	dc.b	$BF,$00,$00,$00,$22,$7C,$00,$19,$CE,$08,$D3,$E9,$00,$04,$24,$7C
	dc.b	$00,$00,$07,$72,$42,$40,$42,$41,$34,$3C,$00,$28,$36,$3C,$00,$0E
	dc.b	$38,$38,$B0,$32,$7A,$00,$4E,$B9,$00,$01,$B6,$92,$38,$38,$B0,$36
	dc.b	$4E,$B9,$00,$01,$BB,$8E,$00,$06,$BF,$0B,$01,$00,$20,$7C,$00,$19
	dc.b	$C6,$28,$22,$48,$24,$48,$D1,$DA,$D3,$DA,$42,$40,$42,$41,$24,$7C
	dc.b	$00,$00,$07,$72,$34,$11,$36,$29,$00,$02,$7A,$00,$4E,$B9,$00,$01
	dc.b	$B6,$92,$38,$38,$B0,$2C,$4E,$B9,$00,$01,$BB,$8E,$00,$06,$BF,$01
	dc.b	$04,$00,$24,$57,$3E,$2A,$00,$28,$7A,$02,$4E,$B9,$00,$01,$2B,$B2
	dc.b	$38,$3C,$00,$01,$22,$7C,$00,$1A,$02,$44,$4E,$B9,$00,$01,$21,$7A
	dc.b	$20,$7C,$00,$1A,$02,$44,$4E,$B9,$00,$01,$21,$8A,$0C,$78,$00,$01
	dc.b	$D2,$64,$67,$00,$00,$28,$4E,$B9,$00,$01,$BC,$72,$00,$20,$8F,$18
	dc.b	$07,$73,$74,$61,$72,$74,$2D,$65,$78,$69,$74,$8F,$16,$08,$5B,$5D
	dc.b	$2D,$73,$65,$6C,$65,$63,$74,$20,$6C,$69,$6E,$65,$24,$5F,$4C,$DF
	dc.b	$07,$3F,$4E,$75

ClearLineEditorTop	;Erase the top of map 2
	;Code the listing does not decode: kept as bytes
	dc.b	$4E,$B9,$00,$01,$BB,$8E,$00,$06,$BF,$00,$00,$00,$70,$28,$72,$0E
	dc.b	$34,$3C,$07,$FF,$4E,$F9,$00,$01,$B9,$76

ClearMenuFlags	;Clear palfadenew+$5A and palfadenew+$7A
	;Code the listing does not decode: kept as bytes
	dc.b	$42,$78,$BD,$98,$42,$78,$BD,$B8,$4E,$75,$00,$10,$00,$12,$00,$04

LineIconPosTable	;Line icons x, y, slot count - 1
	dc.b	$00,$05,$00,$12,$00,$04,$00,$10,$00,$12,$00,$04,$00,$1B,$00,$12
	dc.b	$00,$04,$00,$05,$00,$12,$00,$04,$00,$10,$00,$12,$00,$04,$00,$05
	dc.b	$00,$12,$00,$03,$00,$10,$00,$12,$00,$03,$FF,$FF

LineCursorTable	;The slot after a cursor move, indexed by slot + 8
	dc.b	$01,$01,$02,$03,$04,$05,$19,$01,$01,$01,$02,$03,$04,$05,$19,$01
	dc.b	$09,$09,$0A,$0B,$0C,$0D,$21,$01,$11,$11,$12,$13,$14,$15,$21,$01
	dc.b	$05,$19,$1A,$1B,$1C,$1D,$29,$01,$0D,$21,$22,$23,$24,$25,$31,$01
	dc.b	$1D,$29,$2A,$2B,$2C,$2C,$01,$01,$25,$31,$32,$33,$34,$34,$01,$01
	dc.b	$25,$31,$32,$33,$34,$34,$01,$01,$31,$FC,$00,$18,$BD,$3C,$26,$7C
	dc.b	$00,$20,$00,$00,$30,$2A,$00,$28,$52,$40,$B0,$2B,$00,$01,$67,$00
	dc.b	$00,$90,$4E,$B9,$00,$01,$BC,$72,$00,$46,$8F,$18,$06,$73,$74,$61
	dc.b	$72,$74,$2D,$65,$78,$69,$74,$8F,$16,$07,$61,$2D,$64,$65,$66,$61
	dc.b	$75,$6C,$74,$20,$6C,$69,$6E,$65,$8F,$16,$08,$20,$20,$20,$20,$20
	dc.b	$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$8F,$16,$09,$63
	dc.b	$2D,$73,$61,$76,$65,$20,$6C,$69,$6E,$65,$20,$20,$20,$00,$4E,$B9
	dc.b	$00,$01,$51,$E0,$4E,$B9,$00,$01,$26,$40,$4E,$B9,$00,$01,$5C,$D8
	dc.b	$08,$01,$00,$07,$67,$00,$00,$08,$4E,$F9,$00,$01,$54,$D4,$08,$01
	dc.b	$00,$06,$67,$00,$00,$0C,$4E,$B9,$00,$02,$15,$4E,$60,$00,$F9,$0A
	dc.b	$08,$01,$00,$05,$67,$C8,$4E,$B9,$00,$1E,$23,$9E,$60,$00,$F8,$FA
	dc.b	$4E,$B9,$00,$01,$BC,$72,$00,$46,$8F,$18,$06,$73,$74,$61,$72,$74
	dc.b	$2D,$65,$78,$69,$74,$8F,$16,$07,$61,$2D,$64,$65,$66,$61,$75,$6C
	dc.b	$74,$20,$6C,$69,$6E,$65,$8F,$16,$08,$62,$2D,$6C,$6F,$61,$64,$20
	dc.b	$73,$61,$76,$65,$64,$20,$6C,$69,$6E,$65,$8F,$16,$09,$63,$2D,$73
	dc.b	$61,$76,$65,$20,$6C,$69,$6E,$65,$20,$20,$20,$00,$4E,$B9,$00,$01
	dc.b	$51,$E0,$4E,$B9,$00,$01,$26,$40,$4E,$B9,$00,$01,$5C,$D8,$08,$01
	dc.b	$00,$07,$67,$00,$00,$04,$4E,$75,$08,$01,$00,$06,$67,$00,$00,$0C
	dc.b	$4E,$B9,$00,$02,$15,$4E,$60,$00,$F8,$80,$08,$01,$00,$04,$67,$00
	dc.b	$00,$0A,$61,$00,$00,$48,$60,$00,$F8,$70,$08,$01,$00,$05,$67,$BC
	dc.b	$4E,$B9,$00,$1E,$23,$9E,$4E,$F9,$00,$01,$54,$D4

SetLineSlot	;Put player d0 in line slot d2 of team a2 (swap if already in that line)
	;Code the listing does not decode: kept as bytes
	dc.b	$48,$E7,$E0,$C0,$41,$EA,$01,$84,$32,$02,$02,$41,$FF,$F8,$43,$F0
	dc.b	$10,$00,$72,$05,$B0,$31,$10,$01,$57,$C9,$FF,$FA,$66,$00,$00,$08
	dc.b	$13,$B0,$20,$00,$10,$01,$11,$80,$20,$00,$4C,$DF,$03,$07,$4E,$75

LoadTeamLine	;Line editor menu item Load Team Line
	;Code the listing does not decode: kept as bytes
	dc.b	$48,$E7,$FF,$FE,$4A,$78,$D2,$64,$67,$00,$00,$54,$20,$7C,$00,$20
	dc.b	$00,$00,$54,$48,$43,$EA,$01,$84,$12,$E8,$00,$01,$12,$E8,$00,$03
	dc.b	$12,$E8,$00,$05,$12,$E8,$00,$07,$12,$E8,$00,$09,$12,$E8,$00,$0B
	dc.b	$12,$E8,$00,$0D,$12,$E8,$00,$0F,$D0,$FC,$00,$10,$D0,$FC,$00,$10
	dc.b	$30,$3C,$00,$0B,$12,$E8,$00,$01,$12,$E8,$00,$03,$12,$E8,$00,$05
	dc.b	$12,$E8,$00,$07,$50,$48,$51,$C8,$FF,$EC,$60,$00,$00,$2C,$30,$3C
	dc.b	$00,$0D,$20,$7C,$00,$20,$00,$00,$54,$48,$D0,$FC,$00,$10,$43,$EA
	dc.b	$01,$84,$12,$E8,$00,$01,$12,$E8,$00,$03,$12,$E8,$00,$05,$12,$E8
	dc.b	$00,$07,$50,$48,$51,$C8,$FF,$EC,$4C,$DF,$7F,$FF,$4E,$75

SaveTeamLine	;Line editor menu item Save Team Line
	;Code the listing does not decode: kept as bytes
	dc.b	$48,$E7,$FF,$FE,$20,$7C,$00,$20,$00,$00,$3E,$2A,$00,$28,$52,$47
	dc.b	$30,$C7,$43,$EA,$01,$84,$11,$59,$00,$01,$11,$59,$00,$03,$11,$59
	dc.b	$00,$05,$11,$59,$00,$07,$11,$59,$00,$09,$11,$59,$00,$0B,$11,$59
	dc.b	$00,$0D,$11,$59,$00,$0F,$D0,$FC,$00,$10,$43,$EA,$01,$84,$30,$3C
	dc.b	$00,$0D,$11,$59,$00,$01,$11,$59,$00,$03,$11,$59,$00,$05,$11,$59
	dc.b	$00,$07,$50,$48,$51,$C8,$FF,$EC,$08,$B8,$00,$06,$C3,$50,$4E,$B9
	dc.b	$00,$02,$41,$AA,$4C,$DF,$7F,$FF,$4E,$75,$4E,$75,$01,$02,$03,$04
	dc.b	$05,$09,$0A,$0B,$0C,$0D,$11,$12,$13,$14,$15,$19,$1A,$1B,$1C,$1D
	dc.b	$21,$22,$23,$24,$25,$29,$2A,$2B,$2C,$31,$32,$33,$34,$FF,$2F,$0A
	dc.b	$08,$F8,$00,$05,$C3,$56,$21,$FC,$00,$01,$2D,$46,$D2,$44,$08,$B8
	dc.b	$00,$00,$BF,$B2,$08,$F8,$00,$02,$BF,$B2,$08,$B8,$00,$01,$BF,$B2
	dc.b	$31,$FC,$00,$00,$B0,$00,$31,$FC,$B8,$00,$B0,$02,$31,$FC,$B8,$00
	dc.b	$B0,$0C,$31,$FC,$00,$05,$B0,$0E,$31,$FC,$C0,$00,$B0,$08,$31,$FC
	dc.b	$00,$06,$B0,$0A,$31,$FC,$E0,$00,$B0,$04,$31,$FC,$00,$06,$B0,$06
	dc.b	$30,$3C,$00,$00,$08,$F8,$00,$05,$BF,$B2,$4E,$B9,$00,$01,$B5,$7E
	dc.b	$08,$B8,$00,$05,$BF,$B2,$4E,$B9,$00,$01,$B2,$C4,$38,$3C,$00,$01
	dc.b	$22,$7C,$00,$1A,$02,$44,$4E,$B9,$00,$01,$21,$7A,$38,$3C,$00,$1E
	dc.b	$31,$C4,$B0,$1C,$24,$7C,$00,$17,$91,$70,$4E,$B9,$00,$01,$B7,$30
	dc.b	$31,$C4,$B0,$1E,$24,$7C,$00,$17,$A1,$6C,$4E,$B9,$00,$01,$B7,$30
	dc.b	$21,$FC,$00,$17,$91,$68,$BF,$8A,$31,$C4,$B0,$18,$24,$7C,$00,$17
	dc.b	$B6,$88,$4E,$B9,$00,$01,$B7,$30,$08,$F8,$00,$02,$C3,$54,$4E,$B9
	dc.b	$00,$01,$BA,$2E,$00,$08,$FF,$01,$FD,$00,$FC,$00,$70,$28,$72,$1C
	dc.b	$34,$3C,$07,$FF,$4E,$B9,$00,$01,$B9,$76,$31,$C4,$B0,$32,$4E,$B9
	dc.b	$00,$01,$BB,$8E,$00,$06,$BF,$00,$00,$00,$20,$7C,$00,$19,$CE,$08
	dc.b	$22,$48,$24,$48,$D1,$DA,$D3,$DA,$42,$40,$42,$41,$74,$28,$76,$1C
	dc.b	$7A,$08,$4E,$B9,$00,$01,$B6,$92,$31,$C4,$B0,$34,$24,$7C,$00,$19
	dc.b	$E7,$FE,$4E,$B9,$00,$01,$B7,$30,$31,$C4,$B0,$2C,$4E,$B9,$00,$01
	dc.b	$BB,$8E,$00,$06,$BF,$01,$04,$00,$24,$57,$3E,$2A,$00,$28,$7A,$02
	dc.b	$4E,$B9,$00,$01,$2B,$B2,$31,$C4,$B0,$36,$4E,$B9,$00,$01,$BB,$8E
	dc.b	$00,$06,$BF,$0B,$01,$00,$20,$7C,$00,$19,$C6,$28,$22,$48,$24,$48
	dc.b	$D1,$DA,$D3,$DA,$42,$40,$42,$41,$34,$11,$36,$29,$00,$02,$7A,$08
	dc.b	$4E,$B9,$00,$01,$B6,$92,$61,$00,$00,$44,$4E,$B9,$00,$01,$BB,$8E
	dc.b	$00,$06,$FE,$00,$00,$00,$20,$7C,$00,$17,$0B,$0C,$22,$48,$24,$48
	dc.b	$D1,$DA,$D3,$DA,$42,$40,$42,$41,$74,$40,$76,$1C,$7A,$01,$4E,$B9
	dc.b	$00,$01,$B6,$92,$20,$7C,$00,$1A,$02,$44,$4E,$B9,$00,$01,$21,$8A
	dc.b	$61,$00,$00,$54,$46,$FC,$25,$00,$24,$5F,$4E,$75,$3F,$38,$B0,$1C
	dc.b	$31,$F8,$B0,$1E,$B0,$1C,$4E,$B9,$00,$01,$BC,$72,$00,$34,$8F,$04
	dc.b	$19,$7B,$7D,$5B,$5D,$2D,$68,$69,$67,$68,$6C,$69,$67,$68,$74,$20
	dc.b	$70,$6C,$61,$79,$65,$72,$8F,$07,$1A,$63,$2D,$73,$65,$6C,$65,$63
	dc.b	$74,$20,$70,$6C,$61,$79,$65,$72,$20,$74,$6F,$20,$65,$64,$69,$74
	dc.b	$31,$DF,$B0,$1C,$4E,$75,$48,$E7,$00,$C0,$20,$7C,$00,$17,$C2,$AE
	dc.b	$22,$7C,$FF,$FF,$BD,$7E,$30,$3C,$00,$07,$22,$D8,$51,$C8,$FF,$FC
	dc.b	$4C,$DF,$03,$00,$4E,$75

sub_1E2644	;Called from the line editor
	;Code the listing does not decode: kept as bytes
	dc.b	$48,$E7,$F0,$A0,$4E,$B9,$00,$01,$01,$C6,$32,$7C,$BF,$F4,$12,$FC
	dc.b	$00,$20,$30,$18,$45,$F0,$00,$FE,$0C,$18,$00,$20,$66,$FA,$12,$D8
	dc.b	$B5,$C8,$67,$00,$00,$0E,$4A,$10,$66,$F4,$60,$00,$00,$06,$12,$FC
	dc.b	$00,$20,$B2,$FC,$BF,$FF,$6D,$F6,$4E,$B9,$00,$02,$30,$AA,$4C,$DF
	dc.b	$05,$0F,$4E,$75

ReturnToGame	;Back to the game after a menu: restart the sound driver, RestoreGameScreen, the window registers,
	;setvideo, team struct $30 bit 0 from bit 1 for both teams, then fade in
	jsr	(forceblack).l
	jsr	(stop_current_song).l	;stop the song
	move.w	#9,d0	;restart the sound driver as Begin does
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
	move	#$2700,sr
	jsr	(RestoreGameScreen).l
	movea.l	#VDP_DATA,a0
	move.w	#$9100,4(a0)
	move.w	#$9200,4(a0)
	bclr	#0,(sflags).w
	jsr	(setvideo).l
	movea.l	#tmstruct+$30,a0
	btst	#1,(a0)
	beq.w	.0
	bset	#0,(a0)
.0
	adda.l	#$39E,a0
	btst	#1,(a0)
	beq.w	.1
	bset	#0,(a0)
.1
	move.w	#$18,(palcount).w
	bclr	#5,(sflags11).w
	beq.w	.wait
	move.w	#$FFFF,(palcount).w
.wait
	tst.w	(palcount).w
	bpl.s	.wait
	move.w	(vcount).w,(oldvcount).w
	rts

RestoreGameScreen	;Rebuild the game screen: the vdp maps, palettes, vram, framer, fonts, energy bar and EASN tiles,
	;the face off screen (disflags bit 4) or the ref tiles, the home team graphics and the replay icon
	movem.l	d0-d7/a0-a6,-(sp)
	move.l	#$FFFFFFFF,(padcont).w
	move.l	#$FFFFFFFF,(dword_FFBEB2).w
	move.l	#$FFFFFFFF,(dword_FFBEB6).w
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
	jsr	(setplayercolors).l
	jsr	(setupIceRinkPal).l
	jsr	(setVram_0).l
	jsr	(ClearOldFrames).l
	move.w	#$800,d0
	move.w	(VmMap1).w,d1
	move.w	#$7FF,d2
	jsr	(DoFill).l
	move.w	(framercset).w,d4
	jsr	(sub_1C184).l
	move.w	(word_FFB038).w,d4
	jsr	(LoadSmallFont).l
	jsr	(LoadBigFonts).l
	move.w	(energybarchars).w,d4
	movea.l	#EnergyBarMap+8,a2
	jsr	(DecompressGraphicsPlain).l
	move.w	(animchars).w,d4
	movea.l	#CrowdFrameList+8,a2
	jsr	(DecompressGraphicsPlain).l
	jsr	(setupEASNmap).l
	jsr	(sub_21046).l
	btst	#4,(disflags).w
	beq.w	.ref
	btst	#3,(sflags2).w
	bne.w	.ref
	move.w	(ExtraChars).w,d4
	movea.l	#FaceOffMap+8,a2
	jsr	(DecompressGraphicsPlain).l
	move.w	d4,(faceoffvrcset).w
	movea.l	#FaceOffSprites+8,a2
	jsr	(DecompressGraphicsPlain).l
	jsr	(DrawFaceoffWindow).l
	bra.w	.rink
.ref
	move.w	(ExtraChars).w,d4
	btst	#3,(sflags2).w
	beq.w	.2
	movea.l	#ReplayBannerMap+8,a2
	bra.w	.load
.2
	movea.l	#RefTiles+8,a2
	btst	#4,(sflags9).w
	beq.w	.load
	movea.l	#RefTilesHor+8,a2
.load
	jsr	(DecompressGraphicsPlain).l
.rink
	move.w	(disflags).w,-(sp)
	bset	#2,(disflags).w
	move.w	#$7D0,(Oldrow).w
	clr.w	d4
	move.w	d4,(word_FFB022).w
	movea.l	#Rinktilelist+8,a2
	jsr	(DecompressGraphicsPlain).l
	jsr	(LoadHomeTeamGfx).l
	btst	#3,(sflags2).w
	beq.w	.0
	jsr	(LoadReplayIcon).l
.0
	jsr	(setplayercolors).l
	jsr	(setupIceRinkPal).l
	move.w	(sp)+,(disflags).w
	bclr	#0,(disflags).w
	bclr	#2,(disflags).w
	move	#$2300,sr
	jsr	(SprSort).l
	move.w	(vcount).w,d0
.wait
	cmp.w	(vcount).w,d0
	beq.s	.wait
	bset	#3,(disflags).w
	jsr	(nullsub_4).l
	bset	#7,(sflags11).w
	btst	#3,(sflags2).w
	bne.w	.6
	move.w	#$64,(palcount).w
.6
	movem.l	(sp)+,d0-d7/a0-a6
	rts

ClearOldFrames	;Oldframe = -1 for the 16 sort objects, the 4 sso and the 8 pads, so addframe2 sends their tiles again
	movem.l	d0-d1/a0-a3,-(sp)
	movea.l	#SortCords,a0
	move.w	#$80,d0
	move.w	#$F,d1
.sort
	st	8(a0)
	adda.w	d0,a0
	dbf	d1,.sort
	movea.l	#$FFFFBEBA,a0
	move.w	#$14,d0
	move.w	#3,d1
.sso
	st	8(a0)
	adda.w	d0,a0
	dbf	d1,.sso
	movea.l	#$FFFFBDCA,a0
	move.w	#$1C,d0
	move.w	#7,d1
.pads
	st	8(a0)
	adda.w	d0,a0
	dbf	d1,.pads
	movem.l	(sp)+,d0-d1/a0-a3
	rts

sub_1E2970	;Called from code96_04: a screen with its own vbint (data96_12), the period names and digits
	;Code the listing does not decode: kept as bytes
	dc.b	$2F,$0A,$4E,$B9,$00,$08,$85,$FC,$46,$FC,$27,$00,$23,$FC,$00,$1E
	dc.b	$2E,$76,$FF,$FF,$D2,$44,$08,$B8,$00,$00,$BF,$B2,$08,$F8,$00,$02
	dc.b	$BF,$B2,$08,$B8,$00,$01,$BF,$B2,$31,$FC,$00,$00,$B0,$00,$31,$FC
	dc.b	$B8,$00,$B0,$02,$31,$FC,$B8,$00,$B0,$0C,$31,$FC,$00,$05,$B0,$0E
	dc.b	$31,$FC,$C0,$00,$B0,$08,$31,$FC,$00,$06,$B0,$0A,$31,$FC,$E0,$00
	dc.b	$B0,$04,$31,$FC,$00,$06,$B0,$06,$30,$3C,$00,$00,$08,$F8,$00,$05
	dc.b	$BF,$B2,$4E,$B9,$00,$01,$B5,$7E,$08,$B8,$00,$05,$BF,$B2,$30,$38
	dc.b	$B0,$00,$4E,$B9,$00,$01,$B6,$78,$30,$BC,$00,$00,$30,$3C,$00,$00
	dc.b	$30,$80,$4E,$B9,$00,$01,$B2,$C4,$38,$3C,$00,$01,$22,$7C,$00,$1B
	dc.b	$CB,$FA,$4E,$B9,$00,$01,$21,$7A,$31,$C4,$B0,$1C,$24,$7C,$00,$17
	dc.b	$91,$70,$4E,$B9,$00,$01,$B7,$30,$21,$FC,$00,$17,$91,$68,$BF,$8A
	dc.b	$31,$C4,$B0,$16,$24,$7C,$00,$1B,$89,$D0,$4E,$B9,$00,$01,$B7,$30
	dc.b	$08,$B8,$00,$02,$C3,$54,$31,$C4,$B0,$18,$24,$7C,$00,$1B,$94,$1E
	dc.b	$4E,$B9,$00,$01,$B7,$30,$31,$C4,$B0,$1A,$24,$7C,$00,$1B,$9E,$E0
	dc.b	$4E,$B9,$00,$01,$B7,$30,$4E,$B9,$00,$01,$BA,$2E,$00,$08,$FF,$01
	dc.b	$FD,$00,$FC,$00,$70,$28,$72,$1C,$34,$3C,$07,$FF,$4E,$B9,$00,$01
	dc.b	$B9,$76,$4E,$B9,$00,$01,$BB,$8E,$00,$06,$BF,$00,$00,$00,$20,$7C
	dc.b	$00,$1B,$BB,$EC,$22,$48,$24,$48,$D1,$DA,$D3,$DA,$42,$40,$42,$41
	dc.b	$74,$28,$76,$1C,$7A,$08,$4E,$B9,$00,$01,$B6,$92,$4E,$B9,$00,$01
	dc.b	$BB,$8E,$00,$06,$BF,$04,$04,$00,$20,$7C,$00,$01,$2C,$DE,$30,$38
	dc.b	$C3,$A2,$E5,$40,$20,$70,$00,$00,$22,$48,$24,$48,$D1,$DA,$D3,$DA
	dc.b	$42,$40,$42,$41,$74,$05,$76,$05,$7A,$04,$4E,$B9,$00,$01,$B6,$92
	dc.b	$4E,$B9,$00,$01,$BB,$8E,$00,$06,$BF,$1F,$04,$00,$20,$7C,$00,$01
	dc.b	$2C,$DE,$30,$38,$C3,$A0,$E5,$40,$20,$70,$00,$00,$22,$48,$24,$48
	dc.b	$D1,$DA,$D3,$DA,$42,$40,$42,$41,$74,$05,$76,$05,$7A,$04,$4E,$B9
	dc.b	$00,$01,$B6,$92,$4E,$B9,$00,$01,$BB,$8E,$00,$06,$FE,$00,$00,$00
	dc.b	$20,$7C,$00,$1B,$A4,$BE,$22,$48,$24,$48,$D1,$DA,$D3,$DA,$42,$40
	dc.b	$42,$41,$74,$28,$76,$1C,$7A,$03,$4E,$B9,$00,$01,$B6,$92,$30,$38
	dc.b	$C4,$BC,$20,$7C,$00,$1B,$CF,$78,$08,$00,$00,$00,$66,$00,$00,$08
	dc.b	$20,$7C,$00,$1B,$D5,$E6,$4E,$B9,$00,$01,$BB,$8E,$00,$06,$BF,$0C
	dc.b	$17,$00,$22,$48,$24,$48,$D1,$DA,$D3,$DA,$42,$40,$42,$41,$74,$10
	dc.b	$76,$03,$7A,$00,$4E,$B9,$00,$01,$B6,$92,$4E,$B9,$00,$01,$BE,$C4
	dc.b	$00,$0A,$F8,$04,$01,$0F,$04,$F9,$02,$00,$30,$38,$C4,$BC,$22,$7C
	dc.b	$00,$1E,$2D,$E8,$4E,$B9,$00,$01,$D7,$F2,$4E,$B9,$00,$01,$BE,$E8
	dc.b	$4E,$B9,$00,$01,$BE,$C4,$00,$0A,$F8,$04,$01,$11,$02,$F9,$01,$00
	dc.b	$30,$38,$C4,$BE,$48,$C0,$80,$FC,$02,$58,$2F,$00,$4A,$40,$66,$00
	dc.b	$00,$0A,$52,$78,$B0,$40,$60,$00,$00,$06,$61,$00,$02,$A8,$20,$1F
	dc.b	$48,$40,$48,$C0,$80,$FC,$00,$3C,$2F,$00,$61,$00,$02,$98,$20,$1F
	dc.b	$48,$40,$48,$C0,$52,$78,$B0,$40,$80,$FC,$00,$0A,$2F,$00,$61,$00
	dc.b	$02,$84,$20,$1F,$48,$40,$48,$C0,$61,$00,$02,$7A,$4E,$B9,$00,$01
	dc.b	$BB,$8E,$00,$06,$BF,$08,$02,$00,$22,$7C,$00,$00,$07,$7E,$30,$38
	dc.b	$C3,$A2,$E5,$40,$22,$71,$00,$00,$D2,$E9,$00,$04,$D2,$D1,$D2,$D1
	dc.b	$30,$11,$55,$40,$E2,$40,$91,$78,$B0,$40,$31,$F8,$B0,$16,$B0,$14
	dc.b	$21,$FC,$00,$1B,$89,$C8,$B0,$10,$4E,$B9,$00,$01,$BE,$E8,$4E,$B9
	dc.b	$00,$01,$BB,$8E,$00,$06,$BF,$1F,$02,$00,$22,$7C,$00,$00,$07,$7E
	dc.b	$30,$38,$C3,$A0,$E5,$40,$22,$71,$00,$00,$D2,$E9,$00,$04,$D2,$D1
	dc.b	$D2,$D1,$30,$11,$55,$40,$E2,$40,$91,$78,$B0,$40,$31,$F8,$B0,$16
	dc.b	$B0,$14,$21,$FC,$00,$1B,$89,$C8,$B0,$10,$4E,$B9,$00,$01,$BE,$E8
	dc.b	$4E,$B9,$00,$01,$BE,$C4,$00,$0A,$F8,$04,$01,$05,$09,$F9,$03,$00
	dc.b	$22,$7C,$FF,$FF,$CA,$D0,$30,$11,$32,$3C,$00,$02,$4E,$B9,$00,$01
	dc.b	$BE,$1C,$4E,$B9,$00,$01,$BE,$E8,$4E,$B9,$00,$01,$BE,$C4,$00,$0A
	dc.b	$F8,$04,$01,$20,$09,$F9,$03,$00,$22,$7C,$FF,$FF,$C7,$32,$30,$11
	dc.b	$32,$3C,$00,$02,$4E,$B9,$00,$01,$BE,$1C,$4E,$B9,$00,$01,$BE,$E8
	dc.b	$22,$7C,$FF,$FF,$CA,$C4,$4E,$B9,$00,$01,$BB,$8E,$00,$06,$8F,$05
	dc.b	$14,$00,$30,$11,$32,$3C,$00,$03,$4E,$B9,$00,$01,$BE,$1C,$4E,$B9
	dc.b	$00,$01,$BC,$84,$22,$7C,$FF,$FF,$C7,$26,$4E,$B9,$00,$01,$BB,$8E
	dc.b	$00,$06,$8F,$20,$14,$00,$30,$11,$32,$3C,$00,$03,$4E,$B9,$00,$01
	dc.b	$BE,$1C,$4E,$B9,$00,$01,$BC,$84,$4E,$B9,$00,$01,$BB,$8E,$00,$06
	dc.b	$8F,$1E,$0E,$00,$34,$7C,$C7,$26,$61,$00,$00,$3E,$4E,$B9,$00,$01
	dc.b	$BB,$8E,$00,$06,$8F,$03,$0E,$00,$34,$7C,$CA,$C4,$61,$00,$00,$2A
	dc.b	$61,$00,$01,$78,$20,$7C,$00,$1B,$CB,$FA,$4E,$B9,$00,$01,$21,$8A
	dc.b	$08,$B8,$00,$02,$BF,$B2,$46,$FC,$25,$00,$3F,$3C,$00,$01,$4E,$B9
	dc.b	$00,$08,$85,$86,$24,$5F,$4E,$75,$41,$EA,$00,$A4,$42,$40,$10,$18
	dc.b	$6B,$00,$00,$10,$08,$32,$00,$06,$00,$6C,$66,$F0,$61,$00,$00,$1E
	dc.b	$60,$EA,$41,$EA,$00,$A4,$42,$40,$10,$18,$6B,$00,$00,$6A,$08,$32
	dc.b	$00,$06,$00,$6C,$67,$F0,$61,$00,$00,$04,$60,$EA,$0C,$78,$00,$10
	dc.b	$B0,$42,$62,$00,$00,$52,$34,$32,$00,$6C,$02,$42,$07,$FF,$3E,$2A
	dc.b	$00,$28,$E2,$48,$4E,$B9,$00,$01,$01,$E6,$D2,$D1,$50,$49,$42,$40
	dc.b	$10,$29,$FF,$F8,$3F,$38,$B0,$40,$32,$7C,$BF,$F4,$4E,$B9,$00,$02
	dc.b	$30,$C4,$32,$7C,$BF,$F2,$32,$BC,$00,$04,$4E,$B9,$00,$01,$BC,$84
	dc.b	$30,$02,$4E,$B9,$00,$01,$BD,$84,$4E,$B9,$00,$01,$BC,$84,$31,$DF
	dc.b	$B0,$40,$52,$78,$B0,$42,$4E,$75

PeriodText	;sub_1E2970: the period names
	String	'1st period'
	String	'2nd period'
	String	'3rd period'
	String	' overtime '
	String	'          '
	String	'          '
	String	'          '

DigitText	;The digits 0-9
	String	$30
	String	$31
	String	$32
	String	$33
	String	$34
	String	$35
	String	$36
	String	$37
	String	$38
	String	$39

PrintDigit	;Print digit d0 (DigitText)
	;Code the listing does not decode: kept as bytes
	dc.b	$22,$7C,$00,$1E,$2E,$3C,$4E,$B9,$00,$01,$D7,$F2,$4E,$F9,$00,$01
	dc.b	$BE,$E8
