;	Outside addresses. A routine or table that converted code uses, but that is still inside an incbin
;	segment, is an equate here: one name, one line, in address order. When its segment is converted the
;	equate moves out (the label in the segment replaces it). Included by nhl96.asm and every stub.

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
dword_23456	equ	$23456
dword_235B8	equ	$235B8
off_23574	equ	$23574
sub_15774	equ	$15774
sub_157A2	equ	$157A2
sub_157B2	equ	$157B2
sub_157F4	equ	$157F4
sub_16D36	equ	$16D36
sub_1A458	equ	$1A458
sub_1B09A	equ	$1B09A
sub_1B0A6	equ	$1B0A6
sub_1CFE4	equ	$1CFE4
sub_1D14E	equ	$1D14E
sub_1D6622	equ	$1D6622
sub_1D66AC	equ	$1D66AC
sub_1D6718	equ	$1D6718
sub_1D7DF8	equ	$1D7DF8
sub_1D8B26	equ	$1D8B26
sub_1D9352	equ	$1D9352
sub_1DF8AC	equ	$1DF8AC
sub_1E7A78	equ	$1E7A78
sub_1E8840	equ	$1E8840
sub_1FAFA	equ	$1FAFA
sub_1FB52	equ	$1FB52
sub_22E58	equ	$22E58
sub_230AA	equ	$230AA
sub_230C4	equ	$230C4
sub_241E8	equ	$241E8
sub_88470	equ	$88470
unk_1AE60	equ	$1AE60
unk_1DF9EC	equ	$1DF9EC
unk_1DF9FC	equ	$1DF9FC
unk_44120	equ	$44120
nullsub_4	equ	$01D062
sub_13EA2	equ	$013EA2
sub_143A8	equ	$0143A8
sub_1B282	equ	$01B282
sub_1B320	equ	$01B320
sub_1B724	equ	$01B724
sub_1BE1C	equ	$01BE1C
sub_1BED6	equ	$01BED6
sub_1BEEC	equ	$01BEEC
sub_1D6F24	equ	$1D6F24
sub_1D8262	equ	$1D8262
sub_1DA6C0	equ	$1DA6C0
sub_21C28	equ	$021C28
sub_224E2	equ	$0224E2
sub_24188	equ	$024188
sub_24208	equ	$024208
sub_88586	equ	$088586
unk_12BFE	equ	$012BFE
unk_12C6E	equ	$012C6E
unk_12D46	equ	$012D46
unk_13558	equ	$013558
unk_17AA7A	equ	$17AA7A
unk_1808B8	equ	$1808B8
unk_18C136	equ	$18C136
unk_18C936	equ	$18C936
unk_18DE04	equ	$18DE04
unk_17ECEA	equ	$17ECEA
