<LOAD_DWARF>
#MS_ % '= P[guard]'
#MS_ alice 'w15 @L ! P[run~] P[guard~] ?'
TALKER	n L   
TALKER	a R   
TALKER_REPLACE	a  Mob

PIC   n a_3/a2__F1__f3__m5__b2_u1    
PIC_MP n EXQ

MSG	n_00 FC

PIC   a p3/a0L2R2__F1__e2__u2    
PIC_MP a EXC
WAIT 30
MSG	a_01 


PIC_HIDE_ALL	 
#MS_ % '= w20 P[run] >+[30,0 :12] P[interact]'
WAIT 30
#< alice >
#MS '= ## @L ! P[run~] >+[80,0 <<0.13] ?  P[beware~] w70'
ENGINE Alice200 MINE_WALLJUMP Ev_duct

HKDS	n LB #<%> TT 

TL 180 MSG_SKIP

MTL MSG_HOLD
MSG	n_02 T


CLEARTL
HKDS	n CLB '' 'TT' 

TALKER	n LL    

PIC   n a_2/a0L3R1__F2__m6__b2_u1    
PIC_MP n EXC
TL 15 PIC_MVA n 2 JUMP
MSG	n_03 A
PIC_HIDE_ALL	 
WAIT 10
_duct_alice=1
#CMDRELOAD	IMMEDIATE IMMEDIATE_LOAD 
WAIT 20

QA200_REMOVE_MOVER
#MS_ % '= P[walk~] >+[90,0 :60] P[beware]'
#MS_ Ev_duct '##'

DOTL

HKDS	n CCLT #<%> TT 

MSG	n_04 
PIC_HIDE_ALL	
WAIT 15
#MS_ Ev_duct 'q'
#MS_ % '= w30 ## w40 . >>[Ev_board 30,0 <<0.02] ? @L P[stand_ev~]'

WAIT 100
TX_BOARD *board_10 
WAIT 20

HKDS	n 
TALKER	n L
PIC   n a_3/a2__F1__f3__m1__b4_u0    

IF 'quest_progress_f[p200_alice_mine1]>=0' {

    // 酒場で話を聞いてる
    MSG	n_11 

} ELSE {

    // 酒場で話を聞いていない
    MSG	n_12 
}


PIC_HIDE_ALL	 
WAIT 40

#MS_ Ev_duct '>>[Thunder 0,-50] ##'
HKDS	n LT #<%>
#MS_ % '= w10  >>[Thunder -70,0 <<0.06] P[beware~]'


// 合流
MSG	n_13 

TALKER	n   L 

IF '!SkillHas[evade_jump]' {
// quest_progress_f[p200_elec_facil]<4
// まだメタイベイドを持ってない
    MSG	n_14 

    HKDS	n    
    WAIT 30
    PIC   n a_3/a2__F1__f3__m1__b1_u3    

    MSG	n_15 
    QUEST_PROGRESS p200_alice_mine1 1
    #MS_ % '= P[walk~] >+[-20,0 <<0.02] '
} ELSE {

    HKDS	n    
    PIC   n a_2/a0L1R1__F2__f2__m1__b1_u0    
    // 既にメタイベイドを持っている
    MSG	n_20 

    #MS_ % '= P[walk~] @R ! >+[-15,0 :50] ? @R'

    QUEST_PROGRESS p200_alice_mine1 2
}
PIC_HIDE_ALL	
QUEST_PROGRESS p200_alice 16
#CMDRELOAD
WAIT_MOVE


