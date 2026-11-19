//  puzzle_rope はらばいアリス
<LOAD_DWARF>

TALKER	a R
TALKER	n L   
TALKER_REPLACE	a  Mob 

#< alice >
DENY_SKIP
#MS '## ^ @R P[crawl] >+[20,0 :10] >+[135,0 :100] _ <<[0.1,0 :20:50] P[jump2fall] F P[run] >+[150,0 <<0.14]'
// ジャンプ
#MS '<<[0.12,0 h30r30] P[jump] j[>>90 :30:30] P[jump2fall] F '
#MS '<<[0.12,0 h30r30] P[rolejump] j[>>90 :30:30] P[jump2fall] F '
#MS 'P[run] >+[70,0 <<0.14] P[stand]'

PE ZOOM2 70
#MS_ % 'P[run] >>[Ev_qa200_6.R -11,0 <<0.12] P[crouch] w22 P[guard_crouch] w160 ##'
TL 190 PE ZOOM2 -50

WAIT 15
HKDS	n T 
PIC   n a_3/a0__F1__f3__m1__b2_uo    
PIC_MP n EXC
TL 20 PIC_MVA n 14 SCARY

ALLOW_SKIP
MSG n_00
PIC_HIDE_ALL
HKDS	 n



WAIT_MOVE 50
WAIT 40
PIC   n a_2/a0L1R3__F2__f2__m1__b5_u2    
PIC_MP n SMK
DOTL
TL 50 QA200_REMOVE_MOVER
MSG n_01

DOTL
PIC_HIDE_ALL	 

IF PVV==200 
    PVV 201
_200_escape06=1
#CMDRELOAD	IMMEDIATE IMMEDIATE_LOAD 
WAIT 2
