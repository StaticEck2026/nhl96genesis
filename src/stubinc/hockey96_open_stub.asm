;	Segment build for hockey96_open.asm: sets its origin and the outside routines and data it uses,
;	then includes the file on its own for checking against the ROM.

; region code
	org	$0215DC

; includes for stubs to replace removed code
	include	stubinc\ports.inc	;IO_* / VDP_* ports
	include	stubinc\equals.inc	;VDP status bits
	include	ram96.asm		;RAM map
	include	externs96.asm		;outside addresses still in incbin segments. Equates only
	include	macros\genesis.mac	;String

; External addresses outside, read from lst/nhl96.bin.
SetContTeams = $00B04E		;goal96
sub_10FB4 = $010FB4		;season96
sub_11024 = $011024		;season96
sub_1116A = $01116A		;season96
sub_113C2 = $0113C2		;season96
sub_1147E = $01147E		;season96
sub_1149E = $01149E		;season96
sub_11510 = $011510		;season96
sub_115EA = $0115EA		;season96
sub_1169C = $01169C		;season96
sub_11814 = $011814		;season96
sub_1223E = $01223E		;season96
unk_122A4 = $0122A4		;season96
nullsub_2 = $013556		;teamgfx96
nullsub_3 = $013EA0		;awards96
StartGame = $014702		;hockey96
ResetClock = $01483A		;hockey96
StartPer = $0148BA		;hockey96
PlayoffStatsMenu = $015490		;pause96_menu
CopyPaletteToCRAM = $01B064		;video96
waitx = $01B152		;video96
setVram_0 = $01B594		;video96
dobitmap = $01B692		;video96
printz = $01BB8E		;video96
Intermission = $01D3CE		;hockey96_inter
UpdateScores = $01D518		;hockey96_inter
EncodePW = $02229C		;playoff96
ReadPassData = $022386		;playoff96
WritePassData = $0223B0		;playoff96
WritePassBits = $0223EA		;playoff96
AddPlayoffTeamStats = $0224FA		;playoff96
Z80Program = $025500		;data96_02
SoundBanks = $027026		;data96_02
SoundCmd = $08839E		;data96_04
song = $088586		;data96_04
stop_current_song = $0885FC		;data96_04
SoundOff = $088676		;data96_04
EASportsMap = $13DA74		;data96_06
OptionsScreen = $1E0DDE		;code96_17
ReturnToGame = $1E2688		;code96_18
UserNameEntry = $1E6C4C		;code96_19
PlayoffScreen = $1E700A		;code96_19
SeasonAwards = $1E7AC4		;code96_19
sub_1E827A = $1E827A		;code96_20
sub_1E8544 = $1E8544		;code96_20
sub_1E889C = $1E889C		;code96_20
sub_1E89FC = $1E89FC		;code96_20
sub_1E8C5E = $1E8C5E		;code96_20
maketree = $021CF4		;playoff96
KillCrowd = $020E28		;display96
vb2 = $0202C4		;display96
ContinuePlayoffs = $021BB0		;playoff96
NewPO = $021C28		;playoff96


; Main segment code
	include	hockey96_open.asm
