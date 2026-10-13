;	PListPrint and its helpers (PlayerStatsList), the user name entry (NameEntryScreen, UserNameEntry), the
;	playoff tree screen (PlayoffScreen), the game clock (showclock, showclockdma), the big score and the season
;	awards screen (SeasonAwards).

PListPrint	;PlayerStatsList: print the rows of the list
	movem.l	d0-d7/a0-a6,-(sp)
	jsr	(printz).l
	String	$8F,$00,$00
	clr.w	d6
	move.w	#$B,(printy).w
.0
	clr.w	(word_FFD238).w
	tst.w	(word_FFCF42).w
	bne.w	.1
	cmpi.w	#5,(word_FFD030).w
	blt.w	.2
	move.w	#5,(word_FFD238).w
	bra.w	.2
.1
	cmpi.w	#4,(word_FFD030).w
	blt.w	.2
	move.w	#4,(word_FFD238).w
.2
	movea.l	#PListColumns,a5
	move.w	(word_FFD238).w,d0
	asl.w	#2,d0
	movea.l	(a5,d0.w),a5
	move.w	#4,(printx).w
	movea.l	#unk_1DAE32,a1
	jsr	(printcur).l
	move.w	d6,d0
	add.w	(word_FFD032).w,d0
	cmp.w	(word_FFD03A).w,d0
	blt.w	.3
	move.w	d6,d0
	add.w	(word_FFD032).w,d0
	cmp.w	(word_FFD038).w,d0
	bge.w	.20
	move.w	d0,(word_FFD038).w
	bra.w	.20
.3
	move.w	#4,(printx).w
	movea.l	#setupvalues+4,a0
	move.w	d6,d0
	add.w	(word_FFD032).w,d0
	add.w	d0,d0
	move.w	(a0,d0.w),d0
	ext.l	d0
	move.w	d0,-(sp)
	move.w	(setupvalues+2).w,d7
	btst	#2,(dword_FFDD7E+2).w
	beq.w	*+4
.4
	jsr	(FormatPlayerNameD7).l
	jsr	(printcur).l
	tst.w	(word_FFCF42).w
	bne.w	.5
	cmpi.w	#5,(word_FFD030).w
	bge.w	.8
	bra.w	.6
.5
	cmpi.w	#4,(word_FFD030).w
	bge.w	.8
.6
	move.w	(setupvalues+2).w,d7
	btst	#2,(dword_FFDD7E+2).w
	beq.w	*+4
.7
	jsr	(GetGoalieCountD7).l
	sub.w	d0,(sp)
.8
	move.w	#$11,(printx).w
	tst.w	(word_FFCF42).w
	bne.w	.9
	cmpi.w	#5,(word_FFD030).w
	blt.w	.10
	move.w	#$14,(printx).w
	bra.w	.10
.9
	move.w	#$15,(printx).w
	cmpi.w	#4,(word_FFD030).w
	blt.w	.10
	move.w	#$14,(printx).w
.10
	move.w	(sp),d0
	bsr.w	PListValue
	beq.w	.19
	move.w	#$15,(printx).w
	tst.w	(word_FFCF42).w
	bne.w	.11
	cmpi.w	#5,(word_FFD030).w
	blt.w	.12
	move.w	#$1A,(printx).w
	bra.w	.12
.11
	move.w	#$19,(printx).w
	cmpi.w	#4,(word_FFD030).w
	blt.w	.12
	move.w	#$1A,(printx).w
.12
	move.w	(sp),d0
	bsr.w	PListValue
	beq.w	.19
	move.w	#$19,(printx).w
	tst.w	(word_FFCF42).w
	bne.w	.13
	cmpi.w	#5,(word_FFD030).w
	blt.w	.14
	move.w	#$20,(printx).w
	bra.w	.14
.13
	move.w	#$1D,(printx).w
	cmpi.w	#4,(word_FFD030).w
	blt.w	.14
	move.w	#$20,(printx).w
.14
	move.w	(sp),d0
	bsr.w	PListValue
	beq.w	.19
	move.w	#$1D,(printx).w
	tst.w	(word_FFCF42).w
	bne.w	.15
	cmpi.w	#5,(word_FFD030).w
	blt.w	.16
	move.w	#0,(printx).w
	bra.w	.16
.15
	move.w	#$21,(printx).w
	cmpi.w	#4,(word_FFD030).w
	blt.w	.16
	move.w	#0,(printx).w
.16
	move.w	(sp),d0
	bsr.w	PListValue
	tst.w	(word_FFCF42).w
	bne.w	.19
	move.w	#$21,(printx).w
	tst.w	(word_FFCF42).w
	bne.w	.17
	cmpi.w	#5,(word_FFD030).w
	blt.w	.18
	move.w	#0,(printx).w
	bra.w	.18
.17
	cmpi.w	#4,(word_FFD030).w
	blt.w	.18
	move.w	#0,(printx).w
.18
	move.w	(sp),d0
	bsr.w	PListValue
.19
	tst.w	(sp)+
.20
	addq.w	#1,(printy).w
	addq.w	#1,d6
	cmp.w	(word_FFD036).w,d6
	blt.w	.0
	movem.l	(sp)+,d0-d7/a0-a6
	rts

PListValue	;PlayerStatsList: print stat column word_FFD238 of row d0
	move.w	d0,-(sp)
	move.w	(word_FFD238).w,d0
	asl.w	#2,d0
	movea.l	#PListColumns,a0
	movea.l	(a0,d0.w),a0
	move.w	(sp)+,d0
	add.w	d0,d0
	move.w	(a0,d0.w),d0
	move.w	#3,d1
	tst.w	(word_FFCF42).w
	bne.w	.0
	cmpi.w	#5,(word_FFD238).w
	blt.w	.2
	cmpi.w	#7,(word_FFD238).w
	beq.w	.2
	bra.w	.1
.0
	cmpi.w	#4,(word_FFD238).w
	blt.w	.2
	cmpi.w	#6,(word_FFD238).w
	beq.w	.2
.1
	move.w	#4,d1
.2
	jsr	(PushNumberWidth).l
	bsr.w	PListMark
	addq.w	#1,(word_FFD238).w
	tst.w	(word_FFCF42).w
	bne.w	.3
	cmpi.w	#5,(word_FFD238).w
	beq.w	.4
	cmpi.w	#8,(word_FFD238).w
	rts
.3
	cmpi.w	#4,(word_FFD238).w
	beq.w	.4
	cmpi.w	#7,(word_FFD238).w
.4
	rts

PListMark	;PlayerStatsList: print a value, highlighted in the column of the category
	move.w	(printa).w,-(sp)
	move.w	(word_FFD030).w,d0
	cmp.w	(word_FFD238).w,d0
	bne.w	.0
	jsr	(printsmallz).l
	String	$FE,$05
.0
	jsr	(printcur).l
	move.w	(sp)+,(printa).w
	rts

NameEntryScreen	;Name entry screen for pad slot a5: the name log, then edit or pick a name with the pad
	movem.l	d0-d7/a0-a6,-(sp)
	move.l	#$EDE,d0
	moveq	#$70,d1
	movea.l	#setupvalues,a0
	jsr	(ReadSRAM).l
	bsr.w	NameEntryGfx
	bsr.w	PrintNameLogRecords
	movea.l	#unk_1AEB94,a0
	jsr	(sub_1218A).l
	jsr	(ReadNameLog).l
	clr.w	(word_FFD3C4).w
	move.w	#1,(namelogsel).w
	clr.w	d0
	bsr.w	SkipOtherUserName
	movea.l	#NameEntryBuf,a1
	bsr.w	GetLogName
	bsr.w	PrintNameLog
	move.w	#$18,(palcount).w
	bclr	#2,(disflags).w
	clr.w	d4
	bsr.w	SyncLetterCursor
	bsr.w	PrintNameCursor
	bsr.w	LetterGridPos
	move.w	#1,(word_FFD484).w
	bsr.w	.6
	clr.w	d0
	bra.w	.18
.loop
	bsr.w	GetNameLength
	jsr	(printz).l
	String	$8F,$04,$14
	tst.w	(word_FFD484).w
	beq.w	.0
	movea.l	#NameEntryBuf,a1
	bsr.w	PrintNameField
	bsr.w	PrintNamePrompt
	bra.w	.1
.0
	move.w	(namelogsel).w,d0
	cmp.w	(word_FFD3C4).w,d0
	beq.w	.1
	bsr.w	PrintNameLog
.1
	move	#$2500,sr
.frame
	move.w	(vcount).w,d0
.loop2
	cmp.w	(vcount).w,d0
	beq.s	.loop2
	jsr	(sub_12640).l
	cmpa.l	#pad1user,a5
	beq.w	.2
	cmpa.l	#pad2user,a5
	beq.w	.8
	cmpa.l	#pad3user,a5
	beq.w	.10
	jsr	(ReadJoy4).l
	jsr	(ProcessInputWithRepeat).l
	tst.w	d1
	beq.s	.frame
	bra.w	.3
.10
	jsr	(ReadJoy3).l
	jsr	(ProcessInputWithRepeat).l
	tst.w	d1
	beq.s	.frame
	bra.w	.3
.8
	jsr	(ReadJoy2).l
	jsr	(ProcessInputWithRepeat).l
	tst.w	d1
	beq.s	.frame
	bra.w	.3
.2
	jsr	(ReadJoy1).l
	jsr	(ProcessInputWithRepeat).l
	tst.w	d1
	beq.s	.frame
.3
	btst	#7,d1
	bne.w	.nameEntryExit
	tst.w	(word_FFD484).w
	bne.w	.11
	move.w	#1,d0
	btst	#1,d1
	bne.w	.13
	move.w	#$FFFF,d0
	btst	#0,d1
	bne.w	.13
	btst	#4,d1
	beq.w	.loop
	bsr.w	.6
	clr.w	d0
	bra.w	.13
.11
	moveq	#-1,d0
	btst	#6,d1
	bne.w	.18
	neg.w	d0
	btst	#5,d1
	bne.w	.18
	btst	#3,d1
	bne.w	.19
	neg.w	d0
	btst	#2,d1
	bne.w	.19
	moveq	#$A,d0
	btst	#1,d1
	bne.w	.19
	neg.w	d0
	btst	#0,d1
	bne.w	.19
	btst	#4,d1
	beq.w	.loop
	bsr.w	.6
	bra.w	.loop
.13
	add.w	d0,(namelogsel).w
.loop4
	cmpi.w	#7,(namelogsel).w
	ble.w	.15
	move.w	#1,(namelogsel).w
.15
	tst.w	(namelogsel).w
	bne.w	.16
	move.w	#7,(namelogsel).w
.16
	bsr.w	SkipOtherUserName
	beq.s	.loop4
	movea.l	#NameEntryBuf,a1
	bsr.w	GetLogName
	tst.w	(word_FFD484).w
	bne.w	.4
	jsr	(NameEntryHelp).l
	bra.w	.loop
.4
	jsr	(printcurz).l
	String	$8F,$03,$15
	add.w	d4,(printx).w
	jsr	(printcurz).l
	String	'   '
	bsr.w	LetterGridPos
	bsr.w	PrintCurLetter
	bsr.w	SyncLetterCursor
	move.w	d4,d0
	neg.w	d0
	bra.w	*+4
.18
	add.w	d4,d0
	cmp.w	#8,d0
	bhi.w	.loop
	move.w	d0,d4
	bsr.w	PrintNameCursor
	movea.l	#NameEntryBuf,a0
	clr.w	d0
	cmpi.b	#$2D,(a0,d4.w)
	beq.w	.19
	move.b	(a0,d4.w),d0
	ext.w	d0
	bsr.w	FindLetter
	sub.w	d5,d0
.19
	add.w	d5,d0
	cmp.w	#$1D,d0
	bhi.w	.loop
	move.w	d0,-(sp)
	bsr.w	LetterGridPos
	bsr.w	PrintCurLetter
	move.w	(sp)+,d5
	bsr.w	LetterGridPos
	move.w	(smallfontchars).w,-(sp)
	tst.w	(word_FFD484).w
	beq.w	.5
	move.w	(word_FFB01E).w,(smallfontchars).w
.5
	bsr.w	PrintCurLetter
	move.w	(sp)+,(smallfontchars).w
	jsr	(printsmallz).l
	String	$FE,$07
	movea.l	#NameEntryBuf,a0
	movea.l	#LetterGrid,a1
	move.b	(a1,d5.w),d0
	move.b	d0,(a0,d4.w)
	bra.w	.loop
.nameEntryExit
	bsr.w	StoreUserName
	movem.l	(sp)+,d0-d7/a0-a6
	rts
.6
	movem.l	d0-d7/a0-a6,-(sp)
	jsr	(printz).l
	String	$8F,$01,$11
	move.w	#$15,d0
	move.w	#7,d1
	move.w	#$7FF,d2	;blank char
	jsr	(eraser).l
	jsr	(printz).l
	String	$8F,$17,$0D
	move.w	#$10,d0
	move.w	#$B,d1
	move.w	#$7FF,d2	;blank char
	jsr	(eraser).l
	bchg	#0,(word_FFD484+1).w
	bne.w	.20
	jsr	(printz).l
	String	$8F,$1A,$0F
	movea.l	#LetterGrid,a0
	moveq	#2,d0
.7
	moveq	#9,d1
	movea.l	#mesarea,a1
	move.w	#$C,(a1)+
.9
	move.b	(a0)+,(a1)+
	dbf	d1,.9
	movea.w	#(mesarea-M68K_RAM),a1
	jsr	(printcur).l
	addq.w	#1,(printy).w
	subi.w	#$A,(printx).w
	dbf	d0,.7
	jsr	(printcurz).l
	String	$8F,$17,$13,'{}[]=new letter'
	move.w	#$17,(printx).w
	addq.w	#1,(printy).w
	move.w	(printx).w,-(sp)
	jsr	(printcurz).l
	String	'C=enter letter'
	move.w	(sp),(printx).w
	addq.w	#1,(printy).w
	jsr	(printcurz).l
	String	'A=go back'
	move.w	(sp),(printx).w
	addq.w	#1,(printy).w
	jsr	(printcurz).l
	String	'B=cancel'
	move.w	(sp)+,(printx).w
.12
	addq.w	#1,(printy).w
.14
	jsr	(printcurz).l
	String	'START=done'
.17
	movem.l	(sp)+,d0-d7/a0-a6
	rts
.20
	movea.l	#NameEntryBuf,a1
	bsr.w	GetLogName
.21
	jsr	(printz).l
	String	$8F,$01,$11
	move.w	#$15,d0
	move.w	#7,d1
.22
	move.w	#$7FF,d2
	jsr	(eraser).l
.23
	jsr	(printz).l
	String	$8F,$1A,$0F
	move.w	#$A,d0
	move.w	#3,d1
.24
	move.w	#$7FF,d2
.25
	jsr	(eraser).l
	bsr.w	NameEntryHelp
	bra.s	.17

NameEntryHelp	;Name entry: name log key help text
	movem.l	d0-d7/a0-a6,-(sp)
	jsr	(printcurz).l
	String	$8F,$03,$13,'{}=select name'
	jsr	(printcurz).l
	String	$8F,$03,$14,'b=enter/edit name'
	jsr	(printcurz).l
	String	$8F,$03,$15,'start=use name'
	movem.l	(sp)+,d0-d7/a0-a6
	rts

PrintNamePrompt	;Name entry: print EnterNameTxt for an empty name log slot namelogsel, else SelectNameTxt
	movem.l	d0-d7/a0-a6,-(sp)
	move.w	(namelogsel).w,d0
	mulu.w	#$A,d0
	movea.l	#namelog,a0
	movea.l	#EnterNameTxt,a1
	tst.b	(a0,d0.w)
	beq.w	.1
.0
	movea.l	#SelectNameTxt,a1
.1
	jsr	(printcur).l
	movem.l	(sp)+,d0-d7/a0-a6
	rts

SyncLetterCursor	;Name entry: grid cursor d5 = grid index of the current letter (FindLetter), 0 if not in the grid
	movem.l	d0-d4/a0-a6,-(sp)
	move.b	(byte_FFD3AC).w,d0
	bsr.w	FindLetter
.3
	cmp.w	#$1E,d0
.4
	blt.w	.1
	clr.w	d5
.0
	bra.w	.2
.1
	move.w	d0,d5
	movea.l	#LetterGrid,a0
	move.b	(a0,d5.w),(byte_FFD3AC).w
.2
	movem.l	(sp)+,d0-d4/a0-a6
	rts

FindLetter	;d0 = index of letter d0 in the letter grid, $1E when not found
	movem.l	d1-d3/a0-a6,-(sp)
	movea.l	#LetterGrid,a0
	move.b	d0,d1
	clr.w	d0
	move.w	#$1E,d3
.0
	cmp.b	(a0,d0.w),d1
	beq.w	.x
	addq.w	#1,d0
	dbf	d3,.0
	move.w	#$1E,d0
.x
	movem.l	(sp)+,d1-d3/a0-a6
	rts

PrintNameCursor	;Name entry: position the name cursor, " < " with word_FFD484 set
	jsr	(printz).l
	String	$8F,$03,$15
	add.w	d4,(printx).w
	tst.w	(word_FFD484).w
	beq.w	rtsNameCursor
	jsr	(printcurz).l
	String	' < '

rtsNameCursor	;Shared rts of PrintNameCursor
	rts

PrintCurLetter	;Name entry: print grid letter d5 when the cursor is on
	tst.w	(word_FFD484).w
	beq.s	rtsNameCursor
	movea.l	#ThreeStars,a1
	move.w	#4,(a1)
	move.b	#0,3(a1)
	movea.l	#LetterGrid,a0
	move.b	(a0,d5.w),d0
	move.b	d0,2(a1)
	jmp	printcur

LetterGridPos	;Name entry: printx / printy of grid letter d5 (10 a row)
	jsr	(printz).l
	String	$8F,$1A,$0F
	move.w	d5,d0
	ext.l	d0
	divu.w	#$A,d0
	add.w	d0,(printy).w
	swap	d0
	add.w	d0,(printx).w
	rts

EnterNameTxt	;Name entry prompt for an empty name log slot
	String	$8F,$01,$12,'  Enter new name: '

SelectNameTxt	;Name entry prompt for a used name log slot
	String	$8F,$01,$12,'Select or replace:'

PrintNameLog	;Name entry: print the 7-row name log list
	movem.l	d0-d7/a0-a6,-(sp)
	move.w	(NameEntryLen).w,-(sp)
	move.w	(namelogsel).w,-(sp)
	move.w	(namelogsel).w,d6
	jsr	(printcurz).l
	String	$8F,$01,$0A
	move.w	#6,d7
	move.w	#1,(namelogsel).w
	movea.l	#$FFFFBF54,a1
.0
	bsr.w	GetLogName
	move.w	(printx).w,-(sp)
	move.w	(smallfontchars).w,-(sp)
	cmp.w	(namelogsel).w,d6
	bne.w	.1
	move.w	(word_FFB01E).w,(smallfontchars).w
.1
	bsr.w	PrintNameField
	move.w	(sp)+,(smallfontchars).w
	jsr	(printsmallz).l
	String	$FE,$07
	move.w	(sp)+,(printx).w
	addq.w	#1,(printy).w
	addq.w	#1,(namelogsel).w
	dbf	d7,.0
	move.w	(sp)+,(namelogsel).w
	move.w	(sp)+,(NameEntryLen).w
	movem.l	(sp)+,d0-d7/a0-a6
	rts

GetNameLength	;Name entry: NameEntryLen = length of the name in the entry buffer
	movem.l	d0-d7/a0-a6,-(sp)
	move.w	#9,d3
	movea.l	#NameEntryBuf,a0
	clr.w	(NameEntryLen).w
.loop
	cmpi.b	#$2D,(a0)
	beq.w	.x
	tst.b	(a0)+
	beq.w	.x
	addq.w	#1,(NameEntryLen).w
	dbf	d3,.loop
.x
	movem.l	(sp)+,d0-d7/a0-a6
	rts

PrintNameField	;Name entry: print the name field at a1 ("-" pads) and the current letter when the cursor is on
	movem.l	d0-d7/a0-a6,-(sp)
	movea.l	#ThreeStars,a0
	move.w	(NameEntryLen).w,d0
	move.w	#0,d3
	move.w	#$C,(a0)+
.0
	move.b	(a1,d3.w),d1
	cmp.w	(NameEntryLen).w,d3
	blt.w	.3
	move.b	#$2D,d1
	cmp.w	#9,d3
	bne.w	.3
	move.b	#$20,d1
.3
	move.b	d1,(a0)+
	addq.w	#1,d3
	cmp.w	#9,d3
	blt.s	.0
	movea.l	#ThreeStars,a1
	move.b	#$20,$B(a1)
	jsr	(printcur).l
	movem.l	(sp)+,d0-d7/a0-a6
	rts

LetterGrid	;Name entry letter grid (the create player screen uses it too)
	dc.b	$41,$42,$43,$44,$45,$46,$47,$48,$49,$4A,$4B,$4C,$4D,$4E,$4F,$50
	dc.b	$51,$52,$53,$54,$55,$56,$57,$58,$59,$5A,$2E,$31,$32,$20,$2D,$FF

GetLogName	;Copy name log entry namelogsel to a1 ("-" for blanks), NameEntryLen = its length
	movem.l	d0-d7/a0-a6,-(sp)
	movea.l	#namelog,a0
	move.w	(namelogsel).w,d2
	mulu.w	#$A,d2
	move.w	#0,(NameEntryLen).w
	move.w	#9,d3
.0
	move.b	(a0,d2.w),d0
	beq.w	.1
	bra.w	.2
.1
	move.b	#$2D,d0
	subq.w	#1,(NameEntryLen).w
.2
	move.b	d0,(a1)+
	addq.w	#1,(NameEntryLen).w
	addq.w	#1,d2
	dbf	d3,.0
	movem.l	(sp)+,d0-d7/a0-a6
	rts

StoreUserName	;Name entry: store the edited name in the name log slot; if changed, save and clear its old record
	movem.l	d0-d7/a0-a6,-(sp)
	movea.l	#namelog,a0
	move.w	(namelogsel).w,d0
	mulu.w	#$A,d0
	adda.w	d0,a0
	movea.l	#NameEntryBuf,a1
	move.w	#9,d4
.loop
	cmpi.b	#$2D,(a1)
	bne.w	.1
	move.b	#0,(a1)
.1
	move.b	(a1)+,d1
	cmp.b	(a0)+,d1
	bne.w	.2
	dbf	d4,.loop
	bra.w	.0
.2
	movea.l	#namelog,a0
	move.w	(namelogsel).w,d0
	mulu.w	#$A,d0
	adda.w	d0,a0
	movea.l	#NameEntryBuf,a1
	move.w	#9,d4
.loop2
	move.b	(a1)+,d1
	cmp.b	#$2D,d1
	bne.w	.4
	move.b	#0,d1
.4
	move.b	d1,(a0)+
	dbf	d4,.loop2
	jsr	(WriteNameLog).l
	jsr	(ClearNameRecord).l
	jsr	(MakeSRAMChecksum).l
.0
	movea.l	#pad1user,a5
	tst.w	(nameentryvis).w
	beq.w	.3
	movea.l	#pad2user,a5
.3
	tst.b	(byte_FFD3AC).w
	bne.w	.6
	clr.w	(namelogsel).w
.6
	move.w	(namelogsel).w,(a5)
	movem.l	(sp)+,d0-d7/a0-a6
	rts

ClearNameRecord	;Clear the 16-byte record of name slot namelogsel in save RAM ($ECE + slot * 16)
	movem.l	d0-d7/a0-a6,-(sp)
	move.l	#$ECE,d0
	move.w	(namelogsel).w,d3
	asl.w	#4,d3
	ext.l	d3
	add.l	d3,d0
	moveq	#$10,d1
	movea.l	#ThreeStars,a0
	jsr	(ReadSRAM).l
	move.l	a0,-(sp)
	move.w	#$F,d3
.loop3
	clr.b	(a0)+
	dbf	d3,.loop3
	movea.l	(sp)+,a0
	jsr	(WriteSRAM).l
	jsr	(MakeSRAMChecksum).l
	movem.l	(sp)+,d0-d7/a0-a6
	rts

UserNameEntry	;With user records on (OptUserRec 0): the name entry (NameEntryScreen) for each pad in use
	tst.w	(OptUserRec).w
	bne.w	.x
	clr.w	(pad1user).w
	clr.w	(pad2user).w
	clr.w	(pad3user).w
	clr.w	(pad4user).w
	tst.w	(cont1team).w
	beq.w	.0
	move.w	(cont1team).w,(nameentryvis).w
	subq.w	#1,(nameentryvis).w
	movea.l	#pad1user,a5
	jsr	(NameEntryScreen).l
.0
	tst.w	(cont2team).w
	beq.w	.1
	move.w	(cont2team).w,(nameentryvis).w
	subq.w	#1,(nameentryvis).w
	movea.l	#pad2user,a5
	jsr	(NameEntryScreen).l
.1
	tst.w	(cont3team).w
	beq.w	.2
	move.w	(cont3team).w,(nameentryvis).w
	subq.w	#1,(nameentryvis).w
	movea.l	#pad3user,a5
	jsr	(NameEntryScreen).l
.2
	tst.w	(cont4team).w
	beq.w	.3
	move.w	(cont4team).w,(nameentryvis).w
	subq.w	#1,(nameentryvis).w
	movea.l	#pad4user,a5
	jsr	(NameEntryScreen).l
.3
	bset	#0,(sflags10).w
	move.w	#1,d0
	bsr.w	CountTeamPads
	cmp.w	#1,d2
	ble.w	.4
	bclr	#0,(sflags10).w
.4
	move.w	#2,d0
	bsr.w	CountTeamPads
	cmp.w	#1,d2
	ble.w	.x
	bclr	#0,(sflags10).w
.x
	rts

CountTeamPads	;d2 = the number of pads (cont1team ... cont4team) on team d0 (1 home, 2 away)
	clr.w	d2
	cmp.w	(cont1team).w,d0
	bne.w	.0
	addq.w	#1,d2
.0
	cmp.w	(cont2team).w,d0
	bne.w	.1
	addq.w	#1,d2
.1
	cmp.w	(cont3team).w,d0
	bne.w	.2
	addq.w	#1,d2
.2
	cmp.w	(cont4team).w,d0
	bne.w	.x
	addq.w	#1,d2
.x
	rts

SkipOtherUserName	;Step namelogsel past the name the other team's pad picked, in the direction of the word on the stack
	movem.w	d0,-(sp)
	move.w	(pad2user).w,d0
	tst.w	(nameentryvis).w
	beq.w	.0
	move.w	(pad1user).w,d0
.0
	cmp.w	(namelogsel).w,d0
	bne.w	.2
	move.w	#1,d0
	tst.w	(sp)
	bpl.w	.1
	move.w	#$FFFF,d0
.1
	add.w	d0,(namelogsel).w
	clr.w	d0
.2
	movem.w	(sp)+,d0
	rts

NameEntryGfx	;Name entry: vram, fonts, the screen bitmaps, the pad icon (NameEntryPadIcons), the team block and the
	;heading
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
	movea.l	#unk_1AEB94,a1
	jsr	(sub_1217A).l
	move.w	d4,(smallfontchars).w
	movea.l	#RosterFont+8,a2
	jsr	(DecompressGraphicsPlain).l
	move.w	d4,(word_FFB01E).w
	movea.l	#RosterFont+8,a2
	jsr	(DecompressGraphicsWithCallback).l
	dc.b	$01,$23,$AB,$CE,$89,$AB,$CD,$EF	;remap table
	move.l	#RosterFont,(smallfontptr).w
	move.w	d4,(BigFontChars).w
	movea.l	#BigFontMap4+8,a2
	jsr	(DecompressGraphicsPlain).l
	bset	#2,(sflags11).w
	jsr	(printsmallz).l
	String	$FF,$01,$FD,$00,$FC
	moveq	#$28,d0
	moveq	#$1C,d1
	move.w	#$7FF,d2
	jsr	(eraser).l
	jsr	(printcurz).l
	String	$BF,$00,$00
	movea.l	#unk_1AD7C6,a0
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
	jsr	(printcurz).l
	String	$BF,$0B,$01
	movea.l	#unk_1ACFE6,a0
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
	jsr	(printcurz).l
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
	movea.l	a5,a0
	suba.w	#$D248,a0
	move.l	a0,d0
	movea.l	#NameEntryPadIcons,a0
	add.w	d0,d0
	movea.l	(a0,d0.w),a0
	jsr	(printz).l
	String	$BF,$1A,$09
	movea.l	a0,a1
	movea.l	a0,a2
	adda.l	(a2)+,a0
	adda.l	(a2)+,a1
	clr.w	d0
	clr.w	d1
	moveq	#$A,d2
	moveq	#4,d3
	moveq	#2,d5
	jsr	(dobitmap).l
	jsr	(printz).l
	String	$BF,$17,$05
	move.w	(HomeTeam).w,d7
	tst.w	(nameentryvis).w
	beq.w	.0
	move.w	(VisTeam).w,d7
.0
	jsr	(DrawSetupTeamBlock).l
	jsr	(printbigz).l
	String	$F8,$04,$01,$04,$05,'name',$FD,$0C,'w   l   t'
	rts

NameEntryPadIcons	;NameEntryGfx: the pad icon map of each pad slot
	dc.l	PadIconMap1,PadIconMap2,PadIconMap3,PadIconMap4

PrintNameLogRecords	;Name entry: the record columns of the 7 name log rows (ThreeStars)
	movem.l	d0-d7/a0-a6,-(sp)
	movea.l	#setupvalues,a0
	move.w	#6,d7
	jsr	(printz).l
	String	$8F,$0B,$0A
.0
	move.w	8(a0),d0
.1
	cmp.w	#$3E8,d0
	blt.w	.2
	subi.w	#$3E8,d0
	bra.s	.1
.2
	move.w	#3,d1
	jsr	(PushNumberWidth).l
	move.w	#$B,(printx).w
	jsr	(printcur).l
	move.w	$C(a0),d0
.3
	cmp.w	#$3E8,d0
	blt.w	.4
	subi.w	#$3E8,d0
	bra.s	.3
.4
	move.w	#3,d1
	jsr	(PushNumberWidth).l
	move.w	#$13,(printx).w
	jsr	(printcur).l
	move.w	$A(a0),d0
	sub.w	$C(a0),d0
	sub.w	8(a0),d0
	bpl.w	.5
	clr.w	d0
.5
	cmp.w	#$3E8,d0
	blt.w	.6
	subi.w	#$3E8,d0
	bra.s	.5
.6
	move.w	#3,d1
	jsr	(PushNumberWidth).l
	move.w	#$F,(printx).w
	jsr	(printcur).l
	adda.w	#$10,a0
	addq.w	#1,(printy).w
	dbf	d7,.0
	movem.l	(sp)+,d0-d7/a0-a6
	rts

PlayoffScreen	;Bring up the playoff screen if in playoff mode (OptPlayMode nonzero): the tree, the series scores and
	;the team blocks, until start
	tst.w	(OptPlayMode).w
	beq.w	locret_1E733A
	btst	#7,(GameFlags).w
	beq.w	.1
	btst	#3,(dword_FFDD7E+2).w
	bne.w	.1
	cmpi.w	#4,(gamelevel).w
	bne.w	.1
	move.b	(byte_FFCFEE).w,d0
	move.b	(byte_FFCFEF).w,d1
	move.b	d0,d2
	cmp.b	(dword_FFDD82+2).w,d2
	bne.w	.0
	move.b	d1,d2
.0
	move.b	d2,(byte_FFCFF0).w
.1
	jsr	(forceblack).l
	move.l	#unk_122A4,(dword_FFDDAC).w
	move.w	(VSCRLPM).w,d0
	jsr	(Vmaddr).l
	clr.w	d0
	move.w	d0,(a0)
	move.w	d0,2(a0)
	move.l	#VBlank_Playoff,(vbint).l
	bclr	#1,(disflags).w
	move.w	#0,(VSCRLPM).w
	move.w	#$BC00,(VSPRITES).w
	move.w	#$B000,(VmMap3).w
	move.w	#6,(Map3col1).w
	move.w	#$C000,(VmMap2).w
	move.w	#7,(Map2col1).w
	move.w	#$E000,(VmMap1).w
	move.w	#7,(Map1col1).w
	move.w	#0,d0
	jsr	(setVram).l
	jsr	(printz).l
	String	$FF,$00,$00
	move.l	#$80,d0
	moveq	#$1C,d1
	move.w	#$7FF,d2
	jsr	(eraser).l
	move.w	#2,d4
	move.w	#$19,d1
	clr.w	d2
	movea.l	#setupvalues,a0
	movea.l	#TeamBlockPtrs,a1
.2
	move.w	d4,(a0)+
	move.w	d2,d0
	asl.w	#2,d0
	movea.l	(a1,d0.w),a2
	addq.w	#8,a2
	jsr	(DecompressGraphicsPlain).l
	addq.w	#1,d2
	dbf	d1,.2
	move.w	d4,(smallfontchars).w
	movea.l	#RosterFont+8,a2
	jsr	(DecompressGraphicsPlain).l
	move.l	#RosterFont,(smallfontptr).w
	movea.l	#unk_1BDCD4+8,a2
	jsr	(printz).l
	String	$FF,$00,$00
	movea.l	#unk_1BDCD4,a0
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
	move.w	d4,(ExtraChars).w
	movea.l	#unk_1C4810+8,a2
	jsr	(DecompressGraphicsPlain).l
	jsr	(printz).l
	String	$FE,$00,$00
	movea.l	#unk_1C0302,a0
	movea.l	a0,a1
	movea.l	a0,a2
	adda.l	(a2)+,a0
	adda.l	(a2)+,a1
	move.w	(a1),d2
	clr.w	d0
	clr.w	d1
	move.w	2(a1),d3
	moveq	#1,d5
	jsr	(dobitmap).l
	movea.l	#VDP_CTRL,a0
	move.w	#$9200,(a0)
	movea.l	#potree,a1
	movea.l	#PlayoffTreeSetup,a0
	move.w	(gamelevel).w,d0
	asl.w	#1,d0
	adda.w	(a0,d0.w),a0
	clr.w	d4
	move.b	(a0)+,d4
.3
	jsr	(printz).l
	String	$BF,$00,$00
	move.b	(a0)+,(printx+1).w
	move.b	(a0)+,(printy+1).w
	clr.w	d1
	move.b	(a1)+,d1
	add.w	d1,d1
	bsr.w	DrawTeamBlocks
	dbf	d4,.3
	clr.w	d4
	move.b	(a0)+,d4
.4
	jsr	(printz).l
	String	$BF,$00,$02
	move.b	(a0)+,(printx+1).w
	clr.w	d0
	move.b	(a0)+,d0
	bsr.w	DrawTreeArrow
	dbf	d4,.4
	jsr	(printz).l
	String	$8F,$00,$00
	cmpi.w	#7,(bosgames).w
	beq.w	.6
	clr.w	d4
	move.b	(a0)+,d4
	bmi.w	.6
	movea.w	#(gsstruct-M68K_RAM),a2
.5
	move.b	(a0)+,(printx+1).w
	move.b	(a0)+,(printy+1).w
	bsr.w	PrintSeriesScore
	adda.w	#$10,a2
	dbf	d4,.5
.6
	tst.w	(gamelevel).w
	beq.w	*+4
.7
	move.w	#$18,(palcount).w
	movem.l	d0/a0,-(sp)
	movea.l	#unk_1E765A,a0
	move.w	(gamelevel).w,d0
	add.w	d0,d0
	move.w	(a0,d0.w),d0
	cmpi.w	#$3C,(word_FFD488).w
	blt.w	.8
	neg.w	d0
.8
	move.w	d0,(word_FFD030).w
	movem.l	(sp)+,d0/a0
	move	#$2500,sr
	clr.w	d0
	clr.w	d4
	clr.w	(word_FFD034).w
	bsr.w	UpdatePlayoffScroll
.9
	bsr.w	PlayoffScreen_waitvsync
	movea.l	#rtss2,a0
	bsr.w	HandlePlayoffInput
	bra.s	.9

HandlePlayoffInput	;Read the pads: start leaves PlayoffScreen, right / left scroll the tree
	jsr	(sub_1B282).l
	btst	#7,d3
	bne.w	PlayoffScreenExit
	btst	#3,d3
	beq.w	.nr
	move.w	#$FFFC,(word_FFD034).w
.nr
	btst	#2,d3
	beq.w	UpdatePlayoffScroll
	move.w	#4,(word_FFD034).w

UpdatePlayoffScroll	;Move the tree one step and stop on a page boundary
	move.w	(word_FFD034).w,d0
	beq.w	locret_1E733A
	add.w	(word_FFD030).w,d0
	move.w	(gamelevel).w,d1
	cmp.w	#3,d1
	bls.w	.0
	moveq	#3,d1
.0
	move.w	#3,d1
	movem.l	a0,-(sp)
	movea.l	#unk_1E7650,a0
	add.w	d1,d1
	move.w	(a0,d1.w),d1
	move.w	d1,(jerseynum).w
	movem.l	(sp)+,a0
	cmp.w	d1,d0
	bgt.w	locret_1E733A
	neg.w	d1
	cmp.w	d1,d0
	blt.w	locret_1E733A
	move.w	d0,(word_FFD030).w
	clr.w	(word_FFB8C4).w
	move.w	d0,d1
	addi.w	#$100,d1
	cmp.w	#$40,d1
	blt.w	.nox
	cmp.w	#$200,d1
	bgt.w	.nox
	move.w	d1,(word_FFB8C4).w
.nox
	ext.l	d0
	movea.l	#unk_1E7650,a0
.1
	move.w	(a0)+,d0
	cmp.w	(word_FFD030).w,d0
	beq.w	.2
	neg.w	d0
	cmp.w	(word_FFD030).w,d0
	beq.w	.2
	cmpa.l	#unk_1E7658,a0
	blt.s	.1
	rts
.2
	clr.w	(word_FFD034).w
	rts

PlayoffScreenExit	;Drop HandlePlayoffInput's return address and return from PlayoffScreen
	jsr	(forceblack).l
	addq.w	#4,sp

locret_1E733A
	rts

PlayoffScreen_waitvsync	;Wait for the next frame; flash a colour each time palcount runs out
	tst.w	(palcount).w
	bpl.w	.wait
	movem.l	d0-d1/a0-a1,-(sp)
	movea.l	#word_FFBD62,a0
	move.w	#$C,d1
	move.w	(a0),d0
.0
	move.w	2(a0),-(sp)
	move.w	d0,2(a0)
	move.w	(sp)+,d0
	addq.l	#2,a0
	dbf	d1,.0
	move.w	(word_FFBD7C).w,(word_FFBD62).w
	movem.l	(sp)+,d0-d1/a0-a1
	move.w	#3,(palcount).w
.wait
	move.w	(vcount).w,d0
	cmp.w	(oldvcount).w,d0
	beq.s	.wait
	move.w	d0,(oldvcount).w
	rts

PrintSeriesScore	;Print best of 7 wins "t-b" for game struct a2 at printx / printy
	movea.w	#(mesarea-M68K_RAM),a1
	move.w	#6,(a1)+
	move.w	4(a2),d0
	addi.w	#$30,d0
	move.b	d0,(a1)+
	move.b	#$2D,(a1)+
	move.w	6(a2),d0
	addi.w	#$30,d0
	move.b	d0,(a1)+
	clr.b	(a1)+
	movea.w	#(mesarea-M68K_RAM),a1
	jmp	printcur

DrawTreeArrow	;An rts: no tree arrows
	rts

DrawTeamBlocks	;Draw team block d1 at printx / printy; the user's team gets a frame
	movem.l	d0-d7/a0-a3,-(sp)
	movea.l	#potree,a0
	move.w	(potreeteam).w,d0
	move.b	(a0,d0.w),d0
	add.b	d0,d0
	cmp.b	d0,d1
	bne.w	.0
	move.w	(printx).w,(word_FFD488).w
	movem.l	d0-d7/a0-a6,-(sp)
	move.w	(printx).w,-(sp)
	move.w	(printy).w,-(sp)
	subq.w	#1,(printx).w
	subq.w	#1,(printy).w
	move.w	(ExtraChars).w,d4
	jsr	(printsmallz).l
	String	$FE,$00,$FF,$02
	movea.l	#unk_1C4810,a0
	movea.l	a0,a1
	movea.l	a0,a2
	adda.l	(a2)+,a0
	adda.l	(a2)+,a1
	movea.l	#$772,a2
	clr.w	d0
	clr.w	d1
	move.w	(a1),d2
	move.w	2(a1),d3
	moveq	#2,d5
	jsr	(dobitmap).l
	move.w	(sp)+,(printy).w
	move.w	(sp)+,(printx).w
	jsr	(printsmallz).l
	String	$FE,$04,$FF,$01
	movem.l	(sp)+,d0-d7/a0-a6
.0
	movea.l	#setupvalues,a0
	move.w	(a0,d1.w),d4
	add.w	d1,d1
	movea.l	#TeamBlockPtrs,a0
	movea.l	(a0,d1.w),a0
	asr.w	#1,d1
	movea.l	a0,a1
	adda.l	(a0),a0
	adda.l	4(a1),a1
	movea.w	#$772,a2
	clr.w	d0
	clr.w	d1
	move.w	(a1),d2
	moveq	#2,d3
	move.w	#$C,d5
	jsr	(dobitmap).l
	movem.l	(sp)+,d0-d7/a0-a3
	rts

VBlank_Playoff	;The PlayoffScreen vblank handler (vbint)
	;Code the listing does not decode: kept as bytes
	dc.b	$48,$E7,$FF,$FE,$08,$38,$00,$02,$BF,$B2,$66,$00,$00,$20,$30,$38
	dc.b	$B0,$00,$4E,$B9,$00,$01,$B6,$78,$30,$3C,$FE,$C0,$D0,$78,$D0,$30
	dc.b	$30,$80,$31,$40,$00,$02,$4E,$B9,$00,$01,$AF,$D6,$52,$78,$B0,$52
	dc.b	$4E,$B9,$00,$02,$44,$86,$4C,$DF,$7F,$FF,$4E,$73,$00,$0A,$50,$6C
	dc.b	$61,$79,$6F,$66,$66,$73,$00,$10,$51,$75,$61,$72,$74,$65,$72,$66
	dc.b	$69,$6E,$61,$6C,$73,$00,$00,$0C,$53,$65,$6D,$69,$66,$69,$6E,$61
	dc.b	$6C,$73,$00,$08,$46,$69,$6E,$61,$6C,$73,$00,$0C,$43,$68,$61,$6D
	dc.b	$70,$69,$6F,$6E,$73,$00

PlayoffTreeSetup	;Playoff tree layout by gamelevel. Used by PlayoffScreen
	dc.b	$00,$0A,$00,$41,$00,$84,$00,$CF,$01,$1C,$0F,$01,$02,$01,$04,$01
	dc.b	$08,$01,$0A,$01,$0E,$01,$10,$01,$14,$01,$16,$66,$02,$66,$04,$66
	dc.b	$08,$66,$0A,$66,$0E,$66,$10,$66,$14,$66,$16,$01,$39,$00,$45,$0A
	dc.b	$07,$07,$06,$07,$0C,$07,$12,$07,$18,$6C,$06,$6C,$0C,$6C,$12,$6C
	dc.b	$18,$17,$01,$02,$01,$04,$01,$08,$01,$0A,$01,$0E,$01,$10,$01,$14
	dc.b	$01,$16,$66,$02,$66,$04,$66,$08,$66,$0A,$66,$0E,$66,$10,$66,$14
	dc.b	$66,$16,$12,$05,$12,$07,$12,$11,$12,$13,$55,$05,$55,$07,$55,$11
	dc.b	$55,$13,$03,$2B,$00,$39,$02,$45,$08,$53,$0A,$03,$18,$09,$18,$15
	dc.b	$5B,$09,$5B,$15,$1B,$01,$02,$01,$04,$01,$08,$01,$0A,$01,$0E,$01
	dc.b	$10,$01,$14,$01,$16,$66,$02,$66,$04,$66,$08,$66,$0A,$66,$0E,$66
	dc.b	$10,$66,$14,$66,$16,$12,$05,$12,$07,$12,$11,$12,$13,$55,$05,$55
	dc.b	$07,$55,$11,$55,$13,$21,$0B,$21,$0D,$47,$0B,$47,$0D,$05,$1D,$00
	dc.b	$2B,$02,$39,$04,$45,$06,$53,$08,$61,$0A,$01,$27,$0F,$4D,$0F,$1D
	dc.b	$01,$02,$01,$04,$01,$08,$01,$0A,$01,$0E,$01,$10,$01,$14,$01,$16
	dc.b	$66,$02,$66,$04,$66,$08,$66,$0A,$66,$0E,$66,$10,$66,$14,$66,$16
	dc.b	$12,$05,$12,$07,$12,$11,$12,$13,$55,$05,$55,$07,$55,$11,$55,$13
	dc.b	$21,$0B,$21,$0D,$47,$0B,$47,$0D,$29,$18,$40,$18,$05,$0F,$00,$1D
	dc.b	$02,$2B,$04,$53,$06,$61,$08,$6F,$0A,$00,$3B,$1A,$1E,$01,$02,$01
	dc.b	$04,$01,$08,$01,$0A,$01,$0E,$01,$10,$01,$14,$01,$16,$66,$02,$66
	dc.b	$04,$66,$08,$66,$0A,$66,$0E,$66,$10,$66,$14,$66,$16,$12,$05,$12
	dc.b	$07,$12,$11,$12,$13,$55,$05,$55,$07,$55,$11,$55,$13,$21,$0B,$21
	dc.b	$0D,$47,$0B,$47,$0D,$29,$18,$40,$18,$34,$11,$05,$0F,$00,$1D,$02
	dc.b	$2B,$04,$53,$06,$61,$08,$6F,$0A,$FF,$FF

unk_1E7650	;Used from UpdatePlayoffScroll
	dc.b	$00,$00,$00,$88,$00,$88,$01,$40

unk_1E7658	;The end of unk_1E7650
	dc.b	$01,$40

unk_1E765A	;Used from PlayoffScreen
	dc.b	$01,$40,$01,$40,$00,$88,$00,$00,$00,$00

showclock	;Put the game clock on screen (m:ss), or else queue it (showclockdma)
	btst	#7,(sflags).w
	beq.w	showclockdma
	btst	#0,(gmode2).w
	bne.w	.2
	move.l	a1,-(sp)
	jsr	(printz).l
	String	$BE,$0D,$05
	move.w	(gameclock).w,d0
	ext.l	d0
	divu.w	#$258,d0
	move.l	d0,-(sp)
	tst.w	d0
	bne.w	.0
	addq.w	#1,(printx).w
	bra.w	.1
.0
	jsr	(PrintClockDigit).l
.1
	move.l	(sp)+,d0
	swap	d0
	ext.l	d0
	divu.w	#$3C,d0
	move.l	d0,-(sp)
	jsr	(PrintClockDigit).l
	move.l	(sp)+,d0
	swap	d0
	ext.l	d0
	addq.w	#2,(printx).w
	divu.w	#$A,d0
	move.l	d0,-(sp)
	jsr	(PrintClockDigit).l
	move.l	(sp)+,d0
	swap	d0
	ext.l	d0
	jsr	(PrintClockDigit).l
	movea.l	(sp)+,a1
	jsr	(printz).l
	String	$BD,$0D,$05
.2
	rts

PrintClockDigit	;Print digit d0 (ClockDigitText)
	movea.l	#ClockDigitText,a1
	asl.w	#2,d0
	adda.w	d0,a1
	jsr	(print).l
	rts

ClockDigitText	;The digits 0-9
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

showclockdma	;When dfclock is set queue the clock chars in the dma list (a5)
	bclr	#3,(disflags).w
	beq.w	locret_1E78A6
	btst	#3,(sflags2).w
	bne.w	locret_1E78A6
	cmpi.w	#4,(gsp).w
	beq.w	locret_1E78A6
	movea.w	#(unk_FFBFCA-M68K_RAM),a0
	movea.l	#BigFontMap,a1
	adda.l	4(a1),a1
	move.w	$50(a1),d0
	add.w	(word_FFB016).w,d0
	ori.w	#$8000,d0
	move.w	d0,(word_FFBFC2).w
	move.w	$4E(a1),d0
	add.w	(word_FFB016).w,d0
	ori.w	#$8000,d0
	move.w	d0,-(a0)
	move.w	(gameclock).w,d0
	btst	#1,(gmode2).w
	beq.w	.gotclock
	move.w	(word_FFD326).w,d0
.gotclock
	ext.l	d0
	divu.w	#$A,d0
	bsr.w	ClockDigitChar
	divu.w	#6,d0
	bsr.w	ClockDigitChar
	subq.w	#2,a0
	divu.w	#$A,d0
	bsr.w	ClockDigitChar
	swap	d0
	tst.l	d0
	bne.w	.1
	moveq	#-1,d0
	swap	d0
.1
	bsr.w	ClockDigitChar
	move.w	$52(a1),d0
	add.w	(word_FFB016).w,d0
	ori.w	#$8000,d0
	move.w	d0,-(a0)
	move.l	a0,(a5)+
	move.w	#7,(a5)+
	movea.w	#(VmMap1-M68K_RAM),a1
	moveq	#$19,d0
	moveq	#1,d2
	btst	#7,(sflags).w
	beq.w	.0
	movea.w	#(VmMap2-M68K_RAM),a1
	moveq	#5,d0
	moveq	#$D,d2
.0
	move.w	2(a1),d1
	asl.w	d1,d0
	add.w	d2,d0
	asl.w	#1,d0
	add.w	(a1),d0
	move.w	d0,(a5)+
	movea.w	#(unk_FFBFD8-M68K_RAM),a0
	movea.l	#BigFontMap,a1
	adda.l	4(a1),a1
	move.w	$B0(a1),d0
	add.w	(word_FFB016).w,d0
	ori.w	#$8000,d0
	move.w	d0,(word_FFBFD0).w
	move.w	$AE(a1),d0
	add.w	(word_FFB016).w,d0
	ori.w	#$8000,d0
	move.w	d0,-(a0)
	move.w	(gameclock).w,d0
	btst	#1,(gmode2).w
	beq.w	.2
	move.w	(word_FFD326).w,d0
.2
	ext.l	d0
	divu.w	#$A,d0
	bsr.w	ClockDigitChar2
	divu.w	#6,d0
	bsr.w	ClockDigitChar2
	subq.w	#2,a0
	divu.w	#$A,d0
	bsr.w	ClockDigitChar2
	swap	d0
	tst.l	d0
	bne.w	.3
	moveq	#-1,d0
	swap	d0
.3
	bsr.w	ClockDigitChar2
	move.w	$B2(a1),d0
	add.w	(word_FFB016).w,d0
	ori.w	#$8000,d0
	move.w	d0,-(a0)
	move.l	a0,(a5)+
	move.w	#7,(a5)+
	movea.w	#(VmMap1-M68K_RAM),a1
	moveq	#$1A,d0
	moveq	#1,d2
	btst	#7,(sflags).w
	beq.w	.4
	movea.w	#(VmMap2-M68K_RAM),a1
	moveq	#5,d0
	moveq	#$D,d2
.4
	move.w	2(a1),d1
	asl.w	d1,d0
	add.w	d2,d0
	asl.w	#1,d0
	add.w	(a1),d0
	move.w	d0,(a5)+
	rts

ClockDigitChar	;showclockdma helper: next digit of d0 (divu remainder) as a clock char word to -(a0)
	swap	d0
	asl.w	#1,d0
	move.w	$38(a1,d0.w),d0
	add.w	(word_FFB016).w,d0
	ori.w	#$8000,d0
	move.w	d0,-(a0)
	swap	d0
	ext.l	d0

locret_1E78A6
	rts

ClockDigitChar2	;The same from the second char row of the font
	swap	d0
	asl.w	#1,d0
	addi.w	#$98,d0
	move.w	(a1,d0.w),d0
	add.w	(word_FFB016).w,d0
	ori.w	#$8000,d0
	move.w	d0,-(a0)
	swap	d0
	ext.l	d0
	rts

ShowBigScore	;The big score of both teams with the EASN logo; in a shootout also the period (ScorePeriodText)
	movem.l	d0-d7/a0-a6,-(sp)
	bset	#2,(sflags12).w
	bset	#0,(byte_FFC35A).w
	jsr	(sub_1CFE4).l
	jsr	(EASNLogo).l
	jsr	(printbigz2).l
	String	$F8,$04,$01,$06,$15,$20,$FB,$0F
	move.w	(AwGoals).w,d0
	move.w	#3,d1
	jsr	(PushNumberWidth).l
	jsr	(printbig2).l
	jsr	(printbigz2).l
	String	$3E
	jsr	(printbigz2).l
	String	$F8,$04,$01,$06,$17,$20,$FB,$0F
	move.w	(HmGoals).w,d0
	move.w	#3,d1
	jsr	(PushNumberWidth).l
	jsr	(printbig2).l
	jsr	(printbigz2).l
	String	$3E
	btst	#0,(gmode2).w
	beq.w	.0
	jsr	(printz).l
	String	$BF,$08,$19
	jsr	(printbigz2).l
	String	'    shootout    '
	jsr	(printbigz2).l
	String	$3E
	bra.w	.1
.0
	jsr	(printz).l
	String	$BF,$08,$19
	movea.l	#ScorePeriodText,a1
	move.w	(gsp).w,d0
	jsr	(SkipStrings).l
	jsr	(printbig2).l
	jsr	(printbigz2).l
	String	$3E
.1
	jsr	(printbigz1).l
	String	$F8,$04,$01,$07,$15,'<            >',$FD,$08
	move.w	(word_FFCAEC).w,d0
	movea.w	#TeamList,a1
	asl.w	#2,d0
	movea.l	(a1,d0.w),a1
.2
	adda.w	4(a1),a1
	adda.w	(a1),a1
	adda.w	(a1),a1
	jsr	(printbig1).l
	jsr	(printbigz1).l
	String	$F8,$04,$01,$07,$17,'<            >',$FD,$08
	move.w	(word_FFC74E).w,d0
	movea.w	#TeamList,a1
	asl.w	#2,d0
	movea.l	(a1,d0.w),a1
	adda.w	4(a1),a1
	adda.w	(a1),a1
	adda.w	(a1),a1
	jsr	(printbig1).l
	movem.l	(sp)+,d0-d7/a0-a6
	rts

ScorePeriodText	;ShowBigScore: the period names
	String	'  1st period    '
	String	'  2nd period    '
	String	'  3rd period    '
	String	'   overtime     '
	String	'     final      '

ClearBigScore	;Erase the big score
	movem.l	d0-d7/a0-a6,-(sp)
	bclr	#0,(byte_FFC35A).w
	jsr	(printz).l
	String	$BF,$01,$15
	move.w	#$1B,d0
	move.w	#4,d1
	move.w	#$7FF,d2
	jsr	(eraser).l
	jsr	(printz).l
	String	$BF,$08,$19
	move.w	#$14,d0
	move.w	#2,d1
	move.w	#$7FF,d2
	jsr	(eraser).l
	movem.l	(sp)+,d0-d7/a0-a6
	rts

SeasonAwards	;End of season awards: left / right go through the 9 awards (picture, name, description, winner),
	;start leaves
	movem.l	d0-d7/a0-a6,-(sp)
	jsr	(forceblack).l
	bsr.w	sub_1E83E6
	bsr.w	AwardsScreenSetup
	move.w	#$18,(palcount).w
	bclr	#2,(disflags).w
	clr.w	(word_FFD034).w
.draw
	jsr	(sub_1E7B64).l
	jsr	(DrawAwardPicture).l
	jsr	(PrintAwardName).l
	jsr	(PrintAwardDesc).l
	jsr	(PrintAwardWinner).l
	move.w	#$64,(palcount).w
	move	#$2500,sr
.frame
	move.w	(vcount).w,d0
.vwait
	cmp.w	(vcount).w,d0
	beq.s	.vwait
	jsr	(sub_12640).l
	jsr	(orjoy).l
	btst	#7,d1
	bne.w	.2
	btst	#2,d1
	beq.w	.1
	move.w	(word_FFD034).w,d0
	subq.w	#1,d0
	bpl.w	.0
	move.w	#8,d0
.0
	move.w	d0,(word_FFD034).w
	bra.s	.draw
.1
	btst	#3,d1
	beq.s	.frame
	move.w	(word_FFD034).w,d0
	addq.w	#1,d0
	cmp.w	#8,d0
	ble.s	.0
	clr.w	d0
	bra.s	.0
.2
	movem.l	(sp)+,d0-d7/a0-a6
	rts

sub_1E7B64	;SeasonAwards: a bitmap (sub_1E821C) at 3,8
	jsr	(printz).l
	String	$8F,$03,$08
	bsr.w	sub_1E821C
	move.w	(word_FFB02C).w,d4
	clr.w	d5
	jsr	(sub_12BB2).l
	rts

DrawAwardPicture	;Draw the picture of award word_FFD034 (AwardPictures)
	jsr	(printz).l
	String	$BF,$19,$09
	move.w	(word_FFD034).w,d0
	movea.l	#AwardPictures,a0
	asl.w	#2,d0
	movea.l	(a0,d0.w),a0
	movea.l	a0,a1
	movea.l	a0,a2
	adda.l	(a2)+,a0
	adda.l	(a2)+,a1
	clr.w	d0
	clr.w	d1
	moveq	#$A,d2
	moveq	#$A,d3
	moveq	#2,d5
	move.w	(word_FFD030).w,d4
	jsr	(dobitmap).l
	rts

AwardPictures	;The award picture bitmaps, one per award
	dc.l	HartPic,ArtRossPic,NorrisPic,VezinaPic,ConnSmythePic
	dc.l	PresidentsPic,WalesPic,CampbellPic,PearsonPic

PrintAwardName	;Print the name of award word_FFD034 (AwardNames)
	jsr	(printz).l
	String	$BF,$13,$05
	movea.l	#AwardNames,a1
	move.w	(word_FFD034).w,d0
	jsr	(SkipStrings).l
	move.w	(a1),d0
	subq.w	#2,d0
	lsr.w	#1,d0
	sub.w	d0,(printx).w
	bset	#2,(sflags11).w
	jsr	(printbig).l
	rts

AwardNames	;PrintAwardName Strings: the award names
	String	'hart memorial trophy'
	String	'  art ross trophy   '
	String	'james norris trophy '
	String	'   vezina trophy    '
	String	' conn smythe trophy '
	String	' presidents trophy  '
	String	'  prince of wales   '
	String	' clarence campbell  '
	String	' lester b. pearson  '

PrintAwardDesc	;Print the description of award word_FFD034 (AwardDescs)
	jsr	(printcurz).l
	String	$8F,$02,$14,'                ',$8F,$02,$15,'                ',$8F,$02,$16,'                ',$8F,$02,$17,'                ',$8F,$02,$18,'                '
	movea.l	#AwardDescs,a1
	move.w	(word_FFD034).w,d0
	jsr	(SkipStrings).l
	jsr	(printcur).l
	rts

AwardDescs	;PrintAwardDesc Strings: the award descriptions
	String	$8F,$02,$14,'to the player',$8F,$02,$15,'adjudged to be',$8F,$02,$16,'the most',$8F,$02,$17,'valuable to',$8F,$02,$18,'his team'
	String	$8F,$02,$14,'to the player',$8F,$02,$15,'who leads the',$8F,$02,$16,'league in points',$8F,$02,$17,'at the end of',$8F,$02,$18,'the reg. season'
	String	$8F,$02,$14,'to the defensive',$8F,$02,$15,'player showing',$8F,$02,$16,'the greatest all',$8F,$02,$17,'around ability',$8F,$02,$18,'in the position'
	String	$8F,$02,$14,'to the goalie',$8F,$02,$15,'adjudged to be',$8F,$02,$16,'the best at',$8F,$02,$17,'his position'
	String	$8F,$02,$14,'to the most',$8F,$02,$15,'valuable player',$8F,$02,$16,'for his team',$8F,$02,$17,'in the playoffs'
	String	$8F,$02,$14,'to the club',$8F,$02,$15,'finishing the',$8F,$02,$16,'regular season',$8F,$02,$17,'with the best',$8F,$02,$18,'record'
	String	$8F,$02,$14,'to the winners',$8F,$02,$15,'of the',$8F,$02,$16,'Eastern',$8F,$02,$17,'Conference',$8F,$02,$18,'Championship'
	String	$8F,$02,$14,'to the winners',$8F,$02,$15,'of the',$8F,$02,$16,'Western',$8F,$02,$17,'Conference',$8F,$02,$18,'Championship'
	String	$8F,$02,$14,'to the nhl''s',$8F,$02,$15,'outstanding',$8F,$02,$16,'player chosen by',$8F,$02,$17,'player members',$8F,$02,$18,'of the nhlpa'

PrintAwardWinner	;Print the winner of award word_FFD034: a team (TeamAwardFlags) or a player "F. Name"
	bset	#2,(sflags11).w
	jsr	(printbigz).l
	String	$F8,$04,$01,$17,$15,'              '
	bsr.w	sub_1E824C
	movea.l	#TeamAwardFlags,a0
	move.w	(word_FFD034).w,d1
	tst.b	(a0,d1.w)
	beq.w	.0
	move.w	d0,d7
	asl.w	#2,d7
	movea.l	#TeamList,a1
	movea.l	(a1,d7.w),a1
	adda.w	4(a1),a1
	bra.w	.1
.0
	swap	d0
	jsr	(GetCreatedName).l
	movea.l	a1,a0
	move.l	a0,-(sp)
	movea.w	#(TextBuffer-M68K_RAM),a1
	adda.w	(a0),a0
	move.b	(a0),d0
	movea.l	(sp)+,a0
	move.w	(a0)+,d0
	lea	-2(a0,d0.w),a2
	move.b	(a0)+,(a1)+
	move.b	#$2E,(a1)+
	move.b	#$20,(a1)+
.skipfirst
	cmpi.b	#$20,(a0)+
	bne.s	.skipfirst
.copy
	move.b	(a0)+,(a1)+
	cmpa.l	a0,a2
	bne.s	.copy
	jsr	(FinalizeTextBuffer).l
	movea.l	#mesarea,a1
.1
	jsr	(printz).l
	String	$BF,$1E,$15
	move.w	(a1),d0
	subq.w	#2,d0
	lsr.w	#1,d0
	sub.w	d0,(printx).w
	bset	#2,(sflags11).w
	jsr	(printbig).l
	rts

TeamAwardFlags	;Nonzero for a team award
	dc.b	0,0,0,0,0,1,1,1,0,$FF

AwardsScreenSetup	;Awards screen setup: vram, fonts and the background bitmaps
	bset	#5,(sflags12).w
	move.l	#unk_12D46,(vbint).w
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
	bset	#5,(disflags).w
	jsr	(setVram).l
	bclr	#5,(disflags).w
	jsr	(orjoy).l
	move.w	#1,d4
	movea.l	#unk_1B11B0,a1
	jsr	(sub_1217A).l
	move.w	#$1E,d4
	move.w	d4,(smallfontchars).w
	movea.l	#SmallFontMap2+8,a2
	jsr	(DecompressGraphicsPlain).l
	move.l	#SmallFontMap2,(smallfontptr).w
	move.w	d4,(BigFontChars).w
	movea.l	#BigFontMap4+8,a2
	jsr	(DecompressGraphicsPlain).l
	bset	#2,(sflags11).w
	jsr	(printsmallz).l
	String	$FF,$01,$FD,$00,$FC
	moveq	#$28,d0
	moveq	#$1C,d1
	move.w	#$7FF,d2
	jsr	(eraser).l
	jsr	(printz).l
	String	$BF,$00,$00
	movea.l	#unk_1AF782,a0
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
	move.w	d4,(word_FFB02C).w
	addi.w	#$A0,d4
	move.w	d4,(word_FFD030).w
	addi.w	#$64,d4
	jsr	(printz).l
	String	$BF,$0B,$01
	movea.l	#unk_1AEF62,a0
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
	movea.l	#unk_1B11B0,a0
	jsr	(sub_1218A).l
	rts

sub_1E821C	;Called from sub_1E7B64
	;Code the listing does not decode: kept as bytes
	dc.b	$20,$7C,$FF,$FF,$D1,$30,$20,$3C,$00,$00,$0D,$94,$32,$38,$D0,$34
	dc.b	$B2,$7C,$00,$08,$66,$00,$00,$04,$42,$41,$C2,$FC,$00,$04,$D0,$81
	dc.b	$32,$3C,$00,$04,$4E,$B9,$00,$02,$41,$E8,$3E,$28,$00,$02,$4E,$75
