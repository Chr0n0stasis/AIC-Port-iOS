DEFINENDEF 1=0
_talking=$1

IF '!'$_talking {
    #VANISH
    
    _alma_appear=1
    #CMDRELOAD	IMMEDIATE IMMEDIATE_LOAD 
    WAIT 2
    <LOAD>
    DENY_SKIP
    HKDS	l CLT #<alma> WIDE_TT
    #MS_ % 'j[ >>50 :40] F w15 P[beware] '
    #MS_ alma '@L P[jump] j[ >>130 :60:20] P[fall] F '
    #MS_ alma 'P[jump] j[ >>130 :60:20] P[fall] F'
    #MS_ alma 'P[jump] j[ >>130 :60:20] P[fall] F'
    #MS_ alma 'P[jump] j[ >>190 :60:20] P[fall] F'
    MSG	l_00 AFC
    
    WAIT_MOVE
    #MS_ % 'w10 @R ! P[walk~] >>[Ev_enter.L 160,0 <<0.06] P[stand_ev~] ?'
    #MS_ alma '! @L P[walk] >+[70,0 :90] P[stand]'
    <LOAD>
    WAIT_MOVE
    WAIT 20
    ALLOW_SKIP
    WAIT_BUTTON
    MSG_HIDE 
    WAIT 15


    TALKER	n L   
    TALKER	l R   
    PIC   n a_1/a22__F1__f1__m1__b1__u1    
    PIC_MP	n QUE 
    HKDS	l  
    
    PIC   l l1/a0L2R2__F1__m1__b4_ua4    
    PIC_MP l HOT|SWT
    MSG	n_01 

    PIC   l l1/a0L2R2__F1__m1__b1_ua4    
    PIC_MP l SWT2
    MSG	l_02 


    MSG	l_03 
    PIC   n a_1/a22__F1__f1__m4__b1_ua    
    PIC_MP n PLE


    MSG	n_04 
    PIC_HIDE_ALL	 
    

    LOAD_LAYER Treasure
    #< Treasure_magic_flowerycircle >
    #PTCST general_circle_t 'maxt=50'
    SND itembox_appear

    #MS_ alma 'P[walk] ! >+[30,0 :70] P[stand] ?'

    WAIT 50
} ELSE {
    GREETING	L 16
    #MS_ alma 'q . = @#[%::60] @L'
    WAIT 20
    <LOAD>
    TALKER	n L   
    TALKER	l R   
    IF '(GFC[ALM1]&8)!=0' {
        PIC   l l1/a0L2R1__F1__m1__b1_u2    
        PIC   n a_1/a00L1R3__F1__f1__m1__b1__u3    

        MSG 200/36_alma_magic_learned*n_43
        PIC   l l1/a0L3R2__F1__m1__b3_u2    
        PIC_MP l KIR

        MSG 200/36_alma_magic_learned*l_44

    } ELSE {
        
        PIC   l l1/a0L3R1__F1__m1__b8_u1    
        // 取る前に話しかける
        PIC   n a_3/a0__F1__f3__m1__b4_uo    
        MSG	n_10 

        PIC   l l1/a0L3R1__F1__m1__b8_ua    
        MSG	l_11 

        PIC   n a_1/a00L3R3__F1__f1__m1__b1__u0    
        MSG	n_12 

        PIC   l l1/a0L2R2__F1__m1__b6_u4    
        PIC_MP l SWT2
        PIC_MVA l 1 HOP

        MSG	l_13 
    }
}
