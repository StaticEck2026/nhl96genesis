;	Outside addresses. A routine or table that converted code uses, but that is still inside an incbin
;	segment, is an equate here: one name, one line, in address order. When its segment is converted the
;	equate moves out (the label in the segment replaces it). Included by nhl96.asm and every stub.

sub_201C6	equ	$0201C6
vb2	equ	$0201DC
unk_202C4	equ	$0202C4
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
sub_22820	equ	$022820
loc_22A2C	equ	$022A2C
sub_22B70	equ	$022B70
loc_22C5E	equ	$022C5E
sub_22E70	equ	$022E70
sub_22ED6	equ	$022ED6
AdrErr		equ	$023144	;bus and address error handler
InvOpCode	equ	$02316C	;illegal instruction handler
DivBy0		equ	$023196	;zero divide handler
unk_23248	equ	$023248
unk_232C8	equ	$0232C8
linelist	equ	$023342	;line names
unk_233BC	equ	$0233BC
unk_23426	equ	$023426
unk_236B0	equ	$0236B0
unk_23734	equ	$023734
unk_23890	equ	$023890
unk_239D4	equ	$0239D4
sub_23F1C	equ	$023F1C
sub_241AA	equ	$0241AA	;save RAM checksum (WriteSRAMBits)
doassignment	equ	$024380
sub_2441E	equ	$02441E
Z80Program	equ	$025500
SoundBanks	equ	$027026
SoundCmd	equ	$08839E
sub_883AC	equ	$0883AC
sub_883D4	equ	$0883D4
sub_8842E	equ	$08842E
stop_current_song	equ	$0885FC
SoundOff	equ	$088676
ChooseSong	equ	$088688
sub_887E4	equ	$0887E4
unk_91B86	equ	$091B86
unk_91B8E	equ	$091B8E
FaceOffMap	equ	$091D46	;faceoff window bitmap
unk_97E72	equ	$097E72
unk_98F30	equ	$098F30
unk_98F38	equ	$098F38
unk_13938E	equ	$13938E
unk_13D290	equ	$13D290
unk_13D59E	equ	$13D59E
unk_173C7A	equ	$173C7A	;controller setup screen map
RosterFont	equ	$179168
unk_179A76	equ	$179A76
unk_17AA72	equ	$17AA72
unk_17B680	equ	$17B680
PadIconMap1	equ	$1B53C4
PadIconMap2	equ	$1B5942
PadIconMap3	equ	$1B5EC0
PadIconMap4	equ	$1B643E
PadCursorMap	equ	$1B69BC
unk_1B6F3A	equ	$1B6F3A	;controller setup screen map
unk_1B773A	equ	$1B773A	;controller setup screen background
unk_1B89C8	equ	$1B89C8
unk_1B9416	equ	$1B9416
loc_1D6872	equ	$1D6872	;asstab entry
PuckOnAttackHalf	equ	$1D6B66
sub_1D6D22	equ	$1D6D22
sub_1D6E0E	equ	$1D6E0E
AttributeCalc	equ	$1D6F66
sub_1D72F6	equ	$1D72F6
sub_1D733C	equ	$1D733C
UpdateRecords	equ	$1D7BC6
CountShootoutGoals	equ	$1D8208
sub_1D82A2	equ	$1D82A2
sub_1D8618	equ	$1D8618
ShortenMsgTimer	equ	$1D8676
unk_1D86A4	equ	$1D86A4
nullsub_6	equ	$1D8782
nullsub_7	equ	$1D8A86
PlaceBoardFall	equ	$1D8F66
sub_1D9062	equ	$1D9062
sub_1D906C	equ	$1D906C
sub_1D9114	equ	$1D9114
sub_1D920A	equ	$1D920A
sub_1D92EC	equ	$1D92EC
sub_1D9376	equ	$1D9376
ClearPenalties	equ	$1D97F4
sub_1D9844	equ	$1D9844
loc_1DB020	equ	$1DB020
sub_1DFA1C	equ	$1DFA1C
sub_1E2688	equ	$1E2688
sub_1E55BC	equ	$1E55BC
sub_1E8794	equ	$1E8794
ValidationRoutine	equ	$1E9038	;ROM checksum
dword_23456	equ	$23456
dword_235B8	equ	$235B8
off_23574	equ	$23574
sub_1D6622	equ	$1D6622
sub_1D66AC	equ	$1D66AC
sub_1D6718	equ	$1D6718
sub_1D7DF8	equ	$1D7DF8
sub_1D8B26	equ	$1D8B26
sub_1D9352	equ	$1D9352
sub_1DF8AC	equ	$1DF8AC
sub_1E7A78	equ	$1E7A78
sub_1E8840	equ	$1E8840
sub_22E58	equ	$22E58
sub_230AA	equ	$230AA
sub_230C4	equ	$230C4
sub_241E8	equ	$241E8
sfx	equ	$88470
unk_1DF9EC	equ	$1DF9EC
unk_1DF9FC	equ	$1DF9FC
unk_44120	equ	$44120
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
