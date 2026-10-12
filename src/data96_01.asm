;	The playoff seeding, the cold start (Begin), the start of a game and of a period, the game loop and its
;	frame updates, the demo and the pause menu, the roster attribute columns, and the season schedule.

TeamBlockPtrs	;The setup team block bitmap of each team, a long pointer per team (DrawSetupTeamBlock)
	dc.l	$148054,$148502,$148970,$148DDE
	dc.l	$14928C,$14973A,$149BA8,$14A016
	dc.l	$14A4E4,$14A952,$14AE20,$14B2EE
	dc.l	$14B7BC,$14BC8A,$14C158,$14C626
	dc.l	$14CAD4,$14CFA2,$14D470,$14D8DE
	dc.l	$14DD6C,$14E1DA,$14E6A8,$14EB56
	dc.l	$14F024,$14F4F2,$14F024,$14F024

TeamLogoPtrs	;The team logo bitmap of each team, a long pointer per team (sub_12BB2)
	dc.l	$14F9A0,$150A8E,$151B1C,$152BEA
	dc.l	$153CD8,$154DE6,$155ED4,$156FA2
	dc.l	$1580B0,$15919E,$15A2AC,$15B3DA
	dc.l	$15C508,$15D636,$15E764,$15F872
	dc.l	$160980,$161AAE,$162BDC,$163CAA
	dc.l	$164DB8,$165EA6,$166FB4,$1680A2
	dc.l	$1691D0,$16A2FE,$153CD8,$153CD8

unk_12CDE	;A long pointer per team (read by sub_1E8544)
	dc.l	$16BAAC,$16BDEC,$16B78C,$16C14C
	dc.l	$16C52C,$16C8CC,$16CBAC,$16CEEC
	dc.l	$16B40C,$16D2CC,$16D56C,$16D86C
	dc.l	$16DBAC,$16DF4C,$16E26C,$16E64C
	dc.l	$16E9CC,$16ECEC,$16F00C,$16F32C
	dc.l	$16F6AC,$16FA0C,$16FDEC,$1700EC
	dc.l	$17040C,$17074C

unk_12D46	;The vertical blank handler sub_11BF8 sets (vbint).
	;Code the listing does not decode: kept as bytes
	dc.b	$48,$E7,$FF,$FE,$08,$38,$00,$02,$BF,$B2,$66,$00,$00,$18,$08,$B8
	dc.b	$00,$00,$BF,$B2,$67,$00,$00,$08,$4E,$B9,$00,$02,$03,$1C,$4E,$B9
	dc.b	$00,$01,$AF,$D6,$52,$78,$B0,$52,$61,$00,$F8,$AC,$4E,$B9,$00,$02
	dc.b	$44,$86,$4C,$DF,$7F,$FF,$4E,$73,$23,$FC,$00,$01,$31,$3A,$FF,$FF
	dc.b	$D0,$02,$4A,$78,$DD,$7E,$66,$00,$00,$0C,$23,$FC,$00,$01,$30,$76
	dc.b	$FF,$FF,$D0,$02,$08,$38,$00,$00,$DD,$80,$67,$00,$00,$24,$08,$38
	dc.b	$00,$02,$DD,$80,$67,$00,$00,$10,$23,$FC,$00,$01,$32,$12,$FF,$FF
	dc.b	$D0,$02,$60,$00,$00,$0C,$23,$FC,$00,$01,$32,$D6,$FF,$FF,$D0,$02
	dc.b	$08,$38,$00,$01,$DD,$80,$67,$00,$00,$0C,$23,$FC,$00,$01,$2E,$A2
	dc.b	$FF,$FF,$D0,$02,$42,$78,$CF,$FE,$42,$78,$D0,$00,$31,$FC,$00,$17
	dc.b	$B0,$3C,$31,$FC,$00,$07,$B0,$3E,$4E,$75,$31,$FC,$00,$06,$D0,$0A
	dc.b	$23,$FC,$00,$01,$31,$3A,$FF,$FF,$D0,$02,$4A,$78,$DD,$7E,$66,$00
	dc.b	$00,$0C,$23,$FC,$00,$01,$30,$76,$FF,$FF,$D0,$02,$08,$38,$00,$02
	dc.b	$DD,$80,$67,$00,$00,$24,$23,$FC,$00,$01,$32,$12,$FF,$FF,$D0,$02
	dc.b	$08,$38,$00,$01,$DD,$80,$67,$00,$00,$10,$23,$FC,$00,$01,$2E,$A2
	dc.b	$FF,$FF,$D0,$02,$60,$00,$00,$5E,$30,$39,$FF,$FF,$27,$22,$B0,$38
	dc.b	$DD,$85,$67,$00,$00,$32,$6E,$00,$00,$24,$23,$FC,$00,$01,$2E,$A2
	dc.b	$FF,$FF,$D0,$02,$08,$38,$00,$02,$DD,$80,$67,$00,$00,$1A,$23,$FC
	dc.b	$00,$01,$2F,$3E,$FF,$FF,$D0,$02,$60,$00,$00,$0C,$23,$FC,$00,$01
	dc.b	$2F,$C6,$FF,$FF,$D0,$02,$08,$38,$00,$00,$DD,$80,$67,$00,$00,$16
	dc.b	$08,$38,$00,$02,$DD,$80,$66,$00,$00,$0C,$23,$FC,$00,$01,$32,$D6
	dc.b	$FF,$FF,$D0,$02,$4E,$B9,$00,$01,$43,$FE,$4E,$75,$00,$06,$FE,$07
	dc.b	$F9,$00,$00,$06,$FE,$07,$F9,$01,$00,$10,$4E,$48,$4C,$20,$53,$54
	dc.b	$41,$4E,$44,$49,$4E,$47,$53,$20,$00,$01,$35,$02,$00,$10,$54,$45
	dc.b	$41,$4D,$20,$52,$4F,$53,$54,$45,$52,$20,$20,$20,$00,$01,$35,$0E
	dc.b	$00,$10,$50,$4C,$41,$59,$45,$52,$20,$53,$54,$41,$54,$53,$20,$20
	dc.b	$00,$01,$35,$3E,$00,$10,$4C,$45,$41,$47,$55,$45,$20,$4C,$45,$41
	dc.b	$44,$45,$52,$53,$00,$01,$35,$26,$00,$10,$54,$52,$41,$4E,$53,$41
	dc.b	$43,$54,$49,$4F,$4E,$53,$20,$20,$00,$01,$35,$4A,$00,$10,$47,$41
	dc.b	$4D,$45,$20,$4F,$50,$54,$49,$4F,$4E,$53,$20,$20,$00,$01,$35,$1A
	dc.b	$00,$10,$45,$58,$49,$54,$20,$53,$45,$41,$53,$4F,$4E,$20,$20,$20
	dc.b	$00,$01,$34,$BE,$00,$04,$FF,$00,$00,$06,$FE,$07,$F9,$00,$00,$06
	dc.b	$FE,$07,$F9,$01,$00,$10,$4E,$48,$4C,$20,$53,$54,$41,$4E,$44,$49
	dc.b	$4E,$47,$53,$20,$00,$01,$35,$02,$00,$10,$54,$45,$41,$4D,$20,$52
	dc.b	$4F,$53,$54,$45,$52,$20,$20,$20,$00,$01,$35,$0E,$00,$10,$50,$4C
	dc.b	$41,$59,$45,$52,$20,$53,$54,$41,$54,$53,$20,$20,$00,$01,$35,$3E
	dc.b	$00,$10,$4C,$45,$41,$47,$55,$45,$20,$4C,$45,$41,$44,$45,$52,$53
	dc.b	$00,$01,$35,$26,$00,$10,$47,$41,$4D,$45,$20,$4F,$50,$54,$49,$4F
	dc.b	$4E,$53,$20,$20,$00,$01,$35,$1A,$00,$10,$45,$58,$49,$54,$20,$53
	dc.b	$45,$41,$53,$4F,$4E,$20,$20,$20,$00,$01,$34,$BE,$00,$04,$FF,$00
	dc.b	$00,$06,$FE,$07,$F9,$00,$00,$06,$FE,$07,$F9,$01,$00,$10,$53,$49
	dc.b	$4D,$55,$4C,$41,$54,$45,$20,$47,$41,$4D,$45,$20,$00,$01,$33,$FE
	dc.b	$00,$10,$4E,$48,$4C,$20,$53,$54,$41,$4E,$44,$49,$4E,$47,$53,$20
	dc.b	$00,$01,$35,$02,$00,$10,$54,$45,$41,$4D,$20,$52,$4F,$53,$54,$45
	dc.b	$52,$20,$20,$20,$00,$01,$35,$0E,$00,$10,$50,$4C,$41,$59,$45,$52
	dc.b	$20,$53,$54,$41,$54,$53,$20,$20,$00,$01,$35,$3E,$00,$10,$4C,$45
	dc.b	$41,$47,$55,$45,$20,$4C,$45,$41,$44,$45,$52,$53,$00,$01,$35,$26
	dc.b	$00,$10,$54,$52,$41,$4E,$53,$41,$43,$54,$49,$4F,$4E,$53,$20,$20
	dc.b	$00,$01,$35,$4A,$00,$10,$47,$41,$4D,$45,$20,$4F,$50,$54,$49,$4F
	dc.b	$4E,$53,$20,$20,$00,$01,$35,$1A,$00,$10,$45,$58,$49,$54,$20,$53
	dc.b	$45,$41,$53,$4F,$4E,$20,$20,$20,$00,$01,$34,$BE,$00,$04,$FF,$00
	dc.b	$00,$06,$FE,$07,$F9,$00,$00,$06,$FE,$07,$F9,$01,$00,$10,$50,$4C
	dc.b	$41,$59,$20,$47,$41,$4D,$45,$20,$20,$20,$20,$20,$00,$01,$33,$E4
	dc.b	$00,$10,$53,$49,$4D,$55,$4C,$41,$54,$45,$20,$47,$41,$4D,$45,$20
	dc.b	$00,$01,$33,$FE,$00,$10,$4E,$48,$4C,$20,$53,$54,$41,$4E,$44,$49
	dc.b	$4E,$47,$53,$20,$00,$01,$35,$02,$00,$10,$54,$45,$41,$4D,$20,$52
	dc.b	$4F,$53,$54,$45,$52,$20,$20,$20,$00,$01,$35,$0E,$00,$10,$50,$4C
	dc.b	$41,$59,$45,$52,$20,$53,$54,$41,$54,$53,$20,$20,$00,$01,$35,$3E
	dc.b	$00,$10,$4C,$45,$41,$47,$55,$45,$20,$4C,$45,$41,$44,$45,$52,$53
	dc.b	$00,$01,$35,$26,$00,$10,$54,$52,$41,$4E,$53,$41,$43,$54,$49,$4F
	dc.b	$4E,$53,$20,$20,$00,$01,$35,$4A,$00,$10,$47,$41,$4D,$45,$20,$4F
	dc.b	$50,$54,$49,$4F,$4E,$53,$20,$20,$00,$01,$35,$1A,$00,$10,$45,$58
	dc.b	$49,$54,$20,$53,$45,$41,$53,$4F,$4E,$20,$20,$20,$00,$01,$34,$BE
	dc.b	$00,$04,$FF,$00,$00,$06,$FE,$07,$F9,$00,$00,$06,$FE,$07,$F9,$01
	dc.b	$00,$10,$50,$4C,$41,$59,$20,$47,$41,$4D,$45,$20,$20,$20,$20,$20
	dc.b	$00,$01,$33,$E4,$00,$10,$53,$49,$4D,$55,$4C,$41,$54,$45,$20,$47
	dc.b	$41,$4D,$45,$20,$00,$01,$33,$FE,$00,$10,$4E,$48,$4C,$20,$53,$54
	dc.b	$41,$4E,$44,$49,$4E,$47,$53,$20,$00,$01,$35,$02,$00,$10,$54,$45
	dc.b	$41,$4D,$20,$52,$4F,$53,$54,$45,$52,$20,$20,$20,$00,$01,$35,$0E
	dc.b	$00,$10,$50,$4C,$41,$59,$45,$52,$20,$53,$54,$41,$54,$53,$20,$20
	dc.b	$00,$01,$35,$3E,$00,$10,$4C,$45,$41,$47,$55,$45,$20,$4C,$45,$41
	dc.b	$44,$45,$52,$53,$00,$01,$35,$26,$00,$10,$54,$52,$41,$4E,$53,$41
	dc.b	$43,$54,$49,$4F,$4E,$53,$20,$20,$00,$01,$35,$4A,$00,$10,$45,$4E
	dc.b	$44,$20,$53,$45,$41,$53,$4F,$4E,$20,$4E,$4F,$57,$00,$01,$34,$CC
	dc.b	$00,$10,$47,$41,$4D,$45,$20,$4F,$50,$54,$49,$4F,$4E,$53,$20,$20
	dc.b	$00,$01,$35,$1A,$00,$10,$45,$58,$49,$54,$20,$53,$45,$41,$53,$4F
	dc.b	$4E,$20,$20,$20,$00,$01,$34,$BE,$00,$04,$FF,$00,$00,$06,$FE,$07
	dc.b	$F9,$00,$00,$06,$FE,$07,$F9,$01,$00,$10,$50,$4C,$41,$59,$20,$47
	dc.b	$41,$4D,$45,$20,$20,$20,$20,$20,$00,$01,$33,$E4,$00,$10,$53,$49
	dc.b	$4D,$55,$4C,$41,$54,$45,$20,$47,$41,$4D,$45,$20,$00,$01,$33,$FE
	dc.b	$00,$10,$4E,$48,$4C,$20,$53,$54,$41,$4E,$44,$49,$4E,$47,$53,$20
	dc.b	$00,$01,$35,$02,$00,$10,$54,$45,$41,$4D,$20,$52,$4F,$53,$54,$45
	dc.b	$52,$20,$20,$20,$00,$01,$35,$0E,$00,$10,$50,$4C,$41,$59,$45,$52
	dc.b	$20,$53,$54,$41,$54,$53,$20,$20,$00,$01,$35,$3E,$00,$10,$4C,$45
	dc.b	$41,$47,$55,$45,$20,$4C,$45,$41,$44,$45,$52,$53,$00,$01,$35,$26
	dc.b	$00,$10,$47,$41,$4D,$45,$20,$4F,$50,$54,$49,$4F,$4E,$53,$20,$20
	dc.b	$00,$01,$35,$1A,$00,$10,$50,$4C,$41,$59,$4F,$46,$46,$20,$54,$52
	dc.b	$45,$45,$20,$20,$00,$01,$35,$32,$00,$10,$45,$58,$49,$54,$20,$53
	dc.b	$45,$41,$53,$4F,$4E,$20,$20,$20,$00,$01,$34,$BE,$00,$04,$FF,$00
	dc.b	$00,$06,$FE,$07,$F9,$00,$00,$06,$FE,$07,$F9,$01,$00,$10,$42,$45
	dc.b	$47,$49,$4E,$20,$50,$4C,$41,$59,$4F,$46,$46,$53,$00,$01,$33,$54
	dc.b	$00,$10,$4E,$48,$4C,$20,$53,$54,$41,$4E,$44,$49,$4E,$47,$53,$20
	dc.b	$00,$01,$35,$02,$00,$10,$50,$4C,$41,$59,$45,$52,$20,$53,$54,$41
	dc.b	$54,$53,$20,$20,$00,$01,$35,$3E,$00,$10,$4C,$45,$41,$47,$55,$45
	dc.b	$20,$4C,$45,$41,$44,$45,$52,$53,$00,$01,$35,$26,$00,$10,$45,$58
	dc.b	$49,$54,$20,$53,$45,$41,$53,$4F,$4E,$20,$20,$20,$00,$01,$34,$BE
	dc.b	$00,$04,$FF,$00,$21,$FC,$00,$01,$22,$A4,$DD,$AC,$4E,$75,$4E,$B9
	dc.b	$00,$01,$BA,$2E,$00,$08,$FF,$01,$FD,$15,$FC,$07,$30,$3C,$00,$10
	dc.b	$32,$3C,$00,$06,$34,$3C,$07,$FF,$00,$42,$80,$00,$4E,$B9,$00,$01
	dc.b	$B9,$76,$4E,$B9,$00,$01,$BA,$2E,$00,$66,$FE,$07,$F9,$00,$FD,$15
	dc.b	$FC,$07,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$FD,$15
	dc.b	$FA,$01,$20,$20,$50,$4C,$45,$41,$53,$45,$20,$57,$41,$49,$54,$20
	dc.b	$20,$20,$FD,$15,$FA,$02,$3C,$3C,$3C,$3C,$3C,$3C,$4E,$4F,$54,$45
	dc.b	$3C,$3C,$3C,$3C,$3C,$3C,$FD,$15,$FA,$01,$52,$45,$53,$45,$54,$20
	dc.b	$57,$49,$4C,$4C,$20,$43,$41,$55,$53,$45,$FD,$15,$FA,$01,$44,$41
	dc.b	$54,$41,$20,$43,$4F,$52,$52,$55,$50,$54,$49,$4F,$4E,$20,$42,$78
	dc.b	$DD,$B0,$4E,$B9,$00,$01,$14,$9E,$4E,$B9,$00,$01,$14,$B8,$21,$FC
	dc.b	$00,$00,$07,$72,$DD,$AC,$4E,$75,$30,$39,$FF,$FF,$27,$22,$E7,$40
	dc.b	$20,$7C,$FF,$FF,$27,$26,$30,$30,$00,$02,$90,$78,$DD,$7E,$52,$40
	dc.b	$31,$C0,$DD,$B0,$4E,$B9,$00,$01,$BA,$2E,$00,$08,$FF,$01,$FD,$15
	dc.b	$FC,$07,$30,$3C,$00,$10,$32,$3C,$00,$06,$34,$3C,$07,$FF,$00,$42
	dc.b	$80,$00,$4E,$B9,$00,$01,$B9,$76,$4E,$B9,$00,$01,$BA,$2E,$00,$6A
	dc.b	$FE,$07,$F9,$00,$FD,$15,$FC,$07,$47,$41,$4D,$45,$20,$53,$49,$4D
	dc.b	$55,$4C,$41,$54,$49,$4F,$4E,$20,$FD,$15,$FA,$01,$20,$20,$50,$4C
	dc.b	$45,$41,$53,$45,$20,$57,$41,$49,$54,$20,$20,$20,$FD,$15,$FA,$02
	dc.b	$3C,$3C,$3C,$3C,$3C,$3C,$4E,$4F,$54,$45,$3C,$3C,$3C,$3C,$3C,$3C
	dc.b	$FD,$15,$FA,$01,$52,$45,$53,$45,$54,$20,$57,$49,$4C,$4C,$20,$43
	dc.b	$41,$55,$53,$45,$FD,$15,$FA,$01,$44,$41,$54,$41,$20,$43,$4F,$52
	dc.b	$52,$55,$50,$54,$49,$4F,$4E,$20,$08,$B8,$00,$05,$C3,$56,$21,$FC
	dc.b	$00,$00,$07,$72,$DD,$AC,$4E,$75,$08,$B8,$00,$07,$C3,$50,$4E,$F9
	dc.b	$00,$02,$17,$4A,$4E,$75,$08,$F8,$00,$00,$DD,$80,$08,$F8,$00,$00
	dc.b	$DD,$80,$08,$B8,$00,$01,$DD,$80,$08,$B8,$00,$02,$DD,$80,$61,$00
	dc.b	$DF,$98,$42,$78,$DD,$B0,$08,$B8,$00,$06,$C3,$50,$4E,$B9,$00,$02
	dc.b	$41,$AA,$21,$FC,$00,$00,$07,$72,$DD,$AC,$4E,$75,$23,$FC,$00,$1D
	dc.b	$99,$FA,$FF,$FF,$DD,$AC,$4E,$75,$23,$FC,$00,$1E,$2E,$FC,$FF,$FF
	dc.b	$DD,$AC,$4E,$75,$23,$FC,$00,$1D,$A0,$50,$FF,$FF,$DD,$AC,$4E,$75
	dc.b	$23,$FC,$00,$1D,$A7,$22,$FF,$FF,$DD,$AC,$4E,$75,$23,$FC,$00,$1E
	dc.b	$70,$0A,$FF,$FF,$DD,$AC,$4E,$75,$23,$FC,$00,$1D,$B0,$20,$FF,$FF
	dc.b	$DD,$AC,$4E,$75,$23,$FC,$00,$1D,$BB,$B2,$FF,$FF,$DD,$AC,$4E,$75

nullsub_2
	rts

SeasonSchedule	;The season schedule (sub_1116A, sub_11226): a day count, then a Day record per day,
	;the number of games and two team numbers per game
	dc.b	191	;days
	Day	CHI,PIT,  WPG,OTW,  BOS,MTL,  BUF,QUE,  TB,NYI,  NYR,NJ,  HFD,PHI,  WSH,TOR,  STL,DET,  ANH,DAL,  VAN,CGY,  LA,SJ
	Day	STL,CHI,  VAN,EDM
	Day	BOS,OTW,  PIT,NYR
	Day	QUE,TB,  PHI,FLA,  HFD,TOR,  CGY,DAL
	Day	BUF,PIT,  WSH,OTW,  MTL,WPG,  ANH,EDM,  SJ,VAN,  DET,LA
	Day	QUE,BOS,  PHI,NYR,  NJ,CHI,  STL,FLA
	Day	MTL,BUF,  OTW,NYI,  PIT,WSH,  STL,TB,  EDM,WPG,  ANH,VAN,  DET,SJ
	Day	TOR,BOS,  QUE,HFD,  BUF,MTL,  OTW,NJ,  TB,PHI,  NYI,WSH,  NYR,FLA,  CHI,DAL,  CGY,LA
	Day	EDM,CHI,  VAN,SJ,  CGY,ANH
	Day	FLA,BOS,  TOR,BUF
	Day	PIT,QUE,  TB,NYR,  OTW,TOR,  CHI,STL,  WPG,DAL,  SJ,LA
	Day	FLA,HFD,  WSH,PIT,  NYI,MTL,  PHI,NJ,  BUF,DET,  CGY,EDM,  BOS,SJ,  VAN,ANH
	Day	QUE,TOR,  WPG,CHI,  NYR,STL,  VAN,LA
	Day	HFD,BUF,  MTL,WSH,  FLA,DET,  PHI,WPG,  SJ,CGY,  BOS,ANH
	Day	NYR,HFD,  MTL,PIT,  CHI,QUE,  DET,NYI,  BUF,WSH,  NJ,TB,  STL,TOR,  OTW,DAL,  EDM,VAN,  BOS,LA
	Day	NJ,FLA,  TB,STL,  SJ,WPG,  PHI,CGY
	Day	CHI,MTL,  DAL,DET,  PHI,VAN,  EDM,ANH
	Day	NYR,QUE,  LA,NYI,  PIT,TB,  SJ,STL,  WPG,CGY
	Day	OTW,HFD,  WSH,NJ,  TOR,FLA,  MTL,DET,  DAL,WPG,  ANH,EDM,  BOS,VAN
	Day	LA,NYR,  QUE,PHI,  TOR,TB,  SJ,CHI,  ANH,CGY
	Day	FLA,BUF,  HFD,WSH,  PIT,DET,  VAN,DAL,  BOS,EDM
	Day	WSH,HFD,  LA,PIT,  NYR,MTL,  DET,QUE,  FLA,NYI,  SJ,NJ,  OTW,PHI,  TOR,STL,  CHI,WPG,  BOS,CGY
	Day	QUE,BUF,  TB,OTW,  SJ,NYR,  LA,CHI,  VAN,STL,  EDM,DAL,  ANH,WPG
	Day	NJ,MTL,  CGY,TOR
	Day	DAL,PIT,  EDM,QUE,  VAN,NYI,  LA,FLA,  ANH,DET,  WSH,STL
	Day	PIT,OTW,  EDM,MTL,  DAL,NYR,  CGY,NJ,  LA,TB
	Day	MTL,BOS,  QUE,HFD,  VAN,PHI,  BUF,FLA,  ANH,CHI,  WSH,WPG
	Day	CGY,NYR,  EDM,TOR,  LA,DET
	Day	BUF,BOS,  WPG,HFD,  DET,OTW,  PIT,MTL,  DAL,QUE,  CGY,NYI,  VAN,NJ,  TOR,PHI,  STL,SJ
	Day	VAN,NYR,  WPG,NJ,  TB,CHI,  WSH,EDM,  STL,ANH
	Day
	Day	OTW,PIT,  TB,QUE,  HFD,DET,  NYI,DAL,  WSH,CGY,  NJ,SJ,  NYR,LA
	Day	CHI,BUF,  PHI,OTW,  TB,MTL,  NYI,STL,  TOR,WPG,  FLA,EDM,  WSH,VAN,  NYR,ANH
	Day	PIT,BOS
	Day	PHI,BUF,  TOR,DET,  WPG,DAL,  EDM,CGY,  LA,VAN,  NJ,ANH
	Day	CHI,BOS,  HFD,PIT,  MTL,OTW,  BUF,PHI,  QUE,WSH,  NYI,TB,  DET,TOR,  WPG,STL,  FLA,VAN,  NYR,SJ
	Day	DAL,CHI,  FLA,CGY,  NJ,LA
	Day	BOS,OTW,  DAL,NYI,  SJ,VAN
	Day	MTL,HFD,  NJ,PIT,  TB,BUF,  PHI,QUE,  EDM,WSH,  WPG,DET,  STL,CGY,  VAN,SJ,  ANH,LA
	Day	HFD,NYR,  NYI,FLA,  TB,TOR
	Day	QUE,BOS,  OTW,BUF,  MTL,NJ,  WSH,PHI,  TOR,CHI,  PIT,DAL,  STL,WPG,  ANH,SJ,  CGY,LA
	Day	NYI,NYR,  EDM,FLA,  VAN,ANH
	Day	OTW,QUE,  HFD,NYI,  BOS,NJ,  PHI,WSH,  EDM,TB,  MTL,TOR,  PIT,STL,  DET,DAL,  CHI,WPG,  BUF,SJ,  VAN,LA
	Day	HFD,OTW,  NJ,QUE,  WSH,NYR,  DAL,PHI,  BOS,FLA,  STL,CHI,  CGY,ANH
	Day	EDM,WPG
	Day	DAL,WSH,  CGY,SJ,  CHI,LA,  BUF,ANH
	Day	STL,HFD,  PIT,OTW,  NYI,MTL,  DAL,NJ,  DET,TB,  WPG,TOR,  VAN,EDM
	Day	STL,BOS,  OTW,PIT,  MTL,QUE,  NYR,PHI,  DET,FLA,  ANH,VAN,  BUF,LA
	Day	NYI,NJ,  TOR,WSH,  WPG,TB,  SJ,DAL,  CGY,EDM
	Day	WSH,BOS,  NYI,HFD,  NYR,OTW,  QUE,MTL,  PIT,PHI,  NJ,TB,  WPG,FLA,  STL,TOR,  CGY,VAN
	Day	DET,PHI,  SJ,EDM,  CHI,ANH
	Day	PIT,BOS,  HFD,MTL,  FLA,QUE,  VAN,TOR,  BUF,DAL
	Day	LA,CGY,  CHI,SJ
	Day	PHI,HFD,  NYR,PIT,  BOS,BUF,  NJ,OTW,  FLA,MTL,  TB,NYI,  VAN,WSH,  STL,DET,  QUE,DAL,  TOR,WPG,  LA,EDM,  SJ,ANH
	Day	QUE,STL,  CHI,CGY
	Day	ANH,BOS,  VAN,BUF,  NJ,PHI,  PIT,WSH,  NYR,WPG,  CHI,EDM
	Day	ANH,HFD,  SJ,PIT,  FLA,OTW,  LA,MTL,  WSH,QUE,  TOR,NYI,  TB,PHI,  NJ,DET,  STL,DAL,  CGY,EDM
	Day	VAN,BOS,  TB,HFD,  NYI,BUF,  FLA,NYR
	Day	LA,OTW,  WSH,MTL,  SJ,DET,  WPG,STL,  TOR,DAL
	Day	NYR,HFD,  ANH,PIT,  LA,QUE,  BOS,NYI
	Day	WSH,OTW,  BUF,NYR,  FLA,TB,  ANH,TOR,  PHI,DET,  MTL,STL,  WPG,EDM
	Day	HFD,BOS,  WSH,PIT,  QUE,NJ,  NYI,PHI,  SJ,FLA,  MTL,CHI
	Day	LA,BUF,  ANH,NYR,  SJ,TB,  CGY,DET,  DAL,VAN
	Day	BOS,PIT,  PHI,OTW,  DET,MTL,  HFD,QUE,  BUF,NYI,  EDM,NJ,  TB,WSH,  CHI,FLA,  LA,TOR,  WPG,VAN
	Day	BOS,HFD,  CGY,OTW,  EDM,NYR,  ANH,CHI,  NJ,STL
	Day	TB,FLA,  SJ,DAL
	Day	NYR,PIT,  CGY,QUE,  EDM,NYI,  BOS,DET,  TOR,VAN
	Day	DET,HFD,  PIT,BUF,  CGY,MTL,  OTW,TB,  STL,DAL,  NJ,WPG,  TOR,SJ,  WSH,ANH
	Day	EDM,BOS,  NYI,NYR,  MTL,PHI,  OTW,FLA,  VAN,CHI,  WSH,LA
	Day	HFD,BUF,  DET,NJ,  QUE,TB,  CHI,DAL,  ANH,SJ
	Day	CGY,BOS,  EDM,HFD,  BUF,PIT,  PHI,MTL,  OTW,NYI,  QUE,FLA,  DAL,STL,  VAN,WPG,  WSH,SJ,  TOR,LA
	Day	NJ,PHI,  FLA,CHI,  DET,STL,  TOR,ANH
	Day	CGY,HFD,  LA,VAN
	Day	NJ,OTW,  FLA,QUE,  NYR,NYI,  WPG,WSH,  DAL,DET,  TOR,EDM,  PIT,ANH
	Day	OTW,HFD,  BOS,MTL,  BUF,TB,  NYR,VAN,  DAL,CHI,  NYI,SJ
	Day	FLA,NJ,  WPG,PHI,  QUE,DET,  TOR,CGY,  PIT,LA
	Day	MTL,BUF,  BOS,WSH,  CHI,TB,  STL,VAN,  SJ,ANH
	Day	BUF,BOS,  WSH,HFD,  OTW,MTL,  PHI,QUE,  FLA,TOR,  WPG,DET,  NJ,DAL,  NYR,EDM,  PIT,SJ,  NYI,LA
	Day	TB,QUE,  DET,WPG,  NYR,CGY,  PHI,CHI,  STL,EDM,  NYI,ANH
	Day	BUF,OTW,  TB,MTL,  DAL,TOR
	Day	DET,PIT,  HFD,NJ,  WSH,FLA,  NYI,CHI,  STL,CGY,  EDM,SJ
	Day	DAL,HFD,  TB,OTW,  QUE,PHI,  BUF,MTL,  BOS,NYR,  CHI,TOR,  ANH,WPG,  VAN,SJ
	Day	DAL,BOS,  PIT,FLA,  ANH,CGY,  EDM,LA
	Day	HFD,BUF,  QUE,NYI,  MTL,NYR,  OTW,NJ,  PHI,WSH,  PIT,TB,  CHI,DET,  VAN,STL
	Day
	Day
	Day	HFD,BOS,  WSH,NYI,  OTW,NYR,  BUF,NJ,  PHI,TB,  DET,CHI,  STL,DAL,  LA,ANH
	Day	NJ,BUF,  TOR,QUE,  NYR,WSH,  PHI,FLA,  CHI,STL,  CGY,WPG,  SJ,EDM,  MTL,VAN
	Day	PIT,HFD,  NYI,OTW,  DAL,DET,  ANH,LA
	Day	BUF,PIT,  HFD,QUE,  FLA,WSH,  DAL,TOR,  SJ,STL,  BOS,WPG,  CGY,VAN
	Day	PHI,NYI,  FLA,NJ,  NYR,TB,  MTL,EDM,  CHI,ANH
	Day	NYI,PIT,  PHI,BUF,  HFD,OTW,  BOS,TOR,  SJ,DET,  DAL,STL,  LA,WPG,  MTL,CGY,  NJ,WSH,  QUE,VAN
	Day	NYR,FLA,  SJ,CHI
	Day	TB,BOS,  OTW,TOR,  LA,DAL,  STL,WSH,  EDM,WPG,  MTL,ANH
	Day	CHI,NYI,  STL,NYR,  VAN,FLA,  CGY,DET
	Day	LA,HFD,  PIT,NJ,  VAN,TB,  MTL,SJ
	Day	PHI,BOS,  FLA,PIT,  MTL,QUE,  NYR,NYI,  CGY,CHI,  OTW,WPG
	Day	VAN,HFD,  ANH,BUF,  LA,WSH,  DAL,TB,  CHI,DET
	Day	DET,BOS,  BUF,HFD,  PHI,PIT,  TOR,OTW,  WSH,NYI,  ANH,NJ,  NYR,TB,  FLA,STL,  WPG,DAL,  QUE,EDM,  CGY,SJ
	Day	LA,CHI,  WPG,STL,  QUE,CGY
	Day	NYI,BUF,  OTW,MTL,  FLA,NYR,  PIT,NJ,  ANH,PHI,  DAL,EDM
	Day	WPG,TOR,  LA,STL,  TB,CGY
	Day	WSH,BUF,  BOS,OTW,  FLA,NYI,  PIT,NYR,  PHI,NJ,  ANH,DET,  TB,EDM,  CHI,VAN,  DAL,SJ
	Day	WPG,BOS,  MTL,QUE,  FLA,PHI,  ANH,TOR,  CHI,CGY,  STL,LA
	Day	HFD,PIT,  NYI,NJ,  WPG,DET,  BUF,CGY,  TB,VAN
	Day	NYI,PIT,  FLA,MTL,  BOS,QUE,  OTW,PHI,  NYR,WSH,  DET,TOR,  EDM,VAN,  STL,SJ,  DAL,LA
	Day	ANH,OTW,  NJ,NYR,  HFD,CHI,  TB,WPG,  BUF,EDM
	Day	WSH,BOS,  PHI,NYI,  HFD,DAL,  LA,CGY,  VAN,SJ
	Day	ANH,QUE,  DET,NYR,  NJ,FLA,  CHI,TOR,  STL,WPG,  LA,EDM
	Day	PIT,BOS,  ANH,MTL,  QUE,NYI,  WSH,PHI,  NJ,TB,  TOR,DET,  DAL,HFD,  WPG,CGY,  BUF,VAN
	Day
	Day
	Day
	Day
	Day	PHI,PIT,  OTW,BUF,  HFD,MTL,  QUE,NYR,  TB,FLA,  EDM,CGY,  LA,SJ
	Day	WSH,QUE,  STL,NYI,  VAN,DET,  DAL,LA
	Day	OTW,HFD,  NJ,BUF,  BOS,NYR,  CGY,TB,  VAN,TOR,  EDM,CHI,  WPG,SJ,  DAL,ANH
	Day	NJ,BOS,  WSH,NYI,  HFD,PHI,  CGY,FLA,  EDM,STL,  SJ,LA
	Day	VAN,PIT,  QUE,BUF,  TB,NYR,  OTW,WSH,  TOR,CHI,  WPG,ANH
	Day	FLA,HFD,  TOR,PIT,  BUF,OTW,  NJ,MTL,  NYR,QUE,  TB,NYI,  BOS,PHI,  EDM,DET,  CGY,STL,  DAL,SJ,  WPG,LA
	Day	PHI,MTL,  CHI,WSH
	Day	FLA,BOS,  NYI,NYR,  SJ,TOR,  DET,EDM,  HFD,VAN
	Day	WSH,NJ,  CHI,PHI,  NYI,FLA,  ANH,STL,  WPG,LA
	Day	SJ,OTW,  MTL,TB,  DET,CGY,  HFD,EDM,  TOR,VAN
	Day	OTW,BOS,  CHI,NYR,  BUF,NJ,  NYI,PHI,  QUE,WSH,  MTL,FLA,  LA,STL,  TB,DAL,  PIT,WPG
	Day	HFD,CGY,  TOR,EDM,  DET,ANH
	Day	NYI,BOS,  TB,PIT,  NYR,OTW,  VAN,MTL,  SJ,QUE,  CHI,NJ,  BUF,PHI,  FLA,WSH,  DAL,STL,  HFD,WPG,  TOR,CGY,  DET,LA
	Day	NJ,QUE,  DAL,FLA,  EDM,ANH
	Day	VAN,OTW,  SJ,MTL,  WPG,NYR,  TB,DET,  EDM,LA
	Day	NYR,BOS,  FLA,PIT,  DAL,BUF,  VAN,QUE,  WPG,NYI,  PHI,TOR
	Day	SJ,HFD,  MTL,OTW,  LA,NJ,  WSH,TB,  CHI,EDM,  CGY,ANH
	Day	SJ,BOS,  QUE,PIT,  FLA,BUF,  NYR,PHI,  LA,DET,  STL,ANH,  CHI,VAN
	Day	TOR,NJ,  WSH,PHI,  HFD,TB,  CGY,DAL,  WPG,EDM
	Day	LA,BOS,  MTL,PIT,  OTW,QUE,  SJ,NYI,  NYR,TB,  HFD,FLA,  BUF,TOR,  CGY,STL,  DET,DAL,  WPG,VAN
	Day	BOS,BUF,  NJ,WSH,  PIT,FLA,  DET,STL,  ANH,EDM
	Day	HFD,MTL,  LA,PHI,  NYI,TB,  TOR,DAL,  ANH,CGY
	Day	EDM,PIT
	Day	MTL,HFD,  NYR,BUF,  STL,NJ,  TB,WSH,  NYI,FLA,  CHI,TOR,  EDM,DET,  BOS,DAL,  CGY,WPG,  OTW,SJ,  QUE,ANH
	Day	MTL,NYR,  STL,PHI,  PIT,CHI,  SJ,VAN,  QUE,LA
	Day	NYI,NJ,  BOS,TB,  BUF,FLA,  WSH,DET,  DAL,WPG,  OTW,ANH
	Day	PIT,HFD,  STL,MTL,  NJ,NYI,  EDM,PHI,  DET,WSH,  BUF,TB,  NYR,TOR,  DAL,CGY,  QUE,SJ,  OTW,LA
	Day	HFD,PIT,  BOS,FLA,  WPG,CHI,  LA,ANH
	Day	WPG,BUF,  TOR,NYR,  MTL,WSH,  NYI,DET,  EDM,STL,  DAL,CGY,  QUE,VAN,  PHI,SJ
	Day	PIT,NJ,  OTW,CHI,  ANH,LA
	Day	BOS,HFD,  NYI,BUF,  TB,DET,  TOR,STL,  VAN,WPG,  SJ,CGY,  DAL,EDM,  PHI,ANH
	Day	QUE,OTW,  TB,NJ,  MTL,FLA,  WSH,CHI,  PHI,LA
	Day	STL,PIT,  HFD,NYR,  NYI,TOR,  VAN,DAL,  DET,WPG,  ANH,SJ
	Day	BUF,HFD,  FLA,OTW,  TOR,MTL,  BOS,QUE,  PIT,NYI,  WSH,NJ,  CHI,STL,  PHI,EDM,  CGY,LA
	Day	NYR,BUF,  NJ,WSH,  DET,CHI,  TB,SJ,  VAN,ANH
	Day	FLA,MTL,  STL,TOR
	Day	QUE,BOS,  SJ,BUF,  CHI,OTW,  HFD,NYI,  FLA,NYR,  EDM,CGY,  PIT,VAN,  TB,LA
	Day	NJ,HFD,  SJ,TOR,  OTW,DET,  MTL,DAL,  VAN,EDM,  TB,ANH
	Day	NJ,BOS,  FLA,PHI,  NYI,WSH,  BUF,CHI,  QUE,WPG,  PIT,CGY,  LA,STL
	Day	PHI,NYR,  TOR,DET,  ANH,DAL,  PIT,EDM
	Day	OTW,BOS,  CHI,HFD,  BUF,QUE,  NYR,NYI,  FLA,NJ,  SJ,WSH,  CGY,TOR,  STL,WPG,  MTL,LA
	Day	BOS,HFD,  CGY,BUF,  NYI,OTW,  SJ,PHI,  ANH,FLA,  STL,CHI,  DET,EDM
	Day	PIT,QUE,  NJ,NYR,  ANH,TB,  LA,DAL,  DET,VAN
	Day	NJ,NYI,  CGY,WSH,  WPG,CHI,  OTW,STL
	Day	PHI,HFD,  WSH,MTL,  BUF,NYR,  QUE,FLA,  DAL,WPG,  EDM,SJ
	Day	QUE,PIT,  MTL,NYI,  CGY,PHI,  BOS,TB,  LA,TOR,  CHI,OTW,  HFD,STL,  EDM,VAN,  DET,ANH
	Day	FLA,WSH,  BUF,WPG,  DET,SJ
	Day	CGY,PIT,  NYR,MTL,  NYI,QUE,  PHI,TB,  NJ,TOR,  LA,WPG,  OTW,VAN,  ANH,DAL
	Day	BOS,WSH,  DET,FLA,  CGY,CHI,  BUF,STL,  OTW,EDM,  HFD,SJ
	Day	WPG,PIT,  NYR,PHI,  WSH,TB,  TOR,DAL
	Day	BUF,BOS,  QUE,NJ,  CHI,DET,  STL,EDM,  NYI,VAN,  HFD,LA
	Day	WPG,MTL,  NJ,NYR,  WSH,FLA,  PHI,DAL,  OTW,CGY,  TOR,SJ,  HFD,ANH
	Day	MTL,BOS,  TB,PIT,  DET,BUF,  WPG,QUE,  VAN,CHI,  STL,LA
	Day	VAN,DET,  SJ,CGY,  NYI,EDM,  TOR,ANH
	Day	BUF,BOS,  HFD,CHI,  PIT,OTW,  DAL,MTL,  TB,NJ,  NYR,WSH,  PHI,FLA,  TOR,LA
	Day	TB,BUF,  DAL,OTW,  PIT,QUE,  BOS,NJ,  SJ,WPG,  NYI,CGY,  STL,ANH
	Day	MTL,PHI,  TOR,EDM,  FLA,LA
	Day	PIT,BUF,  OTW,WSH,  NYR,DAL,  DET,CGY,  NJ,EDM,  STL,VAN,  CHI,SJ,  FLA,ANH
	Day	QUE,HFD,  BOS,MTL,  OTW,TB,  DET,WPG
	Day	PHI,NYI,  CGY,NYR,  ANH,STL,  EDM,DAL,  NJ,VAN,  FLA,SJ,  CHI,LA
	Day	MTL,PIT,  QUE,BUF,  BOS,TB,  WPG,TOR,  NJ,CGY
	Day	NYI,HFD,  BUF,MTL,  OTW,QUE,  ANH,WSH,  TOR,WPG,  DET,VAN,  SJ,LA
	Day	EDM,OTW,  ANH,NYI,  PIT,PHI,  HFD,WSH,  TB,FLA,  DAL,CHI,  BOS,STL,  VAN,CGY,  LA,SJ
	Day	MTL,TB,  EDM,TOR,  CHI,DAL
	Day	NYI,BOS,  PHI,PIT,  STL,QUE,  NYR,DET,  WPG,SJ
	Day	EDM,BUF,  STL,OTW,  WSH,TB,  HFD,FLA,  DAL,TOR,  DET,CHI,  LA,VAN,  WPG,ANH
	Day	BOS,PIT,  MTL,NYI,  QUE,NYR,  NJ,PHI
	Day	PHI,WSH,  HFD,TB,  QUE,CHI,  TOR,STL,  SJ,CGY,  LA,EDM,  ANH,VAN
	Day	NYR,BOS,  BUF,NYI,  MTL,NJ,  DET,DAL,  WPG,LA
	Day	OTW,BUF,  NYI,QUE,  BOS,PHI,  FLA,TB,  PIT,TOR,  STL,DET,  NYR,CHI,  WSH,DAL,  CGY,VAN,  SJ,ANH
	Day	MTL,OTW,  EDM,LA
	Day	PHI,BOS,  STL,BUF,  PIT,NYI,  HFD,NJ,  DAL,VAN
	Day	TOR,HFD,  NJ,PIT,  QUE,MTL,  WSH,NYR,  OTW,FLA,  CHI,WPG,  CGY,SJ,  EDM,ANH
	Day	MTL,QUE,  BOS,NYI,  TB,PHI,  TOR,CHI,  DET,STL,  VAN,LA
	Day	WSH,BUF,  OTW,NYR,  FLA,WPG,  LA,CGY,  EDM,SJ,  DAL,ANH
	Day	TB,BOS,  NJ,HFD,  QUE,OTW,  PIT,MTL,  BUF,WSH,  DET,TOR,  VAN,CGY
	Day	TB,HFD,  NYR,NJ,  BOS,CHI,  PHI,STL,  FLA,DAL,  NYI,WPG,  SJ,EDM,  LA,ANH

nullsub_3
	rts

ResolveGames	;Compute winners and losers for playoff matchups: the series wins of the games of the day (gsstruct),
	;WinBits and gamelevel when the round is over; at gamelevel 4 the final flags in dword_FFDD7E, else
	;sub_21CF4; then the save RAM write
	movem.l	d0-d7/a0-a6,-(sp)
	clr.w	(rosterscroll).w
	jsr	(sub_224E2).l
	movea.l	#gsstruct,a0
	moveq	#$10,d3
	mulu.w	d1,d3
	adda.w	d3,a0
	cmpi.w	#7,(bosgames).w
	beq.w	.notbos
.loop
	cmpi.w	#4,4(a0)
	beq.w	.b1
	cmpi.w	#4,6(a0)
	beq.w	.b1
	st	(rosterscroll).w
	clr.w	d3
	btst	#0,$E(a0)
	beq.w	.0
	eori.w	#2,d3
.0
	move.w	$A(a0),d0
	sub.w	$C(a0),d0
	bpl.w	.win
	eori.w	#2,d3
.win
	addq.w	#1,4(a0,d3.w)
.b1
	suba.w	#$10,a0
	dbf	d1,.loop
	addq.w	#1,(bosgames).w
	cmpi.w	#7,(bosgames).w
	beq.w	.1
	tst.w	(rosterscroll).w
	beq.w	.1
	bra.w	.4
.1
	clr.w	(bosgames).w
	jsr	(sub_224E2).l
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
	bra.w	.4
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
.4
	cmpi.w	#4,(gamelevel).w
	bne.w	.7
	bset	#1,(dword_FFDD7E+2).w
	movem.l	d0/a0-a1,-(sp)
	movea.l	#$FFFFDCF8,a0
	lea	2(a0),a1
	move.b	2(a1),d0
	cmp.b	3(a1),d0
	bgt.w	.5
	addq.w	#1,a1
.5
	move.b	(a1),d0
	bclr	#3,(dword_FFDD7E+2).w
	cmp.b	(dword_FFDD82+2).w,d0
	bne.w	.6
	bset	#3,(dword_FFDD7E+2).w
.6
	movem.l	(sp)+,d0/a0-a1
	bra.w	.8
.7
	jsr	(sub_21CF4).l
.8
	movea.w	#(unk_FFD296-M68K_RAM),a3
	jsr	(sub_223EA).l
	jsr	(sub_223B0).l
	bclr	#4,(sflags).w
	move.w	#$FFFF,(lastsfx).w
	move.l	#M68K_RAM,(recbpr).w
	jsr	(sub_11226).l
	movem.l	(sp)+,d0-d7/a0-a6
	rts

BeginPlayoffs	;Seed the playoffs with sflags11 bit 0 (the pairings to POPairingsTmp), SetupPlayoffs, then seed them to save RAM
	;(InitPlayoffs again); GameFlags bit 6 holds the checksum until the end
	bset	#6,(GameFlags).w
	bset	#0,(sflags11).w
	bsr.w	InitPlayoffs
	bclr	#0,(sflags11).w
	btst	#1,(sflags11).w
	bsr.w	SetupPlayoffs
	bsr.w	InitPlayoffs
	jsr	(sub_21CF4).l
	bclr	#6,(GameFlags).w
	jsr	(sub_241AA).l
	rts

InitPlayoffs	;Seed the playoffs: the two conferences (ConferenceTeams1 / 2) sorted by points (SortSeeds), the pairings
	;to save RAM SRPOPairings and SRPOSlots (BuildPOSlots). With sflags11 bit 0 the pairings go to POPairingsTmp
	;instead, and sflags11 bit 1 is set when the team in dword_FFDD82+2 is not in them
	movem.l	d0-d7/a0-a6,-(sp)
	move.w	#$B,d0
	movea.l	#AwardIds,a0
	movea.l	#ConferenceTeams1,a1
	bsr.w	CopyBytes
	move.w	#$D,d0
	movea.l	#AwardIds+$14,a0
	movea.l	#ConferenceTeams2,a1
	bsr.w	CopyBytes
	movea.l	#SeedStandings,a0
	jsr	(sub_1161E).l
	bsr.w	CalcSeedPoints
	move.w	#$C,(SeedCount).l
	movea.l	#AwardIds,a0
	bsr.w	SortSeeds
	move.w	#$E,(SeedCount).l
	movea.l	#AwardIds+$14,a0
	bsr.w	SortSeeds
	movea.l	#SaveRAM+SRPOPairings,a0
	btst	#0,(sflags11).w
	beq.w	.0
	movea.l	#POPairingsTmp,a0
.0
	movea.l	#AwardIds,a1
	bsr.w	SeedPairings
	adda.l	#$10,a0
	movea.l	#AwardIds+$14,a1
	bsr.w	SeedPairings
	btst	#0,(sflags11).w
	beq.w	.3
	bset	#1,(sflags11).w
	movea.l	#POPairingsTmp,a0
	move.b	(dword_FFDD82+2).w,d1
	move.w	#$F,d0
.1
	cmp.b	1(a0),d1
	bne.w	.2
	bclr	#1,(sflags11).w
.2
	tst.w	(a0)+
	dbf	d0,.1
	bra.w	.4
.3
	bsr.w	BuildPOSlots
	jsr	(sub_241AA).l
.4
	movem.l	(sp)+,d0-d7/a0-a6
	rts

SeedPairings	;Write the pairings of the sorted conference a1 to a0: the top team, the first team of another division
	;(TeamDivisions), then the rest in order
	movea.l	#TeamDivisions,a2
	clr.w	d0
	move.b	(a1)+,d0
	move.b	d0,3(a0)
	move.b	(a2,d0.w),d1
	clr.w	d2
.0
	move.b	(a1,d2.w),d0
	cmp.b	(a2,d0.w),d1
	bne.w	.1
	addq.w	#1,d2
	bra.s	.0
.1
	move.b	d0,$F(a0)
	move.b	d0,d1
.2
	move.b	(a1)+,d0
	cmp.b	d0,d1
	beq.s	.2
	move.b	d0,$B(a0)
.3
	move.b	(a1)+,d0
	cmp.b	d0,d1
	beq.s	.3
	move.b	d0,7(a0)
.4
	move.b	(a1)+,d0
	cmp.b	d0,d1
	beq.s	.4
	move.b	d0,5(a0)
.5
	move.b	(a1)+,d0
	cmp.b	d0,d1
	beq.s	.5
	move.b	d0,9(a0)
.6
	move.b	(a1)+,d0
	cmp.b	d0,d1
	beq.s	.6
	move.b	d0,$D(a0)
.7
	move.b	(a1)+,d0
	cmp.b	d0,d1
	beq.s	.7
	move.b	d0,1(a0)
	rts

TeamDivisions	;The division of each team (SeedPairings)
	dc.b	0,2,2,0,1,1,1,0,3,2,0,2,3,3,3,2,3,2,2,0,1,3,1,0,3,1

SortSeeds	;Bubble sort the SeedCount team bytes at a0 by SeedPoints, then SeedGames, highest first
	movea.l	#SeedPoints,a1
	movea.l	#SeedGames,a2
	move.w	d1,-(sp)
.pass
	bclr	#6,(sflags6).w
	clr.w	d7
.cmp
	clr.w	d6
	move.b	(a0,d7.w),d6
	clr.w	d0
	move.b	(a1,d6.w),d0
	move.b	1(a0,d7.w),d6
	clr.w	d1
	move.b	(a1,d6.w),d1
	cmp.w	d1,d0
	bgt.w	.next
	blt.w	.swap
	move.b	(a0,d7.w),d6
	move.b	(a2,d6.w),d0
	move.b	1(a0,d7.w),d6
	cmp.b	(a2,d6.w),d0
	bge.w	.next
.swap
	bset	#6,(sflags6).w
	move.b	(a0,d7.w),d5
	move.b	1(a0,d7.w),d4
	move.b	d5,1(a0,d7.w)
	move.b	d4,(a0,d7.w)
.next
	addq.w	#2,d7
	cmp.w	(SeedCount).l,d7
	bge.w	.4
	subq.w	#1,d7
	bra.s	.cmp
.4
	btst	#6,(sflags6).w
	bne.s	.pass
	move.w	(sp)+,d1
	rts

CalcSeedPoints	;SeedPoints = 2 * wins + ties and SeedGames = wins of the teams (SeedStandings)
	move.w	#$1A,d0
	movea.l	#SeedStandings,a1
	movea.l	#SeedPoints,a2
	movea.l	#SeedGames,a3
	clr.w	d2
	move.w	d1,-(sp)
	bra.w	.1
.0
	move.w	d2,d5
	mulu.w	#3,d5
	clr.w	d3
	move.b	(a1,d5.w),d3
	add.w	d3,d3
	clr.w	d1
	move.b	1(a1,d5.w),d1
	add.w	d1,d3
	move.b	d3,(a2,d2.w)
	clr.w	d3
	move.b	(a1,d5.w),d3
	move.b	d3,(a3,d2.w)
	addq.w	#1,d2
.1
	dbf	d0,.0
	move.w	(sp)+,d1
	rts

CopyBytes	;Copy d0 + 1 bytes from a1 to a0
	move.b	(a1)+,(a0)+
	dbf	d0,CopyBytes
	rts

ConferenceTeams1	;The teams of the first conference
	dc.b	ANH,CGY,EDM,LA,SJ,VAN,CHI,DAL,DET,STL,TOR,WPG

ConferenceTeams2	;The teams of the second conference
	dc.b	BOS,BUF,HFD,MTL,OTW,PIT,QUE,FLA,NJ,NYI,NYR,PHI,TB,WSH

SetupPlayoffs	;Start the playoffs: save the season header (SRSeasonHeaderSave) and clear it, clear save RAM blocks (sub_24208),
	;OptPlayMode 1
	movem.l	d0-d7/a0-a6,-(sp)
	bset	#6,(GameFlags).w
	move.b	(dword_FFDD7E+3).w,-(sp)
	move.b	(dword_FFDD82).w,-(sp)
	move.b	(dword_FFDD82+1).w,-(sp)
	move.b	(dword_FFDD82+2).w,-(sp)
	movea.l	#SaveRAM+SRSeasonHeader,a0
	movea.l	#SaveRAM+SRSeasonHeaderSave,a1
	move.w	#$C,d0
	subq.w	#1,d0
.save
	move.w	(a0)+,(a1)+
	dbf	d0,.save
	movea.l	#SaveRAM+SRSeasonHeader,a0
	clr.l	(a0)
	jsr	(sub_1149E).l
	bset	#2,(dword_FFDD7E+2).w
	move.b	(sp)+,(dword_FFDD82+2).w
	move.b	(sp)+,(dword_FFDD82+1).w
	move.b	(sp)+,(dword_FFDD82).w
	move.b	(sp)+,(dword_FFDD7E+3).w
	clr.b	(dword_FFDD82+3).w
	jsr	(sub_1147E).l
	move.l	#$CBF,d0
	move.w	#$54,d1
	jsr	(sub_24208).l
	move.l	#$D13,d0
	move.w	#$54,d1
	jsr	(sub_24208).l
	move.l	#$D67,d0
	move.w	#$15,d1
	jsr	(sub_24208).l
	move.l	#$D7C,d0
	move.w	#$18,d1
	jsr	(sub_24208).l
	move.l	#$89,d0
	move.l	#$6C0,d1
	jsr	(sub_24208).l
	jsr	(sub_1DFA1C).l
	moveq	#$4D,d0
	moveq	#$A,d1
	jsr	(sub_24208).l
	move.w	#1,(OptPlayMode).w
	bclr	#6,(GameFlags).w
	jsr	(sub_241AA).l
	movem.l	(sp)+,d0-d7/a0-a6
	rts

RestoreSeasonHeader	;Put back the season header saved by SetupPlayoffs. Nothing calls it.
	;Code the listing does not decode: kept as bytes
	dc.b	$48,$E7,$FF,$FE,$20,$7C,$00,$20,$00,$82,$22,$7C,$00,$20,$00,$CE
	dc.b	$30,$3C,$00,$0C,$53,$40,$30,$D9,$51,$C8,$FF,$FC,$4E,$B9,$00,$01
	dc.b	$14,$9E,$4E,$B9,$00,$02,$41,$AA,$4C,$DF,$7F,$FF,$4E,$75

GetTeamPOSlot	;d7 = the seed slot of team d7 (save RAM SRPOSlots)
	move.l	a0,-(sp)
	movea.l	#SaveRAM+SRPOSlots,a0
	add.w	d7,d7
	move.w	(a0,d7.w),d7
	ext.w	d7
	movea.l	(sp)+,a0
	rts

GetPOSlotTeam	;d7 = the team in seed slot d7 (save RAM SRPOPairings)
	move.l	a0,-(sp)
	movea.l	#SaveRAM+SRPOPairings,a0
	add.w	d7,d7
	move.w	(a0,d7.w),d7
	ext.w	d7
	movea.l	(sp)+,a0
	rts

BuildPOSlots	;Save RAM SRPOSlots from SRPOPairings: the seed slot of each team
	movem.l	d0-d7/a0-a6,-(sp)
	movea.l	#SaveRAM+SRPOPairings,a0
	movea.l	#SaveRAM+SRPOSlots,a1
	move.w	#$F,d1
.0
	move.w	d1,d0
	add.w	d0,d0
	move.w	(a0,d0.w),d2
	ext.w	d2
	add.w	d2,d2
	move.b	d1,1(a1,d2.w)
	dbf	d1,.0
	movem.l	(sp)+,d0-d7/a0-a6
	rts

PrintMenuList	;Print the shown rows of the menu list (menulist) with the scroll marks.
	;Code the listing does not decode: kept as bytes
	dc.b	$48,$E7,$FF,$FE,$26,$78,$D0,$02,$28,$4B,$D8,$D4,$42,$47,$20,$78
	dc.b	$D0,$02,$D0,$D0,$D0,$D0,$4A,$68,$00,$02,$6B,$00,$00,$0A,$52,$47
	dc.b	$D0,$D0,$58,$48,$60,$F0,$30,$38,$CF,$FE,$6A,$00,$00,$08,$42,$78
	dc.b	$CF,$FE,$42,$40,$B0,$47,$6D,$00,$00,$0A,$30,$07,$53,$40,$31,$C0
	dc.b	$CF,$FE,$32,$38,$D0,$00,$D2,$78,$D0,$0A,$B2,$78,$CF,$FE,$6E,$00
	dc.b	$00,$08,$52,$78,$D0,$00,$60,$EA,$32,$38,$D0,$00,$B2,$78,$CF,$FE
	dc.b	$6F,$00,$00,$08,$53,$78,$D0,$00,$60,$EE,$30,$38,$D0,$00,$20,$78
	dc.b	$D0,$02,$D0,$D0,$D0,$D0,$30,$38,$D0,$00,$60,$00,$00,$06,$D0,$D0
	dc.b	$58,$48,$51,$C8,$FF,$FA,$31,$F8,$B0,$3C,$B0,$40,$31,$F8,$B0,$3E
	dc.b	$B0,$42,$30,$38,$D0,$0A,$B0,$47,$6F,$00,$00,$04,$30,$07,$42,$41
	dc.b	$60,$00,$00,$3C,$34,$01,$D4,$78,$D0,$00,$22,$4B,$B4,$78,$CF,$FE
	dc.b	$66,$00,$00,$0E,$22,$4C,$2F,$08,$D0,$D0,$21,$D0,$D0,$0C,$20,$5F
	dc.b	$4E,$B9,$00,$01,$BA,$40,$22,$48,$4E,$B9,$00,$01,$BA,$40,$31,$F8
	dc.b	$B0,$3C,$B0,$40,$52,$78,$B0,$42,$D0,$D0,$58,$48,$52,$41,$51,$C8
	dc.b	$FF,$C4,$30,$38,$B0,$3C,$55,$40,$31,$C0,$B0,$40,$31,$F8,$B0,$3E
	dc.b	$B0,$42,$22,$7C,$00,$01,$45,$48,$4A,$78,$D0,$00,$67,$00,$00,$08
	dc.b	$22,$7C,$00,$01,$45,$4E,$4E,$B9,$00,$01,$BA,$40,$30,$38,$B0,$3C
	dc.b	$55,$40,$31,$C0,$B0,$40,$30,$38,$B0,$3E,$D0,$78,$D0,$0A,$53,$40
	dc.b	$31,$C0,$B0,$42,$22,$7C,$00,$01,$45,$48,$30,$38,$D0,$00,$D0,$78
	dc.b	$D0,$0A,$B0,$47,$6C,$00,$00,$08,$22,$7C,$00,$01,$45,$54,$4E,$B9
	dc.b	$00,$01,$BA,$40,$4C,$DF,$7F,$FF,$4E,$75

ScrollClearTxt	;Scroll marks for PrintMenuList
	String	$F9,$00,$20
ScrollUpTxt
	String	$F9,$00,$7B
ScrollDownTxt
	String	$F9,$00,$7D

PrintMenuList2	;Print the shown rows of the menu list (menulist): each item through its routine, the selected item
	;with the highlight
	movem.l	d0-d7/a0-a6,-(sp)
	movea.l	(menulist).w,a3
	movea.l	a3,a4
	adda.w	(a4),a4
	clr.w	d7
	movea.l	(menulist).w,a0
	adda.w	(a0),a0
	adda.w	(a0),a0
.0
	tst.l	(a0)
	bmi.w	.get
	addq.w	#1,d7
	addq.w	#4,a0
	bra.s	.0
.get
	move.w	(menuitem).w,d0
	bpl.w	.1
	clr.w	(menuitem).w
	clr.w	d0
.1
	cmp.w	d7,d0
	blt.w	.2
	move.w	d7,d0
	subq.w	#1,d0
	move.w	d0,(menuitem).w
.2
	move.w	(word_FFD000).w,d1
	add.w	(word_FFD00A).w,d1
	cmp.w	(menuitem).w,d1
	bgt.w	.3
	addq.w	#1,(word_FFD000).w
	bra.s	.2
.3
	move.w	(word_FFD000).w,d1
	cmp.w	(menuitem).w,d1
	ble.w	.4
	subq.w	#1,(word_FFD000).w
	bra.s	.3
.4
	move.w	(word_FFD000).w,d0
	movea.l	(menulist).w,a0
	adda.w	(a0),a0
	adda.w	(a0),a0
	move.w	(word_FFD000).w,d0
	bra.w	.6
.5
	addq.w	#4,a0
.6
	dbf	d0,.5
	move.w	(word_FFB03C).w,(printx).w
	move.w	(word_FFB03E).w,(printy).w
	move.w	(word_FFD00A).w,d0
	cmp.w	d7,d0
	ble.w	.7
	move.w	d7,d0
.7
	clr.w	d1
	bra.w	.10
.8
	move.w	d1,d2
	add.w	(word_FFD000).w,d2
	movea.l	a3,a1
	cmp.w	(menuitem).w,d2
	bne.w	.9
	movea.l	a4,a1
.9
	jsr	(printsmall).l
	movem.l	d0-d1/a0,-(sp)
	movea.l	(a0),a0
	jsr	(a0)
	movem.l	(sp)+,d0-d1/a0
	jsr	(printsmall).l
	move.w	(word_FFB03C).w,(printx).w
	addq.w	#2,(printy).w
	addq.w	#4,a0
	addq.w	#1,d1
.10
	dbf	d0,.8
	movem.l	(sp)+,d0-d7/a0-a6
	rts
	;The same scroll marks again; nothing reads them
	String	$F9,$00,$20
	String	$F9,$00,$7B
	String	$F9,$00,$7D

Begin	;Cold start, entered from Start. Clear RAM, init sound and menus, go to the title screen
	move	#$2700,sr	;interrupts off
	movea.w	#(Stack-M68K_RAM),sp
	movea.w	#(VSCRLPM-M68K_RAM),a0
.0
	clr.l	(a0)+
	cmpa.w	#$DDC6,a0
	blt.s	.0
	clr.w	(PALflag).w
	move.w	(VDP_CTRL).l,d0
	andi.w	#1,d0
	move.w	d0,(PalMode).w
	beq.w	.1
	bset	#0,(PALflag).w
.1
	move.w	#$FFFF,(PlayingSong).w
	move.w	#0,d0
	move.w	#$1B24,d1
	movea.l	#Z80Program,a0
	jsr	(SoundCmd).l
	move.w	#9,d0	;command 9
	jsr	(SoundCmd).l
	move.w	#6,d0	;command 6: the sound data
	clr.w	d1
	movea.l	#SoundBanks,a0
	jsr	(SoundCmd).l
	move.w	#7,d0
	move.w	#0,d1
	jsr	(SoundCmd).l
	jsr	(SoundOff).l
	jsr	(KillCrowd).l
	jsr	(Detect4WayPlay).l
	jsr	(sub_21A4C).l
	jsr	(sub_23F1C).l
	jsr	(sub_1D9114).l
	jsr	(sub_21B82).l
	move.w	(OptLine).w,(TmpOptLine2).w
	move.w	(OptPlayMode).w,(TempOptPlayMode).w
	jsr	(orjoy).l
	jmp	Opening

StartGame	;Reset game state for a new game, then start the first period
	move.l	#vb2,(vbint).l
	clr.w	(RefStep).w
	bclr	#5,(GameFlags).w
	st	(byte_FFD474).w
	jsr	(ReadJoy1).l
	cmp.b	#$E0,d3
	bne.w	.0
	move.w	#3,(OptPerlen).w
.0
	clr.b	(gmode).w
	cmpi.w	#1,(OptPen).w
	bne.w	.1
	bset	#5,(gmode).w
.1
	cmpi.w	#1,(OptPlayMode).w
	ble.w	.2
	bsr.w	sub_14804
.2
	jsr	(sub_21482).l
	btst	#0,(gmode2).w
	beq.w	.3
	move.l	a0,-(sp)
	movea.l	#tmstruct,a0
	jsr	(Create_HotCold_Table).l
	movea.l	#AwShots,a0
	jsr	(Create_HotCold_Table).l
	movea.l	(sp)+,a0
.3
	clr.w	(ScoreSumbytes).w
	clr.w	(PenSumLength).w
	clr.w	(gsp).w
	clr.w	(ChkCnt).w
	bsr.w	restoreteams
	jsr	(stop_current_song).l	;stop the song
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
	move.b	#$E7,(VDP_PSG).l
	move.b	#$C8,(VDP_PSG).l
	move.b	#1,(VDP_PSG).l
	jsr	(sub_1D4CE).l
	jsr	(setupice).l
	jsr	(sub_1D6D22).l
	jmp	loc_2161E

sub_14804
	move.l	#$E68,d0
	moveq	#$66,d1
	jsr	(sub_24208).l
	jsr	(sub_241AA).l
	rts

restoreteams	;Both teams: no players in the penalty box, every roster player on the bench
	movea.w	#(tmstruct-M68K_RAM),a2
	bsr.w	.r
	adda.w	#$39E,a2
.r
	move.w	#6,tmap(a2)	;tmap: no players in pen. box
	moveq	#$36,d0	;(maxros-1)*2
.1
	move.w	#$FFFE,$6C(a2,d0.w)
	subq.w	#2,d0
	bpl.s	.1
	rts

ResetClock	;gameclock = PerTimeTotal = the period length (GetPeriodTime; overtime by OptPlayMode), clock stopped (gmclock)
	bsr.w	GetPeriodTime	;d0 = period length in seconds
	cmpi.w	#3,(gsp).w
	blt.w	.2
	tst.w	(OptPlayMode).w
	bne.w	.0
	move.w	#$12C,d0	;OptPlayMode 0 overtime is always 5:00
	bra.w	.2
.0
	cmpi.w	#3,(OptPlayMode).w
	bgt.w	.1
	move.w	#$4B0,d0
	bra.w	.2
.1
	btst	#7,(GameFlags).w
	beq.w	.2
	btst	#2,(dword_FFDD7E+2).w
	beq.w	.2
	move.w	#$4B0,d0
.2
	move.w	d0,(gameclock).w
	move.w	d0,(PerTimeTotal).w
	move.w	d0,(word_FFB05C).w
	asr.w	#1,d0
	jsr	(randomd0).l
	sub.w	d0,(word_FFB05C).w
	bset	#0,(gmode).w
	rts

GetPeriodTime	;Return d0 = period length in seconds for the period length option
	move.w	(OptPerlen).w,d0
	asl.w	#1,d0
	lea	.times(pc),a0
	move.w	(a0,d0.w),d0
	rts
.times
	dc.w	$12C,$258,$4B0,$1E

StartPer	;Start a period: reset stack, rink and clock, face off, run the game loop
	cmpi.w	#3,(gsp).w
	bne.w	.0
	bset	#1,(sflags7).w
	bset	#5,(GameFlags).w
.0
	st	(byte_FFD47E).w
	movea.w	#(Stack-M68K_RAM),sp
	jsr	(SoundOff).l
	jsr	(setupice).l
	bsr.w	ResetClock
	ori.l	#$F00000,(PadControlBits).w
	st	(c1playernum).w
	st	(c2playernum).w
	st	(c3playernum).w
	st	(c4playernum).w
	movea.w	#(puckx-M68K_RAM),a3
	clr.w	(fox).w
	clr.w	(foy).w
	btst	#0,(gmode2).w
	beq.w	.1
	move.w	#$1E,d0
	move.w	#8,(BA_Skater_Offset).w
	move.w	#$B,(BA_Goalie_SCnum).w
	bra.w	.ass
.1
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
	moveq	#$1B,d0
.ass
	jsr	(assreplace).l
	bset	#2,(sflags2).w
	bclr	#4,(sflags).w
	move.w	#$FFFF,(lastsfx).w
	move.l	#M68K_RAM,(recbpr).w
	move.w	(vcount).w,(oldvcount).w
	bsr.w	DoGameFrame
	move.w	#$FFFF,(palcount).w
	bsr.w	DoGameFrame
	move.w	(gamelevel).w,d0
	asl.w	#4,d0
	move.w	d0,(CwdExciteLvl).w
	clr.w	(CurCrowdMeter).w
	move.w	(HomeTeam).w,(HmTeam).w
	move.w	#0,(SongIndex).w
	jsr	(ChooseSong).l
	move.w	(SongNum).w,-(sp)
	jsr	(song).l
	cmpi.w	#2,(gsp).w
	bge.w	Gameloop
	bset	#7,(sflags3).w

Gameloop	;Main loop for game
	bsr.w	DoGameFrame
	bsr.w	demoread
	btst	#0,(sflags).w
	beq.s	Gameloop
	bsr.w	Pausemode
	bra.s	Gameloop

DoGameFrame	;Wait for at least one vblank, then run one frame of game logic
	move.w	(vcount).w,d7
	sub.w	(oldvcount).w,d7
	beq.s	DoGameFrame
	move.w	(vcount).w,(oldvcount).w
	bsr.w	DoFrameUpdates
	btst	#6,(sflags3).w
	beq.w	.0
	jsr	(sub_FD14).l
	jsr	(sub_FFD0).l
.0
	bsr.w	updateplayers
	tst.w	(songdelay).w
	beq.w	.1
	bmi.w	.1
	subq.w	#1,(songdelay).w
	bne.w	.1
	jsr	(stop_current_song).l
	move.w	(delayedsong).w,-(sp)
	jsr	(song).l
.1
	jsr	(sub_1D733C).l
	bsr.w	checkwindow
	bsr.w	updatereplay
	jmp	sub_2034A

DoFrameUpdates	;The frame updates of DoGameFrame: the new puck carrier check, the crowd, the clock, and once a second
	;(lldisp) the slower updates
	move.w	(lastpuckc).w,d0
	cmp.w	(puckc).w,d0
	beq.w	.0
	bclr	#0,(GameFlags).w
	bclr	#1,(GameFlags).w
.0
	move.w	(puckc).w,(lastpuckc).w
	tst.w	(puckc).w
	bmi.w	.1
	st	(word_FFD238).w
.1
	jsr	(PenaltyManager).l
	bsr.w	updatecrowdf
	jsr	(nullsub_6).l
	jsr	(sub_883D4).l
	bsr.w	clockcont
	btst	#7,(sflags).w
	bne.w	rtss8
	sub.w	d7,(lldisp).w
	bpl.w	rtss8
	addi.w	#$18,(lldisp).w
	bsr.w	ChkGoalies
	jsr	(sub_883AC).l
	jsr	(sub_8842E).l
	bsr.w	RestoreBenchEnergy
	bsr.w	sub_14AD4
	jmp	updatepwrplay

sub_14AD4
	subq.w	#1,(word_FFC442).w
	bne.w	rtss8
	jmp	loc_22A2C

RestoreBenchEnergy	;Unless OptLine: every bench player of both teams gets 9 energy, up to $1000
	tst.w	(OptLine).w
	bne.w	.ex
	movea.w	#(tmstruct-M68K_RAM),a2
	bsr.w	.notinprog
	lea	$39E(a2),a2
.notinprog
	moveq	#$36,d0
.b0
	cmpi.w	#$FFFE,$6C(a2,d0.w)
	bne.w	.next
	addi.w	#9,tmpde(a2,d0.w)
	cmpi.w	#$1000,tmpde(a2,d0.w)
	blt.w	.next
	move.w	#$1000,tmpde(a2,d0.w)
.next
	subq.w	#2,d0
	bpl.s	.b0
.ex
	rts

updatecrowdf	;Every game loop, d7 = elapsed frames: the crowd level falls (faster when loud); every crowdcnt frames
	;the next crowd frame
	cmpi.w	#$15E,(crowdlevel).w
	blt.w	.dec
	subq.w	#3,(crowdlevel).w
.dec
	sub.w	d7,(crowdlevel).w
	bpl.w	.1
	clr.w	(crowdlevel).w
.1
	sub.w	d7,(crowdcnt).w
	bpl.w	.2
	move.w	(crowdlevel).w,d0
	lsr.w	#1,d0
	cmp.w	#$7F,d0
	bls.w	.0
	moveq	#$7F,d0
.0
	andi.w	#$60,d0
	addq.w	#2,(crowdtblidx).w
	andi.w	#$1E,(crowdtblidx).w
	add.w	(crowdtblidx).w,d0
	movea.l	#unk_23248,a0
	move.b	(a0,d0.w),(crowdframe+1).w
	clr.w	d1
	move.b	1(a0,d0.w),d1
	move.w	(VDP_CNTR).l,d2
	and.w	d1,d2
	add.w	d2,d1
	move.w	d1,(crowdcnt).w
.2
	clr.b	(crowdframe).w
	cmpi.w	#$118,(crowdlevel).w
	bls.w	rtss8
	move.w	(VDP_CNTR).l,d0
	andi.w	#$7F,d0
	cmp.w	#$13,d0
	blt.w	rtss8
	cmp.w	#$19,d0
	bgt.w	rtss8
	move.b	d0,(crowdframe).w
	rts

clockcont	;At the end of the period clock (gameclock 0): the horn, then the end of period or game assignments
	btst	#0,(gmode).w
	bne.w	rtss8
	tst.w	(gameclock).w
	bne.w	rtss8
	bset	#3,(disflags).w
	jsr	(stop_current_song).l
	move.w	#4,-(sp)
	jsr	(sfx).l
	bsr.w	LockScroll
	movea.w	#(puckx-M68K_RAM),a3
	moveq	#$18,d0
	jsr	(assinsert).l
	cmpi.w	#2,(gsp).w
	blt.w	.1
	moveq	#7,d0
	movea.w	#(SortCords-M68K_RAM),a3
	cmpi.w	#3,(gamelevel).w
	bne.w	.t3
	cmpi.w	#7,(bosgames).w
	beq.w	.0
	moveq	#$10,d3
	mulu.w	(gamenum).w,d3
	movea.w	#(gsstruct-M68K_RAM),a0
	adda.w	d3,a0
	clr.w	d3
	btst	#0,$E(a0)
	beq.w	.nf
	eori.w	#2,d3
.nf
	move.w	(HmGoals).w,d1
	sub.w	(AwGoals).w,d1
	bpl.w	.ns1
	eori.w	#2,d3
.ns1
	cmpi.w	#3,4(a0,d3.w)
	bne.w	.t3
.0
	moveq	#8,d0
	moveq	#$B,d2
.4
	bclr	#3,$62(a3)
	adda.w	#$80,a3
	dbf	d2,.4
	movea.w	#(SortCords-M68K_RAM),a3
.t3
	moveq	#5,d2
	move.w	(HmGoals).w,d1
	sub.w	(AwGoals).w,d1
	beq.w	.1
	bpl.w	.t2
	adda.w	#$300,a3
.t2
	tst.w	$34(a3)
	ble.w	.n2
	jsr	(assinsert).l
	moveq	#7,d0
.n2
	adda.w	#$80,a3
	dbf	d2,.t2
.eog
	jsr	(ClearPenaltyBuffer).l
	addi.w	#$3E8,(crowdlevel).w
	bset	#0,(gmode).w
	bset	#6,(gmode).w
	jsr	(ClearPenalties).l
	move.w	#4,d0
	jmp	AddPenalty2
.1
	cmpi.w	#3,(gsp).w
	bne.w	.eop_ex
	tst.w	(OptPlayMode).w
	beq.s	.eog
.eop_ex
	move.w	#2,d0
	jmp	AddPenalty2

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
	jsr	(sub_1D9844).l
	movea.l	#unk_23734,a0
	lea	SetupPauseScreen(pc),a1
	btst	#0,(gmode2).w
	beq.w	.0
	movea.l	#unk_236B0,a0
	bra.w	.1
.0
	btst	#2,$30(a2)
	beq.w	.1
	movea.l	#unk_23890,a0
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
	jmp	sub_1E2688
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
	cmpa.l	#unk_1D86A4,a0
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

PlayoffStatsMenu	;Pause menu Playoff Stats: with GameFlags bit 7 set jump to loc_1DB020, else sub_1E55BC for the team struct
	;of team unk_FFCFD2 + word_FFCFCC
	btst	#7,(GameFlags).w
	beq.w	.0
	jmp	loc_1DB020
.0
	movem.l	a2,-(sp)
	jsr	(sub_225E0).l
	movea.w	#(unk_FFCFD2-M68K_RAM),a0
	move.w	(word_FFCFCC).w,d0
	move.b	(a0,d0.w),d0
	movea.w	#(tmstruct-M68K_RAM),a2
	cmp.w	$28(a2),d0
	beq.w	.1
	adda.w	#$39E,a2
.1
	moveq	#1,d7
	jsr	(sub_1E55BC).l
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
