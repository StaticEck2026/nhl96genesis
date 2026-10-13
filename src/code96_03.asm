;	The line change box. SetLCmode opens it for the team of player a3 when line changes are on.

SetLCmode	;Open the line change box for the team of player a3 (loadTeamStruct): not with line changes
	;off (OptLine)
	tst.w	(OptLine).w
	bne.w	rtss7
	btst	#4,(sflags7).w
	bne.w	rtss7
	jsr	(loadTeamStruct).l
	bset	#1,tmflags(a2)
	bne.w	rtss7
	btst	#3,(sflags5).w
	bne.w	.0
	bclr	#2,(sflags).w
.0
	bclr	#3,(sflags).w
	bset	#3,pflags2(a3)
