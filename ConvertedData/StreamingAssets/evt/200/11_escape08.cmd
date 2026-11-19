//  mount_busstop 洞窟逃げアリス
// 強制バトル
// 1 右下
IF 'PVV>201' SEEK_END
<LOAD_DWARF>
DEFINENDEF 1=0

_from_rb=~$1

IF $_from_rb {
    TALKER	n R   
    TALKER	a L
} ELSE {
    TALKER	n L
    TALKER	a R
}

TALKER_REPLACE	a  Mob 


DENY_SKIP

#MS_ QA200_PUPPY '^'
#< alice >
PE ZOOM2 50
#MS '##'
IF 'PVV==200' {
    PIC   n a_2/a0L3R1__F2__f2__m1__b1_u0    
    PIC   a p1/a0L3R3__F1__e7__uia    
    TL 14 PIC_MVA n  14 SCARY
    MSG	200/05_escape03*n_01 C
    MSG_HOLD
    WAIT 25
    DOTL
    PIC_MVA a  2 JUMP
    MSG 200/05_escape03*a_00 
    MSG_HIDE
    PIC_HIDE_ALL	 
    WAIT 15
    
}
IF $_from_rb {
    HKDS	a CLT #<alice> TT
} ELSE {
    HKDS	a CRT #<alice> TT
}

IF $_from_rb'==0' {
    #MS '@L ! >+[100,0 :80] A F <<[0.02,0 a5h10r20 ] P[ev_sink_f] w40 ? @R P[run] <<[0.078,0 h20r30] A P[jump2fall] F <<[0.13,0 h80] F P[rolejump] j[>>70 :50:1]'
    _waittime=150
    TL 77 SUMMONER_CUT_NEAREST_WEED mount_busstop
} ELSE {
    #MS '@R ! P[sink2fear] >+[-100,0 :90] P[crouch2stand] w13 <<[0.117,0 h90r30] F P[rolejump] j[>>190 :65:1]'
    _waittime=150
    TL 40 SUMMONER_CUT_NEAREST_WEED mount_busstop
}

#MS_ % 'P[guard] w60'

// 右金網から暗闇洞窟まで
#MS 'F  <<[0.12,0 h30r30] P[jump] j[>>90 :30:30] P[jump2fall] F P[run] >+[70,0 <<0.14] P[run] >+[500,0:125] P[stand]'
TL 240 #< QA200_PUPPY >
TL 240 ENEMY_ADD_TICKET BACKSTEP 140




MSG a_00 C
MSG_HOLD
WAIT $_waittime
PIC_HIDE_ALL
MSG_HIDE 
PE ZOOM2 -1
#< % >
IF $_from_rb'==0' {
    #MS 'q ##  P[run] <<[ 0.11,0 h90r40] A P[fall] F P[run] w30 P[run_stop] w40 P[guard~] '
    WAIT 96
} ELSE {
    #MS 'q ##  P[run] >>[Ev_center.Rb <<0.12] P[run_stop] <<[ -0.08,0 h1r40] w40 P[guard~] '
WAIT 72
}


#< % >
IF 'PVV==200' {
    PVV 201
}
QUEST_PROGRESS p200_alice 7
SUMMONER_TYPE mount_busstop NO_EFFECT
SUMMONER_ACTIVATE mount_busstop
SUMMONER_PLAYER_SET_DELAY mount_busstop 1
SUMMONER_ACTIVATE_EFFECT NORMAL_SIMPLE

WAIT 30
DOTL
PIC   n a_3/a0__F1__f3__m5__b2_u1    
PIC_MP n SWT2
ALLOW_SKIP
MSG n_01 A

SUMMONER_TYPE mount_busstop 
QA200_REMOVE_MOVER


QUEST_PROGRESS p200_alice 8
