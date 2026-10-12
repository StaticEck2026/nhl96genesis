;	Outside addresses. A routine or table that converted code uses, but that is still inside an incbin
;	segment, is an equate here: one name, one line, in address order. When its segment is converted the
;	equate moves out (the label in the segment replaces it). Included by nhl96.asm and every stub.

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
sub_19782	equ	$019782
loc_19B70	equ	$019B70	;asstab entry
loc_19F14	equ	$019F14	;asstab entry
loc_19F58	equ	$019F58	;asstab entry
assinsert	equ	$01A3D0
assreplace	equ	$01A3DA
vtoa	equ	$01A3EE
SetSPA	equ	$01A614	;set animation d1 for player a3
loc_1A62A	equ	$01A62A
playeracc	equ	$01AB56	;player acceleration with facing d2
sub_1AF52	equ	$01AF52
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
sub_1BEE8	equ	$01BEE8
AddPenalty2	equ	$01C1D2	;d0 = penalty number, a3 = player
sub_1C272	equ	$01C272
ClearPenaltyBuffer	equ	$01CCB0
loc_1CE8A	equ	$01CE8A
loadTeamStruct	equ	$01D328	;a2 = the team struct of player a3
sub_1D4CE	equ	$01D4CE
SkipStrings	equ	$01D7F2
checkcoll	equ	$01D7FE
setd0player	equ	$01F662
rtss2	equ	$01F84A	;rts
getpde	equ	$01FB24
setpde	equ	$01FB44
vb2	equ	$0201DC
IRQ7		equ	$0202E4	;rte
sub_2034A	equ	$02034A
KillCrowd	equ	$020E28
setupice	equ	$020E52
sub_21482	equ	$021482
loc_2161E	equ	$02161E
ExitToOpening	equ	$0216EE
Opening	equ	$0216F2
sub_21A4C	equ	$021A4C
VBlank_SetOptions	equ	$021B52	;vbint of the setup screens
sub_21B82	equ	$021B82
sub_21CF4	equ	$021CF4
sub_223B0	equ	$0223B0
sub_223EA	equ	$0223EA
sub_225E0	equ	$0225E0
loc_22A2C	equ	$022A2C
AdrErr		equ	$023144	;bus and address error handler
InvOpCode	equ	$02316C	;illegal instruction handler
DivBy0		equ	$023196	;zero divide handler
unk_23248	equ	$023248
linelist	equ	$023342	;line names
unk_236B0	equ	$0236B0
unk_23734	equ	$023734
unk_23890	equ	$023890
sub_23F1C	equ	$023F1C
sub_241AA	equ	$0241AA	;save RAM checksum (WriteSRAMBits)
doassignment	equ	$024380
Z80Program	equ	$025500
SoundBanks	equ	$027026
SoundCmd	equ	$08839E
sub_883AC	equ	$0883AC
sub_883D4	equ	$0883D4
sub_8842E	equ	$08842E
stop_current_song	equ	$0885FC
SoundOff	equ	$088676
ChooseSong	equ	$088688
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
sub_1D6D22	equ	$1D6D22
sub_1D733C	equ	$1D733C
ShortenMsgTimer	equ	$1D8676
unk_1D86A4	equ	$1D86A4
nullsub_6	equ	$1D8782
PlaceBoardFall	equ	$1D8F66
sub_1D9114	equ	$1D9114
sub_1D920A	equ	$1D920A
sub_1D92EC	equ	$1D92EC
ClearPenalties	equ	$1D97F4
sub_1D9844	equ	$1D9844
loc_1DB020	equ	$1DB020
sub_1DFA1C	equ	$1DFA1C
sub_1E2688	equ	$1E2688
sub_1E55BC	equ	$1E55BC
ValidationRoutine	equ	$1E9038	;ROM checksum
dword_23456	equ	$23456
dword_235B8	equ	$235B8
off_23574	equ	$23574
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
sfx	equ	$88470
dirtab	equ	$1AE60
unk_1DF9EC	equ	$1DF9EC
unk_1DF9FC	equ	$1DF9FC
unk_44120	equ	$44120
nullsub_4	equ	$01D062
sub_1B282	equ	$01B282
sub_1B320	equ	$01B320
sub_1B724	equ	$01B724
sub_1BE1C	equ	$01BE1C
sub_1BED6	equ	$01BED6
sub_1BEEC	equ	$01BEEC
Create_HotCold_Table	equ	$1D6F24
sub_1D8262	equ	$1D8262
sub_1DA6C0	equ	$1DA6C0
sub_21C28	equ	$021C28
sub_224E2	equ	$0224E2
sub_24188	equ	$024188
sub_24208	equ	$024208
song	equ	$088586
unk_17AA7A	equ	$17AA7A
unk_1808B8	equ	$1808B8
unk_18C136	equ	$18C136
unk_18C936	equ	$18C936
unk_18DE04	equ	$18DE04
unk_17ECEA	equ	$17ECEA
