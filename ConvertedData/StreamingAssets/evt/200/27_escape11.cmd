// 途中を省略してここまで来た人向け アリスとの会話
<LOAD_DWARF>

#< alice >
_enable=0
IF 'quest_progress_f[p200_alice]<4' {
    _enable=1
}
IF $_enable {
    
    TALKER	a R
    TALKER	n L   
    TALKER_REPLACE	a  Mob 


    PIC   n a_2/a0L1R1__F2__f2__m1__b1_uo    
    PIC   a p1/a0L3R3__F1__e7__uia    
    TL 14 PIC_MVA n  14 SCARY

    #MS_ alice '##  @L ! P[walk] >+[110,0 :40] @L P[crouch2beware] ?'
    PE ZOOM2 70

    MSG	200/05_escape03*n_01 C

    MSG_HOLD

    WAIT 25
    DOTL
    PIC_MVA a  2 JUMP

    MSG 200/05_escape03*a_00 
    MSG_HIDE
    PIC_HIDE_ALL	 
}

#MS_ alice 'q ! P[sink2fear] >+[20,0 :15] >+[70,0 :110] ? P[crouch2stand] >+[20,0 :14] @R w11 P[run] >+[320,0 :90] '
IF $_enable {
    #MS_ % 'w80 ##'
    DENY_SKIP
    WAIT 120
    QA200_REMOVE_MOVER
}
