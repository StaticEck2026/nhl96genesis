;	Outside addresses. A routine or table that converted code uses, but that is still inside an incbin
;	segment, is an equate here: one name, one line, in address order. When its segment is converted the
;	equate moves out (the label in the segment replaces it). Included by nhl96.asm and every stub.

TeamRosterScreen	equ	$1E2EFC
ScoringSummaryScreen	equ	$1E352A
PenaltySummaryScreen	equ	$1E38E6
PeriodStatsScreen	equ	$1E3C7C
GameStatisticsScreen	equ	$1E3FDE
ShootoutShooters	equ	$1E4582
RecordHoldersScreen	equ	$1E4DCC
PlayerStatsScreen	equ	$1E55BA
sub_1E55BC	equ	$1E55BC
sub_1E6C4C	equ	$1E6C4C
sub_1E700A	equ	$1E700A
loc_1E7664	equ	$1E7664
loc_1E78C4	equ	$1E78C4
sub_1E7AC4	equ	$1E7AC4
sub_1E827A	equ	$1E827A
sub_1E8544	equ	$1E8544
sub_1E8794	equ	$1E8794
sub_1E889C	equ	$1E889C
sub_1E89FC	equ	$1E89FC
sub_1E8C5E	equ	$1E8C5E
ValidationRoutine	equ	$1E9038	;ROM checksum
sub_1E7A78	equ	$1E7A78
sub_1E8840	equ	$1E8840
