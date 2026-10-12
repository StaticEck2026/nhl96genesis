;	Outside addresses. A routine or table that converted code uses, but that is still inside an incbin
;	segment, is an equate here: one name, one line, in address order. When its segment is converted the
;	equate moves out (the label in the segment replaces it). Included by nhl96.asm and every stub.

loc_EE0E	equ	$00EE0E	;doinput: line change input
SetShotMode	equ	$00F496
ShotMode	equ	$00F530
setpassmode	equ	$00F898
passmode	equ	$00F8D2
sub_12B84	equ	$012B84	;ControllerSetupScreen: draw team d7
Begin		equ	$01464C	;cold start: clear RAM, start the sound driver and the menus
loc_14D6E	equ	$014D6E	;doinput: start button, pad 1
loc_14D74	equ	$014D74	;pad 2
loc_14D7C	equ	$014D7C	;pad 3
loc_14D84	equ	$014D84	;pad 4
vcountwait	equ	$0151E0	;wait for the next vblank
getGoalieSCnum	equ	$0168B8	;d0 = SCnum of the goalie of the team of player d0
loc_16934	equ	$016934
holdplayer	equ	$016988
chgplayer	equ	$016A46
setc1player	equ	$016C52
setc2player	equ	$016C5C
setc3player	equ	$016C68
setc4player	equ	$016C74
setpads	equ	$016D6A
loc_16E40	equ	$016E40	;asstab entry
loc_16FCE	equ	$016FCE	;asstab entry
loc_17058	equ	$017058	;asstab entry
loc_171E0	equ	$0171E0	;asstab entry
loc_17210	equ	$017210	;asstab entry
loc_172C2	equ	$0172C2	;asstab entry
loc_17334	equ	$017334	;asstab entry
loc_17388	equ	$017388	;asstab entry
loc_1745A	equ	$01745A	;asstab entry
loc_175BE	equ	$0175BE	;asstab entry
goaliesave	equ	$017C58
loc_17E7E	equ	$017E7E	;asstab entry
loc_18068	equ	$018068	;asstab entry
loc_18092	equ	$018092	;asstab entry
checkob	equ	$0187D4	;offside watch
loc_18874	equ	$018874	;asstab entry
loc_1889A	equ	$01889A	;asstab entry
loc_18ECA	equ	$018ECA	;asstab entry
loc_18FE0	equ	$018FE0	;asstab entry
loc_19018	equ	$019018	;asstab entry
loc_19326	equ	$019326	;asstab entry
loc_19B70	equ	$019B70	;asstab entry
loc_19F14	equ	$019F14	;asstab entry
loc_19F58	equ	$019F58	;asstab entry
assinsert	equ	$01A3D0
assreplace	equ	$01A3DA
vtoa	equ	$01A3EE
SetSPA	equ	$01A614	;set animation d1 for player a3
loc_1A62A	equ	$01A62A
playeracc	equ	$01AB56	;player acceleration with facing d2
sroot	equ	$01B0DE
sub_1B2C4	equ	$01B2C4
nodiag	equ	$01B2F8
ReadJoy1	equ	$01B348
ReadJoy2	equ	$01B360
ReadJoy3	equ	$01B378
ReadJoy4	equ	$01B390
setVram	equ	$01B57E
Vmaddr	equ	$01B678
dobitmap	equ	$01B692
DecompressGraphicsPlain	equ	$01B730
eraser	equ	$01B976
Framer	equ	$01B9B0
printsmallz	equ	$01BA2E	;printsmall with the String after the call
printsmall	equ	$01BA40
printz	equ	$01BB8E	;print with the String after the call
print	equ	$01BBA0
AddPenalty2	equ	$01C1D2	;d0 = penalty number, a3 = player
loadTeamStruct	equ	$01D328	;a2 = the team struct of player a3
SkipStrings	equ	$01D7F2
checkcoll	equ	$01D7FE
setd0player	equ	$01F662
rtss2	equ	$01F84A	;rts
IRQ7		equ	$0202E4	;rte
VBlank_SetOptions	equ	$021B52	;vbint of the setup screens
AdrErr		equ	$023144	;bus and address error handler
InvOpCode	equ	$02316C	;illegal instruction handler
DivBy0		equ	$023196	;zero divide handler
linelist	equ	$023342	;line names
sub_241AA	equ	$0241AA	;save RAM checksum (WriteSRAMBits)
doassignment	equ	$024380
FaceOffMap	equ	$091D46	;faceoff window bitmap
unk_173C7A	equ	$173C7A	;controller setup screen map
RosterFont	equ	$179168
PadIconMap1	equ	$1B53C4
PadIconMap2	equ	$1B5942
PadIconMap3	equ	$1B5EC0
PadIconMap4	equ	$1B643E
PadCursorMap	equ	$1B69BC
unk_1B6F3A	equ	$1B6F3A	;controller setup screen map
unk_1B773A	equ	$1B773A	;controller setup screen background
loc_1D6872	equ	$1D6872	;asstab entry
PuckOnAttackHalf	equ	$1D6B66
ShortenMsgTimer	equ	$1D8676
sub_1D920A	equ	$1D920A
ValidationRoutine	equ	$1E9038	;ROM checksum
