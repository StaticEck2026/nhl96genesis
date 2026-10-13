;	Falls and injuries, the wall and goal collisions (checkwallcoll, checkgoal with Goal, wallcoll, puckbody), the
;	player energy (makepde, getpde, setpde) and putting players on the ice (setpersonel, SetPlList, ResetBench,
;	setplayer).

FallDown	;Player a3 falls down (a check or the puck): the fall animation, the injury chance, the penalty
	cmpi.w	#$B,SCnum(a2)
	bgt.w	rtss2
	cmpi.w	#SPA17E4,SPA(a2)
	blt.w	.0
	cmpi.w	#SPA1F76,SPA(a2)
	ble.w	rtss2
.0
	cmpi.w	#SPA12EC,SPA(a2)
	beq.w	rtss2
	cmpi.w	#SPA2576,SPA(a2)
	beq.w	rtss2
	cmpi.w	#SPA26C8,SPA(a2)
	beq.w	rtss2
	cmpi.w	#SPA0F14,SPA(a2)
	beq.w	rtss2
	cmpa.l	(PlayerChked).w,a2
	bne.w	.1
	cmpa.l	(PlayerChking).w,a3
	bne.w	.1
	rts
.1
	move.l	a2,(PlayerChked).w	;player checked
	move.l	a3,(PlayerChking).w	;player checking
	btst	#3,pflags3(a2)	;is player a2 doing a one-timer
	bne.w	rtss2
	btst	#3,pflags3(a3)	;Is player a3 doing a one-timer
	bne.w	rtss2
	move.w	#SPA12EC,d1
	btst	#4,pflags3(a3)	;wall collision bit
	bne.w	.cont2
	cmpi.b	#$18,$72(a2)
	blt.w	.cont2
	tst.b	$5F(a2)	;check if puck collision possible
	bne.w	.cont2
	move.w	(VDP_CNTR).l,d0	;frame counter
	andi.w	#$F,d0	;pass 1st byte of d0
	addi.w	#$10,d0
	cmp.w	impact(a2),d0	;compare impact value to d0.
	ble.w	.cont2
	move.b	#$3C,$5F(a2)	;move 3C (60 decimal) into nopuck
	bra.w	loc_1E462
.cont2
	tst.w	position(a3)	;check for goalie
	beq.w	.chkpos
	movea.w	#(tmstruct-M68K_RAM),a0	;Start of Home Team Stats Struct
	btst	#6,pflags(a3)
	beq.w	.AddChktoPlayerStats
	adda.w	#$39E,a0	;Change to Away Team Stats
.AddChktoPlayerStats
	addq.w	#1,$10(a0)	;Add 1 Chk to Team Total
	clr.w	d0
	move.b	$67(a3),d0
	adda.w	d0,a0
	addq.b	#1,$130(a0)
	addq.w	#1,(ChkCnt).w	;Add 1 to ChkCnt
	tst.b	$75(a3)
	bne.w	.chkpos
	addq.w	#2,(ChkCnt).w	;add 2 to ChkCnt
.chkpos
	move.b	#$78,nopuck(a2)
	move.w	(a3),d0	;Xpos
	sub.w	(a2),d0	;sub Xpos
	move.w	Ypos(a3),d1
	sub.w	Ypos(a2),d1	;sub Ypos
	bsr.w	vtoa
	tst.w	position(a2)
	beq.w	loc_1E41A
	jsr	(sub_1D72F6).l	;check for wall collision
	btst	#4,pflags3(a2)	;check wall collision bit
	beq.w	loc_1E41A
	movem.l	d1-d4,-(sp)
	move.w	Xvel(a2),d1
	bpl.w	.yvel
	neg.w	d1	;negate d1
.yvel
	move.w	Yvel(a2),d2
	bpl.w	.chkpos2
	neg.w	d2	;negate d2
.chkpos2
	move.w	(a2),d3	;Xpos of player into d3
	sub.w	(a3),d3	;sub Xpos of checker
	move.w	Ypos(a2),d4
	sub.w	Ypos(a3),d4
	cmpi.w	#$11E,Ypos(a3)
	bgt.w	.bnet1
	cmpi.w	#$FEE2,Ypos(a3)
	blt.w	.bnet2
	tst.w	(a3)	;In between goal lines
	bpl.w	.posx
	tst.w	d3	;check diff of Xpos
	bpl.w	.chktowardcenterice
	cmp.w	#$FFFD,d3	;comp diff of Xpos with -3
	bgt.w	.chktowardcenterice
	bra.w	.chkawayfromcenterice
.posx
	tst.w	d3	;check diff of Xpos
	bmi.w	.chktowardcenterice
	cmp.w	#3,d3	;comp diff of Xpos with 3
	blt.w	.chktowardcenterice
	bra.w	.chkawayfromcenterice
.bnet2
	tst.w	d4	;check diff of Ypos
	bpl.w	.chktowardcenterice
	bra.w	.chkawayfromcenterice
.bnet1
	tst.w	d4	;check diff of Ypos
	bmi.w	.chktowardcenterice
	bra.w	.chkawayfromcenterice
.chktowardcenterice
	movem.l	(sp)+,d1-d4
	bra.w	loc_1E41A
.chkawayfromcenterice
	movem.l	(sp)+,d1-d4	;pop from stack
	bra.w	*+4	;to the next instruction (.playerpos)
.10
	cmpi.w	#$122,Ypos(a2)
	bgt.w	.chkawayfrommiddle
	cmpi.w	#$FEDE,Ypos(a2)
	blt.w	.chkawayfrommiddle
	cmpi.w	#$76,(a2)
	bgt.w	.chkawayfrommiddle
	cmpi.w	#$FF8A,(a2)
	blt.w	.chkawayfrommiddle
	bra.w	loc_1E41A
.chkawayfrommiddle
	cmpi.w	#$B,SCnum(a3)
	bgt.w	.12
	addi.w	#$A,(CwdExciteLvl).w
	addi.w	#$96,(crowdlevel).w
	move.w	d1,-(sp)	;push to stack
	move.b	#0,$40(a3)
	move.b	#0,$66(a3)
	move.w	#SPA15B8,d1
	jsr	(SetSPA).l	;set animation
	clr.w	Xvel(a3)
	clr.w	Yvel(a3)
	move.w	(sp)+,d1	;pop from stack
.12
	movem.l	d0/a0,-(sp)	;push to stack
	cmpi.w	#$122,Ypos(a2)
	bgt.w	.playerabovetopgoalline
	cmpi.w	#$FEDE,Ypos(a2)
	blt.w	.playerbelowbottomgoalline
	tst.w	(a2)	;test player Xpos
	bmi.w	.playerleftofcenter
	move.w	#2,d0	;player right of center
	bra.w	.getchkanim
.playerleftofcenter
	move.w	#6,d0
	bra.w	.getchkanim
.playerabovetopgoalline
	move.w	#0,d0
	bra.w	.getchkanim
.playerbelowbottomgoalline
	move.w	#4,d0
.getchkanim
	add.w	d0,d0
	movea.l	#unk_1E40A,a0
	move.w	(a0,d0.w),d1
	move.w	Ypos(a2),(FallYPos).w
	move.w	(a2),(FallXPos).w
	cmp.w	#$24C4,d1
	bne.w	.2
	cmpi.w	#$59,Ypos(a2)
	bgt.w	.2
	cmpi.w	#$FFA7,Ypos(a2)
	blt.w	.2
	move.w	d0,-(sp)
	move.w	#7,d0
	jsr	(nullsub_7).l
	move.w	(sp)+,d0
	addq.w	#3,(ChkCnt).w
	move.w	#SPAboardmidl,d1
	btst	#3,attribute(a2)
	beq.w	.20
	bra.w	.20
.2
	addq.w	#2,(ChkCnt).w
	btst	#3,attribute(a2)
	beq.w	.20
	cmp.w	#$2360,d1
	beq.w	.19
	cmp.w	#$24C4,d1
	bne.w	.20
	move.w	#SPAboardleft,d1
	bra.w	.20
.19
	move.w	#SPAboardmidr,d1
.20
	clr.w	Xvel(a2)
	clr.w	Yvel(a2)
	btst	#5,pflags3(a2)
	bne.w	.22
	move.w	#$C,-(sp)
	btst	#6,pflags(a2)
	beq.w	.21
	move.w	#$B,(sp)
.21
	jsr	(sfx).l
.22
	bset	#5,pflags3(a2)	;set falldown bit
	bset	#0,pflags(a2)
	movem.l	(sp)+,d0/a0	;pop from stack
	bra.w	loc_1E434

unk_1E40A	;FallDown table
	dc.b	$22,$AE,$22,$AE,$23,$60,$23,$60,$24,$12,$24,$12,$24,$C4,$24,$C4

loc_1E41A
	move.w	#$26C8,d1
	sub.w	$54(a2),d0
	addq.w	#1,d0
	andi.w	#7,d0
	cmp.w	#2,d0
	bls.w	loc_1E462
	move.w	#$2576,d1

loc_1E434
	move.w	$54(a2),d0
	andi.w	#3,d0
	bne.w	loc_1E462
	cmpi.b	#$14,$76(a3)
	blt.w	loc_1E462
	cmpi.w	#$B,$52(a3)	;check if SCNum of checker is a player
	bgt.w	loc_1E462
	btst	#5,$64(a2)	;check if falldown bit is set for player
	bne.w	loc_1E462
	move.w	#$F14,d1

loc_1E462
	exg	a2,a3	;swap a2 and a3
	bset	#5,$62(a3)
	bsr.w	SetSPA
	exg	a2,a3
	tst.w	$34(a3)
	beq.w	.0
	tst.w	$34(a2)
	beq.w	.0
	addi.w	#$12C,(crowdlevel).w
	addi.w	#$F,(CwdExciteLvl).w
.0
	move.w	(puckc).w,d0	;move puck carrier SCNum into d0
	bmi.w	.6
	cmp.w	$52(a2),d0	;check if puck carrier is a2
	bne.w	.6
	st	(puckc).w	;clear out puck carrier
	btst	#4,(gmode).w	;check if highlight
	bne.w	.4
	cmpi.w	#$26C8,$58(a2)
	bne.w	.4
	move.w	$54(a2),d0	;facedir into d0
	andi.w	#3,d0	;pass first 2 bits of d0
	bne.w	.4
	btst	#4,$63(a2)	;check if player is unavailable
	bne.w	.4
	move.w	#$DC,d0
	bsr.w	randomd0
	cmp.w	$32(a2),d0	;compare impact to d0
	bgt.w	.4
	btst	#0,(gmode).w	;check if clock running
	bne.w	.4
	exg	a2,a3
	move.w	#$17E4,d1
	btst	#0,(seed+1).w
	beq.w	.1
	move.w	#$1EAC,d1
.1
	bsr.w	SetSPA
	exg	a2,a3
	bsr.w	setInjuryType
	btst	#5,(sflags7).w	;check if clock running
	bne.w	.3
	exg	a2,a3
	move.w	#$188E,d1
	btst	#0,(seed+1).w
	bne.w	.2
	move.w	#$1F76,d1
.2
	bsr.w	SetSPA
	exg	a2,a3
.3
	move.w	#4,(InjCntDown).w
	moveq	#$14,d0
	tst.w	$34(a3)
	beq.w	.7
	tst.w	(OptPen).w
	beq.w	.7
	moveq	#$12,d0
	jsr	(AddPenalty2).l
	jmp	Stop4Pen
.4
	addq.w	#5,(ChkCnt).w
	move.w	#$B,-(sp)
	btst	#6,$62(a2)
	bne.w	.5
	move.w	#$C,(sp)
.5
	jsr	(song).l
	rts
.6
	jmp	newcheck
.7
	jmp	AddPenalty2

setInjuryType	;a2 injured: out for the period ($FFFD) or the game ($FFFC); in a season a random games count (SetInjuryGames)
	bclr	#2,(sflags13).w
	addq.w	#5,(ChkCnt).w
	move.w	d0,-(sp)
	bset	#2,pflags2(a2)
	addi.w	#$12C,(crowdlevel).w
	addi.w	#$1E,(CwdExciteLvl).w
	move.w	#$D,-(sp)	;sound effect
	jsr	(sfx).l
	move.w	(a2),(xc1).w	;move Xpos to scroll center
	move.w	Ypos(a2),(yc1).w
	bset	#6,(sflags).w
	clr.w	d1	;clear d1
	movea.w	#(tmstruct-M68K_RAM),a0	;move Home team Struct to a0
	btst	#6,pflags(a2)
	beq.w	.0	;branch if home
	move.w	#$8000,d1
	adda.w	#$39E,a0	;add $364 to a0 (Away Team Struct start)
.0
	move.b	$67(a2),d1
	move.w	d1,(TempPlOffset).w
	ext.w	d1	;sign extend - in this case just makes upper bye of word 00
	add.w	d1,d1	;add d1 to itself
	exg	a2,a3	;swap a2 and a3
	jsr	(sub_1D9062).l	;get the Fgt byte (divided by 4)
	exg	a2,a3	;swap back
	tst.w	d0	;check if d0 is zero
	bne.w	.not0
	bclr	#5,(sflags7).w	;clear injury game bit
	move.w	#$FFFD,$6C(a0,d1.w)
	bra.w	.1
.not0
	cmp.w	#3,d0	;compare d0 to 3 (if H/F was 12, d0 = 3)
	beq.w	.2
	bclr	#5,(sflags7).w
	move.w	#$FFFD,$6C(a0,d1.w)
	jsr	(sub_1D906C).l	;check Fgt bit 1 of player.
	beq.w	.1
.2
	bset	#5,(sflags7).w	;set injury game bit
	move.w	#$FFFC,$6C(a0,d1.w)
	btst	#7,(GameFlags).w
	beq.w	.1
	jsr	(sub_1E8794).l
.1
	move.w	(sp)+,d0
	rts

checkwallcoll	;d2/d3 = x/y to test, a3 = object, wcradiusx/wcradiusy = radius. Check the corner circles, the goals
	;(checkgoal with a2 = SortCords+(13*SCstruct) top, SortCords+(12*SCstruct) bottom) and then the side and end
	;boards. Calls wallcollb on a hit, with d0/d1 = cos/sin of the wall.
	bclr	#4,pflags3(a3)	;wall collision bit
	move.w	#$96,d4
	sub.w	(wcradiusx).w,d4
	move.w	#$148,d5
	sub.w	(wcradiusy).w,d5
	movem.w	d2-d5,-(sp)
	neg.w	d4
	neg.w	d5
	addi.w	#$40,d4
	addi.w	#$40,d5
	cmp.w	d5,d3
	bgt.w	.ctc
	cmp.w	d4,d2
	blt.w	.circle
	neg.w	d4
	cmp.w	d4,d2
	bgt.w	.circle
	movea.w	#(SortCords+$680-M68K_RAM),a2
	bsr.w	checkgoal
	bra.w	.exit
.ctc
	neg.w	d5
	cmp.w	d5,d3
	blt.w	.exit
	cmp.w	d4,d2
	blt.w	.circle
	neg.w	d4
	cmp.w	d4,d2
	bgt.w	.circle
	movea.w	#(SortCords+$600-M68K_RAM),a2
	bsr.w	checkgoal
	bra.w	.exit
.circle
	sub.w	d4,d2
	sub.w	d5,d3
	move.w	d3,d0
	move.w	d2,d1
	neg.w	d1
	muls.w	d3,d3
	muls.w	d2,d2
	add.l	d2,d3
	cmp.l	#$1000,d3
	bls.w	.exit
	exg	d0,d3
	bsr.w	sroot
	exg	d0,d3
	ext.l	d0
	asl.l	#8,d0
	divs.w	d3,d0
	ext.l	d1
	asl.l	#8,d1
	divs.w	d3,d1
	bsr.w	wallcollb
.exit
	movem.w	(sp)+,d2-d5
	move.w	$4E(a3),d0
	or.w	$50(a3),d0
	bne.w	rtss2
	move.w	#$100,d0	;now check side walls
	clr.w	d1
	cmp.w	d5,d3
	bge.w	wallcollb
	neg.w	d5
	neg.w	d0
	cmp.w	d5,d3
	ble.w	wallcollb
	exg	d0,d1
	cmp.w	d4,d2
	bge.w	wallcollb
	neg.w	d4
	neg.w	d1
	cmp.w	d4,d2
	ble.w	wallcollb
	rts

checkgoal	;Check object a3 against the goal / net a2: the puck scores (Goal), a player collides (checkgoalp)
	cmpi.w	#$D,Zpos(a3)
	bgt.w	rtss2
	cmpi.w	#$E,SCnum(a3)
	bne.w	checkgoalp	;coll with player not puck
	tst.w	(puckc).w
	bmi.w	.8
	movem.l	d0/a0,-(sp)
	move.w	(puckc).w,d0
	asl.w	#7,d0
	movea.l	#SortCords,a0
	adda.w	d0,a0
	move.w	Ypos(a0),d4
	movem.l	(sp)+,d0/a0
	cmp.w	#$11E,d4
	bgt.w	.8
	cmp.w	#$FEE2,d4
	bge.w	rtss2
.8
	sub.w	(a2),d2	;Xpos
	moveq	#$10,d4
	add.w	(wcradiusx).w,d4
	cmp.w	d4,d2
	bgt.w	rtss2
	neg.w	d4
	cmp.w	d4,d2
	blt.w	rtss2
	sub.w	Ypos(a2),d3
	move.w	#2,d5
	add.w	(wcradiusy).w,d5
	cmp.w	d5,d3
	bgt.w	rtss2
	neg.w	d5
	cmp.w	d5,d3
	blt.w	rtss2
	st	(collflag).w	;inside goal area now
	cmpi.w	#$D,OldZpos(a3)	;compare OldZpos to zside
	blt.w	.nod
	move.w	OldZpos(a3),Zpos(a3)
	bra.w	.7
.nod
	bclr	#7,pflags(a3)
	move.w	(puckc).w,d0
	bmi.w	.nocon
	st	(puckc).w
	asl.w	#7,d0
	movea.w	#(SortCords-M68K_RAM),a0
	move.b	#8,nopuck(a0,d0.w)
	move.w	(pucky).w,d1
	btst	#7,pflags(a0,d0.w)
	bne.w	.an
	neg.w	d1
.an
	tst.w	d1
	bpl.w	.nocon
	bset	#7,pflags(a3)
.nocon
	move.w	#$FF00,d0
	move.l	Ypos(a3),d1
	sub.l	OldYpos(a3),d1
	asr.l	#8,d1
	beq.w	.sideentry
	bmi.w	.3
	neg.w	d0	;check top entry
	neg.w	d5
.3
	add.w	d3,d5
	move.l	(a3),d3
	sub.l	OldXpos(a3),d3
	asr.l	#8,d3
	muls.w	d3,d5
	divs.w	d1,d5
	bvs.w	.sideentry
	sub.w	d5,d2
	cmp.w	d4,d2
	blt.w	.sideentry
	neg.w	d4
	cmp.w	d4,d2
	bgt.w	.sideentry
	clr.w	d1
	move.w	Ypos(a3),d3
	eor.w	d0,d3
	bmi.w	wallcoll
	neg.w	d0
	btst	#7,pflags(a3)
	bne.w	wallcoll
	cmpi.w	#$D,Zpos(a3)
	beq.w	.10
	subq.w	#1,d4
	cmp.w	d4,d2
	bgt.w	.10
	neg.w	d4
	cmp.w	d4,d2
	bge.w	.17
.10
	bsr.w	ChkShotStat
	move.w	#$25,-(sp)	;sfx $25 when the clock is stopped
	btst	#0,(gmode).w	;gmclock: no goal after the whistle
	bne.w	.5
	move.w	#8,(sp)	;sfx 8 and crowd
	addi.w	#$12C,(crowdlevel).w
	addi.w	#$28,(CwdExciteLvl).w
.5
	jsr	(sfx).l
	move.w	#$1000,d0
	bsr.w	randomd0
	tst.w	Ypos(a3)
	bmi.w	.df0
	neg.w	d0
.df0
	move.w	d0,Yvel(a3)
	move.w	#$1000,d0
	bsr.w	randomd0s
	move.w	d0,Xvel(a3)
	move.w	#$1000,d0
	bsr.w	randomd0s
	move.w	d0,Zvel(a3)
	bra.w	puckflip
.7
	neg.w	Zvel(a3)
	bpl.w	rtss2
	neg.w	Zvel(a3)
	rts
.sideentry
	clr.w	d0
	move.w	#$100,d1
	move.w	(a3),d2
	sub.w	OldXpos(a3),d2
	bmi.w	wallcoll
	neg.w	d1
	bra.w	wallcoll
.17
	tst.w	(puckc).w
	bpl.w	rtss2
	btst	#2,(BA_PS_flags).w
	beq.w	.6
	btst	#0,(gmode2).w
	bne.w	.0
	movem.l	d0/a0,-(sp)
	move.w	(BA_Sktr_SCnum).w,d0
	asl.w	#7,d0
	movea.l	#SortCords,a0
	adda.w	d0,a0
	btst	#7,pflags(a0)
	movem.l	(sp)+,d0/a0
	bne.w	.1
	bra.w	.2
.0
	tst.w	(shootoutteam).w
	bne.w	.2
.1
	tst.w	(pucky).w
	bmi.w	rtss2
	bra.w	.18
.2
	tst.w	(pucky).w
	bpl.w	rtss2
.18
	bset	#5,(sflags4).w
	tst.w	(shootoutteam).w
	beq.w	.4
	addq.w	#1,(awayshootgoals).w
	bra.w	.19
.4
	addq.w	#1,(homeshootgoals).w
.19
	bset	#0,(sflags8).w
	jsr	(EndPenaltyShotPlay).l
	bra.w	.20
.6
	btst	#0,(gmode).w
	bne.w	rtss2
.20
	bset	#0,(sflags4).w
	bclr	#3,(sflags8).w
	bsr.w	ChkShotStat
	jsr	(stop_current_song).l
	move.w	d0,-(sp)
	move.w	(vcount).w,d0
.loop
	cmp.w	(vcount).w,d0
	beq.s	.loop
	move.w	(sp)+,d0
	addq.w	#5,(ChkCnt).w
	move.w	#0,-(sp)
	jsr	(sfx).l
	jsr	(LockScroll).l
	addi.w	#$1F4,(crowdlevel).w
	movea.w	#(tmstruct-M68K_RAM),a2
	lea	$39E(a2),a1
	tst.w	Ypos(a3)
	bpl.w	.9
	exg	a2,a1
.9
	btst	#1,(gmode).w
	beq.w	.23
	exg	a2,a1
.23
	cmpi.w	#$7D,$C(a2)
	bge.w	.28
	addq.w	#1,$C(a2)
.28
	btst	#5,(sflags4).w
	beq.w	.11
	btst	#0,(gmode2).w
	bne.w	.11
	addq.w	#1,$39C(a2)
.11
	bclr	#4,(gmode2).w
	beq.w	.12
	addq.w	#1,$394(a2)
.12
	btst	#5,(sflags2).w
	beq.w	.14
	btst	#6,(sflags2).w
	bne.w	.13
	cmpa.l	#AwShots,a2
	bne.w	.14
.loop2
	addq.w	#1,$390(a2)
	bra.w	.14
.13
	cmpa.l	#tmstruct,a2
	beq.s	.loop2
.14
	movem.l	d0/a2,-(sp)
	move.w	(gsp).w,d0
	add.w	d0,d0
	adda.w	d0,a2
	addq.w	#1,$37C(a2)
	movem.l	(sp)+,d0/a2
	bclr	#7,(sflags8).w
	beq.w	.15
	addq.w	#1,$398(a2)
.15
	cmpa.w	#(tmstruct-M68K_RAM),a2
	bne.w	.16
	move.w	(HomeTeam).w,(HmTeam).w
	move.w	#3,(SongIndex).w
	jsr	(ChooseSong).l
	move.w	#$78,(songdelay).w
	move.w	(SongNum).w,-(sp)
	move.w	(sp)+,(delayedsong).w
.16
	cmpi.w	#$168,(ScoreSumbytes).w
	bne.w	.sum
	subq.w	#6,(ScoreSumbytes).w
.sum
	movea.w	#(ScoreSum-M68K_RAM),a0
	adda.w	(ScoreSumbytes).w,a0
	addq.w	#6,(ScoreSumbytes).w
	bsr.w	GetPeriodTimeRemaining
	move.w	d0,(a0)+
	moveq	#2,d0
	add.w	OldZpos(a2),d0
	sub.w	OldZpos(a1),d0
	move.b	d0,(a0)+
	addi.w	#$1E,(CwdExciteLvl).w
	cmpa.w	#(tmstruct-M68K_RAM),a2
	beq.w	.home
	subi.w	#$14,(CwdExciteLvl).w
	bset	#7,-1(a0)
.home
	move.w	Zpos(a2),d0
	move.b	d0,(a0)+
	move.w	#$FFFF,(a0)
	addi.w	#$C0,d0
	addq.b	#1,(a2,d0.w)
	move.w	$1A(a2),d0
	bmi.w	.21
	cmp.w	Zpos(a2),d0
	beq.w	.21
	move.b	d0,(a0)+
	addi.w	#$DC,d0
	addq.b	#1,(a2,d0.w)
	move.w	OldXpos(a2),d0
	bmi.w	.21
	cmp.w	Zpos(a2),d0
	beq.w	.21
	move.b	d0,(a0)
	addi.w	#$DC,d0
	addq.b	#1,(a2,d0.w)
.21
	move.w	$26(a1),d0
	bmi.w	.22
	addi.w	#$C0,d0
	addq.b	#1,(a1,d0.w)
.22
	bsr.w	ChkShotStat
	bsr.w	PenGoalStuff
	bclr	#3,(BA_PS_flags).w
	bsr.w	nullsub_4
	move.w	#$2710,(crowdnoisedelay).w
	btst	#0,(gmode2).w
	beq.w	.24
	bra.w	.25
.24
	moveq	#7,d0
	bsr.w	AssignTeam
.25
	clr.w	(collflag).w
	clr.w	Xvel(a3)
	clr.w	Yvel(a3)
	moveq	#6,d0
	tst.w	(a3)
	bpl.w	.26
	neg.w	d0
.26
	move.w	d0,(a3)
	move.w	#$126,d0
	tst.w	Ypos(a3)
	bpl.w	.27
	neg.w	d0
.27
	move.w	d0,Ypos(a3)
	move.w	#$600,Zvel(a3)
	clr.w	Zpos(a3)
	st	(puckcross2).w
	st	(puckcross6).w
	bset	#2,pflags(a3)
	move.w	#$1A,d0
	bsr.w	assreplace
	move.l	a3,-(sp)
	adda.w	#$80,a3
	move.w	#$28CE,d1
	tst.w	Ypos(a3)
	bpl.w	.29
	move.w	#$2920,d1
.29
	bsr.w	SetSPA
	movea.w	$22(a1),a3
	moveq	#$E,d0
	jsr	(AddPenalty2).l
	movea.l	(sp)+,a3
	rts

AssignTeam	;Give assignment d0 to every player of team a2 on the ice (assinsert)
	move.l	a3,-(sp)
	movea.w	$22(a2),a3
	moveq	#5,d3
.loop
	tst.w	position(a3)
	ble.w	.next
	btst	#0,pflags2(a3)
	bne.w	.next
	bclr	#2,pflags(a3)
	bclr	#3,pflags3(a3)
	beq.w	.0
	jsr	(sub_1D9376).l
.0
	bsr.w	assinsert
.next
	adda.w	#$80,a3
	dbf	d3,.loop
	movea.l	(sp)+,a3
	rts

GetPeriodTimeRemaining	;Return d0 = (gsp << 14 | PerTimeTotal) - gameclock
	move.w	(gsp).w,d0
	swap	d0
	clr.w	d0
	lsr.l	#2,d0
	or.w	(PerTimeTotal).w,d0
	sub.w	(gameclock).w,d0
	rts

checkgoalp	;Check for player a3 collision with goal/net a2. Entered from checkgoal
	btst	#5,pflags2(a3)	;pflags2 bit 5: no player coll
	bne.w	rtss2
	cmpi.w	#$A,Zpos(a3)
	bgt.w	rtss2
	cmpi.w	#$B,SCnum(a3)
	bgt.w	rtss2
	tst.w	position(a3)
	beq.w	.0
	movem.w	d2-d3,-(sp)
	sub.w	Ypos(a2),d3
	move.w	d3,d0
	sub.w	(a2),d2
	move.w	d2,d1
	neg.w	d0
	asl.w	#4,d2
	muls.w	d2,d2
	divu.w	#$400,d2
	cmp.w	#$100,d2
	bhi.w	.exit
	asl.w	#4,d3
	muls.w	d3,d3
	divu.w	#$79,d3
	add.w	d2,d3
	cmp.w	#$100,d3
	bhi.w	.exit
	movem.w	(sp)+,d2-d3
	bsr.w	CheckBump
	movem.w	d2-d3,-(sp)
	movem.w	d0-d1,-(sp)
	muls.w	d0,d0
	muls.w	d1,d1
	add.l	d1,d0
	bsr.w	sroot
	move.w	d0,d2
	movem.w	(sp)+,d0-d1
	addq.w	#1,d2
	asl.l	#8,d0
	divs.w	d2,d0
	asl.l	#8,d1
	divs.w	d2,d1
	bset	#4,(sflags6).w	;wallcoll: do not set the wall collision bit
	bsr.w	wallcoll
	bclr	#4,(sflags6).w
.exit
	movem.w	(sp)+,d2-d3
	rts
.0
	movem.w	d2-d3,-(sp)
	btst	#3,pflags(a3)
	bne.w	.1
	movem.w	d0,-(sp)
	move.w	Ypos(a3),d0
	btst	#7,pflags(a3)
	beq.w	.6
	neg.w	d0
.6
	cmp.w	#$11E,d0
	movem.w	(sp)+,d0
	bge.w	.1
	cmpi.w	#2,facedir(a3)
	beq.s	.exit
	cmpi.w	#6,facedir(a3)
	beq.s	.exit
.1
	sub.w	Ypos(a2),d3
	move.w	d3,d0
	sub.w	(a2),d2
	move.w	d2,d1
	neg.w	d0
	asl.w	#4,d2
	muls.w	d2,d2
	divu.w	#$384,d2
	cmp.w	#$100,d2
	bhi.s	.exit
	asl.w	#4,d3
	muls.w	d3,d3
	divu.w	#$64,d3
	add.w	d2,d3
	cmp.w	#$100,d3
	bhi.s	.exit
	movem.w	(sp)+,d2-d3
	bsr.w	CheckBump
	movem.w	d2-d3,-(sp)
	movem.w	d0-d1,-(sp)
	muls.w	d0,d0
	muls.w	d1,d1
	add.l	d1,d0
	bsr.w	sroot
	move.w	d0,d2
	movem.w	(sp)+,d0-d1
	addq.w	#1,d2
	asl.l	#8,d0
	divs.w	d2,d0
	asl.l	#8,d1
	divs.w	d2,d1
	bset	#4,(sflags6).w	;wallcoll: do not set the wall collision bit
	bsr.w	wallcoll
	bclr	#4,(sflags6).w
	bra.w	.exit

CheckBump	;Supply minimum separation velocity for coll with walls/goal/net. a2 = goal, a3 = player. On one frame in 32,
	;a player near the puck in y moving faster than $24CC knocks the net (a2 gets a quarter of a3's velocity, a3
	;stops, scroll lock at Vpos) and, while the clock runs, calls penalty 8. Called from checkgoalp
	movem.l	d0-d1,-(sp)
	move.w	(VDP_CNTR).l,d0
	andi.w	#$1F,d0
	bne.w	.ex
	move.w	(pucky).w,d0
	sub.w	Ypos(a2),d0
	cmp.w	#$28,d0
	bgt.w	.ex
	cmp.w	#$FFD8,d0
	blt.w	.ex
	move.w	Xvel(a3),d0
	move.w	Yvel(a3),d1
	cmp.w	#$2000,d0
	bgt.w	.0
	cmp.w	#$E000,d0
	blt.w	.0
	cmp.w	#$2000,d1
	bgt.w	.0
	cmp.w	#$E000,d1
	blt.w	.0
.ex
	movem.l	(sp)+,d0-d1
	rts
.0
	btst	#0,(gmode2).w
	bne.s	.ex
	adda.w	#$C,sp	;drop the saved d0-d1 and the return to checkgoalp: return to checkgoal's caller
	asr.w	#2,d0
	asr.w	#2,d1
	move.w	d0,Xvel(a2)
	move.w	d1,Yvel(a2)
	clr.w	Xvel(a3)
	clr.w	Yvel(a3)
	bset	#6,(sflags).w
	btst	#0,(gmode).w
	bne.w	rtss2
	moveq	#8,d0
	jmp	AddPenalty2

wallcollb	;Bounce off the boards
	cmpi.w	#$E,SCnum(a3)
	bne.w	wallcoll
	cmpi.w	#$1D,Zpos(a3)
	bgt.w	.1
	cmpi.w	#$12,Zpos(a3)
	bls.w	wallcoll
	cmpi.w	#$118,Ypos(a3)
	blt.w	.1
	cmpi.w	#$46,(a3)
	blt.w	wallcoll
	cmpi.w	#$4A,(a3)
	bgt.w	wallcoll
	cmpi.w	#$FA0,Yvel(a3)
	blt.w	wallcoll
	move.l	a3,-(sp)
	asr	Yvel(a3)
	adda.w	#$80,a3
	move.w	#$48,(a3)
	move.w	#$13C,Ypos(a3)
	move.w	#$18,Zpos(a3)
	clr.w	Xvel(a3)
	clr.w	Yvel(a3)
	clr.w	Xvel(a3)
	move.w	#$2B88,d1
	bsr.w	SetSPA
	movea.l	(sp)+,a3
	move.w	#$E,-(sp)
	jsr	(sfx).l
	addi.w	#$258,(crowdlevel).w
	addi.w	#$F,(CwdExciteLvl).w
.1
	bset	#6,(sflags).w
	bset	#2,pflags(a3)
	tst.w	Ypos(a3)
	bpl.w	.2
	ori.w	#$8000,attribute(a3)
.2
	clr.w	$86(a3)	;frame+SCstruct(a3)
	btst	#0,(gmode).w
	bne.w	rtss2
	move.l	a3,-(sp)
	move.w	(ltplayer).w,d0
	asl.w	#7,d0	;#scsize
	movea.w	#(SortCords-M68K_RAM),a3
	adda.w	d0,a3
	moveq	#6,d0
	jsr	(AddPenalty2).l
	movea.l	(sp)+,a3
	rts

wallcoll	;d0 = cosine, d1 = sine of angle of incidence with wall, a3 = object. Bounce a3 off the wall: the puck loses
	;speed, flips and plays sfx $28-$2B; a player sets the wall collision bit (unless sflags6 bit 4) and plays
	;SFXplayerwall on a hard hit
	move.w	d0,$4E(a3)
	move.w	d1,$50(a3)
	movem.l	d2-d3,-(sp)
	movem.w	d0-d1,-(sp)
	muls.w	Yvel(a3),d0
	muls.w	Xvel(a3),d1
	sub.l	d1,d0
	asr.l	#8,d0
	move.w	d0,d2	;v1n
	movem.w	(sp),d0-d1
	muls.w	Xvel(a3),d0
	muls.w	Yvel(a3),d1
	add.l	d1,d0
	asr.l	#8,d0
	move.w	d0,d3	;v1t
	neg.w	d2
	cmpi.w	#$E,SCnum(a3)	;#puckSCnum, SCnum
	bne.w	.player
	bclr	#4,(sflags2).w
	tst.w	d2
	bpl.w	.nocoll
	asr.w	#2,d2	;reduce normal speed on puck
	cmp.w	#$FC00,d2	;#-400
	bgt.w	.pok
	move.w	#$800,d0
	bsr.w	randomd0
	neg.w	d0
	move.w	d0,Zvel(a3)
	bsr.w	puckflip
	move.w	d2,d0
	asr.w	#8,d0
	asr.w	#2,d0
	addq.w	#4,d0
	bpl.w	.sf0
	clr.w	d0
.sf0
	andi.w	#3,d0
	addi.w	#$28,d0
	move.w	d0,-(sp)
	jsr	(sfx).l
.pok
	move.w	d3,d0	;reduce tangent speed on puck
	asr.w	#6,d0
	sub.w	d0,d3
	asr.w	#1,d0
	sub.w	d0,d3
	bra.w	.noadd
.player
	cmp.w	#$3E8,d2	;#1000
	bgt.w	.nocoll
	bclr	#4,(sflags6).w
	bne.w	.3
	bset	#4,pflags3(a3)	;set wall collision bit
.3
	cmp.w	#$F000,d2	;$-1000
	bgt.w	.nosfx
	cmpi.w	#$A,impact(a3)	;impact(a3)
	blt.w	.nosfx
	move.w	#$20,-(sp)	;#SFXplayerwall
	jsr	(sfx).l
.nosfx
	asr.w	#2,d2
	cmp.w	#$FC7C,d2	;#-900
	blt.w	.noadd
	move.w	#$FC18,d2	;#-1000
.noadd
	movem.w	(sp),d0-d1
	movem.w	d2-d3,-(sp)
	muls.w	d0,d3
	muls.w	d1,d2
	sub.l	d2,d3
	asr.l	#8,d3
	tst.w	position(a3)
	bne.w	.0
	cmpi.w	#$B,SCnum(a3)
	bgt.w	.0
	cmpi.w	#$128,Ypos(a3)
	bgt.w	.0
	cmpi.w	#$FED8,Ypos(a3)
	blt.w	.0
	asr.l	#1,d3
	asr.l	#1,d3
	asr.l	#1,d3
	asr.l	#1,d3
	asr.l	#1,d3
.0
	move.w	d3,Xvel(a3)
	movem.w	(sp)+,d2-d3
	movem.w	(sp),d0-d1
	muls.w	d1,d3
	muls.w	d0,d2
	add.l	d2,d3
	asr.l	#8,d3
	tst.w	position(a3)
	bne.w	.1
	cmpi.w	#$B,SCnum(a3)
	bgt.w	.1
	cmpi.w	#$128,Ypos(a3)
	bgt.w	.1
	cmpi.w	#$FED8,Ypos(a3)
	blt.w	.1
	asr.l	#1,d3
	asr.l	#1,d3
	asr.l	#1,d3
	asr.l	#1,d3
	asr.l	#1,d3
.1
	move.w	d3,Yvel(a3)
	tst.w	Zvel(a3)
	bmi.w	.nocoll
	clr.w	Zvel(a3)
.nocoll
	addq.w	#4,sp
	movem.l	(sp)+,d2-d3
	rts
	;After wallcoll: code that nothing in the listing reaches.
	;Code the listing does not decode: kept as bytes
	dc.b	$08,$B8,$00,$02,$C3,$42,$67,$00,$08,$5C,$3F,$3C,$00,$05,$4E,$F9
	dc.b	$00,$08,$84,$70,$0C,$6B,$01,$90,$00,$14,$6E,$00,$00,$0C,$0C,$6B
	dc.b	$FE,$70,$00,$14,$6E,$00,$00,$06,$42,$6B,$00,$2A,$0C,$6B,$00,$10
	dc.b	$00,$18,$6E,$CC,$30,$2B,$00,$52,$E3,$40,$30,$7C,$B8,$7E,$32,$7C
	dc.b	$B8,$9E,$34,$7C,$B8,$5E,$32,$30,$00,$00,$B2,$7C,$00,$0F,$67,$00
	dc.b	$00,$20,$42,$44,$18,$31,$10,$01,$3A,$32,$40,$00,$9A,$6B,$00,$14
	dc.b	$BA,$7C,$00,$18,$6E,$00,$00,$0A,$61,$00,$00,$2E,$52,$41,$60,$DA
	dc.b	$32,$30,$00,$00,$67,$00,$00,$20,$42,$44,$18,$31,$10,$FF,$3A,$2B
	dc.b	$00,$14,$9A,$72,$40,$00,$BA,$7C,$00,$18,$6E,$00,$00,$0A,$61,$00
	dc.b	$00,$08,$53,$41,$66,$E2,$4E,$75,$48,$E7,$FF,$F0,$E2,$4C,$B8,$78
	dc.b	$B7,$BE,$67,$00,$01,$06,$B8,$7C,$00,$0B,$6E,$00,$00,$FE,$EF,$44
	dc.b	$34,$7C,$B0,$5E,$D4,$C4,$08,$38,$00,$02,$C3,$40,$67,$00,$00,$14
	dc.b	$EE,$44,$B8,$78,$D2,$D4,$67,$00,$00,$0A,$B8,$78,$D2,$D6,$66,$00
	dc.b	$00,$DA,$08,$2A,$00,$02,$00,$62,$66,$00,$00,$D0,$4A,$2A,$00,$5E
	dc.b	$66,$00,$00,$C8,$08,$2A,$00,$02,$00,$63,$66,$00,$00,$6C,$0C,$6B
	dc.b	$00,$05,$00,$18,$6E,$00,$00,$62,$0C,$6B,$02,$00,$00,$2C,$6E,$00
	dc.b	$00,$58,$2F,$0A,$61,$00,$B3,$6C,$D0,$52,$90,$53,$B0,$7C,$00,$10
	dc.b	$6E,$00,$00,$46,$B0,$7C,$FF,$F0,$6D,$00,$00,$3E,$D2,$6A,$00,$14
	dc.b	$92,$6B,$00,$14,$B2,$7C,$00,$10,$6E,$00,$00,$2E,$B2,$7C,$FF,$F0
	dc.b	$6D,$00,$00,$26,$C1,$C0,$C3,$C1,$D0,$81,$22,$3C,$00,$00,$01,$00
	dc.b	$4A,$2B,$00,$5E,$6F,$00,$00,$04,$E4,$49,$B0,$81,$62,$00,$00,$0A
	dc.b	$61,$00,$02,$B4,$60,$00,$00,$54,$4A,$6A,$00,$34,$67,$00,$00,$D0
	dc.b	$08,$2A,$00,$03,$00,$64,$66,$00,$00,$42,$30,$12,$90,$53,$B0,$7C
	dc.b	$00,$08,$6E,$00,$00,$36,$B0,$7C,$FF,$F8,$6D,$00,$00,$2E,$32,$2A
	dc.b	$00,$14,$92,$6B,$00,$14,$B2,$7C,$00,$08,$6E,$00,$00,$1E,$B2,$7C
	dc.b	$FF,$F8,$6D,$00,$00,$16,$C1,$C0,$C3,$C1,$D0,$81,$B0,$BC,$00,$00
	dc.b	$00,$40,$62,$00,$00,$06,$61,$00,$06,$20,$4C,$DF,$0F,$FF,$4E,$75
	dc.b	$00,$00,$00,$03,$00,$03,$00,$04,$00,$04,$00,$04,$00,$05,$00,$05
	dc.b	$00,$05,$00,$05,$00,$05,$00,$05,$00,$05,$00,$05,$00,$05,$00,$05
	dc.b	$00,$05,$00,$05,$00,$05,$00,$05,$00,$05,$00,$00,$00,$01,$00,$01
	dc.b	$00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$00,$02,$00,$02,$00,$02
	dc.b	$00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02
	dc.b	$00,$02,$00,$02,$00,$00,$00,$02,$00,$02,$00,$03,$00,$03,$00,$03
	dc.b	$00,$03,$00,$03,$00,$04,$00,$04,$00,$04,$00,$04,$00,$04,$00,$04
	dc.b	$00,$04,$00,$04,$00,$04,$00,$04,$00,$04,$00,$04,$00,$04,$2F,$08
	dc.b	$20,$7C,$00,$01,$F1,$96,$0C,$78,$00,$01,$D2,$68,$67,$00,$00,$86
	dc.b	$0C,$78,$00,$02,$D2,$68,$66,$00,$00,$46,$30,$3C,$00,$01,$32,$3C
	dc.b	$00,$02,$08,$2A,$00,$06,$00,$62,$67,$00,$00,$0A,$30,$3C,$00,$02
	dc.b	$32,$3C,$00,$01,$B0,$78,$C3,$90,$67,$00,$00,$2E,$B0,$78,$C3,$92
	dc.b	$67,$00,$00,$26,$B0,$78,$C3,$94,$67,$00,$00,$1E,$B0,$78,$C3,$96
	dc.b	$67,$00,$00,$16,$20,$7C,$00,$01,$F1,$C0,$60,$00,$00,$38,$20,$7C
	dc.b	$00,$01,$F1,$EA,$60,$00,$00,$2E,$20,$7C,$00,$01,$F1,$C0,$B2,$78
	dc.b	$C3,$90,$67,$00,$00,$20,$B2,$78,$C3,$92,$67,$00,$00,$18,$B2,$78
	dc.b	$C3,$94,$67,$00,$00,$10,$B2,$78,$C3,$96,$67,$00,$00,$08,$20,$7C
	dc.b	$00,$01,$F1,$96,$42,$40,$42,$41,$10,$2A,$00,$74,$12,$2A,$00,$6F
	dc.b	$D0,$41,$12,$2A,$00,$71,$D0,$41,$12,$2A,$00,$73,$D0,$41,$E6,$40
	dc.b	$02,$40,$00,$0F,$D0,$40,$31,$F0,$00,$00,$BF,$9E,$20,$5F,$0C,$52
	dc.b	$00,$15,$6E,$00,$00,$42,$0C,$52,$FF,$EB,$6D,$00,$00,$3A,$08,$2A
	dc.b	$00,$07,$00,$62,$67,$00,$00,$16,$30,$38,$B7,$72,$04,$40,$FE,$E0
	dc.b	$32,$2A,$00,$14,$04,$41,$FE,$E0,$60,$00,$00,$12,$30,$38,$B7,$72
	dc.b	$04,$40,$01,$20,$32,$2A,$00,$14,$04,$41,$01,$20,$B3,$40,$6A,$00
	dc.b	$00,$06,$60,$00,$00,$AE,$31,$F8,$BF,$9E,$BF,$A4,$5E,$78,$BF,$A4
	dc.b	$30,$12,$32,$2A,$00,$14,$61,$00,$00,$7A,$6F,$00,$00,$60,$B0,$7C
	dc.b	$00,$28,$6C,$00,$00,$8E,$B2,$7C,$00,$28,$6C,$00,$00,$86,$2F,$0A
	dc.b	$4E,$B9,$00,$01,$A4,$B2,$31,$F8,$BF,$9E,$BF,$A4,$5C,$78,$BF,$A4
	dc.b	$61,$00,$00,$50,$6F,$00,$00,$36,$2F,$0A,$4E,$B9,$00,$01,$A5,$28
	dc.b	$31,$F8,$BF,$9E,$BF,$A4,$56,$78,$BF,$A4,$61,$00,$00,$36,$6F,$00
	dc.b	$00,$1C,$2F,$0A,$4E,$B9,$00,$01,$A5,$9E,$31,$F8,$BF,$9E,$BF,$A4
	dc.b	$56,$78,$BF,$A4,$61,$00,$00,$1C,$6E,$00,$00,$38,$30,$12,$90,$53
	dc.b	$32,$2A,$00,$14,$92,$6B,$00,$14,$4E,$B9,$00,$01,$F8,$4C,$60,$00
	dc.b	$FD,$EA,$90,$53,$6A,$00,$00,$04,$44,$40,$92,$6B,$00,$14,$6A,$00
	dc.b	$00,$04,$44,$41,$B0,$78,$BF,$A4,$6E,$00,$00,$06,$B2,$78,$BF,$A4
	dc.b	$4E,$75,$08,$B8,$00,$02,$C3,$42,$67,$00,$FD,$C0,$30,$38,$B7,$BE
	dc.b	$B0,$6A,$00,$52,$67,$00,$FD,$B4,$3F,$3C,$00,$05,$4E,$B9,$00,$08
	dc.b	$84,$70,$60,$00,$FD,$A6,$4A,$6A,$00,$34,$66,$00,$00,$0C,$08,$38
	dc.b	$00,$04,$C3,$38,$66,$00,$04,$4E,$08,$AA,$00,$00,$00,$62,$32,$38
	dc.b	$B7,$BE,$6B,$00,$00,$DE,$EF,$41,$30,$7C,$B0,$5E,$D0,$C1,$12,$28
	dc.b	$00,$62,$14,$2A,$00,$62,$B3,$42,$08,$02,$00,$06,$67,$00,$04,$26
	dc.b	$08,$38,$00,$05,$C3,$46,$67,$00,$00,$10,$B0,$BC,$00,$00,$00,$40
	dc.b	$62,$00,$04,$12,$60,$00,$00,$0C,$B0,$BC,$00,$00,$00,$24,$62,$00
	dc.b	$04,$04,$4A,$6A,$00,$34,$67,$00,$00,$4E,$4A,$68,$00,$34,$67,$00
	dc.b	$03,$F4,$10,$28,$00,$72,$E2,$08,$61,$00,$06,$9A,$3F,$00,$C1,$4A
	dc.b	$10,$28,$00,$72,$E2,$08,$61,$00,$06,$8C,$C1,$4A,$44,$40,$D0,$5F
	dc.b	$06,$40,$00,$24,$61,$00,$BC,$2A,$08,$38,$00,$05,$C3,$46,$67,$00
	dc.b	$00,$0E,$B0,$7C,$00,$04,$62,$00,$03,$BC,$60,$00,$00,$0A,$B0,$7C
	dc.b	$00,$02,$62,$00,$03,$B0,$10,$28,$00,$72,$E2,$08,$61,$00,$06,$56
	dc.b	$06,$40,$00,$14,$11,$40,$00,$5E,$C1,$4A,$10,$28,$00,$72,$E2,$08
	dc.b	$61,$00,$06,$42,$06,$40,$00,$14,$11,$40,$00,$5E,$C1,$4A,$31,$E8
	dc.b	$00,$52,$BF,$0C,$08,$B8,$00,$02,$C3,$3A,$08,$B8,$00,$03,$C3,$3A
	dc.b	$3F,$3C,$00,$06,$4E,$B9,$00,$08,$84,$70,$61,$00,$A8,$C0,$60,$00
	dc.b	$05,$E8,$4A,$6A,$00,$34,$66,$00,$00,$0C,$B0,$BC,$00,$00,$00,$40
	dc.b	$62,$00,$03,$52,$08,$2A,$00,$03,$00,$64,$67,$00,$00,$2C,$B0,$BC
	dc.b	$00,$00,$00,$64,$62,$00,$00,$8C,$08,$38,$00,$03,$C3,$50,$66,$00
	dc.b	$00,$12,$0C,$6A,$00,$18,$00,$5A,$6C,$00,$00,$0E,$35,$7C,$00,$18
	dc.b	$00,$5A,$08,$F8,$00,$07,$C3,$4C,$30,$38,$B7,$86,$32,$38,$B7,$88
	dc.b	$C1,$C0,$C3,$C1,$D0,$81,$42,$41,$08,$38,$00,$04,$C3,$3C,$66,$00
	dc.b	$00,$14,$08,$2A,$00,$03,$00,$64,$66,$00,$00,$3C,$12,$2A,$00,$72
	dc.b	$C2,$FC,$01,$5E,$06,$81,$00,$00,$32,$C8,$48,$A7,$20,$00,$34,$38
	dc.b	$BF,$12,$B4,$6A,$00,$52,$4C,$9F,$00,$04,$66,$00,$00,$08,$06,$81
	dc.b	$00,$00,$32,$C8,$C2,$C1,$B0,$81,$63,$00,$00,$3E,$15,$7C,$00,$08
	dc.b	$00,$5E,$60,$00,$FF,$4C,$C5,$4B,$4E,$B9,$00,$1D,$6B,$E6,$C5,$4B
	dc.b	$4E,$75,$B0,$BC,$00,$00,$01,$44,$62,$00,$00,$1C,$08,$38,$00,$03
	dc.b	$C3,$50,$66,$00,$00,$12,$0C,$6A,$00,$18,$00,$5A,$6C,$00,$00,$08
	dc.b	$35,$7C,$00,$18,$00,$5A,$4E,$75,$3F,$3C,$00,$07,$30,$2A,$00,$52
	dc.b	$31,$C0,$B7,$BE,$30,$7C,$C7,$26,$43,$E8,$03,$9E,$08,$2A,$00,$06
	dc.b	$00,$62,$66,$00,$00,$04,$C1,$49,$50,$E8,$00,$1A,$50,$E8,$00,$1C
	dc.b	$08,$E8,$00,$03,$00,$30,$08,$B8,$00,$04,$C3,$3E,$67,$00,$00,$26
	dc.b	$52,$69,$00,$0E,$06,$78,$00,$C8,$B8,$B2,$5A,$78,$C4,$C4,$3E,$BC
	dc.b	$00,$0C,$B2,$FC,$C7,$26,$66,$00,$00,$0C,$06,$78,$00,$0A,$B8,$B8
	dc.b	$3E,$BC,$00,$0B,$4E,$B9,$00,$08,$85,$86,$30,$2A,$00,$52,$B0,$78
	dc.b	$BF,$12,$66,$00,$00,$06,$52,$69,$00,$14,$50,$F8,$BF,$12,$08,$B8
	dc.b	$00,$02,$C3,$3A,$08,$B8,$00,$03,$C3,$3A,$4A,$6A,$00,$34,$66,$00
	dc.b	$00,$1C,$61,$00,$DB,$CE,$35,$7C,$00,$8C,$00,$48,$0C,$6A,$04,$9A
	dc.b	$00,$58,$66,$00,$00,$08,$35,$7C,$00,$05,$00,$48

setd0player	;Player d0 becomes the player of a pad of his team (setc1player ... setc4player), unless a pad has him already
	cmp.w	(c1playernum).w,d0
	beq.w	.0
	cmp.w	(c2playernum).w,d0
	beq.w	.0
	cmp.w	(c3playernum).w,d0
	beq.w	.0
	cmp.w	(c4playernum).w,d0
	beq.w	.0
	movem.l	d0/a3,-(sp)
	asl.w	#7,d0
	movea.l	#SortCords,a3
	tst.w	$34(a3,d0.w)
	bne.w	.1
	btst	#3,$62(a3,d0.w)
	beq.w	.1
	movem.l	(sp)+,d0/a3
.0
	rts
.1
	movem.l	(sp)+,d0/a3
	cmp.w	#6,d0
	slt	d1
	ext.w	d1
	addq.w	#2,d1
	move.w	(lastplayer).w,d2
	cmp.w	(c1playernum).w,d2
	beq.w	.13
	cmp.w	(c2playernum).w,d2
	beq.w	.9
	cmp.w	(c3playernum).w,d2
	beq.w	.5
	cmp.w	(cont4team).w,d1
	bne.w	.2
	jmp	setc4player
.2
	cmp.w	(cont1team).w,d1
	bne.w	.3
	jmp	setc1player
.3
	cmp.w	(cont2team).w,d1
	bne.w	.4
	jmp	setc2player
.4
	cmp.w	(cont3team).w,d1
	bne.s	.0
	jmp	setc3player
.5
	cmp.w	(cont3team).w,d1
	bne.w	.6
	jmp	setc3player
.6
	cmp.w	(cont1team).w,d1
	bne.w	.7
	jmp	setc1player
.7
	cmp.w	(cont2team).w,d1
	bne.w	.8
	jmp	setc2player
.8
	cmp.w	(cont4team).w,d1
	bne.w	.0
	jmp	setc4player
.9
	cmp.w	(cont2team).w,d1
	bne.w	.10
	jmp	setc2player
.10
	cmp.w	(cont1team).w,d1
	bne.w	.11
	jmp	setc1player
.11
	cmp.w	(cont3team).w,d1
	bne.w	.12
	jmp	setc3player
.12
	cmp.w	(cont4team).w,d1
	bne.w	.0
	jmp	setc4player
.13
	cmp.w	(cont1team).w,d1
	bne.w	.14
	jmp	setc1player
.14
	cmp.w	(cont2team).w,d1
	bne.w	.15
	jmp	setc2player
.15
	cmp.w	(cont3team).w,d1
	bne.w	.16
	jmp	setc3player
.16
	cmp.w	(cont4team).w,d1
	bne.w	.0
	jmp	setc4player

puckbody	;Puck hits player a2. a3 = puck. The puck bounces off; a high fast puck makes a2 fall.
	;Code the listing does not decode: kept as bytes
	dc.b	$08,$2A,$00,$03,$00,$64,$66,$00,$00,$94,$0C,$6B,$00,$08,$00,$18
	dc.b	$6E,$00,$00,$0C,$32,$00,$02,$41,$00,$0F,$66,$00,$00,$80,$61,$00
	dc.b	$A5,$D4,$3F,$3C,$00,$24,$4E,$B9,$00,$08,$84,$70,$42,$6B,$00,$2C
	dc.b	$15,$7C,$00,$08,$00,$5E,$30,$13,$90,$52,$32,$2B,$00,$14,$92,$6A
	dc.b	$00,$14,$66,$00,$00,$08,$2F,$0A,$61,$00,$AC,$60,$34,$2B,$00,$28
	dc.b	$36,$2B,$00,$2A,$17,$40,$00,$28,$17,$41,$00,$2A,$61,$00,$A7,$32
	dc.b	$0C,$6B,$00,$08,$00,$18,$6F,$00,$00,$34,$C5,$C2,$C7,$C3,$D4,$83
	dc.b	$B4,$BC,$09,$00,$00,$00,$63,$00,$00,$0E,$0C,$6B,$00,$0C,$00,$18
	dc.b	$6E,$00,$E8,$E0,$4E,$75,$08,$EA,$00,$05,$00,$62,$66,$00,$00,$0E
	dc.b	$32,$3C,$14,$42,$C5,$4B,$61,$00,$AD,$CE,$C5,$4B

rtss2	;The shared rts many routines branch to
	rts

sub_1F84C	;Called from the code before puckbody.
	;Code the listing does not decode: kept as bytes
	dc.b	$08,$38,$00,$04,$C3,$38,$66,$F6,$42,$42,$0C,$6B,$00,$08,$00,$18
	dc.b	$6E,$00,$00,$04,$54,$42,$44,$40,$44,$41,$61,$00,$AB,$86,$90,$6A
	dc.b	$00,$54,$02,$40,$00,$07,$32,$00,$02,$41,$00,$03,$66,$00,$00,$08
	dc.b	$30,$39,$00,$C0,$00,$08,$02,$40,$00,$04,$E4,$48,$0A,$40,$00,$01
	dc.b	$D4,$40,$D4,$42,$41,$FA,$01,$68,$30,$30,$20,$00,$72,$0F,$D2,$32
	dc.b	$00,$00,$41,$FA,$01,$62,$08,$2A,$00,$03,$00,$04,$67,$00,$00,$06
	dc.b	$0A,$42,$00,$02,$30,$2A,$00,$06,$08,$B8,$00,$02,$C3,$42,$61,$00
	dc.b	$D9,$5C,$61,$00,$A4,$E2,$0C,$78,$30,$00,$B7,$88,$6E,$00,$00,$0C
	dc.b	$0C,$78,$D0,$00,$B7,$88,$6E,$00,$00,$1A,$3F,$3C,$00,$0B,$08,$2A
	dc.b	$00,$06,$00,$62,$67,$00,$00,$06,$3E,$BC,$00,$0D,$4E,$B9,$00,$08
	dc.b	$85,$86,$3F,$3C,$00,$24,$4E,$B9,$00,$08,$84,$70,$34,$38,$B7,$BE
	dc.b	$6B,$00,$00,$60,$50,$F8,$B7,$BE,$EF,$42,$30,$7C,$B0,$5E,$D0,$C2
	dc.b	$11,$7C,$00,$14,$00,$5E,$31,$E8,$00,$52,$BF,$0C,$08,$B8,$00,$02
	dc.b	$C3,$3A,$08,$B8,$00,$03,$C3,$3A,$42,$6B,$00,$2C,$15,$7C,$00,$0A
	dc.b	$00,$5E,$35,$7C,$00,$04,$00,$46,$30,$13,$90,$52,$32,$2B,$00,$14
	dc.b	$92,$6A,$00,$14,$66,$00,$00,$08,$2F,$0A,$61,$00,$AB,$10,$17,$40
	dc.b	$00,$28,$17,$41,$00,$2A,$60,$00,$A5,$EA,$08,$F8,$00,$02,$C3,$42
	dc.b	$4E,$75,$0C,$6A,$04,$9A,$00,$58,$67,$BE,$70,$02,$D0,$2A,$00,$6D
	dc.b	$E1,$40,$E3,$40,$61,$00,$B7,$34,$06,$40,$0C,$00,$D0,$40,$6A,$00
	dc.b	$00,$06,$30,$3C,$7F,$FF,$08,$2A,$00,$01,$00,$63,$66,$00,$00,$3C
	dc.b	$0C,$53,$00,$2C,$6E,$00,$00,$34,$0C,$53,$FF,$D4,$6D,$00,$00,$2C
	dc.b	$0C,$6B,$01,$24,$00,$14,$6E,$00,$00,$22,$0C,$6B,$FE,$DC,$00,$14
	dc.b	$6D,$00,$00,$18,$0C,$6B,$00,$E8,$00,$14,$6E,$00,$00,$0C,$0C,$6B
	dc.b	$FF,$18,$00,$14,$6E,$00,$00,$04,$E4,$40,$B0,$78,$B7,$86,$6D,$00
	dc.b	$FF,$58,$B0,$78,$B7,$88,$6D,$00,$FF,$50,$44,$40,$B0,$78,$B7,$86
	dc.b	$6E,$00,$FF,$46,$B0,$78,$B7,$88,$6E,$00,$FF,$3E,$08,$2A,$00,$02
	dc.b	$00,$63,$66,$00,$FF,$34,$42,$6B,$00,$2C,$60,$00,$FB,$C6,$00,$74
	dc.b	$00,$6F,$00,$71,$00,$73,$55,$9D,$67,$55,$9D,$67,$55,$9D,$67,$55
	dc.b	$9D,$67,$55,$9D,$67,$55,$9D,$67,$55,$9D,$67,$55,$9D,$67,$55,$55
	dc.b	$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$F0
	dc.b	$55,$F0,$55,$F0,$55,$F0,$55,$F0,$55,$F0,$55,$F0,$55,$F0,$55,$F0
	dc.b	$55,$F0,$55,$F0,$55,$F0,$D5,$75,$D5,$75,$D5,$75,$D5,$75,$D5,$75
	dc.b	$D5,$75,$D5,$75,$D5,$75,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55
	dc.b	$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55
	dc.b	$55,$55,$55,$55,$55,$55,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0
	dc.b	$F0,$F0,$F0,$F0,$F0,$F0,$57,$57,$57,$57,$A5,$A5,$A5,$A5,$A5,$A5
	dc.b	$A5,$A5,$A5,$A5,$A5,$A5,$A5,$A5,$A5,$A5,$A5,$A5,$A5,$A5,$A5,$A5
	dc.b	$A5,$A5,$9D,$67,$9D,$67,$9D,$67,$9D,$67,$9D,$67,$9D,$67,$9D,$67
	dc.b	$9D,$67,$D5,$D5,$75,$75,$D5,$D5,$75,$75,$D5,$D5,$75,$75,$D5,$D5
	dc.b	$75,$75,$D5,$D5,$75,$75,$D5,$D5,$75,$75,$D5,$D5,$75,$75,$D5,$D5
	dc.b	$75,$75,$50,$F8,$B7,$BE,$30,$3C,$10,$00,$61,$00,$B5,$C2,$37,$40
	dc.b	$00,$2A,$30,$3C,$10,$00,$61,$00,$B5,$B6,$37,$40,$00,$28,$30,$3C
	dc.b	$10,$00,$61,$00,$B5,$B6,$37,$40,$00,$2C,$60,$00,$A4,$46

makepde	;Pass d0 as value to be scaled by player a0's energy level (full energy while sflags7 bit 4 is set). Return d0
	;as result
	ext.w	d0
	move.w	d0,-(sp)
	movem.l	d1/a2-a3,-(sp)
	movea.l	a0,a3
	bsr.w	getpde
	btst	#4,(sflags7).w
	beq.w	.0
	move.w	#$1000,d0
.0
	movem.l	(sp)+,d1/a2-a3
	muls.w	(sp)+,d0
	asl.l	#4,d0
	swap	d0
	ext.l	d0
	rts

getpde	;Get player a3's energy level into d0. Return a2 = his team struct, d1 = pnum*2
	movea.w	#(tmstruct-M68K_RAM),a2
	btst	#6,$62(a3)
	beq.w	.0
	adda.w	#$39E,a2	;team is away
.0
	move.b	$67(a3),d1
	ext.w	d1
	add.w	d1,d1
	move.w	$34(a2,d1.w),d0
	rts

setpde	;d1 = rostnum of player * 2, a2 = team struct, d0 = new energy level (0 if negative)
	tst.w	d0
	bpl.w	.0
	clr.w	d0
.0
	move.w	d0,$34(a2,d1.w)
	rts

setpersonel	;Put team a2 on the ice: the players of PlList (SetPlList) with setplayer
	movem.l	d0-d5/a0-a4,-(sp)
	btst	#7,(GameFlags).w
	beq.w	.0
	jsr	(sub_1E8840).l
.0
	movea.w	$22(a2),a3
	moveq	#5,d4
.1
	st	$60(a3)
	st	$61(a3)
	adda.w	#$80,a3
	dbf	d4,.1
	bsr.w	SetPlList
	moveq	#5,d4
	movea.w	#(PlList-M68K_RAM),a4
.2
	clr.w	d5
	move.b	(a4,d4.w),d5
	beq.w	.4
	subq.w	#1,d5
	moveq	#5,d3
	movea.w	$22(a2),a3
	suba.w	#$80,a3
.3
	adda.w	#$80,a3
	cmp.b	$67(a3),d5
	dbeq	d3,.3
	bne.w	.4
	move.b	6(a4,d4.w),$60(a3)
	move.b	d5,$61(a3)
	clr.b	(a4,d4.w)
.4
	dbf	d4,.2
	moveq	#5,d4
	movea.w	#(PlList-M68K_RAM),a4
.5
	clr.w	d5
	move.b	(a4,d4.w),d5
	beq.w	.8
	subq.w	#1,d5
	moveq	#5,d3
	movea.w	$22(a2),a3
	suba.w	#$80,a3
.6
	adda.w	#$80,a3
	tst.b	$61(a3)
	dbmi	d3,.6
	bpl.w	.7
	movea.w	a3,a0
.7
	tst.w	$34(a3)
	dbpl	d3,.6
	move.b	6(a4,d4.w),$60(a0)
	move.b	d5,$61(a0)
	clr.b	(a4,d4.w)
.8
	dbf	d4,.5
	movem.l	(sp)+,d0-d5/a0-a4
	rts

SetPlList	;Create PlList of players who we want on the ice now. a2 = team struct. Takes the current line (tmline) by
	;priolist; an unavailable player is replaced from sublist, else by roster order (GetPlayerCount)
	movea.w	#(PlList-M68K_RAM),a4
	clr.l	(a4)	;clear 6 bytes (PlList)
	clr.w	4(a4)
	movea.l	#priolist,a0	;priority of positions
	tst.w	$26(a2)
	bpl.w	.0
	addq.w	#1,a0	;add 1 to a0
.0
	lea	$184(a2),a1
	move.w	$16(a2),d0
	asl.w	#3,d0	;mult by 8
	adda.w	d0,a1	;add to a1 to set a1 to currently selected line
	move.w	$24(a2),d4
	bra.w	.next
.1
	clr.w	d5
	move.b	(a0,d4.w),d5
	move.b	(a1,d5.w),(a4,d4.w)
	move.b	d5,6(a4,d4.w)
	bne.w	.next
	moveq	#1,d3
	add.w	$26(a2),d3
	move.b	d3,(a4,d4.w)
.next
	dbf	d4,.1
	moveq	#5,d4	;now check to see if player is available
.3
	move.b	(a4,d4.w),d3
	beq.w	.next1
	ext.w	d3
	subq.w	#1,d3
	add.w	d3,d3
	cmpi.w	#$FFFD,$6C(a2,d3.w)
	beq.w	.4
	cmpi.w	#$FFFC,$6C(a2,d3.w)
	beq.w	.4
	tst.w	$6C(a2,d3.w)
	ble.w	.next1
.4
	lea	$184(a2),a1
	move.b	6(a4,d4.w),d0	;move 6+a4+d4 into d0 (previous d5)
	ext.w	d0	;extend d0
	asl.w	#1,d0	;mult by 2
	movea.l	#sublist,a0	;move sublist into a0
	adda.w	(a0,d0.w),a0
.s1
	clr.w	d0
	move.b	(a0)+,d0
	bmi.w	.error
	move.b	(a1,d0.w),d0
	bsr.w	TryAddPlayerToList
	beq.s	.s1
.next1
	dbf	d4,.3
	rts
.error
	jsr	(GetPlayerCount).l	;then try the players from d0 down
	move.w	d0,d3
.try
	move.w	d3,d0
	subq.w	#1,d3
	bmi.s	.next1
	bsr.w	TryAddPlayerToList
	beq.s	.try
	bra.s	.next1

TryAddPlayerToList	;d0 = player number (1 based), d4 = PlList slot. Put d0 in the slot if he is on the bench and not in PlList
	;yet (eq when taken)
	move.w	d0,d1
	subq.w	#1,d0
	add.w	d0,d0
	tst.w	$6C(a2,d0.w)
	bgt.w	.no
	cmpi.w	#$FFFD,$6C(a2,d0.w)
	beq.w	.no
	cmpi.w	#$FFFC,$6C(a2,d0.w)
	beq.w	.no
	moveq	#5,d0
.s2
	cmp.b	(a4,d0.w),d1
	dbeq	d0,.s2
	beq.w	.no
	move.b	d1,(a4,d4.w)
	rts
.no
	clr.w	d1
	rts

SetupPenaltyShot	;Penalty shot for team a2: the shooter plays center, the goalie stays, the other players unavailable.
	;Code the listing does not decode: kept as bytes
	dc.b	$48,$E7,$FC,$F0,$36,$6A,$00,$22,$78,$05,$30,$2B,$00,$52,$B0,$78
	dc.b	$D2,$D4,$67,$00,$00,$1C,$B0,$78,$D2,$D6,$67,$00,$00,$2E,$08,$EB
	dc.b	$00,$02,$00,$63,$30,$3C,$00,$20,$61,$00,$A6,$AA,$60,$00,$00,$38
	dc.b	$61,$00,$01,$20,$11,$EB,$00,$61,$C3,$82,$17,$78,$D2,$D9,$00,$61
	dc.b	$37,$7C,$00,$04,$00,$34,$60,$00,$00,$0A,$61,$00,$01,$06,$42,$6B
	dc.b	$00,$34,$42,$43,$16,$2B,$00,$61,$D6,$43,$35,$BC,$FF,$FF,$30,$6C
	dc.b	$E2,$4B,$61,$00,$01,$36,$50,$EB,$00,$61,$50,$EB,$00,$60,$D6,$FC
	dc.b	$00,$80,$51,$CC,$FF,$96,$4C,$DF,$0F,$3F,$4E,$75

forcepldata	;Force the player data.
	;Code the listing does not decode: kept as bytes
	dc.b	$48,$E7,$F8,$F0,$36,$6A,$00,$22,$78,$05,$10,$2B,$00,$60,$48,$80
	dc.b	$4A,$6B,$00,$34,$66,$00,$00,$16,$4A,$40,$67,$00,$00,$10,$3F,$2B
	dc.b	$00,$52,$37,$7C,$00,$0F,$00,$52,$37,$5F,$00,$52,$37,$40,$00,$34
	dc.b	$6B,$00,$00,$2A,$61,$00,$00,$A0,$0C,$6B,$00,$04,$00,$34,$66,$00
	dc.b	$00,$08,$70,$11,$61,$00,$A6,$08,$42,$43,$16,$2B,$00,$61,$D6,$43
	dc.b	$35,$BC,$FF,$FF,$30,$6C,$E2,$4B,$61,$00,$00,$C4,$50,$EB,$00,$61
	dc.b	$50,$EB,$00,$60,$D6,$FC,$00,$80,$51,$CC,$FF,$A0,$4C,$DF,$0F,$1F
	dc.b	$4E,$75

ResetBench	;Remove all players from penalty box / put all players on their own bench (not the injured, -3 / -4). Counts
	;the players left in the box in PBnum (home in the high nibble)
	clr.b	(PBnum).w	;PBnum = HV00
	moveq	#$10,d1
	movea.w	#(tmstruct-M68K_RAM),a0
	bsr.w	.rb
	moveq	#1,d1
	adda.w	#$39E,a0	;change to Away Team
.rb
	moveq	#$36,d0	;$32 = (MaxRos-1)*2 = 50 decimal
.rb1
	add.b	d1,(PBnum).w
	tst.w	$6C(a0,d0.w)	;check tmpdst
	ble.w	.cont
	btst	#4,$6C(a0,d0.w)	;test 3rd bit in tmpdst (4 decimal)
	beq.w	.next
	move.w	$6C(a0,d0.w),d2	;move tmpdst into d2
	andi.w	#$7FF,d2	;mask 7FF with d2. Passes lowest 11 bits
	bne.w	.next
	sub.b	d1,(PBnum).w
	bra.w	.next
.cont
	sub.b	d1,(PBnum).w
	cmpi.w	#$FFFD,$6C(a0,d0.w)	;compare -4 with tmpdst
	beq.w	.next
	cmpi.w	#$FFFC,$6C(a0,d0.w)
	beq.w	.next
	move.w	#$FFFE,$6C(a0,d0.w)	;move -2 into tmpdst
.next
	subq.w	#2,d0
	bpl.s	.rb1
	rts

sub_1FE58	;assreplace player a3 with the assignment of his position (unk_1FE70)
	move.w	position(a3),d0
	bmi.w	rtss2
	st	$65(a3)
	lea	unk_1FE70(pc),a0
	move.b	(a0,d0.w),d0
	bra.w	assreplace

unk_1FE70	;sub_1FE58: the assignment of each position
	dc.b	$0E,$02,$02,$03,$05,$03,$05,$FF

sub_1FE78	;The assignment of the position of player a3 (unk_1FE98)
	move.w	position(a3),d0
	bmi.w	rtss2
	tst.b	$65(a3)
	bmi.w	.0
	move.b	$65(a3),d0
.0
	lea	unk_1FE98(pc),a0
	move.b	(a0,d0.w),d0
	bra.w	assreplace

unk_1FE98	;sub_1FE78: the assignment of each position
	dc.b	$0E,$02,$02,$03,$05,$03,$05,$FF

setplayer	;Bring player onto the ice and set his attributes. d3 = offset of player on roster, a3 = sortcord of player.
	;Reads the roster bytes through AttributeCalc (attribute number in TempWord2), adds the PP / PK, home / away
	;and third period bonuses and clamps them (ClampNibble).
	st	$65(a3)
	bclr	#6,$63(a3)
	movea.w	#(tmstruct-M68K_RAM),a0	;Start of Team Struct
	btst	#6,$62(a3)
	beq.w	.0
	adda.w	#$39E,a0
.0
	move.b	d3,$67(a3)
	moveq	#$A,d0
	ext.w	d3
	add.w	d3,d3	;= asl #1,d3. Accomplishes the same. Doubles d3
	move.w	$6C(a0,d3.w),d1	;move tmpdst(a0, d3) into d1
	bpl.w	.1
	moveq	#9,d0
	cmp.w	#$FFFE,d1	;-2 in this case
	bne.w	.nda
.1
	bsr.w	assinsert
	bclr	#5,$62(a3)
	clr.w	$58(a3)
.nda
	move.w	#$FFFF,$6C(a0,d3.w)	;clear out temp space
	lsr.w	#1,d3	;shift d3 back to its original value
	move.l	a0,-(sp)
	movea.l	$1E(a0),a0	;Offset 1E from Team Struct = The address where the team's data is stored (roster, etc)
	adda.w	8(a0),a0
	clr.l	(PPBonus).w	;Clears all bonuses
	tst.w	$34(a3)	;check if goalie
	beq.w	.2
	btst	#5,(sflags2).w	;might be checking for a PP
	beq.w	.habonus
	bsr.w	chkpk2
	beq.w	.pk
	move.b	1(a0),(PPBonus).w	;moves PP/PK byte into PPBonus
	andi.b	#$F,(PPBonus).w	;passes lower nibble of PP/PK byte (bug)
	bra.w	.habonus
.pk
	move.b	1(a0),d0	;moves PP/PK byte into d0
	lsr.b	#4,d0	;shifts d0.b 4 places, to remove the lower nibble
	neg.b	d0	;switches value to negative (because its a PK, its negative bonus)
	move.b	d0,(PPBonus+1).w	;move d0 into PKBonus
.habonus
	move.b	2(a0),d0	;This is location of Home/Away adv
	andi.b	#$F,d0	;pass the lower nibble (Away) to d0
	neg.b	d0	;make d0 negative (away disadvantage)
	btst	#6,$62(a3)
	bne.w	.3rdperbonuscheck
	move.b	2(a0),d0	;player is home, move Home/Away byte back in to d0
	lsr.b	#4,d0	;Shift d0 4 places right, to move upper nibble into d0
.3rdperbonuscheck
	move.b	d0,(PPBonus+3).w	;move d0 into HA bonus
	cmpi.w	#2,(gsp).w	;Check if period is 3rd or OT
	blt.w	.2
	bgt.w	.6
	jsr	(GetPeriodTime).l
	lsr.w	#1,d0	;divide by 2 (5 min length = 2:30)
	cmp.w	(gameclock).w,d0	;compare to game clock
	bgt.w	.2
.6
	move.w	(HmGoals).w,d0
	sub.w	(AwGoals).w,d0
	beq.w	.8
	btst	#6,$62(a3)
	beq.w	.home
	eori	#8,ccr	;If Aw team, checks if N flag is set from HmGoals-AwGoals.
.home
	bpl.w	.2
.8
	move.b	#2,(PPBonus+2).w	;move 2 into 3rd Per Bonus
.2
	movea.l	(sp)+,a0
	movem.l	d0/d7/a1,-(sp)
	move.w	$28(a0),d7
	move.w	d3,d0
	jsr	(GetRosterName).l
	jsr	(GetJerseyNumber).l
	adda.w	(a1),a1
	movea.l	a1,a0
	movem.l	(sp)+,d0/d7/a1
	move.b	(jerseynum+1).w,$70(a3)
	move.b	1(a0),d3	;move Wgt/Agl byte to d3
	andi.w	#$F0,d3	;Mask Wgt nibble
	lsr.w	#1,d3	;shift d3 1 bit right (This is taking Wgt and mult by 8)
	move.b	d3,$68(a3)
	move.b	1(a0),d3	;move Wgt/Agl byte to d3
	andi.b	#$F,d3	;mask Agl nibble
	move.w	#3,(TempWord2).w	;TempWord2 = 3
	jsr	(AttributeCalc).l	;attribute math and add hot/cold
	move.b	d3,$69(a3)
	move.b	2(a0),d3	;load Spd/OfA byte to d3
	lsr.b	#4,d3	;remove OfA nibble by shifting 4 bits right, moving Spd into lower nibble
	move.w	#4,(TempWord2).w	;TempWord2 = 4
	jsr	(AttributeCalc).l
	move.b	d3,$6A(a3)
	move.b	2(a0),d3	;move Spd/OfA byte to d3
	andi.b	#$F,d3
	move.w	#5,(TempWord2).w	;TempWord2 = 5
	jsr	(AttributeCalc).l
	add.b	(PPBonus).w,d3	;add Bonsuses to OfA
	add.b	(PPBonus+1).w,d3
	add.b	(PPBonus+3).w,d3
	add.b	(PPBonus+2).w,d3
	bsr.w	ClampNibble
	lsr.b	#1,d3	;shift right 1 bit (divide by 2)
	eori.b	#$F,d3	;XOR d3 with F
	addi.b	#$F,d3	;add F to d3
	lsr.b	#1,d3	;divide by 2
	move.b	d3,$6B(a3)
	move.b	3(a0),d3	;move DfA/ShP byte to d3
	lsr.b	#4,d3	;see above
	move.w	#6,(TempWord2).w
	jsr	(AttributeCalc).l
	add.b	(PPBonus+3).w,d3
	bsr.w	ClampNibble
	lsr.b	#1,d3
	eori.b	#$F,d3
	addi.b	#$F,d3
	lsr.b	#1,d3
	move.b	d3,$6C(a3)
	move.b	3(a0),$6D(a3)
	andi.b	#$F,$6D(a3)
	move.b	$6D(a3),d3
	move.w	#7,(TempWord2).w
	jsr	(AttributeCalc).l
	move.b	d3,$6D(a3)
	move.b	4(a0),d3	;move Chk/Hnd byte into d3
	lsr.b	#4,d3
	move.w	#8,(TempWord2).w
	jsr	(AttributeCalc).l
	add.b	(PPBonus+2).w,d3
	bsr.w	ClampNibble
	move.b	d3,$76(a3)
	bclr	#3,4(a3)
	move.b	4(a0),$77(a3)
	andi.b	#1,$77(a3)
	eori.b	#1,$77(a3)
	bne.w	.3
	bset	#3,4(a3)
.3
	move.b	4(a0),d3
	tst.w	$34(a3)
	bne.w	.4
	move.b	5(a0),d3
	lsr.b	#3,d3
.4
	andi.b	#$FE,d3
	or.b	d3,$77(a3)
	clr.b	$75(a3)
	tst.w	$34(a3)
	beq.w	.5
	move.b	7(a0),d3
	andi.b	#$F,d3
	cmp.b	#6,d3
	ble.w	.5
	subq.w	#6,d3
	move.b	d3,$75(a3)
.5
	move.b	5(a0),d3	;move Pas/Agr byte into d3
	lsr.b	#4,d3
	move.w	#$A,(TempWord2).w
	jsr	(AttributeCalc).l
	add.b	(PPBonus).w,d3
	add.b	(PPBonus+1).w,d3
	add.b	(PPBonus+3).w,d3
	bsr.w	ClampNibble
	move.b	d3,$72(a3)
	move.b	5(a0),d3
	andi.b	#$F,d3
	move.w	#$B,(TempWord2).w
	jsr	(AttributeCalc).l
	add.b	(PPBonus).w,d3
	add.b	(PPBonus+1).w,d3
	add.b	(PPBonus+3).w,d3
	bsr.w	ClampNibble
	move.b	d3,$6E(a3)
	move.b	6(a0),d3
	lsr.b	#4,d3
	move.w	#$C,(TempWord2).w
	jsr	(AttributeCalc).l
	move.b	d3,$73(a3)
	move.b	6(a0),d3
	andi.b	#$F,d3
	move.w	#$D,(TempWord2).w
	jsr	(AttributeCalc).l
	add.b	(PPBonus+2).w,d3
	add.b	(PPBonus+2).w,d3
	bsr.w	ClampNibble
	move.b	d3,$71(a3)
	move.b	7(a0),d3	;move Pas/Agr byte into d3
	lsr.b	#4,d3
	move.w	#$E,(TempWord2).w
	jsr	(AttributeCalc).l
	add.b	(PPBonus).w,d3
	add.b	(PPBonus+3).w,d3
	bsr.w	ClampNibble
	move.b	d3,$6F(a3)
	move.b	7(a0),d3
	andi.b	#$F,d3
	cmp.b	#6,d3
	ble.w	.7
	subq.b	#6,d3
.7
	move.w	#$F,(TempWord2).w
	jsr	(AttributeCalc).l
	move.b	d3,$74(a3)
	andi.b	#$F,$74(a3)
	rts
