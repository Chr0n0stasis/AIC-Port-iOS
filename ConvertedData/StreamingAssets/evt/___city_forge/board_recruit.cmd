_focusto=$1
<LOAD_EMOJI>
GREETING	L -15
WAIT 20

#< $_focusto >
#TTT_TEMP_HIDE
#< smith >
#TTT_TEMP_HIDE

TX_BOARD *board_recruit FRAMED_PAPER

IF 'GFC[FORGE0]<2' {
    WAIT 40
    TALKER	n R
    PIC   n a_3/a0__F1__f3__m1__b4_u0    
    PIC_MP n L
    
    MSG n_100
    PIC_HIDE_ALL	 
    
    WAIT 10 
    #MS_ % 'w130 P[stand_ev~=0] @L ! w30 P[walk~] >+[30,0:40] P[stand_ev~] ?' 
    CHANGE_EVENT	___city_forge/t01
} ELSE {
    
    HKDS	fd RT #<$_focusto>
    TALKER_REPLACE	fd Mob talk_mob_w2
    IF 'GFC[FORGE0]<4' {
        WAIT 30
        #MS_ $_focusto '##'
        WAIT 10
        MSG fd_200
        CHANGE_EVENT2	___city_forge/t_buy01
        GFC_SET_MX FORGE0 4
    } ELSE {
        // 業務請負を見たあと張り紙をもう一度見る
        WAIT 30
        TALKER	n L    
        PIC   n a_1/a00L1R1__F1__f1__m3__b1_u0    
        PIC_MP n SWT


        MSG	n_300 

        PIC_HIDE_ALL	 

        #MS_ % 'q w130 @L P[stand_ev~=0]'

        @___city_forge/father_comment ___city_forge/board_recruit*ff_301  $_focusto

        #MS_ % 'q w30 @R P[stand_ev~=0]'


        MSG	fd_302 


        MSG	fd_303 


        MSG	fd_304 

        #MS_ % 'q w20 @L P[stand_ev~=0]'

        @___city_forge/father_comment ''  $_focusto

        #MS_ % 'q w30 @R P[stand_ev~=0]'


        MSG	fd_306 

        PIC   n a_2/a0L2R3__F2__m6__b2_u0     I
        @_TSUKKOMI n
        PIC_MP n EXQ
        MSG	n_307  AI

    }
}
