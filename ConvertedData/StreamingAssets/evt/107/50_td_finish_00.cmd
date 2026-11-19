DEFINENDEF 1=-1
_p=$1
HALF_BGM 1
IF $_p'==-10' {
    SHOW_BLURSC
    WAIT 60
    PR_CURE 1 1 1 1 1
TALKER	p L   
TALKER	n R   

    // 終わった後にノエルが戦闘不能であった場合
    MSG	p_40 

    WAIT 70
    PIC   n a_3/a1__F1__f3__m2__b2_u1     I
    PIC_MVA n 14 SCARY
    PIC_FADEIN n 50
    MSG	n_41 

    PIC   p p/a11__F2__f2__m3__b1_u1    
    WAIT 30

    @_PIIN
    PIC   n a_2/a0L2R1__F2__f2__m3__b1_ua    I
    PIC_MVA n 1 JUMP
    PIC_MP n SWT2
    MSG	n_42 I

    PIC   p p/a11__F1__m2__b2_u0    
    MSG	p_43 


    PIC   n a_3/a2__F1__f3__m4__b1_ua    
    PIC_MVA n 14 SCARY

    MSG	n_44 
    SND foot_107_l2r
    PIC_HIDE n 
    
    WAIT 80


    PIC   p p/a11__F2__f2__m1__b1_u0    
    MSG	p_45 

    PIC_HIDE_ALL	 
    WAIT 35


} ELSE {
    IF $_p'==-2' {
MSG_PREFIX so <tigrina> 
        TALKER	so L   
        TALKER	l R   
        PIC   so so1/a0L2R4__F1__f1__m8__b2_u1    
        PIC_MP so SWT2
        // 2戦目
        MSG	so_20 
PIC_HIDE_ALL	 
WAIT 50

WAIT 20
PIC   l l1/a0L2R1__F1__m1__b8_u3    
        MSG	l_21 
    } ELSE {

        TALKER	n R   
        TALKER	i L
        PIC   n a_3/a2__F1__f3__m3__b1_u0    
        MSG n_00

PIC   i i/a00L5R5__F1__f1__m1__b1_u4    
        MSG i_01

    }
    PIC_HIDE_ALL	 

}

DENY_SKIP
STOP_BGM	50 0

_107_first=1
INIT_MAP_MATERIAL city_scl_ground 3
PIC_FILL &10 DARK
PIC_FADEIN &10 65
WAIT 60
PR_CURE 1 1 1 1 1
HIDE_BLURSC 1
WAIT_FN MAP_TRANSFER
NEL_MAP_TRANSFER city_scl_ground L !Ev_200_trash

#MS_ % '## >>[Ev_200_trash -240,0] #; @R P[stand_ev]' 

PIC_FADEOUT &10 65
WAIT 2
AUTO_SAVE 1
HALF_BGM 0
CHANGE_EVENT	107/_td_portal


