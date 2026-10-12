;	Pads, faceoffs and the controller setup screen. The save RAM bit field routines (WriteSRAMBits,
;	ReadSRAMBits); the faceoff routines (faceoffinput, the faceoff assignments, DrawFaceoffWindow, limitfo,
;	Endfaceoff); the pad input of a player (updatepadinput, doinput and its goalie and skater parts);
;	the controller setup screen (SetContTeams, ControllerSetupScreen) and the 4 way play adaptor check.
;	Code the listing does not decode stays as bytes, with its labels where they are known.

WriteSRAMBits	;Write the d2-bit value d0 to the save RAM at bit d1 (bit 0 is the top bit of the
	;first odd byte at SaveRAM), then sub_241AA unless GameFlags bit 6 is set
	movem.l	d0-d6/a0,-(sp)
	movea.l	#SaveRAM,a0
	move.w	d1,d3
	lsr.w	#3,d3
	add.w	d3,d3
	move.w	d1,d4
	andi.w	#7,d4
	adda.w	d3,a0
	moveq	#-1,d5
	move.w	#$20,d6
	sub.w	d2,d6
	lsl.l	d6,d5
	lsr.l	d4,d5
	not.l	d5
	lsl.l	d6,d0
	lsr.l	d4,d0
	move.b	1(a0),d6
	lsl.w	#8,d6
	move.b	3(a0),d6
	swap	d6
	move.b	5(a0),d6
	lsl.w	#8,d6
	move.b	7(a0),d6
	and.l	d5,d6
	or.l	d0,d6
	move.b	d6,7(a0)
	lsr.w	#8,d6
	move.b	d6,5(a0)
	swap	d6
	move.b	d6,3(a0)
	lsr.w	#8,d6
	move.b	d6,1(a0)
	btst	#6,(GameFlags).l
	bne.w	.0
	jsr	(sub_241AA).l
.0
	movem.l	(sp)+,d0-d6/a0
	rts

ReadSRAMBits	;d0 = the d2-bit value at bit d1 of the save RAM (see WriteSRAMBits)
	movem.l	d1-d6/a0,-(sp)
	movea.l	#SaveRAM,a0
	move.w	d1,d3
	lsr.w	#3,d3
	add.w	d3,d3
	move.w	d1,d4
	andi.w	#7,d4
	adda.w	d3,a0
	moveq	#-1,d5
	move.w	#$20,d6
	sub.w	d2,d6
	lsl.l	d6,d5
	lsr.l	d4,d5
	move.b	1(a0),d0
	lsl.w	#8,d0
	move.b	3(a0),d0
	swap	d0
	move.b	5(a0),d0
	lsl.w	#8,d0
	move.b	7(a0),d0
	and.l	d5,d0
	lsl.l	d4,d0
	lsr.l	d6,d0
	movem.l	(sp)+,d1-d6/a0
	rts
	;Not decoded in the listing and not referenced from it: kept as bytes
	dc.b	$48,$E7,$BB,$6E,$3E,$03,$48,$C5,$60,$00,$00,$5A,$28,$7C,$00,$20
	dc.b	$00,$00,$36,$01,$E6,$4B,$D6,$43,$38,$01,$02,$44,$00,$07,$D8,$C3
	dc.b	$76,$FF,$3C,$3C,$00,$20,$9C,$42,$ED,$AB,$E8,$AB,$10,$2C,$00,$01
	dc.b	$E1,$48,$10,$2C,$00,$03,$48,$40,$10,$2C,$00,$05,$E1,$48,$10,$2C
	dc.b	$00,$07,$C0,$83,$E9,$A8,$EC,$A8,$BE,$79,$FF,$FF,$DD,$C0,$6C,$00
	dc.b	$00,$04,$42,$40,$4A,$40,$67,$00,$00,$08,$36,$C5,$52,$52,$30,$C0
	dc.b	$52,$85,$D2,$82,$51,$CF,$FF,$A6,$4C,$DF,$76,$DD,$4E,$75,$48,$E7
	dc.b	$BB,$6E,$3E,$03,$48,$C5,$60,$00,$00,$CA,$28,$7C,$00,$20,$00,$00
	dc.b	$36,$01,$E6,$4B,$D6,$43,$38,$01,$02,$44,$00,$07,$D8,$C3,$76,$FF
	dc.b	$3C,$3C,$00,$20,$9C,$42,$ED,$AB,$E8,$AB,$10,$2C,$00,$01,$E1,$48
	dc.b	$10,$2C,$00,$03,$48,$40,$10,$2C,$00,$05,$E1,$48,$10,$2C,$00,$07
	dc.b	$C0,$83,$E9,$A8,$EC,$A8,$BE,$79,$FF,$FF,$DD,$C0,$6C,$00,$00,$04
	dc.b	$42,$40,$48,$E7,$C0,$00,$08,$39,$00,$02,$FF,$FF,$DD,$80,$67,$00
	dc.b	$00,$0C,$06,$81,$00,$00,$0F,$00,$60,$00,$00,$08,$06,$81,$00,$00
	dc.b	$1D,$40,$28,$7C,$00,$20,$00,$00,$36,$01,$E6,$4B,$D6,$43,$38,$01
	dc.b	$02,$44,$00,$07,$D8,$C3,$76,$FF,$3C,$3C,$00,$20,$9C,$42,$ED,$AB
	dc.b	$E8,$AB,$10,$2C,$00,$01,$E1,$48,$10,$2C,$00,$03,$48,$40,$10,$2C
	dc.b	$00,$05,$E1,$48,$10,$2C,$00,$07,$C0,$83,$E9,$A8,$EC,$A8,$2C,$00
	dc.b	$BE,$79,$FF,$FF,$DD,$C0,$6C,$00,$00,$04,$42,$40,$4C,$DF,$00,$03
	dc.b	$D0,$46,$4A,$40,$67,$00,$00,$08,$36,$C5,$52,$52,$30,$C0,$52,$85
	dc.b	$D2,$82,$51,$CF,$FF,$36,$4C,$DF,$76,$DD,$4E,$75,$48,$E7,$B3,$6E
	dc.b	$3E,$03,$48,$C5,$2F,$04,$2F,$06,$60,$00,$00,$C2,$74,$0E,$28,$7C
	dc.b	$00,$20,$00,$00,$36,$01,$E6,$4B,$D6,$43,$38,$01,$02,$44,$00,$07
	dc.b	$D8,$C3,$76,$FF,$3C,$3C,$00,$20,$9C,$42,$ED,$AB,$E8,$AB,$10,$2C
	dc.b	$00,$01,$E1,$48,$10,$2C,$00,$03,$48,$40,$10,$2C,$00,$05,$E1,$48
	dc.b	$10,$2C,$00,$07,$C0,$83,$E9,$A8,$EC,$A8,$24,$17,$26,$2F,$00,$04
	dc.b	$48,$E7,$C0,$00,$22,$03,$28,$7C,$00,$20,$00,$00,$36,$01,$E6,$4B
	dc.b	$D6,$43,$38,$01,$02,$44,$00,$07,$D8,$C3,$76,$FF,$3C,$3C,$00,$20
	dc.b	$9C,$42,$ED,$AB,$E8,$AB,$10,$2C,$00,$01,$E1,$48,$10,$2C,$00,$03
	dc.b	$48,$40,$10,$2C,$00,$05,$E1,$48,$10,$2C,$00,$07,$C0,$83,$E9,$A8
	dc.b	$EC,$A8,$2C,$00,$4C,$DF,$00,$03,$4A,$46,$67,$00,$00,$22,$CC,$FC
	dc.b	$00,$0A,$8C,$FC,$00,$3C,$69,$00,$00,$16,$BC,$7C,$00,$0A,$6D,$00
	dc.b	$00,$0E,$C0,$FC,$03,$E8,$80,$C6,$36,$C5,$52,$52,$30,$C0,$52,$85
	dc.b	$06,$81,$00,$00,$00,$0E,$26,$17,$D7,$AF,$00,$04,$51,$CF,$FF,$3E
	dc.b	$58,$4F,$28,$1F,$4C,$DF,$76,$CD,$4E,$75

faceoffinput	;The faceoff player (assignment $17): store the dpad pull (fodir1 / fodir2) and start the faceoff
	;SPA (SPA2126 with B, else SPA2150)
	btst	#6,(sflags5).w
	beq.w	.1
	rts
.1
	move.w	assnum(a3),d4
	cmpi.b	#$17,asslist(a3,d4.w)
	bne.w	rtss7
	movea.w	#(fodir1-M68K_RAM),a0	;faceoff direction of puck control variable
	btst	#7,pflags(a3)
	beq.w	.2	;branch if bottom goal
	movea.w	#(fodir2-M68K_RAM),a0
.2
	move.w	d0,(a0)
	btst	#1,pflags2(a3)
	bne.w	rtss7
	btst	#4,d1	;test for b button press
	beq.w	.3
	move.w	#SPA2126,d1
	bset	#1,pflags2(a3)	;set anim in progress
	jmp	SetSPA
.3
	move.w	#SPA2150,d1
	jmp	SetSPA

assfaceoff	;Assignment: wait for the faceoff to end (sflags2 bit 0), then assexit. Not decoded in the
	;listing: kept as bytes, as the faceoff routines up to puckfaceoff2
	dc.b	$08,$2B,$00,$05,$00,$62,$66,$00,$00,$0C,$08,$38,$00,$00,$C3,$3C
	dc.b	$67,$00,$00,$04,$4E,$75,$4E,$F9,$00,$01,$A3,$BE

assfaceoffpl	;Assignment: the faceoff player
	dc.b	$08,$2B,$00,$05,$00,$62,$66,$00,$00,$8C,$08,$38,$00,$00,$C3,$3C
	dc.b	$67,$00,$00,$78,$08,$AB,$00,$01,$00,$62,$67,$00,$00,$06,$42,$6B
	dc.b	$00,$40,$20,$7C,$FF,$FF,$BD,$BE,$08,$2B,$00,$06,$00,$62,$67,$00
	dc.b	$00,$04,$58,$48,$30,$2B,$00,$5A,$E4,$48,$52,$40,$08,$2B,$00,$00
	dc.b	$00,$77,$66,$00,$00,$04,$56,$40,$30,$80,$08,$2B,$00,$03,$00,$62
	dc.b	$66,$00,$00,$42,$08,$EB,$00,$01,$00,$63,$66,$00,$00,$38,$32,$3C
	dc.b	$21,$26,$0C,$78,$00,$12,$B7,$9E,$63,$00,$00,$14,$70,$08,$4E,$B9
	dc.b	$00,$01,$B0,$A6,$4A,$40,$67,$00,$00,$06,$32,$3C,$21,$50,$08,$EB
	dc.b	$00,$01,$00,$63,$4E,$F9,$00,$01,$A6,$14,$17,$7C,$00,$14,$00,$5E
	dc.b	$60,$00,$FF,$68,$4E,$75

puckfaceoff	;Puck assignment: the faceoff set up
	dc.b	$50,$F8,$D2,$38,$50,$F8,$D2,$3A,$50,$F8,$D2,$3C,$08,$B8,$00,$04
	dc.b	$C3,$4C,$08,$38,$00,$00,$C3,$48,$67,$00,$00,$14,$42,$78,$B7,$86
	dc.b	$42,$78,$B7,$88,$30,$3C,$00,$1E,$4E,$F9,$00,$01,$A3,$DA,$08,$AB
	dc.b	$00,$01,$00,$62,$67,$00,$02,$9A,$08,$B8,$00,$00,$C3,$4C,$67,$00
	dc.b	$00,$0A,$42,$78,$BF,$E2,$42,$78,$BF,$E4,$08,$B8,$00,$07,$C3,$4A
	dc.b	$42,$B8,$BE,$AE,$42,$B8,$BE,$B2,$42,$B8,$BE,$B6,$08,$B8,$00,$06
	dc.b	$C3,$4A,$08,$B8,$00,$02,$C3,$4A,$08,$F8,$00,$02,$C3,$56,$4E,$B9
	dc.b	$00,$1D,$90,$E2,$4A,$78,$D4,$7E,$6B,$00,$00,$0A,$30,$38,$D4,$7E
	dc.b	$60,$00,$00,$0E,$4E,$B9,$00,$1D,$90,$94,$4A,$40,$6B,$00,$00,$08
	dc.b	$4E,$B9,$00,$1D,$8A,$B4,$08,$B8,$00,$01,$C3,$46,$08,$B8,$00,$01
	dc.b	$C3,$48,$4A,$78,$C4,$BE,$67,$00,$02,$C8,$08,$38,$00,$06,$C3,$38
	dc.b	$66,$00,$02,$BE,$0C,$78,$00,$03,$C4,$BC,$66,$00,$00,$14,$30,$38
	dc.b	$C7,$32,$B0,$78,$CA,$D0,$67,$00,$00,$08,$4E,$F9,$00,$01,$4B,$DC
	dc.b	$08,$38,$00,$03,$C3,$38,$66,$00,$02,$9E,$30,$38,$C4,$C2,$E2,$40
	dc.b	$B0,$78,$C4,$BE,$63,$00,$00,$42,$0C,$78,$00,$3C,$C4,$BE,$6D,$00
	dc.b	$00,$38,$08,$B8,$00,$07,$C3,$3E,$67,$00,$00,$2E,$08,$38,$00,$00
	dc.b	$C3,$38,$67,$00,$00,$24,$08,$38,$00,$06,$C3,$4C,$66,$00,$00,$1A
	dc.b	$31,$F8,$C3,$A0,$D4,$8C,$31,$FC,$00,$02,$D4,$8E,$4E,$B9,$00,$08
	dc.b	$86,$88,$08,$F8,$00,$04,$C3,$4C,$4E,$B9,$00,$01,$97,$EA,$50,$EB
	dc.b	$00,$40,$50,$EB,$00,$42,$4A,$78,$D2,$64,$66,$00,$01,$94,$08,$B8
	dc.b	$00,$01,$C7,$56,$08,$B8,$00,$01,$CA,$F4,$30,$7C,$B0,$5E,$70,$0B
	dc.b	$08,$A8,$00,$03,$00,$63,$D0,$FC,$00,$80,$51,$C8,$FF,$F4,$30,$38
	dc.b	$C3,$90,$80,$78,$C3,$92,$67,$00,$00,$3A,$08,$38,$00,$07,$C3,$3A
	dc.b	$67,$00,$00,$30,$4E,$B9,$00,$01,$AF,$52,$08,$F8,$00,$06,$C3,$3A
	dc.b	$4E,$B9,$00,$01,$D0,$1E,$31,$FC,$00,$18,$BD,$3C,$4A,$78,$D2,$64
	dc.b	$66,$00,$00,$10,$08,$38,$00,$04,$C3,$4A,$67,$00,$00,$06,$42,$78
	dc.b	$BD,$3C,$30,$38,$C3,$84,$6B,$00,$00,$0A,$B0,$7C,$00,$06,$6D,$00
	dc.b	$00,$2E,$30,$38,$C3,$86,$6B,$00,$00,$0A,$B0,$7C,$00,$06,$6D,$00
	dc.b	$00,$1E,$30,$38,$C3,$88,$6B,$00,$00,$0A,$B0,$7C,$00,$06,$6D,$00
	dc.b	$00,$0E,$30,$38,$C3,$8A,$B0,$7C,$00,$06,$6C,$00,$00,$0C,$4A,$40
	dc.b	$6B,$00,$00,$06,$61,$00,$00,$9C,$30,$38,$C3,$84,$B0,$7C,$00,$06
	dc.b	$6C,$00,$00,$26,$30,$38,$C3,$86,$B0,$7C,$00,$06,$6C,$00,$00,$1A
	dc.b	$30,$38,$C3,$88,$B0,$7C,$00,$06,$6C,$00,$00,$0E,$30,$38,$C3,$8A
	dc.b	$B0,$7C,$00,$06,$6D,$00,$00,$0C,$4A,$40,$6B,$00,$00,$06,$61,$00
	dc.b	$00,$62,$32,$7C,$C7,$26,$45,$E9,$03,$9E,$70,$02,$4E,$B9,$00,$00
	dc.b	$9D,$0C,$60,$00,$00,$9C

SetFaceoffComputerLine	;Line changes on and team d0 not on a pad: CompLine, SetPersonel
	dc.b	$4A,$78,$D2,$64,$66,$00,$00,$44,$08,$38,$00,$04,$C3,$4A,$66,$00
	dc.b	$00,$22,$B0,$78,$C3,$90,$67,$00,$00,$32,$B0,$78,$C3,$92,$67,$00
	dc.b	$00,$2A,$B0,$78,$C3,$94,$67,$00,$00,$22,$B0,$78,$C3,$96,$67,$00
	dc.b	$00,$1A,$4E,$B9,$00,$01,$98,$68,$4E,$B9,$00,$01,$FB,$52,$4E,$B9
	dc.b	$00,$01,$D0,$62,$31,$FC,$27,$10,$C3,$68,$4E,$75

StartFaceoffLineChange	;Player d0 (sort object) opens the line change box
	dc.b	$C5,$4B,$EF,$40,$36,$7C,$B0,$5E,$D6,$C0,$08,$AB,$00,$03,$00,$63
	dc.b	$2F,$0A,$4E,$B9,$00,$00,$EC,$30,$24,$5F,$08,$2B,$00,$03,$00,$63
	dc.b	$67,$00,$00,$28,$08,$2B,$00,$06,$00,$62,$67,$00,$00,$12,$35,$7C
	dc.b	$01,$68,$00,$42,$35,$6B,$00,$52,$00,$46,$60,$00,$00,$0E,$35,$7C
	dc.b	$02,$58,$00,$40,$35,$6B,$00,$52,$00,$44,$C5,$4B

rtsfaceoff	;The shared rts of the faceoff routines
	dc.b	$4E,$75

WaitForFaceoffLineChanges	;Run both line change timers; when both are done set the home computer line
	dc.b	$30,$3C,$00,$40,$4E,$B9,$00,$00,$9D,$E6,$30,$3C,$00,$42,$4E,$B9
	dc.b	$00,$00,$9D,$E6,$4A,$6B,$00,$40,$6A,$96,$4A,$6B,$00,$42,$6A,$90
	dc.b	$34,$7C,$C7,$26,$43,$EA,$03,$9E,$70,$01,$4E,$B9,$00,$00,$9D,$0C
	dc.b	$31,$FC,$FF,$FF,$D4,$88,$30,$3C,$00,$1C,$4E,$F9,$00,$01,$A3,$DA

UpdateFaceoffLineChangeTimer	;Line change timer d0 (temp1 / temp2 of the puck)
	dc.b	$4A,$73,$00,$00,$6B,$00,$FF,$6A,$32,$33,$00,$04,$EF,$41,$30,$7C
	dc.b	$B0,$5E,$34,$7C,$C7,$26,$08,$30,$00,$06,$10,$62,$67,$00,$00,$06
	dc.b	$D4,$FC,$03,$9E,$08,$30,$00,$03,$10,$63,$66,$00,$00,$0A,$50,$F3
	dc.b	$00,$00,$60,$00,$4E,$54,$9F,$73,$00,$00,$6A,$00,$FF,$34,$2F,$0B
	dc.b	$47,$F0,$10,$00,$08,$2B,$00,$03,$00,$63,$67,$00,$00,$10,$42,$42
	dc.b	$4E,$B9,$00,$00,$EE,$92,$4E,$B9,$00,$00,$EC,$6E,$26,$5F,$4E,$75
	dc.b	$4E,$F9,$00,$02,$15,$DC,$4E,$F9,$00,$01,$C7,$84

puckfaceoff2	;Puck assignment: the faceoff
	dc.b	$08,$AB,$00,$01,$00,$62,$67,$00,$03,$DE,$08,$B8,$00,$01,$C3,$56
	dc.b	$08,$B8,$00,$02,$C3,$40,$08,$B8,$00,$05,$C3,$40,$08,$B8,$00,$00
	dc.b	$C3,$42,$08,$B8,$00,$01,$C3,$42,$08,$B8,$00,$00,$C3,$4E,$08,$B8
	dc.b	$00,$01,$C3,$4E,$08,$B8,$00,$02,$C3,$4E,$48,$E7,$FF,$FE,$4E,$B9
	dc.b	$00,$01,$AF,$52,$08,$38,$00,$00,$BF,$B2,$66,$F8,$08,$B8,$00,$00
	dc.b	$C3,$5A,$40,$E7,$31,$FC,$00,$3C,$D2,$E0,$4A,$78,$BF,$E2,$66,$00
	dc.b	$00,$14,$4A,$78,$BF,$E4,$66,$00,$00,$0C,$31,$FC,$FF,$FF,$D4,$7E
	dc.b	$60,$00,$00,$06,$46,$FC,$27,$00,$0C,$78,$02,$58,$B8,$B2,$63,$00
	dc.b	$00,$08,$31,$FC,$02,$58,$B8,$B2,$08,$F8,$00,$03,$BF,$B2,$08,$B8
	dc.b	$00,$00,$C3,$3A,$08,$B8,$00,$00,$C3,$3E,$31,$FC,$03,$E8,$BF,$16
	dc.b	$31,$FC,$03,$E8,$BF,$14,$42,$38,$BF,$BA,$50,$F8,$C4,$46,$50,$F8
	dc.b	$BF,$1C,$50,$F8,$BF,$20,$08,$B8,$00,$01,$C3,$3C,$08,$F8,$00,$00
	dc.b	$C3,$3C,$08,$F8,$00,$02,$C3,$3C,$50,$F8,$BF,$12,$50,$F8,$BF,$A6
	dc.b	$08,$F8,$00,$04,$BF,$B2,$08,$B8,$00,$04,$C3,$4E,$4E,$B9,$00,$01
	dc.b	$D0,$1E,$31,$FC,$27,$10,$C3,$68,$42,$78,$BD,$2E,$42,$78,$BD,$32
	dc.b	$31,$F8,$BF,$E2,$B7,$5E,$31,$F8,$BF,$E4,$B7,$72,$50,$F8,$B7,$76
	dc.b	$42,$78,$B7,$86,$42,$78,$B7,$88,$42,$78,$B7,$8A,$50,$F8,$B7,$BE
	dc.b	$30,$7C,$B6,$5E,$42,$68,$00,$28,$42,$68,$00,$2A,$42,$50,$31,$7C
	dc.b	$01,$22,$00,$14,$D0,$FC,$00,$80,$42,$68,$00,$28,$42,$68,$00,$2A
	dc.b	$42,$50,$31,$7C,$FE,$DE,$00,$14,$30,$7C,$B7,$DE,$31,$7C,$02,$99
	dc.b	$00,$06,$42,$68,$00,$58,$42,$68,$00,$04,$42,$78,$B7,$62,$08,$B8
	dc.b	$00,$06,$C3,$3A,$78,$64,$4E,$B9,$00,$01,$67,$9A,$51,$CC,$FF,$F8
	dc.b	$31,$FC,$00,$3C,$BF,$E0,$4E,$B9,$00,$01,$FD,$F4,$34,$7C,$C7,$26
	dc.b	$4E,$B9,$00,$01,$FB,$52,$4E,$B9,$00,$01,$FD,$82,$D4,$FC,$03,$9E
	dc.b	$4E,$B9,$00,$01,$FB,$52,$4E,$B9,$00,$01,$FD,$82,$4E,$B9,$00,$02
	dc.b	$14,$30,$2F,$0B,$36,$7C,$B0,$5E,$74,$0B,$36,$BC,$FF,$10,$42,$6B
	dc.b	$00,$14,$42,$6B,$00,$06,$32,$2B,$00,$34,$6B,$00,$00,$FE,$67,$00
	dc.b	$00,$4C,$20,$3C,$00,$00,$00,$16,$B2,$7C,$00,$04,$66,$00,$00,$38
	dc.b	$34,$7C,$C7,$26,$08,$2B,$00,$06,$00,$62,$67,$00,$00,$06,$D4,$FC
	dc.b	$03,$9E,$42,$6A,$00,$18,$15,$6B,$00,$67,$00,$19,$08,$B8,$00,$07
	dc.b	$C3,$4C,$50,$EA,$00,$1A,$50,$EA,$00,$1C,$08,$AA,$00,$03,$00,$30
	dc.b	$20,$3C,$00,$00,$00,$17,$4E,$B9,$00,$01,$A3,$D0,$38,$38,$C7,$4A
	dc.b	$08,$2B,$00,$06,$00,$62,$67,$00,$00,$06,$38,$38,$CA,$E8,$44,$44
	dc.b	$5C,$44,$E7,$44,$22,$7C,$00,$00,$A2,$6C,$D2,$C4,$18,$31,$10,$00
	dc.b	$E5,$44,$22,$7C,$00,$00,$A2,$84,$30,$31,$40,$00,$32,$31,$40,$02
	dc.b	$08,$2B,$00,$07,$00,$62,$66,$00,$00,$06,$44,$40,$44,$41,$4A,$6B
	dc.b	$00,$34,$67,$00,$00,$2C,$B8,$7C,$00,$08,$6E,$00,$00,$1C,$36,$38
	dc.b	$BF,$E2,$B1,$43,$6A,$00,$00,$0A,$36,$38,$BF,$E4,$E6,$43,$92,$43
	dc.b	$36,$38,$BF,$E2,$E4,$43,$90,$43,$D0,$78,$BF,$E2,$D2,$78,$BF,$E4
	dc.b	$36,$80,$37,$41,$00,$14,$42,$6B,$00,$28,$42,$6B,$00,$2A,$90,$78
	dc.b	$B7,$5E,$92,$78,$B7,$72,$44,$40,$44,$41,$4E,$B9,$00,$01,$A3,$EE
	dc.b	$37,$40,$00,$54,$08,$AB,$00,$02,$00,$63,$08,$AB,$00,$05,$00,$62
	dc.b	$32,$3C,$08,$56,$4E,$B9,$00,$01,$A6,$14,$D6,$FC,$00,$80,$51,$CA
	dc.b	$FE,$EA,$4E,$B9,$00,$02,$13,$AE,$26,$5F,$4E,$B9,$00,$01,$99,$66
	dc.b	$38,$38,$B0,$3A,$24,$7C,$00,$09,$1D,$4E,$4E,$B9,$00,$01,$B7,$30
	dc.b	$31,$C4,$B0,$26,$24,$7C,$00,$13,$BC,$B8,$4E,$B9,$00,$01,$B7,$30
	dc.b	$31,$FC,$FF,$FF,$D4,$74,$08,$38,$00,$00,$C3,$4A,$67,$00,$00,$10
	dc.b	$30,$38,$D4,$7E,$6B,$00,$00,$08,$4E,$B9,$00,$1D,$8A,$86,$61,$00
	dc.b	$01,$4E,$30,$3C,$00,$78,$4E,$B9,$00,$01,$B0,$A6,$06,$40,$01,$2C
	dc.b	$0C,$78,$00,$00,$D4,$74,$67,$00,$00,$2A,$0C,$78,$00,$01,$D4,$74
	dc.b	$67,$00,$00,$20,$0C,$78,$00,$05,$D4,$74,$67,$00,$00,$16,$0C,$78
	dc.b	$00,$04,$D4,$74,$67,$00,$00,$0C,$0C,$78,$00,$02,$D4,$74,$66,$00
	dc.b	$00,$0E,$B0,$7C,$01,$86,$6E,$00,$00,$06,$30,$3C,$01,$86,$37,$40
	dc.b	$00,$40,$31,$FC,$00,$18,$BD,$3C,$20,$7C,$FF,$FF,$BD,$BE,$30,$BC
	dc.b	$00,$01,$31,$7C,$80,$00,$00,$02,$31,$7C,$00,$04,$00,$04,$31,$7C
	dc.b	$A8,$00,$00,$06,$31,$7C,$00,$07,$00,$08,$31,$7C,$80,$00,$00,$0A
	dc.b	$08,$38,$00,$01,$C3,$38,$66,$00,$00,$0E,$0A,$68,$08,$00,$00,$02
	dc.b	$0A,$68,$08,$00,$00,$06,$31,$FC,$FF,$FF,$BF,$E6,$31,$FC,$FF,$FF
	dc.b	$BF,$E8,$4E,$B9,$00,$1D,$97,$48,$08,$B8,$00,$06,$C3,$4C,$66,$00
	dc.b	$00,$0C,$08,$B8,$00,$04,$C3,$4C,$67,$00,$00,$12,$08,$B8,$00,$04
	dc.b	$C3,$4C,$3F,$38,$D4,$8A,$4E,$B9,$00,$08,$85,$86,$31,$FC,$00,$78
	dc.b	$C3,$A4,$4E,$B9,$00,$1E,$78,$C4,$31,$FC,$00,$18,$BD,$3C,$46,$DF
	dc.b	$4C,$DF,$7F,$FF,$4E,$75,$53,$78,$C3,$A4,$66,$00,$00,$14,$4E,$B9
	dc.b	$00,$1E,$7A,$78,$08,$B8,$00,$02,$C3,$56,$08,$F8,$00,$03,$C3,$56
	dc.b	$53,$6B,$00,$40,$6A,$00,$00,$0E,$4E,$B9,$00,$1D,$8A,$C0,$4E,$F9
	dc.b	$00,$00,$A3,$DC,$4E,$F9,$00,$01,$9B,$16
.apl	;Faceoff positions of the players by line slot
	dc.b	0,1,2,3,4,5,6,0
	dc.b	0,1,5,3,4,2,0,0
	dc.b	0,3,5,1,4,0,0,0
.ptab	;Faceoff x / y offsets
	dc.w	0,$FEF0,$FFDD,$FFCE,$23,$FFCE,$FFCE,$FFF6
	dc.w	0,$FFF1,$32,$FFF6,0,$FFC4

DrawFaceoffWindow	;Draw the faceoff window (FaceOffMap) at x $36 or $BE
	;y $5C, and with line changes on the two line names (linelist)
	jsr	(printz).l
	String	-(TXPRI+TXMAP1),0,0,0
	moveq	#$36,d0
	tst.w	(fox).w
	bpl.w	.setx
	move.w	#$BE,d0
.setx
	move.w	d0,(fodropx).w
	subi.w	#$2E,d0
	asr.w	#3,d0
	move.w	d0,(printx).w
	moveq	#$5C,d0
	move.w	d0,(fodropy).w
	subi.w	#$44,d0
	asr.w	#3,d0
	move.w	d0,(printy).w
	move.w	(ExtraChars).w,d4
	movea.l	#FaceOffMap,a0
	movea.l	a0,a1
	movea.l	a0,a2
	adda.l	(a2)+,a0
	adda.l	(a2)+,a1
	clr.w	d0
	clr.w	d1
	moveq	#$C,d2
	moveq	#9,d3
	moveq	#0,d5
	bset	#0,(sflags6).w
	jsr	(dobitmap).l
	bclr	#0,(sflags6).w
	tst.w	(OptLine).w
	bne.w	.exit
	jsr	(printsmallz).l
	String	CC_AddY,$A,CC_SetAttribute,4
	moveq	#$C,d0
	moveq	#3,d1
	jsr	(Framer).l
	move.w	(tmstruct+tmline).w,d0
	move.w	(AwShots+tmline).w,d1
	btst	#1,(gmode).w
	bne.w	.0
	exg	d0,d1
.0
	jsr	(printsmallz).l
	String	CC_AddX,1,CC_AddY,$FE
	movea.l	#linelist,a1
	jsr	(SkipStrings).l
	jsr	(print).l
	addq.w	#4,(printx).w
	move.w	d1,d0
	movea.l	#linelist,a1
	jsr	(SkipStrings).l
	jsr	(print).l
.exit
	rts

limitfo	;Limit the faceoff spot to the walls of the rink, for every player in PenBuf
	movem.l	d0-d1/a0-a1,-(sp)
	movea.w	#(PenBuf-M68K_RAM),a0
.loop
	bsr.w	.lf
	addq.w	#2,a0
	tst.w	(a0)
	bne.s	.loop
	movem.l	(sp)+,d0-d1/a0-a1
	rts
.lf
	move.b	1(a0),d0
	andi.w	#$7F,d0
	asl.w	#7,d0	;scsize
	movea.w	#(SortCords-M68K_RAM),a1
	move.w	#$76,d1
	btst	#7,pflags(a1,d0.w)
	bne.w	.2
	neg.w	d1
	cmp.w	(foy).w,d1
	blt.w	.1
	move.w	#$FF98,(foy).w
	bra.w	.sx
.2
	cmp.w	(foy).w,d1
	bgt.w	.1
	move.w	#$68,(foy).w
.sx
	move.w	#$51,d0
	tst.w	(fox).w
	bpl.w	.0
	neg.w	d0
.0
	move.w	d0,(fox).w
.1
	rts

rtss7	;The shared rts of faceoffinput and doinput
	rts

Endfaceoff	;Drop the puck: pick the winner (.ftab) and the puck direction. Not decoded in the listing:
	;kept as bytes
	dc.b	$3F,$3C,$00,$2C,$4E,$B9,$00,$08,$84,$70,$08,$B8,$00,$00,$C3,$3C
	dc.b	$31,$FC,$00,$3C,$D2,$E0,$38,$38,$B0,$3A,$24,$7C,$00,$09,$7E,$7A
	dc.b	$4E,$B9,$00,$01,$B7,$30,$08,$B8,$00,$02,$C3,$3C,$08,$B8,$00,$00
	dc.b	$C3,$38,$08,$AB,$00,$00,$00,$63,$42,$78,$C3,$68,$08,$F8,$00,$04
	dc.b	$C3,$3E,$36,$38,$BF,$E6,$38,$3C,$08,$00,$20,$7C,$00,$00,$A4,$D6
	dc.b	$32,$7C,$BD,$BE,$74,$10,$32,$11,$94,$30,$10,$FF,$32,$29,$00,$04
	dc.b	$D4,$30,$10,$FF,$70,$21,$4E,$B9,$00,$01,$B0,$A6,$B4,$00,$63,$00
	dc.b	$00,$04,$58,$49,$08,$29,$00,$03,$00,$02,$67,$00,$00,$08,$36,$38
	dc.b	$BF,$E8,$44,$44,$30,$03,$08,$00,$00,$03,$66,$00,$00,$14,$02,$40
	dc.b	$00,$07,$32,$39,$00,$C0,$00,$08,$02,$41,$00,$03,$66,$00,$00,$1A
	dc.b	$70,$05,$4E,$B9,$00,$01,$B0,$A6,$55,$40,$02,$40,$00,$07,$4A,$44
	dc.b	$6B,$00,$00,$06,$0A,$40,$00,$04,$E5,$40,$20,$7C,$00,$01,$AE,$60
	dc.b	$32,$30,$00,$00,$EB,$41,$37,$41,$00,$28,$32,$30,$00,$02,$EB,$41
	dc.b	$D2,$44,$37,$41,$00,$2A,$30,$3C,$08,$00,$4E,$B9,$00,$01,$B0,$A6
	dc.b	$37,$40,$00,$2C,$42,$78,$B7,$76,$08,$AB,$00,$02,$00,$62,$20,$3C
	dc.b	$00,$00,$00,$18,$4E,$F9,$00,$01,$A3,$DA
.ftab
	dc.b	0,8,$10,0,8,$10

updatepadinput	;Pad d6 (0-6): read it, run doinput for its player and keep impact
	cmp.w	(c1playernum).w,d6	;check if cont 1 is puck carrier
	bne.w	.t0
	jsr	(ReadJoy1).l
	clr.w	d4	;pad index for cont 1 player
	move.w	#$FFFF,(joypuckcarrier).w
	jsr	(doinput).l
	bra.w	.t1
.t0
	cmp.w	(c2playernum).w,d6	;check if cont 2 is puck carrier
	bne.w	.t1
	jsr	(ReadJoy2).l
	move.w	#2,d4	;pad index for cont 2 player
	move.w	#$FFFF,(joypuckcarrier).w
	jsr	(doinput).l
.t1
	cmp.w	(c3playernum).w,d6
	bne.w	.t3
	jsr	(ReadJoy3).l
	move.w	#4,d4
	move.w	#$FFFF,(joypuckcarrier).w
	jsr	(doinput).l
.t3
	cmp.w	(c4playernum).w,d6
	bne.w	.t1cont
	jsr	(ReadJoy4).l
	move.w	#6,d4
	move.w	#$FFFF,(joypuckcarrier).w
	jsr	(doinput).l
.t1cont
	jsr	(doassignment).l
	clr.w	Wallcos(a3)	;clear wallcos
	clr.w	Wallsin(a3)	;clear wallsin
	move.w	(a3),d2	;Xpos
	move.w	Ypos(a3),d3	;Ypos
	cmp.w	OldXpos(a3),d2	;compare to oldXpos
	bne.w	.cc	;branch if not equal
	cmp.w	OldYpos(a3),d3	;compare to oldYpos
	beq.w	.nf	;branch if equal
.cc
	jsr	(checkcoll).l	;check for collisions
.nf
	move.w	d7,d0	;move d7 into d0 (elapsed frames)
	asl.w	#1,d0	;mult by 2
	sub.w	d0,impact(a3)	;reduce impact at a constant rate
	bpl.w	.nf1	;branch if positive
	clr.w	impact(a3)	;clear impact if negative or zero
.nf1
	move.w	impact(a3),limpact(a3)	;move impact into limpact
	rts

doinput	;Process controller input for player a3: d0 = dpad, d1 = new buttons, d2 = changed buttons, d3 = held buttons,
	;d4 = pad 0 / 2 / 4 / 6
	bclr	#0,(sflags13).w
	btst	#4,d3
	beq.w	.7
	bset	#0,(sflags13).w
.7
	btst	#6,d3
	bne.w	.0
	btst	#6,d2
	bne.w	.0
	movem.l	a0,-(sp)
	movea.l	#unk_FFC38C,a0
	asr.w	#1,d4
	clr.b	(a0,d4.w)
	add.w	d4,d4
	movem.l	(sp)+,a0
.0
	btst	#4,d1	;B button
	beq.w	.1	;branch if not pressed
	btst	#5,d1	;C button
	beq.w	.1	;branch if not pressed
	bclr	#4,d1
	bset	#6,pflags3(a3)
	bra.w	.5
.1
	btst	#4,d1
	beq.w	.2
	bclr	#6,pflags3(a3)
.2
	btst	#4,d2
	beq.w	.5
	bclr	#6,pflags3(a3)
	beq.w	.5
	tst.w	d4
	bne.w	.3
	move.b	#$F,(bholdtimer).w
	bra.w	.4
.3
	move.b	#$F,(bholdtimer+1).w
.4
	bclr	#4,d2
.5
	btst	#7,(gmode2).w
	beq.w	.6
	cmp.b	#8,d0
	beq.w	.6
	jsr	(ShortenMsgTimer).l
.6
	move.w	d0,(TempWord1).w
	andi.w	#$F,(TempWord1).w
	jsr	(setpads).l
	btst	#7,d1	;start button
	beq.w	.10
	tst.w	position(a3)
	beq.w	.8
	movem.w	d3,-(sp)
	andi.b	#$F,d3
	movem.w	(sp)+,d3
	beq.w	.8
	jsr	(sub_AFDA).l
	bra.w	.nostart
.8
	tst.w	d4
	bne.w	.34
	jmp	startpause1
.34
	cmp.w	#2,d4
	bne.w	.35
	jmp	startpause2
.35
	cmp.w	#4,d4
	bne.w	.9
	jmp	startpause3
.9
	cmp.w	#6,d4
	bne.w	.10
	jmp	startpause4
.10
	btst	#7,(sflags).w
	beq.w	.nostart
	btst	#3,d0
	bne.w	.nostart
	addq.w	#2,d0
	andi.w	#7,d0
.nostart
	btst	#0,(sflags2).w
	bne.w	faceoffinput
	btst	#3,pflags2(a3)
	bne.w	lineinput
	btst	#3,pflags(a3)
	beq.w	rtss15
	movem.l	d0-d2/a0/a3,-(sp)
	move.w	(lastplayer).w,d0
	cmp.w	SCnum(a3),d0
	bne.w	.26
	tst.w	(passplayer).w
	bmi.w	.26
	tst.w	(onetimerplayer).w
	bpl.w	.26
	bclr	#2,(GameFlags).w
	bne.w	.16
	btst	#5,d1
	beq.w	.26
.16
	bclr	#3,(GameFlags).w
	bsr.w	.20
	beq.w	.26
	movem.l	(sp)+,d0-d2/a0/a3
	rts
.20
	move.w	(passplayer).w,d0
	bmi.w	.24
	tst.w	(puckc).w
	bpl.w	.24
	asl.w	#7,d0
	movea.l	#SortCords,a3
	adda.w	d0,a3
	tst.w	position(a3)
	beq.w	.24
	jsr	(PuckOnAttackHalf).l
	beq.w	.24
	btst	#3,pflags(a3)
	bne.w	.24
	btst	#3,pflags3(a3)
	bne.w	.24
	move.w	d4,(inputjoy).w
	bsr.w	PadOnTeam
	beq.w	.24
	move.w	#$23,d0
	jsr	(assreplace).l
	move.w	#1,d0
	rts
.24
	clr.w	d0
	rts
.26
	movem.l	(sp)+,d0-d2/a0/a3
	btst	#6,d1
	beq.w	.32
	cmpi.w	#SPAhook,SPA(a3)
	bne.w	.32
	tst.w	SPAnum(a3)
	bne.w	.32
	movem.w	d1,-(sp)
	move.w	#SPA099A,d1
	jsr	(SetSPA).l
	bset	#5,pflags(a3)
	movem.w	(sp)+,d1
	bra.w	doinput_islocked
.32
	btst	#0,pflags2(a3)
	beq.w	.37
	btst	#5,pflags(a3)
	bne.w	doinput_islocked
	bra.w	fightinput
.37
	move.w	(puckc).w,d5
	cmp.w	SCnum(a3),d5
	bne.w	.38
	btst	#3,pflags3(a3)
	bne.w	doinput_ispc
	btst	#5,pflags(a3)
	beq.w	doinput_ispc
	bra.w	doinput_islocked
.38
	tst.w	position(a3)
	bne.w	.39
	btst	#3,pflags3(a3)
	bne.w	.11
	btst	#5,pflags(a3)
	bne.w	.39
	bra.w	.11
.39
	btst	#3,pflags3(a3)
	beq.w	.57
	btst	#5,pflags(a3)
	bne.w	doinput_islocked
	bra.w	.11
.57
	btst	#6,d1
	beq.w	.40
	btst	#0,(sflags13).w
	bne.w	.40
	movem.l	d0-d7/a0-a6,-(sp)
	bset	#3,(GameFlags).w
	bsr.w	.20
	movem.l	(sp)+,d0-d7/a0-a6
	beq.w	.41
	bset	#3,(GameFlags).w
	rts
.40
	btst	#5,pflags(a3)
	bne.w	doinput_islocked
	bra.w	.11
.41
	movem.l	d7-a0,-(sp)
	move.w	(lastplayer).w,d7
	asl.w	#7,d7
	movea.l	#SortCords,a0
	adda.w	d7,a0
	tst.w	position(a0)
	movem.l	(sp)+,d7-a0
	beq.w	.43
	movem.w	d7,-(sp)
	move.w	SCnum(a3),d7
	cmp.w	(passplayer).w,d7
	movem.w	(sp)+,d7
	bne.w	.43
	tst.w	(puckc).w
	bpl.w	.43
	bset	#3,(GameFlags).w
	jsr	(PuckOnAttackHalf).l
	beq.w	.43
	move.w	d0,-(sp)
	move.w	d4,(inputjoy).w
	bsr.w	PadOnTeam
	beq.w	.42
	move.w	#$23,d0
	jsr	(assreplace).l
.42
	move.w	(sp)+,d0
	rts
.43
	btst	#5,pflags(a3)
	bne.w	doinput_islocked
	jmp	holdplayer
.11
	tst.w	position(a3)
	beq.w	.12
	btst	#2,(BA_PS_flags).w
	bne.w	.noswitch
	bra.w	.bhold
.12
	btst	#6,(sflags5).w
	bne.w	.bhold
	tst.w	d4
	beq.w	.13
	tst.w	(goaliemode2).w
	bra.w	.14
.13
	tst.w	(goaliemode1).w
.14
	beq.w	.bhold
	movem.w	d0,-(sp)
	move.w	SCnum(a3),d0
	cmp.w	(puckc).w,d0
	movem.w	(sp)+,d0
	beq.w	.bhold
.15
	jmp	chgplayer
.bhold
	btst	#4,d3
	beq.w	.bpress
	tst.w	(holdreset).w
	bne.w	.bpress
	tst.w	d4
	beq.w	.c1
	tst.b	(bholdtimer+1).w
	beq.w	.noswitch
	subq.b	#1,(bholdtimer+1).w
	bpl.w	.17
	move.b	#0,(bholdtimer+1).w
.17
	tst.b	(bholdtimer+1).w
	bne.w	.bpress
	tst.w	d4
	beq.w	.18
	tst.w	(goaliemode2).w
	bra.w	.19
.18
	tst.w	(goaliemode1).w
.19
	bne.w	.bpress
	bra.w	.goalie
.c1
	tst.b	(bholdtimer).w
	beq.w	.noswitch
	subq.b	#1,(bholdtimer).w
	bpl.w	.21
	move.b	#0,(bholdtimer).w
.21
	tst.w	d4
	beq.w	.22
	tst.w	(goaliemode2).w
	bra.w	.23
.22
	tst.w	(goaliemode1).w
.23
	bne.w	.bpress
	tst.b	(bholdtimer).w
	beq.w	.goalie
.bpress
	btst	#4,d1
	beq.w	.brel
	tst.w	d4
	bne.w	.25
	move.b	#$F,(bholdtimer).w
	bra.w	.noswitch
.25
	move.b	#$F,(bholdtimer+1).w
	bra.w	.noswitch
.brel
	btst	#4,d2
	beq.w	.noswitch
	btst	#4,d3
	bne.w	.noswitch
	move.w	(bholdtimer).w,d0
	tst.w	d4
	beq.w	.29
	move.b	#$F,(bholdtimer+1).w
	andi.w	#$FF,d0
	bne.w	.15
	tst.w	d4
	beq.w	.27
	tst.w	(goaliemode2).w
	bra.w	.28
.27
	tst.w	(goaliemode1).w
.28
	bne.w	.15
	bra.w	.goalie
.29
	move.b	#$F,(bholdtimer).w
	andi.w	#$FF00,d0
	bne.w	.15
	tst.w	d4
	beq.w	.30
	tst.w	(goaliemode2).w
	bra.w	.31
.30
	tst.w	(goaliemode1).w
.31
	bne.w	.15
.goalie
	tst.w	(holdreset).w
	beq.w	.44
	jmp	chgplayer
.44
	move.w	#5,d0
	cmp.w	#5,d6
	ble.w	.33
	move.w	#$B,d0
.33
	jsr	(getGoalieSCnum).l
	tst.w	d0
	bmi.w	rtss15
	movem.l	d0/a3,-(sp)
	movea.l	#SortCords,a3
	asl.w	#7,d0
	adda.w	d0,a3
	btst	#3,pflags(a3)
	movem.l	(sp)+,d0/a3
	bne.w	rtss15
	tst.w	d4
	bne.w	.45
	jmp	setc1player
.45
	cmp.w	#2,d4
	bne.w	.46
	jmp	setc2player
.46
	cmp.w	#4,d4
	bne.w	.36
	jmp	setc3player
.36
	jmp	setc4player
.noswitch
	tst.w	position(a3)
	bne.w	doinput_skater

doinput_goaliedive	;Goalie: A with a dpad direction dives that way (SPAgdive)
	btst	#6,d1
	beq.w	doinput_cbut
	move.w	(TempWord1).w,d0
	cmp.b	#8,d0
	beq.w	doinput_cbut
	move.w	d0,facedir(a3)
	move.b	#8,nopuck(a3)
	move.w	#SPAgdive,d1
	jsr	(SetSPA).l
	bset	#1,pflags2(a3)
	bset	#5,pflags(a3)
	addi.w	#$96,(crowdlevel).w

rtss15	;The shared rts of doinput_goaliedive and doinput_cbut
	rts

doinput_cbut	;Button C (bit 5): new press: face the puck (vtoa) and go on below; held: hold the SPA frame
	;(SPAcnt $A) at the end
	btst	#5,d1
	bne.w	.press
	btst	#5,d3
	bne.w	.held
	bclr	#7,pflags2(a3)
	bra.w	doinput_chkanim
.held
	btst	#7,pflags2(a3)
	beq.w	doinput_chkanim
	movem.l	d0-d3/a0-a3,-(sp)
	movea.l	#SPAlist,a0
	adda.w	SPA(a3),a0
	move.w	facedir(a3),d0
	btst	#3,attribute(a3)
	beq.w	.1
	neg.w	d0
	addq.w	#8,d0
	andi.w	#7,d0
.1
	asl.w	#1,d0
	adda.w	(a0,d0.w),a0
	tst.b	SPAnum+1(a3)
	movem.l	(sp)+,d0-d3/a0-a3
	bpl.s	rtss15
	move.w	#$A,SPAcnt(a3)
	rts
.press
	btst	#5,pflags(a3)
	bne.w	doinput_chkanim
	movem.w	d0-d1,-(sp)
	move.w	(puckx).w,d0
	sub.w	(a3),d0
	move.w	(pucky).w,d1
	sub.w	Ypos(a3),d1
	jsr	(vtoa).l
	move.w	d0,facedir(a3)
	movem.w	(sp)+,d0-d1
	move.w	(TempWord1).w,d0
	bclr	#0,(BA_PS_flags).w
	move.w	(gameclock).w,d0
	andi.w	#7,d0
	asl.w	#4,d0
	addi.w	#$A0,d0
	cmpi.w	#$F1,(pucky).w
	bgt.w	.3
	cmpi.w	#$FF0F,(pucky).w
	bgt.w	.4
.3
	subi.w	#$40,d0
.4
	move.w	d0,d1
	muls.w	(puckvx).w,d0
	swap	d0
	add.w	(puckx).w,d0
	muls.w	(puckvy).w,d1
	swap	d1
	add.w	(pucky).w,d1
	bsr.w	ClampTargetY
	movem.w	d0-d1,-(sp)
	muls.w	d0,d0
	muls.w	d1,d1
	add.l	d1,d0
	cmp.l	#$384,d0
	bhi.w	.far
	movem.w	(sp)+,d0-d1
	bra.w	.near
.far
	jsr	(sroot).l
	moveq	#1,d2
	add.w	d0,d2
	moveq	#$12,d4
	btst	#3,(sflags).w
	beq.w	.6
	addq.w	#8,d4
.6
	movem.w	(sp)+,d0-d1
	muls.w	d4,d1
	addq.w	#8,d4
	muls.w	d4,d0
	divs.w	d2,d0
	divs.w	d2,d1
.near
	add.w	d3,d1
	move.w	d1,d2
	cmpi.w	#$22,2(a0)
	cmpi.w	#$18,(a0)
	cmpi.w	#$FFE8,(a0)
	cmpi.w	#$C,2(a0)
	cmpi.w	#$11E,(pucky).w
	cmpi.w	#$FEE2,(pucky).w
	bset	#1,pflags2(a3)
	bne.w	doinput_chkanim
	movem.l	d0-d7/a0-a6,-(sp)
	movea.l	#puckcross,a0
	move.w	#$11E,d3
	btst	#7,pflags(a3)
	beq.w	.save	;branch if bottom net
	neg.w	d3
	addq.w	#4,a0	;puckcross+4 (for bottom goalie)
.save
	jsr	(goaliesave).l
	movem.l	(sp)+,d0-d7/a0-a6
	rts

ClampTargetY	;Clamp target y d1 to $119 / $FEE7, then d1 - d3; d0 = 0 for the puck carrier
	move.w	(puckc).w,d2
	cmp.w	SCnum(a3),d2
	bne.w	.0
	clr.w	d0
.0
	cmp.w	#$119,d1
	blt.w	.1
	move.w	#$119,d1
.1
	cmp.w	#$FEE7,d1
	bgt.w	.2
	move.w	#$FEE7,d1
.2
	sub.w	d3,d1
	rts
	;SPA offsets, unreferenced: SPAgglover, SPAgglovel, SPAgstackr, SPAgstackl, SPAgstickr,
	;SPAgstickl, then SPAgglover, SPAgglovel, SPAgstickr, SPAgstickl
	dc.w	SPAgglover,SPAgglovel,SPAgstackr,SPAgstackl,SPAgstickr,SPAgstickl,SPAgglover,SPAgglovel,SPAgstickr,SPAgstickl

doinput_chkanim	;Animation in progress (pflags2 bit 1): rts. Then the goalie checks, then playeracc with TempWord1
	btst	#1,pflags2(a3)
	beq.w	.0
	rts
.0
	tst.w	position(a3)
	bne.w	loc_AFD4
	bclr	#1,(BA_PS_flags).w
	cmpi.w	#$24,(a3)
	ble.w	.1
	tst.w	Xvel(a3)
	bmi.w	.1
	beq.w	.1
	bset	#1,(BA_PS_flags).w
	clr.w	Xvel(a3)
.1
	cmpi.w	#$FFDC,(a3)
	bge.w	.2
	tst.w	Xvel(a3)
	bpl.w	.2
	bset	#1,(BA_PS_flags).w
	clr.w	Xvel(a3)
.2
	cmpi.w	#$E7,Ypos(a3)
	bgt.w	.4
	cmpi.w	#$FF19,Ypos(a3)
	ble.w	.4
	bra.w	*+4	;to the next instruction
.3
	movem.w	d0-d1,-(sp)
	move.w	Ypos(a3),d0
	move.w	Yvel(a3),d1
	eor.w	d1,d0
	movem.w	(sp)+,d0-d1
	bpl.w	.4
	tst.w	Yvel(a3)
	beq.w	.4
	bset	#1,(BA_PS_flags).w
	clr.w	Yvel(a3)
.4
	btst	#1,(BA_PS_flags).w
	bne.w	rtss15
	move.w	(TempWord1).w,d0
	jmp	doplayeracc

doinput_skater	;Skater input (doinput, position not 0)
	move.w	(TempWord1).w,d0
	btst	#3,pflags3(a3)
	bne.w	rtss7
	btst	#5,d1
	beq.w	loc_AFD4
	movem.l	d7-a0,-(sp)
	move.w	(lastplayer).w,d7
	asl.w	#7,d7
	movea.l	#SortCords,a0
	adda.w	d7,a0
	tst.w	position(a0)
	movem.l	(sp)+,d7-a0
	bne.w	.1
.0
	jmp	burst
.1
	movem.w	d7,-(sp)
	move.w	SCnum(a3),d7
	cmp.w	(passplayer).w,d7
	movem.w	(sp)+,d7
	bne.s	.0
	tst.w	(puckc).w
	bpl.s	.0
	bclr	#3,(GameFlags).w
	jsr	(PuckOnAttackHalf).l
	beq.s	.0
	move.w	d0,-(sp)
	move.w	d4,(inputjoy).w
	bsr.w	PadOnTeam
	beq.w	.2
	move.w	#$23,d0
	bclr	#3,(GameFlags).w
	jsr	(assreplace).l
.2
	move.w	(sp)+,d0
	rts

doinput_ispc	;The puck carrier: checkob, then pass mode, shot mode, or the buttons
	jsr	(checkob).l
	tst.w	position(a3)
	bne.w	.42
	btst	#1,pflags2(a3)
	bne.w	rtss15
.42
	btst	#2,(sflags).w
	bne.w	passmode
	btst	#3,(sflags).w
	bne.w	ShotMode
	btst	#4,d1
	beq.w	.0
	jsr	(sub_1D920A).l
	bra.w	setpassmode
.0
	movem.l	a0,-(sp)
	btst	#6,d1
	beq.w	.1
	movea.l	#LineHoldTimer,a0
	move.w	#$F,(a0,d4.w)
	movem.l	(sp)+,a0
	bra.w	.51
.1
	btst	#6,d3
	beq.w	.51
	movea.l	#LineHoldTimer,a0
	subq.w	#1,(a0,d4.w)
	bpl.w	.50
	clr.w	(a0,d4.w)
.50
	tst.w	(a0,d4.w)
	bne.w	.51
	movem.l	(sp)+,a0
	bra.w	SetLCmode
.51
	movem.l	(sp)+,a0
	btst	#6,d3
	bne.w	.6
	btst	#6,d2
	beq.w	.6
	movem.l	a0,-(sp)
	movea.l	#unk_FFC38C,a0
	asr.w	#1,d4
	tst.b	(a0,d4.w)
	bmi.w	.5
	add.w	d4,d4
	movea.l	#LineHoldTimer,a0
	cmpi.w	#$3DE,(a0,d4.w)
	movem.l	(sp)+,a0
	bge.w	.6
	btst	#3,pflags2(a3)
	bne.w	.4
	movem.w	d0,-(sp)
	move.w	(pucky).w,d0
	bpl.w	.52
	neg.w	d0
.52
	cmp.w	#$76,d0
	blt.w	.55
	move.w	(pucky).w,d0
	btst	#7,pflags(a3)
	bne.w	.53
	neg.w	d0
.53
	tst.w	d0
	bmi.w	.55
	movem.w	(sp)+,d0
	btst	#3,(TempWord1+1).w
	bne.w	.3
	movem.w	d1,-(sp)
	move.w	#1,d1
	btst	#7,pflags(a3)
	bne.w	.2
	move.w	#0,d1
.2
	btst	d1,d3
	movem.w	(sp)+,d1
	beq.w	.3
	move.w	(TempWord1).w,d0
	bset	#1,(GameFlags).w
	bset	#2,(GameFlags).w
	jmp	setpassmode
.3
	bset	#0,(GameFlags).w	;fake shot (A released in the attacking zone)
	bne.w	.54
	jmp	SetShotMode
.54
	rts
.55
	movem.w	(sp)+,d0
.4
	bset	#3,(sflags5).w
	bra.w	setpassmode
.5
	movem.l	(sp)+,a0
	add.w	d4,d4
.6
	tst.w	position(a3)
	bne.w	.7
	jmp	doplayeracc
.7
	btst	#5,d1
	beq.w	loc_AFD4
	jsr	(sub_1D920A).l
	bra.w	SetShotMode

doinput_islocked	;B with the player not the carrier: change player (chgplayer)
	move.w	(puckc).w,d5
	cmp.w	SCnum(a3),d5
	beq.w	rtss15
	btst	#4,d1
	beq.w	rtss7
	btst	#6,(sflags5).w
	bne.w	rtss7
	jsr	(chgplayer).l
	movem.l	d0/a0,-(sp)
	tst.w	d4
	beq.w	.3
	cmp.w	#2,d4
	beq.w	.2
	cmp.w	#4,d4
	beq.w	.1
	bra.w	*+4
.0
	move.w	(c4playernum).w,d0
	bra.w	.4
.1
	move.w	(c3playernum).w,d0
	bra.w	.4
.2
	move.w	(c2playernum).w,d0
	bra.w	.4
.3
	move.w	(c1playernum).w,d0
.4
	tst.w	d0
	bmi.w	.x
	asl.w	#7,d0
	movea.l	#SortCords,a0
	adda.w	d0,a0
	bset	#6,pflags3(a0)
.x
	movem.l	(sp)+,d0/a0
	rts

loc_AFD4	;jmp doplayeracc, shared by doinput_chkanim, doinput_skater and doinput_islocked
	jmp	doplayeracc

sub_AFDA	;Start with a dpad direction: SPA288C with pflags2 bit 1 set and Xvel + $64,
	;not while pflags2 bit 2 or gmode bit 0 is set
	btst	#2,pflags2(a3)
	bne.w	.0
	btst	#0,(gmode).w
	bne.w	.0
	movem.l	d0-d7/a0-a6,-(sp)
	move.w	#SPA288C,d1
	jsr	(SetSPA).l
	bset	#1,pflags2(a3)
	addi.w	#$64,Xvel(a3)
	movem.l	(sp)+,d0-d7/a0-a6
.0
	rts

PadOnTeam	;d0 = 1 when pad inputjoy is on the team of player a3 (its cont1team ... cont4team
	;entry: 1 home, 2 visitors), else 0
	movem.l	d0-d1/a0,-(sp)
	movea.l	#cont1team,a0
	move.w	(inputjoy).w,d0
	move.w	(a0,d0.w),d0
	bmi.w	.1
	move.w	#1,d1
	btst	#6,pflags(a3)
	beq.w	.0
	move.w	#2,d1
.0
	cmp.w	d1,d0
	bne.w	.1
	move.w	#1,d0
	bra.w	.2
.1
	move.w	#0,d0
.2
	movem.l	(sp)+,d0-d1/a0
	rts

SetContTeams	;The controller setup screen: pick the team of each pad (cont1team ... cont4team);
	;a demo or a timeout clears all pads
	tst.w	(demoflag).w
	bmi.w	.setup
.clear
	clr.w	(cont1team).w
	clr.w	(cont2team).w
	clr.w	(cont3team).w
	clr.w	(cont4team).w
	clr.w	(OptNOP).w
	rts
.setup
	clr.w	(setupvalues).w
	clr.w	(setupvalues+2).w
	move.w	#1,(cont1team).w
	btst	#7,(GameFlags).w
	beq.w	.0
	move.w	(HomeTeam).w,d0
	cmp.b	(dword_FFDD82+2).w,d0
	beq.w	.0
	move.w	#2,(cont1team).w
.0
	cmpi.w	#1,(OptPlayMode).w
	beq.w	.1
	cmpi.w	#3,(OptPlayMode).w
	beq.w	.1
	cmpi.w	#2,(OptPlayMode).w
	bne.w	.2
.1
	move.w	(potreeteam).w,d0
	movea.l	#potree,a0
	move.b	(a0,d0.w),d0
	move.w	#1,(cont1team).w
	cmp.w	(HomeTeam).w,d0
	beq.w	.2
	move.w	#2,(cont1team).w
.2
	clr.w	(cont2team).w
	clr.w	(cont3team).w
	clr.w	(cont4team).w
	bsr.w	ControllerSetupScreen
	bsr.w	DrawPadSetup
	jsr	(vcountwait).l
	jsr	(vcountwait).l
	move.w	#$18,(palcount).w
	bclr	#2,(disflags).w
	clr.w	(carddelay).w
.frame
	move.w	(vcount).w,d0
.wait
	cmp.w	(vcount).w,d0
	beq.s	.wait
	move.w	(VSCRLPM).w,d0
	jsr	(Vmaddr).l
	move.w	#0,(a0)
	move.w	(word_FFD31A).w,d0
	move.w	d0,(a0)
	addq.w	#1,(word_FFD31A).w
	cmpi.w	#$5460,(carddelay).w
	bge.w	.clear
	bsr.w	ReadAllPads
	tst.w	(TempLegSpd).w
	beq.w	.keys
	clr.w	(carddelay).w
.keys
	btst	#7,(TempLegSpd+1).w
	bne.w	.4
	move.w	#1,d4
	tst.w	(FourWayPlay).w
	beq.w	.8
	btst	#0,(gmode2).w
	bne.w	.8
	move.w	#3,d4
.8
	movea.l	#cont1team,a0
	movea.l	#TempWord1+1,a3
.pad
	move.b	(a3),d1
	btst	#2,d1
	beq.w	.10
	move.w	(a0),d0
	cmp.w	#2,d0
	beq.w	.10
	movea.l	#ContTeamOrder1,a4
	move.b	(a4,d0.w),d0
	move.w	d0,(a0)
	move.w	(vcount).w,d0
.3
	cmp.w	(vcount).w,d0
	beq.s	.3
	bsr.w	DrawPadSetup
	bra.w	.nextpad
.10
	btst	#3,d1
	beq.w	.nextpad
	move.w	(a0),d0
	cmp.w	#1,d0
	beq.w	.nextpad
	movea.l	#ContTeamOrder2,a4
	move.b	(a4,d0.w),d0
	move.w	d0,(a0)
	bsr.w	DrawPadSetup
	bra.w	*+4
.nextpad
	addq.w	#2,a0
	addq.w	#2,a3
	dbf	d4,.pad
	bra.w	.frame
.4
	move.w	#4,(OptNOP).w
	clr.w	(padiconchars1).w
	rts

ContTeamOrder1	;Pad team order tables for SetContTeams
	dc.b	2,0,2,$FF

ContTeamOrder2
	dc.b	1,1,0,$FF

DrawPadSetup	;Draw the pads and their icons (DrawPadIcon)
	movem.l	d0-d7/a0-a6,-(sp)
	move.w	#8,(printy).w
	move.w	#1,d4
	tst.w	(FourWayPlay).w
	beq.w	.0
	btst	#0,(gmode2).w
	bne.w	.0
	move.w	#3,d4
.0
	movea.l	#cont1team,a0
	move.w	#0,d7
.loop
	move.w	(printy).w,-(sp)
	move.w	#$E,(printx).w
	tst.w	(a0)
	beq.w	.1
	move.w	#$19,(printx).w
	cmpi.w	#1,(a0)
	beq.w	.1
	move.w	#3,(printx).w
.1
	movem.l	d4/d7-a0,-(sp)
	add.w	d7,d7
	movea.l	#LineHoldFlag,a0
	move.w	(printx).w,d4
	cmp.w	(a0,d7.w),d4
	beq.w	.2
	move.w	d4,(a0,d7.w)
	movem.l	(sp)+,d4/d7-a0
	move.w	(printx).w,-(sp)
	subq.w	#1,(printy).w
	movea.l	#BlankLineTxt,a1
	bsr.w	PrintSetupStr
	addq.w	#1,(printy).w
	bsr.w	PrintSetupStr
	addq.w	#1,(printy).w
	bsr.w	PrintSetupStr
	addq.w	#1,(printy).w
	bsr.w	PrintSetupStr
	jsr	(printz).l
	String	-TXMAP1,0,0,0
	move.w	(sp)+,(printx).w
	move.w	(sp)+,(printy).w
	bsr.w	DrawPadIcon
	bra.w	.3
.2
	movem.l	(sp)+,d4/d7-a0
	move.w	(sp)+,(printy).w
.3
	addq.w	#2,a0
	addq.w	#5,(printy).w
	addq.w	#1,d7
	dbf	d4,.loop
	movem.l	(sp)+,d0-d7/a0-a6
	rts

DrawPadIcon	;Draw pad icon d7 (PadIconMaps at PadIconChars), or the pad cursor (PadCursorMap,
	;padcursorchars) at printx $E
	move.w	(printx).w,-(sp)
	move.w	(printy).w,-(sp)
	movem.l	d0-d7/a0-a6,-(sp)
	movea.l	#PadIconChars,a0
	move.w	d7,d0
	asl.w	#2,d0
	movea.l	(a0,d0.w),a0
	move.w	(a0),d4
	movea.l	#PadIconMaps,a0
	movea.l	(a0,d0.w),a0
	cmpi.w	#$E,(printx).w
	bne.w	.0
	movea.l	#PadCursorMap,a0
	move.w	(padcursorchars).w,d4
.0
	movea.l	a0,a1
	movea.l	a0,a2
	adda.l	(a2)+,a0
	adda.l	(a2)+,a1
	clr.w	d0
	addq.w	#1,(printx).w
	clr.w	d1
	subq.w	#1,(printy).w
	move.w	(a1),d2
	move.w	2(a1),d3
	moveq	#0,d5
	movea.l	#ZeroLong,a2
	jsr	(dobitmap).l
	movem.l	(sp)+,d0-d7/a0-a6
	move.w	(sp)+,(printy).w
	move.w	(sp)+,(printx).w
	rts

PadIconChars	;The RAM words with the chars of each pad icon
	dc.l	padiconchars1,padiconchars2,padiconchars3,padiconchars4

PadIconMaps	;Pad icon bitmaps
	dc.l	PadIconMap1,PadIconMap2,PadIconMap3,PadIconMap4

BlankLineTxt	;A blank line
	String	CC_SetX,0,'                                        '

ControllerSetupScreen	;Build the controller setup screen: vram, fonts, the pad graphics, the screen maps
	;and the team logos of VisTeam / HomeTeam
	move.l	#VBlank_SetOptions,(vbint).l
	move	#$2500,sr
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
	bclr	#5,(disflags).w
	jsr	(setVram).l
	jsr	(orjoy).l
	move.w	#1,d4
	move.w	d4,(smallfontchars).w
	movea.l	#RosterFont+8,a2
	jsr	(DecompressGraphicsPlain).l
	move.l	#RosterFont,(smallfontptr).l
	move.w	d4,(padcursorchars).w
	movea.l	#PadCursorMap+8,a2
	jsr	(DecompressGraphicsPlain).l
	move.w	d4,(padiconchars1).w
	movea.l	#PadIconMap1+8,a2
	jsr	(DecompressGraphicsPlain).l
	move.w	d4,(padiconchars2).w
	movea.l	#PadIconMap2+8,a2
	jsr	(DecompressGraphicsPlain).l
	move.w	d4,(padiconchars3).w
	movea.l	#PadIconMap3+8,a2
	jsr	(DecompressGraphicsPlain).l
	move.w	d4,(padiconchars4).w
	movea.l	#PadIconMap4+8,a2
	jsr	(DecompressGraphicsPlain).l
	jsr	(printsmallz).l
	String	CC_SetMap,1,CC_SetX,0,CC_SetY,0
	moveq	#$28,d0
	moveq	#$1C,d1
	move.w	#$7FF,d2
	jsr	(eraser).l
	jsr	(printz).l
	String	-(TXPRI+TXMAP1),0,0,0
	movea.l	#unk_1B773A,a0
	movea.l	a0,a1
	movea.l	a0,a2
	adda.l	(a2)+,a0
	adda.l	(a2)+,a1
	clr.w	d0
	clr.w	d1
	moveq	#$28,d2
	moveq	#$1C,d3
	moveq	#$A,d5
	jsr	(dobitmap).l
	jsr	(printz).l
	String	-(TXPRI+TXMAP1),$B,1,0
	movea.l	#unk_1B6F3A,a0
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
	String	-TXMAP2,0,0,0
	movea.l	#unk_173C7A,a0
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
	jsr	(printz).l
	String	-(TXPRI+TXMAP1),1,4,0
	move.w	(VisTeam).w,d7
	jsr	(DrawSetupTeamBlock).l
	addi.w	#$20,d4
	jsr	(printz).l
	String	-(TXPRI+TXMAP1),$17,4,0
	move.w	(HomeTeam).w,d7
	jsr	(DrawSetupTeamBlock).l
	addi.w	#$20,d4
	rts

PrintSetupStr	;Print String a1 (printsmallz CC_SetAttribute,5,CC_SetMap,1,CC_SetFont,0, then printsmall)
	movem.l	d0-d7/a0-a6,-(sp)
	move.l	a1,-(sp)
	jsr	(printsmallz).l
	String	CC_SetAttribute,5,CC_SetMap,1,CC_SetFont,0
	movea.l	(sp)+,a1
	jsr	(printsmall).l
	movem.l	(sp)+,d0-d7/a0-a6
	rts

PrintSetupStrHi	;The same highlighted (CC_SetFont,1)
	movem.l	d0-d7/a0-a6,-(sp)
	move.l	a1,-(sp)
	jsr	(printsmallz).l
	String	CC_SetAttribute,5,CC_SetMap,1,CC_SetFont,1
	movea.l	(sp)+,a1
	jsr	(printsmall).l
	movem.l	(sp)+,d0-d7/a0-a6
	rts

ReadAllPads	;Read the 4 pads into TempWord1, TempWord2, TempRawSpd and TempMaxSpd
	jsr	(ReadJoy1).l
	jsr	(nodiag).l
	move.w	d1,(TempWord1).w
	jsr	(ReadJoy2).l
	jsr	(nodiag).l
	move.w	d1,(TempWord2).w
	tst.w	(FourWayPlay).w
	beq.w	.0
	jsr	(ReadJoy3).l
	jsr	(nodiag).l
	move.w	d1,(TempRawSpd).w
	jsr	(ReadJoy4).l
	jsr	(nodiag).l
	move.w	d1,(TempMaxSpd).w
.0
	move.w	(TempWord1).w,d1
	or.w	(TempWord2).w,d1
	tst.w	(FourWayPlay).w
	beq.w	.1
	or.w	(TempRawSpd).w,d1
	or.w	(TempMaxSpd).w,d1
.1
	move.w	d1,(TempLegSpd).w
	rts

Detect4WayPlay	;Detect the 4 way play adaptor (EA 4 Way Play) on port 2: FourWayPlay = 1 when found
	move.w	#0,(IO_Z80RES).l
	move.b	#$40,(IO_CT1_CTRL+1).l
	move.b	#$43,(IO_CT2_CTRL+1).l
	nop
	move.b	#$7C,(IO_CT2_DATA+1).l
	nop
	move.b	#$7F,(IO_CT2_CTRL+1).l
	nop
	move.b	#$7C,(IO_CT2_DATA+1).l
	nop
	move.b	(IO_CT1_DATA+1).l,d0
	andi.b	#3,d0
	cmp.b	#0,d0
	bne.s	.0
	move.w	#1,(FourWayPlay).w
	bra.s	.1
.0
	move.w	#0,(FourWayPlay).w
	move.b	#$40,(IO_CT2_CTRL+1).l
.1
	move.w	#$100,(IO_Z80RES).l
	rts

ReadJoySwapPad1	;Unreferenced. Read 4 way play pad 1. Not decoded in the listing: kept as bytes
	dc.b	$13,$FC,$00,$00,$00,$A1,$00,$05,$31,$F8,$BF,$32,$BF,$2E,$4E,$B9
	dc.b	$00,$01,$B3,$48,$31,$F8,$BF,$2E,$BF,$32,$4E,$75

ReadJoySwapPad2	;Unreferenced. The same for pad 2
	dc.b	$13,$FC,$00,$10,$00,$A1,$00,$05,$31,$F8,$BF,$34,$BF,$2E,$4E,$B9
	dc.b	$00,$01,$B3,$48,$31,$F8,$BF,$2E,$BF,$34,$4E,$75

ReadJoySwapPad3	;Unreferenced. The same for pad 3
	dc.b	$13,$FC,$00,$20,$00,$A1,$00,$05,$31,$F8,$BF,$36,$BF,$2E,$4E,$B9
	dc.b	$00,$01,$B3,$48,$31,$F8,$BF,$2E,$BF,$36,$4E,$75

ReadJoySwapPad4	;Unreferenced. The same for pad 4
	dc.b	$13,$FC,$00,$30,$00,$A1,$00,$05,$31,$F8,$BF,$38,$BF,$2E,$4E,$B9
	dc.b	$00,$01,$B3,$48,$31,$F8,$BF,$2E,$BF,$38,$4E,$75

checkfight	;Look for the start of a fight between players a2 and a3 (impact $A or more on both, no
	;animation lock, no goalie, no faceoff): SetInst both ways, then startfight for both and the other
	;players watch (assignment $15)
	tst.w	(word_FFD266).w
	bne.w	.5
	btst	#5,(GameFlags).w
	bne.w	rtsfight
	tst.w	(gsp).w
	beq.w	rtsfight
	cmpi.w	#$A,impact(a3)
	blt.w	rtsfight
	cmpi.w	#$A,impact(a2)
	blt.w	rtsfight
	btst	#5,pflags(a3)
	bne.w	rtsfight
	btst	#5,pflags(a2)
	bne.w	rtsfight
	btst	#4,pflags2(a3)
	bne.w	rtsfight
	btst	#4,pflags2(a2)
	bne.w	rtsfight
	tst.w	position(a3)
	beq.w	rtsfight
	tst.w	position(a2)
	beq.w	rtsfight
	btst	#0,(gmode).w
	bne.w	rtsfight
	btst	#0,(byte_FFB7C1).w
	bne.w	rtsfight
	cmpi.w	#$10A,Ypos(a3)
	bgt.w	rtsfight
	cmpi.w	#$10A,Ypos(a3)
	bgt.w	rtsfight
	movem.l	d0-d4/a0-a3,-(sp)
	movea.w	#(puckx-M68K_RAM),a0
	move.w	assnum(a0),d0
	cmpi.b	#$1B,asslist(a0,d0.w)
	beq.w	.4
	move.w	(ChkCnt).w,d0
	cmp.w	#$64,d0
	blt.w	.4
	bsr.w	SetInst
	exg	a2,a3
	bsr.w	SetInst
	exg	a2,a3
	btst	#0,pflags2(a3)
	beq.w	.4
	clr.w	(ChkCnt).w
	moveq	#$1B,d0
	movea.w	#(unk_FFC856-M68K_RAM),a0
.0
	clr.b	$39E(a0)
	clr.b	(a0)+
	dbf	d0,.0
	addi.w	#$3E8,(crowdlevel).w
	addi.w	#$23,(padcursorchars).w
	clr.w	(word_FFDCEA).w
	clr.l	(dword_FFDCE0).w
	clr.l	(dword_FFDCE4).w
	bclr	#1,(sflags10).w
	bclr	#2,(sflags10).w
	bclr	#2,(sflags).w
	bclr	#3,(sflags).w
	move.w	SCnum(a3),(puckc).w
	move.w	Ypos(a3),d1
	add.w	Ypos(a2),d1
	asr.w	#1,d1
	move.w	d1,(yc1).w
	bset	#2,(sflags2).w
	bset	#6,(sflags).w
	moveq	#2,d1
	move.w	(a3),d0
	cmp.w	(a2),d0
	blt.w	.1
	eori.w	#7,d1
.1
	move.w	d1,facedir(a3)
	eori.w	#7,d1
	move.w	d1,facedir(a2)
	move.l	a3,-(sp)
	bsr.w	startfight
	exg	a2,a3
	bsr.w	startfight
	movea.w	#(SortCords-M68K_RAM),a3
	move.l	#$15,d0
	moveq	#$B,d1
.2
	btst	#0,pflags2(a3)
	bne.w	.3
	tst.w	position(a3)	;check if goalie
	beq.w	.3
	btst	#2,pflags2(a3)
	bne.w	.3
	movem.w	d0,-(sp)
	move.w	assnum(a3),d0
	cmpi.b	#$D,asslist(a3,d0.w)
	movem.w	(sp)+,d0
	beq.w	.3
	jsr	(assinsert).l
.3
	adda.w	#$80,a3
	dbf	d1,.2
	movea.w	#(puckx-M68K_RAM),a3
	bset	#0,pflags2(a3)
	move.l	#$1A,d0
	jsr	(assinsert).l
	st	(collflag).w
	movea.l	(sp)+,a3
.4
	movem.l	(sp)+,d0-d4/a0-a3
.5
	rts
