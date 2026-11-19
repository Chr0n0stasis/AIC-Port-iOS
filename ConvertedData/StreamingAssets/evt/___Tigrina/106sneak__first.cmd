// 武器庫初回侵入時

IF 'GFC[TIG0]==2&&(GFC[TIG1])==0' {
    // first
    #< sneaker_0 >
    #MS '##'
    DENY_SKIP
    WAIT 40
    LP_ACTIVATE door Extender_LT
    WAIT 45
    ALLOW_SKIP
    _ms_def='P[walk] >>[Ev_door_out.B 23,-40] @R '
    #MS $_ms_def' w55  >+[80,0 << 0.064] P[stand]'
    #MS_ sneaker_1 $_ms_def' w25 >+[230,0 << 0.083] P[stand] @L'
    #MS_ sneaker_2 $_ms_def' w35 >+[180,0 << 0.08] P[stand] @L'
    #MS_ sneaker_3 $_ms_def' w55 >+[255,0 << 0.086] P[stand] @L'
    #MS_ sneaker_4 $_ms_def' w25 >+[305,0 << 0.068] P[stand] @L'
    #MS_ sneaker_5 $_ms_def' w76 >+[282,0 << 0.084] P[stand] @L'
    WAIT 20
    HKDS	mb0 CLT #<sneaker_0>
    TALKER_REPLACE	mb0 Army talk_mob_w3 
    
    
    MSG mb0_00

    PIC_FILL	#9 DARK
    
    PIC_FADEIN	#9 50
    WAIT 60
    <LOAD>
    LP_ACTIVATE sneaking_data SneakingMG_00
    PIC_FADEOUT	#9 60
    
    #MS_ sneaker_3 '## #;'
    WAIT_BUTTON 120

    #MS_ sneaker_1 '## '    
    WAIT_BUTTON 90

    #MS_ % '## '    
    
    TALKER	n L   
    
    PIC   n a_3/a0__F1__f3__m8__b1_u2    
    PIC_MP	n TTT 
    MSG n_00
    GFC_SET TIG1 1

} ELSE {
    LP_ACTIVATE door Extender_LT

}


GFC_SET TIG2 |=1
SNEAKINGMG INIT_PR_RUNNING