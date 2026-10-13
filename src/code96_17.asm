;	The created players list, the sign free agents and release player screens (code the listing does not
;	decode, kept as bytes with labels; the texts written out), then the game options screen (OptionsScreen) and
;	its menu, the option save RAM block and SetPlayMode.

sub_1DFA1C	;Clear save RAM bytes $DE6-$E5D
	movem.l	d0-d1/a0,-(sp)
	move.l	#$DE6,d0
	moveq	#$78,d1
	jsr	(ClearSRAMBytes).l
	movem.l	(sp)+,d0-d1/a0
	rts

ClearCreatedPlayers	;Clear the created players list at M68K_RAM+$DB4 (20 x $8000 + 0 terminator)
	movem.l	d0-d7/a0-a6,-(sp)
	movea.l	#M68K_RAM+$DB4,a0
	move.w	#$13,d6
.loop
	move.w	#$8000,(a0)+
	dbf	d6,.loop
	move.b	#0,(byte_FF0DDC).l
	movem.l	(sp)+,d0-d7/a0-a6
	rts

DeleteCreatedPlayer	;Delete created player #TempWord1: remove it from the save RAM records, roster list and team lines
	;Code the listing does not decode: kept as bytes
	dc.b	$48,$E7,$FF,$FE,$3E,$3C,$00,$1C,$08,$F8,$00,$06,$C3,$50,$30,$38
	dc.b	$BF,$46,$02,$40,$00,$FF,$48,$A7,$81,$00,$4E,$B9,$00,$1D,$FB,$54
	dc.b	$34,$C0,$4C,$9F,$00,$81,$4E,$B9,$00,$01,$02,$B8,$34,$F8,$DD,$AA
	dc.b	$20,$7C,$FF,$FF,$D1,$30,$4E,$B9,$00,$1D,$FB,$7C,$30,$38,$BF,$46
	dc.b	$02,$40,$00,$FF,$D0,$40,$B0,$7C,$00,$26,$66,$00,$00,$0C,$31,$FC
	dc.b	$80,$00,$D1,$56,$60,$00,$00,$1A,$36,$3C,$00,$26,$32,$30,$00,$02
	dc.b	$31,$81,$00,$00,$54,$40,$B0,$43,$6D,$F2,$31,$BC,$80,$00,$00,$00
	dc.b	$3F,$00,$30,$3C,$00,$28,$53,$30,$00,$00,$30,$1F,$4E,$B9,$00,$1D
	dc.b	$FB,$94,$48,$E7,$FF,$FE,$20,$7C,$00,$20,$1B,$CC,$30,$38,$BF,$46
	dc.b	$02,$40,$00,$FF,$C0,$FC,$00,$0C,$D1,$C0,$2F,$08,$34,$3C,$00,$02
	dc.b	$14,$E8,$00,$01,$14,$E8,$00,$03,$58,$48,$51,$CA,$FF,$F4,$20,$5F
	dc.b	$30,$38,$BF,$46,$02,$40,$00,$FF,$B0,$7C,$00,$13,$67,$00,$00,$1A
	dc.b	$20,$A8,$00,$0C,$21,$68,$00,$10,$00,$04,$21,$68,$00,$14,$00,$08
	dc.b	$D0,$FC,$00,$0C,$52,$40,$60,$E0,$5C,$4A,$42,$47,$74,$03,$76,$14
	dc.b	$22,$3C,$00,$00,$6E,$E8,$4E,$B9,$00,$1D,$D4,$B6,$4C,$DF,$7F,$FF
	dc.b	$4E,$B9,$00,$02,$41,$AA,$4C,$DF,$7F,$FF,$4E,$75

GetCreatedId	;The player id word of created entry d0
	;Code the listing does not decode: kept as bytes
	dc.b	$48,$E7,$7F,$FE,$20,$7C,$00,$20,$1B,$68,$D0,$40,$D0,$40,$D0,$C0
	dc.b	$30,$28,$00,$02,$02,$40,$00,$FF,$3E,$10,$E1,$4F,$02,$47,$FF,$00
	dc.b	$80,$47,$4C,$DF,$7F,$FE,$4E,$75

ReadCreateList	;Read the created players list from save RAM
	;Code the listing does not decode: kept as bytes
	dc.b	$48,$E7,$C0,$00,$20,$3C,$00,$00,$0D,$B4,$72,$29,$4E,$B9,$00,$02
	dc.b	$41,$E8,$4C,$DF,$00,$03,$4E,$75

WriteCreateList	;Write the created players list to save RAM
	;Code the listing does not decode: kept as bytes
	dc.b	$48,$E7,$C0,$00,$20,$3C,$00,$00,$0D,$B4,$72,$29,$4E,$B9,$00,$02
	dc.b	$41,$88,$4C,$DF,$00,$03,$4E,$75

SignFreeAgents	;The sign free agents screen (roster menu item Sign Free Agents)
	;Code the listing does not decode: kept as bytes
	dc.b	$4E,$B9,$00,$01,$AF,$52,$61,$00,$06,$C2,$20,$7C,$00,$19,$76,$2A
	dc.b	$4E,$B9,$00,$01,$21,$8A,$4E,$B9,$00,$1E,$0D,$66,$61,$00,$08,$CE
	dc.b	$30,$3C,$00,$03,$20,$7C,$FF,$FF,$C8,$E2,$42,$98,$51,$C8,$FF,$FC
	dc.b	$42,$79,$FF,$FF,$27,$16,$42,$79,$FF,$FF,$27,$10,$61,$00,$08,$14
	dc.b	$31,$FC,$00,$18,$BD,$3C,$08,$B8,$00,$02,$BF,$B2,$61,$00,$06,$6A
	dc.b	$67,$00,$05,$50,$3E,$39,$FF,$FF,$27,$16,$4E,$B9,$00,$1E,$0D,$86
	dc.b	$42,$79,$FF,$FF,$27,$12,$30,$39,$00,$20,$1B,$B8,$53,$00,$02,$40
	dc.b	$00,$FF,$B0,$7C,$00,$09,$6F,$00,$00,$06,$30,$3C,$00,$09,$33,$C0
	dc.b	$FF,$FF,$27,$14,$20,$7C,$FF,$FF,$3A,$98,$61,$00,$05,$74,$61,$00
	dc.b	$05,$B6,$31,$FC,$FF,$FF,$D0,$14,$4E,$B9,$00,$1D,$CC,$8A,$61,$00
	dc.b	$07,$B2,$4E,$B9,$00,$1D,$CC,$8A,$61,$00,$03,$26,$61,$00,$02,$5C
	dc.b	$46,$FC,$25,$00,$60,$00,$00,$2A,$0C,$78,$FF,$FF,$D0,$14,$67,$00
	dc.b	$00,$20,$4E,$B9,$00,$1D,$CC,$8A,$61,$00,$07,$88,$4E,$B9,$00,$1D
	dc.b	$CC,$8A,$61,$00,$02,$FC,$4E,$B9,$00,$1D,$CC,$8A,$61,$00,$02,$2C
	dc.b	$31,$FC,$FF,$FF,$D0,$14,$61,$00,$04,$32,$4A,$41,$67,$00,$04,$B2
	dc.b	$08,$01,$00,$00,$67,$00,$00,$2C,$4A,$79,$FF,$FF,$27,$10,$67,$00
	dc.b	$00,$0A,$53,$79,$FF,$FF,$27,$10,$60,$8E,$4A,$79,$FF,$FF,$27,$12
	dc.b	$67,$CE,$53,$79,$FF,$FF,$27,$12,$53,$79,$FF,$FF,$27,$14,$60,$00
	dc.b	$FF,$78,$08,$01,$00,$01,$67,$00,$00,$46,$30,$39,$FF,$FF,$27,$10
	dc.b	$D0,$79,$FF,$FF,$27,$12,$B0,$79,$FF,$FF,$27,$14,$67,$00,$00,$0C
	dc.b	$52,$79,$FF,$FF,$27,$10,$60,$00,$FF,$50,$30,$39,$00,$20,$1B,$B8
	dc.b	$02,$40,$00,$FF,$53,$40,$B0,$79,$FF,$FF,$27,$14,$6F,$82,$52,$79
	dc.b	$FF,$FF,$27,$12,$52,$79,$FF,$FF,$27,$14,$60,$00,$FF,$2C,$08,$01
	dc.b	$00,$04,$67,$00,$00,$1E,$52,$79,$FF,$FF,$27,$16,$0C,$79,$00,$1A
	dc.b	$FF,$FF,$27,$16,$6D,$00,$FF,$12,$42,$79,$FF,$FF,$27,$16,$60,$00
	dc.b	$FF,$08,$08,$01,$00,$06,$67,$00,$00,$18,$53,$79,$FF,$FF,$27,$16
	dc.b	$6A,$00,$FE,$F6,$33,$FC,$00,$19,$FF,$FF,$27,$16,$60,$00,$FE,$EA
	dc.b	$08,$01,$00,$07,$66,$00,$03,$EA,$08,$01,$00,$05,$67,$00,$01,$3C
	dc.b	$3E,$39,$FF,$FF,$27,$16,$20,$7C,$FF,$FF,$4E,$20,$30,$39,$FF,$FF
	dc.b	$27,$12,$D0,$79,$FF,$FF,$27,$10,$D0,$40,$30,$30,$00,$00,$48,$A7
	dc.b	$01,$00,$3E,$3C,$00,$1C,$02,$40,$00,$FF,$4E,$B9,$00,$01,$03,$AA
	dc.b	$31,$C0,$BF,$7C,$4A,$40,$4C,$9F,$00,$80,$66,$00,$00,$0E,$61,$00
	dc.b	$00,$FE,$67,$00,$01,$92,$66,$00,$00,$1C,$4E,$B9,$00,$01,$57,$B2
	dc.b	$3F,$00,$4E,$B9,$00,$01,$57,$74,$90,$5F,$44,$40,$B0,$7C,$00,$18
	dc.b	$67,$00,$01,$74,$20,$7C,$FF,$FF,$4E,$20,$30,$39,$FF,$FF,$27,$12
	dc.b	$D0,$79,$FF,$FF,$27,$10,$D0,$40,$30,$30,$00,$00,$31,$C0,$BF,$46
	dc.b	$3E,$3C,$00,$1C,$30,$38,$BF,$46,$4E,$B9,$00,$01,$02,$B8,$11,$F8
	dc.b	$DD,$AB,$BF,$46,$24,$7C,$FF,$FF,$D3,$C8,$3F,$38,$BF,$46,$08,$B8
	dc.b	$00,$06,$C3,$50,$4E,$B9,$00,$1D,$FA,$58,$31,$DF,$BF,$46,$31,$F9
	dc.b	$FF,$FF,$27,$16,$BF,$4C,$30,$38,$BF,$7C,$33,$C0,$FF,$FF,$27,$18
	dc.b	$3E,$39,$FF,$FF,$27,$16,$4A,$40,$67,$00,$00,$0C,$4E,$B9,$00,$01
	dc.b	$57,$B2,$60,$00,$00,$08,$4E,$B9,$00,$01,$57,$74,$32,$39,$FF,$FF
	dc.b	$27,$18,$E1,$49,$80,$41,$31,$C0,$BF,$48,$31,$F9,$FF,$FF,$27,$16
	dc.b	$BF,$4C,$24,$7C,$FF,$FF,$D3,$C8,$3F,$38,$BF,$46,$3F,$38,$BF,$48
	dc.b	$3F,$38,$BF,$4C,$4E,$B9,$00,$1D,$D5,$16,$31,$DF,$BF,$4C,$31,$DF
	dc.b	$BF,$48,$31,$DF,$BF,$46,$08,$B8,$00,$06,$C3,$50,$4E,$B9,$00,$02
	dc.b	$41,$AA,$61,$00,$06,$6A,$4A,$79,$FF,$FF,$27,$10,$67,$00,$00,$08
	dc.b	$53,$79,$FF,$FF,$27,$10,$60,$00,$FD,$54,$60,$00,$FD,$BC,$4E,$B9
	dc.b	$00,$01,$57,$74,$B0,$7C,$00,$03,$4E,$75

FreeAgentArrows	;Draw scroll up/down arrows for the list
	;Code the listing does not decode: kept as bytes
	dc.b	$48,$E7,$FF,$FE,$4E,$B9,$00,$01,$BA,$2E,$00,$04,$FE,$07,$30,$39
	dc.b	$FF,$FF,$27,$12,$D0,$79,$FF,$FF,$27,$10,$67,$00,$00,$14,$4E,$B9
	dc.b	$00,$01,$BA,$2E,$00,$08,$FD,$02,$FC,$10,$7B,$00,$60,$00,$00,$10
	dc.b	$4E,$B9,$00,$01,$BA,$2E,$00,$08,$FD,$02,$FC,$10,$20,$00,$32,$39
	dc.b	$FF,$FF,$27,$10,$D2,$79,$FF,$FF,$27,$12,$30,$39,$00,$20,$1B,$B8
	dc.b	$02,$40,$00,$FF,$53,$40,$B2,$40,$6C,$00,$00,$14,$4E,$B9,$00,$01
	dc.b	$BA,$2E,$00,$08,$FD,$02,$FC,$19,$7D,$00,$60,$00,$00,$10,$4E,$B9
	dc.b	$00,$01,$BA,$2E,$00,$08,$FD,$02,$FC,$19,$20,$00,$4E,$B9,$00,$01
	dc.b	$BA,$2E,$00,$04,$FE,$07,$4C,$DF,$7F,$FF,$4E,$75,$61,$00,$04,$EC
	dc.b	$4E,$B9,$00,$01,$BA,$2E,$00,$24,$FE,$07,$FD,$18,$FC,$06,$56,$49
	dc.b	$4F,$4C,$41,$54,$49,$4F,$4E,$20,$4F,$46,$FD,$17,$FA,$01,$52,$4F
	dc.b	$53,$54,$45,$52,$20,$52,$55,$4C,$45,$53,$61,$00,$01,$54,$61,$00
	dc.b	$05,$22,$60,$00,$FC,$CA

DrawFreeAgents	;Draw visible free agent rows (pos, name, rating)
	;Code the listing does not decode: kept as bytes
	dc.b	$3A,$39,$FF,$FF,$27,$10,$2A,$7C,$FF,$FF,$27,$12,$28,$7C,$FF,$FF
	dc.b	$3A,$98,$26,$7C,$FF,$FF,$4E,$20,$31,$FC,$00,$10,$B0,$42,$3E,$3C
	dc.b	$00,$1C,$3F,$38,$B0,$42,$4E,$B9,$00,$01,$BB,$8E,$00,$06,$8F,$00
	dc.b	$00,$00,$31,$DF,$B0,$42,$42,$46,$30,$15,$E3,$40,$48,$C0,$D9,$C0
	dc.b	$D7,$C0,$4E,$B9,$00,$01,$BA,$2E,$00,$24,$FD,$02,$20,$20,$20,$20
	dc.b	$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$FB,$02,$20,$20,$20
	dc.b	$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$31,$FC,$00,$03
	dc.b	$B0,$40,$4E,$B9,$00,$01,$BA,$2E,$00,$04,$FE,$07,$BC,$45,$66,$00
	dc.b	$00,$0C,$4E,$B9,$00,$01,$BA,$2E,$00,$04,$FE,$06,$30,$13,$3E,$3C
	dc.b	$00,$1C,$4E,$B9,$00,$01,$01,$7A,$4E,$B9,$00,$01,$BC,$84,$31,$FC
	dc.b	$00,$16,$B0,$40,$22,$7C,$00,$1D,$D8,$FE,$3E,$3C,$00,$1C,$30,$1B
	dc.b	$4E,$B9,$00,$01,$03,$AA,$33,$C0,$FF,$FF,$27,$18,$4E,$B9,$00,$01
	dc.b	$D7,$F2,$4E,$B9,$00,$01,$BC,$84,$31,$FC,$00,$1F,$B0,$40,$30,$14
	dc.b	$4E,$B9,$00,$01,$01,$DC,$D2,$D1,$50,$49,$20,$49,$48,$E7,$00,$08
	dc.b	$28,$7C,$FF,$FF,$C8,$F2,$2C,$7C,$00,$1D,$F9,$FC,$28,$39,$00,$02
	dc.b	$35,$B8,$4A,$79,$FF,$FF,$27,$18,$67,$00,$00,$0E,$2C,$7C,$00,$1D
	dc.b	$F9,$EC,$28,$39,$00,$02,$34,$56,$4E,$B9,$00,$1D,$F8,$AC,$4C,$DF
	dc.b	$10,$00,$C0,$FC,$00,$64,$80,$C1,$4E,$B9,$00,$1D,$93,$02,$32,$3C
	dc.b	$00,$02,$4E,$B9,$00,$01,$BE,$1C,$4E,$B9,$00,$01,$BC,$84,$54,$8C
	dc.b	$52,$78,$B0,$42,$52,$46,$30,$39,$FF,$FF,$27,$12,$D0,$46,$B0,$79
	dc.b	$FF,$FF,$27,$14,$6F,$00,$FE,$FC,$4E,$75,$2C,$3C,$00,$00,$54,$60
	dc.b	$3C,$3C,$00,$64,$32,$38,$B0,$52,$92,$78,$B0,$54,$67,$F2,$31,$F8
	dc.b	$B0,$52,$B0,$54,$4E,$B9,$00,$01,$26,$40,$4E,$B9,$00,$01,$B3,$48
	dc.b	$4E,$B9,$00,$01,$B3,$20,$4A,$41,$67,$00,$00,$06,$60,$00,$00,$50
	dc.b	$4E,$B9,$00,$01,$B3,$60,$4E,$B9,$00,$01,$B3,$20,$4A,$41,$67,$00
	dc.b	$00,$06,$60,$00,$00,$3A,$4A,$78,$D2,$50,$67,$00,$00,$2E,$4E,$B9
	dc.b	$00,$01,$B3,$78,$4E,$B9,$00,$01,$B3,$20,$4A,$41,$67,$00,$00,$06
	dc.b	$60,$00,$00,$1C,$4E,$B9,$00,$01,$B3,$90,$4E,$B9,$00,$01,$B3,$20
	dc.b	$4A,$41,$67,$00,$00,$06,$60,$00,$00,$06,$51,$CE,$FF,$84,$4E,$75
	dc.b	$4E,$75,$42,$40,$60,$00,$00,$02,$48,$A7,$E0,$00,$61,$00,$02,$D6
	dc.b	$4C,$9F,$00,$07,$22,$7C,$00,$1E,$01,$78,$4E,$B9,$00,$01,$D7,$F2
	dc.b	$4E,$B9,$00,$01,$BC,$84,$61,$00,$FF,$52,$60,$D4

FreeAgentMsgText	;SignFreeAgents: the message when there are no free agents
	String	$8F,$18,$06,'No free agents.',$8F,$17,$07,'Press Any button',$8F,$16,$08,'to exit.'
	dc.b	$4E,$75

BuildFreeAgentList	;Copy the free agent list from save RAM to a work table and an index list
	;Code the listing does not decode: kept as bytes
	dc.b	$48,$E7,$FF,$FE,$30,$39,$00,$20,$1B,$B8,$02,$40,$00,$FF,$67,$00
	dc.b	$00,$30,$53,$40,$20,$7C,$00,$20,$1B,$68,$22,$7C,$FF,$FF,$3A,$98
	dc.b	$2A,$7C,$FF,$FF,$4E,$20,$42,$46,$22,$18,$14,$01,$02,$42,$00,$FF
	dc.b	$48,$41,$E1,$49,$84,$41,$32,$C2,$3A,$C6,$52,$46,$51,$C8,$FF,$EA
	dc.b	$4C,$DF,$7F,$FF,$4E,$75,$48,$E7,$FF,$FE,$3A,$39,$00,$20,$1B,$B8
	dc.b	$02,$45,$00,$FF,$BA,$7C,$00,$02,$6D,$00,$00,$58,$55,$45,$3E,$3C
	dc.b	$00,$1C,$20,$7C,$FF,$FF,$3A,$98,$22,$7C,$FF,$FF,$4E,$20,$38,$05
	dc.b	$42,$46,$30,$11,$4E,$B9,$00,$01,$03,$AA,$3F,$00,$30,$29,$00,$02
	dc.b	$4E,$B9,$00,$01,$03,$AA,$B0,$5F,$6C,$00,$00,$1C,$50,$C6,$30,$11
	dc.b	$34,$29,$00,$02,$33,$40,$00,$02,$32,$82,$30,$10,$34,$28,$00,$02
	dc.b	$31,$40,$00,$02,$30,$82,$54,$48,$54,$49,$51,$CC,$FF,$C6,$4A,$46
	dc.b	$66,$B0,$4C,$DF,$7F,$FF,$4E,$75,$48,$A7,$80,$00,$30,$39,$00,$20
	dc.b	$1B,$B8,$4A,$00,$4C,$9F,$00,$01,$4E,$75,$08,$F8,$00,$05,$C3,$56
	dc.b	$21,$FC,$00,$01,$2D,$46,$D2,$44,$08,$B8,$00,$00,$BF,$B2,$08,$F8
	dc.b	$00,$02,$BF,$B2,$08,$B8,$00,$01,$BF,$B2,$31,$FC,$00,$00,$B0,$00
	dc.b	$31,$FC,$B8,$00,$B0,$02,$31,$FC,$B8,$00,$B0,$0C,$31,$FC,$00,$05
	dc.b	$B0,$0E,$31,$FC,$C0,$00,$B0,$08,$31,$FC,$00,$06,$B0,$0A,$31,$FC
	dc.b	$E0,$00,$B0,$04,$31,$FC,$00,$06,$B0,$06,$30,$3C,$00,$00,$08,$F8
	dc.b	$00,$05,$BF,$B2,$4E,$B9,$00,$01,$B5,$7E,$08,$B8,$00,$05,$BF,$B2
	dc.b	$4E,$B9,$00,$01,$B2,$C4,$38,$3C,$00,$01,$22,$7C,$00,$19,$76,$2A
	dc.b	$4E,$B9,$00,$01,$21,$7A,$31,$C4,$B0,$1C,$24,$7C,$00,$17,$91,$70
	dc.b	$4E,$B9,$00,$01,$B7,$30,$31,$C4,$B0,$1E,$24,$7C,$00,$17,$A1,$6C
	dc.b	$4E,$B9,$00,$01,$B7,$30,$21,$FC,$00,$17,$91,$68,$BF,$8A,$31,$C4
	dc.b	$B0,$18,$24,$7C,$00,$17,$B6,$88,$4E,$B9,$00,$01,$B7,$30,$08,$F8
	dc.b	$00,$02,$C3,$54,$4E,$B9,$00,$01,$BA,$2E,$00,$08,$FF,$01,$FD,$00
	dc.b	$FC,$00,$70,$28,$72,$1C,$34,$3C,$07,$FF,$4E,$B9,$00,$01,$B9,$76
	dc.b	$4E,$B9,$00,$01,$BB,$8E,$00,$06,$BF,$00,$00,$00,$20,$7C,$00,$19
	dc.b	$82,$60,$22,$48,$24,$48,$D1,$DA,$D3,$DA,$42,$40,$42,$41,$74,$28
	dc.b	$76,$1C,$7A,$08,$4E,$B9,$00,$01,$B6,$92,$4E,$B9,$00,$01,$BB,$8E
	dc.b	$00,$06,$BF,$0B,$01,$00,$20,$7C,$00,$19,$6E,$0A,$22,$48,$24,$48
	dc.b	$D1,$DA,$D3,$DA,$42,$40,$42,$41,$34,$11,$36,$29,$00,$02,$7A,$08
	dc.b	$4E,$B9,$00,$01,$B6,$92,$4E,$B9,$00,$01,$BB,$8E,$00,$06,$FE,$00
	dc.b	$00,$00,$20,$7C,$00,$17,$3C,$7A,$22,$48,$24,$48,$D1,$DA,$D3,$DA
	dc.b	$42,$40,$42,$41,$74,$40,$76,$1C,$7A,$01,$4E,$B9,$00,$01,$B6,$92
	dc.b	$33,$C4,$FF,$FF,$23,$28,$06,$44,$00,$C8,$08,$F8,$00,$02,$C3,$54
	dc.b	$4E,$B9,$00,$01,$BE,$D6,$00,$16,$F8,$04,$01,$15,$0C,$70,$6F,$73
	dc.b	$F8,$04,$01,$1C,$0C,$6F,$76,$65,$72,$61,$6C,$6C,$46,$FC,$25,$00
	dc.b	$4E,$75,$48,$E7,$FF,$FE,$3E,$39,$FF,$FF,$27,$16,$4E,$B9,$00,$01
	dc.b	$BB,$8E,$00,$06,$BF,$01,$04,$00,$38,$39,$FF,$FF,$23,$28,$3A,$3C
	dc.b	$00,$02,$4E,$B9,$00,$01,$2B,$B2,$31,$FC,$00,$64,$BD,$3C,$4C,$DF
	dc.b	$7F,$FF,$4E,$75,$48,$E7,$FF,$FE,$4E,$B9,$00,$01,$BA,$2E,$00,$58
	dc.b	$FE,$07,$FF,$01,$FD,$18,$FC,$06,$20,$20,$20,$20,$20,$20,$20,$20
	dc.b	$20,$20,$20,$20,$20,$20,$20,$FD,$17,$FA,$01,$20,$20,$20,$20,$20
	dc.b	$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$FD,$16,$FA,$01,$20
	dc.b	$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
	dc.b	$FD,$15,$FA,$01,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
	dc.b	$20,$20,$20,$20,$20,$00,$4C,$DF,$7F,$FF,$4E,$75,$48,$E7,$FF,$FE
	dc.b	$61,$92,$4E,$B9,$00,$01,$BC,$72,$00,$06,$8F,$18,$06,$00,$4E,$B9
	dc.b	$00,$01,$BA,$2E,$00,$44,$73,$74,$61,$72,$74,$2D,$65,$78,$69,$74
	dc.b	$FD,$17,$FA,$01,$63,$2D,$73,$69,$67,$6E,$20,$70,$6C,$61,$79,$65
	dc.b	$72,$FD,$16,$FA,$01,$7B,$7D,$73,$65,$6C,$65,$63,$74,$20,$70,$6C
	dc.b	$61,$79,$65,$72,$FD,$15,$FA,$01,$61,$2F,$62,$2D,$73,$77,$69,$74
	dc.b	$63,$68,$20,$74,$65,$61,$6D,$73,$4C,$DF,$7F,$FF,$4E,$75,$4E,$B9
	dc.b	$00,$01,$BB,$8E,$00,$06,$8F,$02,$10,$00,$34,$3C,$07,$FF,$30,$3C
	dc.b	$00,$0E,$32,$3C,$00,$0A,$4E,$B9,$00,$01,$B9,$76,$4E,$B9,$00,$01
	dc.b	$BB,$8E,$00,$06,$8F,$14,$10,$00,$34,$3C,$07,$FF,$30,$3C,$00,$10
	dc.b	$32,$3C,$00,$0A,$4E,$F9,$00,$01,$B9,$76

ReleasePlayers	;The release player screen (roster menu item Release Player)
	;Code the listing does not decode: kept as bytes
	dc.b	$4E,$B9,$00,$01,$AF,$52,$4E,$B9,$00,$1E,$0B,$76,$20,$7C,$00,$19
	dc.b	$97,$AE,$4E,$B9,$00,$01,$21,$8A,$4E,$B9,$00,$1E,$0D,$66,$61,$00
	dc.b	$07,$A8,$42,$79,$FF,$FF,$27,$16,$42,$79,$FF,$FF,$27,$10,$31,$FC
	dc.b	$00,$00,$C3,$A0,$31,$FC,$00,$00,$C3,$A2,$4E,$B9,$00,$02,$14,$82
	dc.b	$61,$00,$FE,$86,$31,$FC,$00,$18,$BD,$3C,$08,$B8,$00,$02,$BF,$B2
	dc.b	$30,$39,$00,$20,$1B,$B8,$02,$40,$00,$FF,$B0,$7C,$00,$14,$6C,$00
	dc.b	$05,$36,$42,$79,$FF,$FF,$27,$12,$3E,$39,$FF,$FF,$27,$16,$4E,$B9
	dc.b	$00,$1E,$0D,$86,$31,$C7,$C3,$A0,$31,$C7,$C3,$A2,$4E,$B9,$00,$02
	dc.b	$14,$82,$4E,$B9,$00,$01,$57,$B2,$53,$40,$B0,$7C,$00,$09,$6F,$00
	dc.b	$00,$06,$30,$3C,$00,$09,$33,$C0,$FF,$FF,$27,$14,$20,$7C,$FF,$FF
	dc.b	$3A,$98,$22,$7C,$FF,$FF,$2A,$F8,$61,$00,$C8,$CE,$61,$00,$05,$50
	dc.b	$31,$FC,$FF,$FF,$D0,$14,$4E,$B9,$00,$1D,$CC,$8A,$61,$00,$FE,$0A
	dc.b	$4E,$B9,$00,$1D,$CC,$8A,$61,$00,$03,$48,$61,$00,$02,$7C,$0C,$78
	dc.b	$FF,$FF,$D0,$14,$67,$00,$00,$16,$4E,$B9,$00,$1D,$CC,$8A,$61,$00
	dc.b	$FD,$E8,$4E,$B9,$00,$1D,$CC,$8A,$61,$00,$03,$26,$31,$FC,$FF,$FF
	dc.b	$D0,$14,$61,$00,$04,$1A,$4A,$41,$67,$00,$04,$9A,$08,$01,$00,$00
	dc.b	$67,$00,$00,$2A,$4A,$79,$FF,$FF,$27,$10,$67,$00,$00,$0A,$53,$79
	dc.b	$FF,$FF,$27,$10,$60,$A0,$4A,$79,$FF,$FF,$27,$12,$67,$CE,$53,$79
	dc.b	$FF,$FF,$27,$12,$53,$79,$FF,$FF,$27,$14,$60,$8A,$08,$01,$00,$01
	dc.b	$67,$00,$00,$48,$30,$39,$FF,$FF,$27,$10,$D0,$79,$FF,$FF,$27,$12
	dc.b	$B0,$79,$FF,$FF,$27,$14,$67,$00,$00,$0C,$52,$79,$FF,$FF,$27,$10
	dc.b	$60,$00,$FF,$64,$3E,$39,$FF,$FF,$27,$16,$4E,$B9,$00,$01,$57,$B2
	dc.b	$53,$40,$B0,$79,$FF,$FF,$27,$14,$6F,$82,$52,$79,$FF,$FF,$27,$12
	dc.b	$52,$79,$FF,$FF,$27,$14,$60,$00,$FF,$3E,$08,$01,$00,$04,$67,$00
	dc.b	$00,$32,$42,$79,$FF,$FF,$27,$10,$42,$79,$FF,$FF,$27,$12,$33,$FC
	dc.b	$00,$09,$FF,$FF,$27,$14,$52,$79,$FF,$FF,$27,$16,$0C,$79,$00,$1A
	dc.b	$FF,$FF,$27,$16,$6D,$00,$FE,$AA,$42,$79,$FF,$FF,$27,$16,$60,$00
	dc.b	$FE,$A0,$08,$01,$00,$06,$67,$00,$00,$2C,$42,$79,$FF,$FF,$27,$10
	dc.b	$42,$79,$FF,$FF,$27,$12,$33,$FC,$00,$09,$FF,$FF,$27,$14,$53,$79
	dc.b	$FF,$FF,$27,$16,$6A,$00,$FE,$7A,$33,$FC,$00,$19,$FF,$FF,$27,$16
	dc.b	$60,$00,$FE,$6E,$08,$01,$00,$07,$66,$00,$03,$AA,$08,$01,$00,$05
	dc.b	$67,$00,$01,$46,$3E,$39,$FF,$FF,$27,$16,$4E,$B9,$00,$01,$57,$B2
	dc.b	$B0,$7C,$00,$11,$67,$00,$01,$D0,$20,$7C,$FF,$FF,$3A,$98,$30,$39
	dc.b	$FF,$FF,$27,$12,$D0,$79,$FF,$FF,$27,$10,$E5,$40,$D0,$C0,$42,$40
	dc.b	$10,$28,$00,$01,$66,$00,$00,$0C,$4E,$B9,$00,$1E,$08,$72,$67,$00
	dc.b	$01,$A6,$20,$7C,$FF,$FF,$3A,$98,$30,$39,$FF,$FF,$27,$12,$D0,$79
	dc.b	$FF,$FF,$27,$10,$E5,$40,$D0,$C0,$11,$E8,$00,$01,$BF,$46,$11,$E8
	dc.b	$00,$02,$BF,$47,$31,$F9,$FF,$FF,$27,$16,$BF,$4A,$24,$7C,$FF,$FF
	dc.b	$D3,$C8,$4E,$B9,$00,$1D,$D2,$12,$31,$F9,$FF,$FF,$27,$16,$D0,$16
	dc.b	$31,$F9,$FF,$FF,$27,$16,$D0,$1E,$20,$7C,$00,$20,$1B,$68,$42,$78
	dc.b	$BF,$50,$4A,$28,$00,$01,$6B,$00,$00,$0A,$58,$88,$52,$78,$BF,$50
	dc.b	$60,$F0,$30,$38,$D3,$C8,$02,$40,$1F,$FF,$12,$38,$BF,$46,$02,$41
	dc.b	$00,$03,$34,$3C,$00,$0D,$E5,$69,$80,$41,$32,$00,$E0,$49,$02,$41
	dc.b	$00,$FF,$30,$81,$02,$40,$00,$FF,$31,$40,$00,$02,$48,$E7,$FF,$FE
	dc.b	$30,$38,$BF,$50,$C0,$FC,$00,$0C,$20,$7C,$00,$20,$1B,$CC,$D1,$C0
	dc.b	$24,$7C,$FF,$FF,$D3,$CC,$34,$3C,$00,$02,$11,$5A,$00,$01,$11,$5A
	dc.b	$00,$03,$58,$48,$51,$CA,$FF,$F4,$5C,$4A,$3F,$38,$BF,$48,$31,$F8
	dc.b	$BF,$50,$BF,$48,$42,$47,$74,$03,$76,$14,$22,$3C,$00,$00,$6E,$E8
	dc.b	$4E,$B9,$00,$1D,$D7,$D4,$31,$DF,$BF,$48,$4C,$DF,$7F,$FF,$52,$79
	dc.b	$00,$20,$1B,$B8,$08,$B8,$00,$06,$C3,$50,$4E,$B9,$00,$02,$41,$AA
	dc.b	$61,$00,$FC,$A2,$4A,$79,$FF,$FF,$27,$10,$67,$00,$00,$08,$53,$79
	dc.b	$FF,$FF,$27,$10,$60,$00,$FD,$1A,$60,$00,$FD,$94

sub_1E0872	;Used from ReleasePlayers
	;Code the listing does not decode: kept as bytes
	dc.b	$4E,$B9,$00,$01,$57,$74,$B0,$7C,$00,$02,$4E,$75

ReleaseArrows	;Draw scroll arrows ({ above / } below) beside the roster list
	;Code the listing does not decode: kept as bytes
	dc.b	$48,$E7,$FF,$FE,$4E,$B9,$00,$01,$BA,$2E,$00,$04,$FE,$07,$30,$39
	dc.b	$FF,$FF,$27,$12,$D0,$79,$FF,$FF,$27,$10,$67,$00,$00,$14,$4E,$B9
	dc.b	$00,$01,$BA,$2E,$00,$08,$FD,$02,$FC,$10,$7B,$00,$60,$00,$00,$10
	dc.b	$4E,$B9,$00,$01,$BA,$2E,$00,$08,$FD,$02,$FC,$10,$20,$00,$32,$39
	dc.b	$FF,$FF,$27,$10,$D2,$79,$FF,$FF,$27,$12,$3E,$39,$FF,$FF,$27,$16
	dc.b	$4E,$B9,$00,$01,$57,$B2,$53,$40,$B2,$40,$6C,$00,$00,$14,$4E,$B9
	dc.b	$00,$01,$BA,$2E,$00,$08,$FD,$02,$FC,$19,$7D,$00,$60,$00,$00,$10
	dc.b	$4E,$B9,$00,$01,$BA,$2E,$00,$08,$FD,$02,$FC,$19,$20,$00,$4E,$B9
	dc.b	$00,$01,$BA,$2E,$00,$04,$FE,$07,$4C,$DF,$7F,$FF,$4E,$75,$61,$00
	dc.b	$FB,$22,$4E,$B9,$00,$01,$BA,$2E,$00,$24,$FE,$07,$FD,$18,$FC,$06
	dc.b	$56,$49,$4F,$4C,$41,$54,$49,$4F,$4E,$20,$4F,$46,$FD,$17,$FA,$01
	dc.b	$52,$4F,$53,$54,$45,$52,$20,$52,$55,$4C,$45,$53,$61,$00,$01,$08
	dc.b	$61,$00,$03,$BE,$60,$00,$FC,$A8,$40,$E7

DrawReleaseRoster	;Draw the visible roster rows (pos letter, name, rating) with highlight on cursor row
	;Code the listing does not decode: kept as bytes
	dc.b	$3A,$39,$FF,$FF,$27,$10,$2A,$7C,$FF,$FF,$27,$12,$28,$7C,$FF,$FF
	dc.b	$3A,$98,$31,$FC,$00,$10,$B0,$42,$3E,$39,$FF,$FF,$27,$16,$3F,$38
	dc.b	$B0,$42,$4E,$B9,$00,$01,$BB,$8E,$00,$06,$8F,$00,$00,$00,$31,$DF
	dc.b	$B0,$42,$42,$46,$30,$15,$E5,$40,$48,$C0,$D9,$C0,$4E,$B9,$00,$01
	dc.b	$BA,$2E,$00,$24,$FD,$02,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
	dc.b	$20,$20,$20,$20,$20,$FB,$02,$20,$20,$20,$20,$20,$20,$20,$20,$20
	dc.b	$20,$20,$20,$20,$20,$20,$31,$FC,$00,$03,$B0,$40,$4E,$B9,$00,$01
	dc.b	$BA,$2E,$00,$04,$FE,$07,$BC,$45,$66,$00,$00,$0C,$4E,$B9,$00,$01
	dc.b	$BA,$2E,$00,$04,$FE,$06,$42,$40,$10,$2C,$00,$02,$4E,$B9,$00,$01
	dc.b	$01,$7A,$4E,$B9,$00,$01,$BC,$84,$31,$FC,$00,$16,$B0,$40,$22,$7C
	dc.b	$00,$1D,$D8,$FE,$42,$40,$10,$2C,$00,$01,$33,$C0,$FF,$FF,$27,$18
	dc.b	$4E,$B9,$00,$01,$D7,$F2,$4E,$B9,$00,$01,$BC,$84,$31,$FC,$00,$1F
	dc.b	$B0,$40,$42,$40,$10,$2C,$00,$03,$4E,$B9,$00,$1D,$93,$02,$32,$3C
	dc.b	$00,$02,$4E,$B9,$00,$01,$BE,$1C,$4E,$B9,$00,$01,$BC,$84,$58,$8C
	dc.b	$52,$78,$B0,$42,$52,$46,$30,$39,$FF,$FF,$27,$12,$D0,$46,$B0,$79
	dc.b	$FF,$FF,$27,$14,$6F,$00,$FF,$46,$46,$DF,$4E,$75,$2C,$3C,$00,$00
	dc.b	$54,$60,$3C,$3C,$00,$64,$32,$38,$B0,$52,$92,$78,$B0,$54,$67,$F2
	dc.b	$31,$F8,$B0,$52,$B0,$54,$4E,$B9,$00,$01,$26,$40,$4E,$B9,$00,$01
	dc.b	$B3,$48,$4E,$B9,$00,$01,$B3,$20,$4A,$41,$67,$00,$00,$06,$60,$00
	dc.b	$00,$50,$4E,$B9,$00,$01,$B3,$60,$4E,$B9,$00,$01,$B3,$20,$4A,$41
	dc.b	$67,$00,$00,$06,$60,$00,$00,$3A,$4A,$78,$D2,$50,$67,$00,$00,$2E
	dc.b	$4E,$B9,$00,$01,$B3,$78,$4E,$B9,$00,$01,$B3,$20,$4A,$41,$67,$00
	dc.b	$00,$06,$60,$00,$00,$1C,$4E,$B9,$00,$01,$B3,$90,$4E,$B9,$00,$01
	dc.b	$B3,$20,$4A,$41,$67,$00,$00,$06,$60,$00,$00,$06,$51,$CE,$FF,$84
	dc.b	$4E,$75,$4E,$75,$42,$40,$60,$00,$00,$02,$48,$A7,$E0,$00,$61,$00
	dc.b	$F9,$58,$4C,$9F,$00,$07,$22,$7C,$00,$1E,$0A,$F6,$4E,$B9,$00,$01
	dc.b	$D7,$F2,$4E,$B9,$00,$01,$BC,$84,$61,$00,$FF,$52,$60,$D4

ReleaseMsgText	;ReleasePlayers: the message when the free agent list is full
	String	$8F,$18,$06,'Free agent list',$8F,$17,$07,'is full.',$8F,$16,$08,'Press any button',$8F,$15,$09,'to exit.'
	dc.b	$48,$E7,$FF,$FE,$4E,$B9,$00,$01,$57,$B2,$55,$40,$3A,$00,$20,$7C
	dc.b	$FF,$FF,$3A,$98,$38,$05,$42,$46,$10,$28,$00,$01,$B0,$28,$00,$05
	dc.b	$6F,$00,$00,$10,$50,$C6,$20,$10,$24,$28,$00,$04,$21,$40,$00,$04
	dc.b	$20,$82,$58,$48,$51,$CC,$FF,$E2,$4A,$46,$66,$D2,$4C,$DF,$7F,$FF
	dc.b	$4E,$75

sub_1E0B76	;Called from ReleasePlayers: vram, fonts and the screen bitmaps
	;Code the listing does not decode: kept as bytes
	dc.b	$08,$F8,$00,$05,$C3,$56,$21,$FC,$00,$01,$2D,$46,$D2,$44,$08,$B8
	dc.b	$00,$00,$BF,$B2,$08,$F8,$00,$02,$BF,$B2,$08,$B8,$00,$01,$BF,$B2
	dc.b	$31,$FC,$00,$00,$B0,$00,$31,$FC,$B8,$00,$B0,$02,$31,$FC,$B8,$00
	dc.b	$B0,$0C,$31,$FC,$00,$05,$B0,$0E,$31,$FC,$C0,$00,$B0,$08,$31,$FC
	dc.b	$00,$06,$B0,$0A,$31,$FC,$E0,$00,$B0,$04,$31,$FC,$00,$06,$B0,$06
	dc.b	$30,$3C,$00,$00,$08,$F8,$00,$05,$BF,$B2,$4E,$B9,$00,$01,$B5,$7E
	dc.b	$08,$B8,$00,$05,$BF,$B2,$4E,$B9,$00,$01,$B2,$C4,$38,$3C,$00,$01
	dc.b	$22,$7C,$00,$19,$97,$AE,$4E,$B9,$00,$01,$21,$7A,$31,$C4,$B0,$1C
	dc.b	$24,$7C,$00,$17,$91,$70,$4E,$B9,$00,$01,$B7,$30,$31,$C4,$B0,$1E
	dc.b	$24,$7C,$00,$17,$A1,$6C,$4E,$B9,$00,$01,$B7,$30,$21,$FC,$00,$17
	dc.b	$91,$68,$BF,$8A,$31,$C4,$B0,$18,$24,$7C,$00,$17,$B6,$88,$4E,$B9
	dc.b	$00,$01,$B7,$30,$08,$F8,$00,$02,$C3,$54,$4E,$B9,$00,$01,$BA,$2E
	dc.b	$00,$08,$FF,$01,$FD,$00,$FC,$00,$70,$28,$72,$1C,$34,$3C,$07,$FF
	dc.b	$4E,$B9,$00,$01,$B9,$76,$4E,$B9,$00,$01,$BB,$8E,$00,$06,$BF,$00
	dc.b	$00,$00,$20,$7C,$00,$19,$82,$60,$22,$48,$24,$48,$D1,$DA,$D3,$DA
	dc.b	$42,$40,$42,$41,$74,$28,$76,$1C,$7A,$08,$4E,$B9,$00,$01,$B6,$92
	dc.b	$4E,$B9,$00,$01,$BB,$8E,$00,$06,$BF,$0B,$01,$00,$20,$7C,$00,$19
	dc.b	$7A,$60,$22,$48,$24,$48,$D1,$DA,$D3,$DA,$42,$40,$42,$41,$34,$11
	dc.b	$36,$29,$00,$02,$7A,$08,$4E,$B9,$00,$01,$B6,$92,$4E,$B9,$00,$01
	dc.b	$BB,$8E,$00,$06,$FE,$00,$00,$00,$20,$7C,$00,$17,$3C,$7A,$22,$48
	dc.b	$24,$48,$D1,$DA,$D3,$DA,$42,$40,$42,$41,$74,$40,$76,$1C,$7A,$01
	dc.b	$4E,$B9,$00,$01,$B6,$92,$33,$C4,$FF,$FF,$23,$28,$06,$44,$00,$C8
	dc.b	$08,$F8,$00,$02,$C3,$54,$4E,$B9,$00,$01,$BE,$D6,$00,$16,$F8,$04
	dc.b	$01,$15,$0C,$70,$6F,$73,$F8,$04,$01,$1C,$0C,$6F,$76,$65,$72,$61
	dc.b	$6C,$6C,$46,$FC,$25,$00,$4E,$75,$48,$E7,$FF,$FE,$61,$00,$F7,$2C
	dc.b	$4E,$B9,$00,$01,$BC,$72,$00,$06,$8F,$18,$06,$00,$4E,$B9,$00,$01
	dc.b	$BA,$2E,$00,$48,$73,$74,$61,$72,$74,$2D,$65,$78,$69,$74,$FD,$17
	dc.b	$FA,$01,$63,$2D,$72,$65,$6C,$65,$61,$73,$65,$20,$70,$6C,$61,$79
	dc.b	$65,$72,$FD,$16,$FA,$01,$7B,$7D,$73,$65,$6C,$65,$63,$74,$20,$70
	dc.b	$6C,$61,$79,$65,$72,$FD,$15,$FA,$01,$61,$2F,$62,$2D,$73,$77,$69
	dc.b	$74,$63,$68,$20,$74,$65,$61,$6D,$73,$00,$4C,$DF,$7F,$FF,$4E,$75

sub_1E0D66	;Called from SignFreeAgents and ReleasePlayers: 8 palette longs to palfadenew+$40
	;Code the listing does not decode: kept as bytes
	dc.b	$48,$E7,$00,$C0,$20,$7C,$00,$17,$C2,$AE,$22,$7C,$FF,$FF,$BD,$7E
	dc.b	$30,$3C,$00,$07,$22,$D8,$51,$C8,$FF,$FC,$4C,$DF,$03,$00,$4E,$75

sub_1E0D86	;Called from sub_1DD086, SignFreeAgents and ReleasePlayers
	;Code the listing does not decode: kept as bytes
	dc.b	$48,$E7,$FF,$FE,$30,$39,$00,$20,$00,$00,$53,$00,$B0,$07,$66,$00
	dc.b	$00,$06,$61,$00,$00,$2C,$30,$39,$00,$20,$18,$72,$53,$00,$B0,$07
	dc.b	$66,$00,$00,$06,$61,$00,$00,$24,$4C,$DF,$7F,$FF,$4E,$75,$48,$E7
	dc.b	$FF,$FE,$61,$00,$00,$0C,$61,$00,$00,$12,$4C,$DF,$7F,$FF,$4E,$75
	dc.b	$70,$00,$72,$41,$4E,$F9,$00,$02,$42,$08,$20,$3C,$00,$00,$0C,$39
	dc.b	$72,$41,$4E,$F9,$00,$02,$42,$08

OptionsScreen	;The game options screen: play mode, rosters, period length, goalies, user records, penalties, line
	;changes, fighting and skill level (OptionsMenuList; left / right change OptionVars). Start saves them
	;(WriteOptions) and sets the play mode (SetPlayMode); transactions go to PlayoffMenuScreen. Left alone
	;(carddelay) it puts the options back to the defaults
	move.w	#$15,(word_FFD284).w
	move.w	#$1D,(word_FFD286).w
	move.w	(VDP_CNTR).l,(seed).w
	move.w	(VDP_CNTR).l,(seed+2).w
	clr.w	(word_FFB8C6).w
	clr.w	(word_FFB8C8).w
	st	(demoflag).w
	jsr	(ReadPassData).l
	movea.l	#pwddatabuffer,a3
	jsr	(ReadPassBits).l
	move.w	(gamelevel).w,d0
	or.w	(bosgames).w,d0
	beq.w	.0
	jsr	(maketree).l
.0
	jsr	(sub_1149E).l
	bclr	#1,(sflags13).w
	btst	#1,(dword_FFDD7E+2).w
	beq.w	.1
	btst	#3,(dword_FFDD7E+2).w
	bne.w	.1
	bset	#1,(sflags13).w
.1
	bsr.w	ReadOptions
	cmpi.w	#4,(OptPlayMode).w
	bne.w	.2
	btst	#1,(sflags13).w
	bne.w	.2
	tst.b	(dword_FFDD82+2).w
	bpl.w	.2
	clr.w	(OptPlayMode).w
.2
	cmpi.w	#1,(OptPlayMode).w
	bne.w	.3
	move.w	(gamelevel).w,d0
	or.w	(bosgames).w,d0
	bne.w	.3
	clr.w	(OptPlayMode).w
.3
	bclr	#1,(sflags7).w
	bsr.w	ClearGameRAM
	clr.w	(carddelay).w
	bsr.w	OptionsMenuInit
	bsr.w	OptionsScreenSetup
	movea.l	#unk_19C232,a0
	jsr	(sub_1218A).l
	jsr	(PStatsPalette).l
	move.w	#$18,(palcount).w
	bclr	#2,(disflags).w
.4
	bsr.w	OptionsMenuDraw
	move	#$2500,sr
.frame
	move.w	(vcount).w,d0
.loop2
	cmp.w	(vcount).w,d0
	beq.s	.loop2
	jsr	(sub_12640).l
	addq.w	#1,(carddelay).w
	cmpi.w	#$2A30,(carddelay).w
	bge.w	.16
	move.w	(word_FFB8C8).w,d0
	addq.w	#1,d0
	cmp.w	#8,d0
	blt.w	.5
	bsr.w	sub_1E1AD4
	addq.w	#1,(word_FFB8C6).w
	andi.w	#7,(word_FFB8C6).w
	clr.w	d0
.5
	move.w	d0,(word_FFB8C8).w
	jsr	(sub_1B282).l
	jsr	(ProcessInputWithRepeat).l
	tst.w	d1
	beq.w	.6
	clr.w	(carddelay).w
.6
	move.b	d1,(byte_FFDCA6).w
	btst	#7,d1
	bne.w	.17
	btst	#1,d1
	beq.w	.up
	cmpi.w	#8,(menuitem).w
	beq.s	.frame
	cmpi.w	#7,(OptPlayMode).w
	beq.s	.frame
	cmpi.w	#4,(OptPlayMode).w
	beq.w	.frame
	cmpi.w	#5,(OptPlayMode).w
	beq.w	.frame
.7
	addq.w	#1,(menuitem).w
	cmpi.w	#1,(menuitem).w
	bne.w	.8
	cmpi.w	#1,(OptPlayMode).w
	beq.s	.7
	cmpi.w	#2,(OptPlayMode).w
	beq.s	.7
	cmpi.w	#3,(OptPlayMode).w
	beq.s	.7
	cmpi.w	#7,(menuitem).w
	bne.w	*+4
.8
	cmpi.w	#6,(OptPlayMode).w
	bne.w	.4
	cmpi.w	#3,(menuitem).w
	bne.w	.9
	addq.w	#5,(menuitem).w
	bra.w	.4
.9
	cmpi.w	#2,(menuitem).w
	bne.w	.10
	addq.w	#1,(menuitem).w
.10
	cmpi.w	#4,(menuitem).w
	bne.w	.4
	addq.w	#4,(menuitem).w
	bra.w	.4
.up
	btst	#0,d1	;ubut
	beq.w	.14
	tst.w	(menuitem).w
	beq.w	.frame
	subq.w	#1,(menuitem).w
	cmpi.w	#1,(menuitem).w
	bne.w	.12
	cmpi.w	#1,(OptPlayMode).w
	beq.w	.11
	cmpi.w	#2,(OptPlayMode).w
	beq.w	.11
	cmpi.w	#3,(OptPlayMode).w
	bne.w	.12
.11
	clr.w	(menuitem).w
.12
	cmpi.w	#7,(menuitem).w
	bne.w	*+4
.13
	cmpi.w	#6,(OptPlayMode).w
	bne.w	.4
.37
	cmpi.w	#3,(menuitem).w
	bne.w	.prev
	bra.w	.4
.prev
	cmpi.w	#1,(menuitem).w
	beq.w	.4
	tst.w	(menuitem).w
	beq.w	.4
	subq.w	#1,(menuitem).w
	bra.s	.37
.14
	btst	#2,d1
	beq.w	.15
	movea.l	#OptionVars,a0
	move.w	(menuitem).w,d0
	asl.w	#2,d0
	movea.l	(a0,d0.w),a0
	subq.w	#1,(a0)
	bra.w	.4
.15
	btst	#3,d1
	beq.w	.frame
	movea.l	#OptionVars,a0
	move.w	(menuitem).w,d0
	asl.w	#2,d0
	movea.l	(a0,d0.w),a0
	addq.w	#1,(a0)
	bra.w	.4
.16
	clr.w	(demoflag).w
	clr.w	(OptPlayMode).w
	clr.w	(OptRosters).w
	clr.w	(OptPerlen).w
	move.w	#1,(OptGoalie).w
	clr.w	(OptUserRec).w
	move.w	#2,(OptPen).w
	clr.w	(OptLine).w
	move.w	#1,(OptFighting).w
	move.w	#1,(OptSkill).w
	bra.w	.18
.17
	move.w	#4,(OptNOP).w
	bsr.w	WriteOptions
	cmpi.w	#7,(OptPlayMode).w
	bne.w	.18
	jsr	(PlayoffMenuScreen).l
	bra.w	OptionsScreen
.18
	bsr.w	SetPlayMode
	btst	#7,(GameFlags).w
	beq.w	.19
	jsr	(sub_1149E).l
	btst	#2,(dword_FFDD7E+2).w
	beq.w	.19
	jsr	(ReadPassData).l
	jsr	(ReadPassBits).l
	tst.w	(WinBits).w
	bne.w	.19
	tst.w	(bosgames).w
	bne.w	.19
	jmp	NewPO
.19
	jsr	(maketree).l
	rts

OptionVars	;OptionsScreen: the option of each menu row
	dc.l	OptPlayMode,OptRosters,OptPerlen,OptGoalie,OptUserRec
	dc.l	OptPen,OptLine,OptFighting,OptSkill

OptionsMenuDraw	;OptionsScreen: draw the menu (PrintMenuList2)
	movem.l	d0-d7/a0-a6,-(sp)
	jsr	(PrintMenuList2).l
	movem.l	(sp)+,d0-d7/a0-a6
	rts

OptionsScreenSetup	;OptionsScreen: vram, fonts, the screen bitmaps and the row labels
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
	movea.l	#unk_19C232,a1
	jsr	(sub_1217A).l
	move.w	d4,(smallfontchars).w
	movea.l	#RosterFont+8,a2
	jsr	(DecompressGraphicsPlain).l
	move.w	d4,(word_FFB01E).w
	movea.l	#SmallFontMap2+8,a2
	jsr	(DecompressGraphicsPlain).l
	move.l	#RosterFont,(smallfontptr).w
	move.w	d4,(word_FFB8C4).w
	movea.l	#unk_1C4C4E+8,a2
	jsr	(DecompressGraphicsPlain).l
	jsr	(printsmallz).l
	String	$FF,$01,$FD,$00,$FC
	moveq	#$28,d0
	moveq	#$1C,d1
	move.w	#$7FF,d2
	jsr	(eraser).l
	jsr	(printz).l
	String	$BF,$00,$00
	movea.l	#unk_19A3E4,a0
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
	movea.l	#unk_199BE4,a0
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
	jsr	(printcurz).l
	String	<$8F,$03,$09>,'Play mode:',<$8F,$03,$0B>,'rosters:',<$8F,$03,$0D>,'period length:',<$8F,$03,$0F>,'goalies:',<$8F,$03,$11>,'user records:',<$8F,$03,$13>,'penalties:',<$8F,$03,$15>,'line changes:',<$8F,$03,$17>,'fighting:',<$8F,$03,$19>,'skill level:'
	move	#$2500,sr
	rts

ClearGameRAM	;Clear the shootout words, both team structs, PenBuf and the game flags
	movem.l	d0-d7/a0-a6,-(sp)
	movea.l	#$FFFFD432,a0
	moveq	#$12,d0
.shoot
	clr.w	(a0)+
	dbf	d0,.shoot
	movea.l	#tmstruct,a0
	move.w	#$39D,d0
.loop
	clr.w	(a0)+
	dbf	d0,.loop
	movea.l	#PenBuf,a0
	moveq	#$4E,d0
.4
	clr.w	(a0)+
	dbf	d0,.4
	clr.w	(BA_PS_flags).w
	clr.w	(sflags4).w
	clr.w	(sflags6).w
	clr.w	(gmode2).w
	clr.w	(word_FFD300).w
	clr.w	(word_FFD310).w
	movem.l	(sp)+,d0-d7/a0-a6
	rts

OptionsMenuInit	;OptionsScreen: menulist = OptionsMenuList, item 0
	move.l	#OptionsMenuList,(menulist).l
	clr.w	(menuitem).w
	clr.w	(word_FFD000).w
	move.w	#9,(word_FFD00A).w
	move.w	#$13,(word_FFB03C).w
	move.w	#9,(word_FFB03E).w
	rts

OptionsMenuList	;The options menu: each item routine keeps its option in range and returns its text in a1
	String	$FE,$07,$F9
	String	$FE,$05,$F9
	dc.l	PlayModeItem,RostersItem,PerLenItem,GoalieItem,UserRecItem
	dc.l	PenaltyItem,LineItem,FightingItem,SkillItem,-1

SkillItem	;Options menu row: skill level
	;Code the listing does not decode: kept as bytes
	dc.b	$0C,$78,$00,$04,$D2,$54,$67,$00,$01,$B2,$0C,$78,$00,$05,$D2,$54
	dc.b	$67,$00,$01,$A8,$0C,$78,$00,$07,$D2,$54,$6C,$00,$01,$9E,$30,$38
	dc.b	$D2,$68,$B0,$7C,$00,$02,$6F,$00,$00,$04,$42,$40,$4A,$40,$6A,$00
	dc.b	$00,$06,$30,$3C,$00,$02,$31,$C0,$D2,$68,$22,$7C,$00,$1E,$18,$38
	dc.b	$4E,$B9,$00,$01,$D7,$F2,$4E,$75

FightingItem	;Options menu row: fighting
	;Code the listing does not decode: kept as bytes
	dc.b	$0C,$78,$00,$04,$D2,$54,$67,$00,$01,$6A,$0C,$78,$00,$05,$D2,$54
	dc.b	$67,$00,$01,$60,$0C,$78,$00,$06,$D2,$54,$6C,$00,$01,$56,$30,$38
	dc.b	$D2,$66,$B0,$7C,$00,$01,$6F,$00,$00,$04,$42,$40,$4A,$40,$6A,$00
	dc.b	$00,$06,$30,$3C,$00,$01,$31,$C0,$D2,$66,$22,$7C,$00,$1E,$18,$10
	dc.b	$4E,$B9,$00,$01,$D7,$F2,$4E,$75

LineItem	;Options menu row: line changes
	;Code the listing does not decode: kept as bytes
	dc.b	$0C,$78,$00,$04,$D2,$54,$67,$00,$01,$22,$0C,$78,$00,$05,$D2,$54
	dc.b	$67,$00,$01,$18,$0C,$78,$00,$06,$D2,$54,$6C,$00,$01,$0E,$30,$38
	dc.b	$D2,$64,$B0,$7C,$00,$02,$6F,$00,$00,$04,$42,$40,$4A,$40,$6A,$00
	dc.b	$00,$06,$30,$3C,$00,$02,$31,$C0,$D2,$64,$22,$7C,$00,$1E,$17,$D4
	dc.b	$4E,$B9,$00,$01,$D7,$F2,$4E,$75

PenaltyItem	;Options menu row: penalties
	;Code the listing does not decode: kept as bytes
	dc.b	$0C,$78,$00,$04,$D2,$54,$67,$00,$00,$DA,$0C,$78,$00,$05,$D2,$54
	dc.b	$67,$00,$00,$D0,$0C,$78,$00,$06,$D2,$54,$6C,$00,$00,$C6,$30,$38
	dc.b	$D2,$62,$B0,$7C,$00,$02,$6F,$00,$00,$04,$42,$40,$4A,$40,$6A,$00
	dc.b	$00,$06,$30,$3C,$00,$02,$31,$C0,$D2,$62,$22,$7C,$00,$1E,$17,$98
	dc.b	$4E,$B9,$00,$01,$D7,$F2,$4E,$75

UserRecItem	;Options menu row: user records
	;Code the listing does not decode: kept as bytes
	dc.b	$0C,$78,$00,$04,$D2,$54,$67,$00,$00,$92,$0C,$78,$00,$05,$D2,$54
	dc.b	$67,$00,$00,$88,$0C,$78,$00,$06,$D2,$54,$6C,$00,$00,$7E,$30,$38
	dc.b	$D2,$60,$B0,$7C,$00,$01,$6F,$00,$00,$04,$42,$40,$4A,$40,$6A,$00
	dc.b	$00,$06,$30,$3C,$00,$01,$31,$C0,$D2,$60,$22,$7C,$00,$1E,$17,$70
	dc.b	$4E,$B9,$00,$01,$D7,$F2,$4E,$75

GoalieItem	;Options menu row: goalies
	;Code the listing does not decode: kept as bytes
	dc.b	$0C,$78,$00,$04,$D2,$54,$67,$00,$00,$4A,$0C,$78,$00,$05,$D2,$54
	dc.b	$67,$00,$00,$40,$0C,$78,$00,$07,$D2,$54,$67,$00,$00,$36,$30,$38
	dc.b	$D2,$5E,$B0,$7C,$00,$01,$6F,$00,$00,$04,$42,$40,$4A,$40,$6A,$00
	dc.b	$00,$06,$30,$3C,$00,$01,$31,$C0,$D2,$5E,$22,$7C,$00,$1E,$17,$48
	dc.b	$4E,$B9,$00,$01,$D7,$F2,$4E,$75

PerLenItem	;Options menu row: period length
	;Code the listing does not decode: kept as bytes
	dc.b	$0C,$78,$00,$06,$D2,$54,$6D,$00,$00,$0A,$22,$7C,$00,$1E,$16,$CC
	dc.b	$4E,$75,$0C,$78,$00,$04,$D2,$54,$67,$F0,$0C,$78,$00,$05,$D2,$54
	dc.b	$67,$E8,$0C,$78,$00,$04,$D2,$54,$67,$E0,$30,$38,$D2,$5C,$B0,$7C
	dc.b	$00,$03,$6D,$00,$00,$04,$42,$40,$4A,$40,$6A,$00,$00,$06,$30,$3C
	dc.b	$00,$02,$31,$C0,$D2,$5C,$22,$7C,$00,$1E,$17,$0C,$4E,$B9,$00,$01
	dc.b	$D7,$F2,$4E,$75

RostersItem	;Options menu row: rosters
	;Code the listing does not decode: kept as bytes
	dc.b	$0C,$78,$00,$07,$D2,$54,$67,$AE,$0C,$78,$00,$05,$D2,$54,$67,$A6
	dc.b	$0C,$78,$00,$04,$D2,$54,$67,$9E,$0C,$78,$00,$01,$D2,$54,$67,$96
	dc.b	$0C,$78,$00,$02,$D2,$54,$67,$8E,$0C,$78,$00,$03,$D2,$54,$67,$86
	dc.b	$30,$38,$D2,$6A,$B0,$7C,$00,$01,$6F,$00,$00,$04,$42,$40,$4A,$40
	dc.b	$6A,$00,$00,$06,$30,$3C,$00,$01,$31,$C0,$D2,$6A,$22,$7C,$00,$1E
	dc.b	$16,$E4,$4E,$B9,$00,$01,$D7,$F2,$4E,$75

PlayModeItem	;Options menu row: play mode
	;Code the listing does not decode: kept as bytes
	dc.b	$30,$38,$D2,$54,$6A,$00,$00,$06,$30,$3C,$00,$07,$B0,$7C,$00,$07
	dc.b	$6F,$00,$00,$04,$42,$40,$B0,$7C,$00,$07,$66,$00,$00,$24,$08,$38
	dc.b	$00,$02,$DD,$80,$67,$00,$00,$1A,$08,$38,$00,$02,$DC,$A6,$67,$00
	dc.b	$00,$0A,$31,$FC,$00,$06,$D2,$54,$60,$C6,$42,$78,$D2,$54,$60,$C0
	dc.b	$B0,$7C,$00,$01,$66,$00,$00,$20,$32,$38,$CF,$CA,$82,$78,$CF,$C8
	dc.b	$66,$00,$00,$14,$30,$3C,$00,$02,$08,$38,$00,$02,$DC,$A6,$67,$00
	dc.b	$00,$06,$30,$3C,$00,$00,$B0,$7C,$00,$04,$66,$00,$00,$26,$08,$38
	dc.b	$00,$01,$C3,$58,$66,$00,$00,$0A,$4A,$38,$DD,$84,$6A,$00,$00,$14
	dc.b	$30,$3C,$00,$05,$08,$38,$00,$02,$DC,$A6,$67,$00,$00,$06,$30,$3C
	dc.b	$00,$03,$31,$C0,$D2,$54,$22,$7C,$00,$1E,$18,$74,$4E,$B9,$00,$01
	dc.b	$D7,$F2,$4E,$75

NotApplicableText	;Options menu: an option the play mode does not use
	String	$FE,$03,'not applicable    ',$FE,$07

RostersText	;Options menu: rosters
	String	'with trades       '
	String	'Regular           '

PerLenText	;Options menu: period length
	String	'5 minutes         '
	String	'10 minutes        '
	String	'20 minutes        '

GoalieText	;Options menu: goalies
	String	'Manual Control    '
	String	'Auto control      '

UserRecText	;Options menu: user records
	String	'off               '
	String	'on                '

PenaltyText	;Options menu: penalties
	String	'off               '
	String	'on, no offsides   '
	String	'on                '

LineText	;Options menu: line changes
	String	'off               '
	String	'auto              '
	String	'on                '

FightingText	;Options menu: fighting
	String	'on                '
	String	'off               '

SkillText	;Options menu: skill level
	String	'pro               '
	String	'all-star          '
	String	'rookie            '

PlayModeText	;Options menu: play mode
	String	'regular game      '
	String	'continue playoffs '
	String	'new playoffs      '
	String	'new poffs best/7  '
	String	'continue season   '
	String	'new season        '
	String	'shootout          '
	String	'transactions      '

ReadOptions	;Read the $18 option bytes from save RAM $1EC6 to OptPlayMode
	movem.l	d0-d7/a0-a6,-(sp)
	movea.l	#OptPlayMode,a0
	move.l	#$1EC6,d0
	moveq	#$18,d1
	jsr	(ReadSRAM).l
	movem.l	(sp)+,d0-d7/a0-a6
	rts

WriteOptions	;Write the option bytes to save RAM $1EC6 and update the checksum
	movem.l	d0-d7/a0-a6,-(sp)
	movea.l	#OptPlayMode,a0
	move.l	#$1EC6,d0
	moveq	#$18,d1
	jsr	(WriteSRAM).l
	jsr	(MakeSRAMChecksum).l
	movem.l	(sp)+,d0-d7/a0-a6
	rts

SetPlayMode	;Set the game flags for the chosen play mode: season (continue or new), shootout, or else a game or the
	;playoffs
	movem.l	d0-d7/a0-a6,-(sp)
	bclr	#7,(GameFlags).w
	bclr	#6,(sflags10).w
	cmpi.w	#7,(OptPlayMode).w
	beq.w	.0
	cmpi.w	#4,(OptPlayMode).w
	beq.w	.0
	cmpi.w	#1,(OptPlayMode).w
	beq.w	.0
	cmpi.w	#2,(OptPlayMode).w
	beq.w	.0
	cmpi.w	#3,(OptPlayMode).w
	beq.w	.0
	cmpi.w	#5,(OptPlayMode).w
	bne.w	.1
.0
	clr.w	(OptRosters).w
.1
	bclr	#4,(sflags11).w
	tst.w	(OptRosters).w
	beq.w	.fix
	bset	#4,(sflags11).w
.fix
	bsr.w	sub_1E1A5E
	bsr.w	sub_1E1A3C
	cmpi.w	#4,(OptPlayMode).w
	bne.w	.3
	clr.w	(OptPlayMode).w
	bset	#7,(GameFlags).w
	bra.w	.5
.3
	cmpi.w	#5,(OptPlayMode).w
	bne.w	.2
	clr.w	(OptPlayMode).w
	bset	#7,(GameFlags).w
	bset	#6,(sflags10).w
	bra.w	.5
.2
	cmpi.w	#6,(OptPlayMode).w
	bne.w	.4
	move.w	#0,(OptPlayMode).w
	move.w	#1,(OptUserRec).w
	move.w	#1,(OptLine).w
	clr.w	(OptPen).w
	bset	#0,(gmode2).w
	jsr	(ClearShootout).l
	bra.w	.5
.4
	bsr.w	sub_1E1A66
	bsr.w	sub_1E1A8E
	jsr	(sub_1E1AA8).l
.5
	movem.l	(sp)+,d0-d7/a0-a6
	rts
