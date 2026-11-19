 DEFINENDEF 1=0
<NOLOAD>
IF 'GFC[OST1]<2' {
    IF 'PVV>=215'
        SEEK_END
    IF '!Exist_mover[ostrea]'
        SEEK_END
    <LOAD>
    GFC_SET_MX OST1 2
    #MS_ Cannon_0_Mv0 '##'
    #MS_ % 'F w20 @L ! >>[Ev_ostreaR -10,0 <<0.05]   @L P[stand_ev~] ?'
    #MS_ ostrea '@#[%::190]'
    DENY_SKIP
    WAIT 120
    // START_LETTERBOX

    WAIT 20
    ALLOW_SKIP

    #MS_ % '##'


    WAIT 30
    TALKER s R
    TALKER n L
    PIC   s s/a0L1R2__F1__f1__m1__e1__u2    
    PIC   n a_2/a0L1R1__F2__f2__m1__b5_u0    
    MSG	s_00 

    PIC   n a_3/a2__F1__f3__m1__b3_uo   
    PIC_MP	n SWT2 
    
    MSG	n_01 
    #MS_ % '= w20 ? @R'
    PIC_HIDE_ALL	 

    INIT_MAP_MATERIAL mount_carabl 1
    PIC_FILL #9 DARK
    PIC_FADEIN #9 30
    __43_ostrea_panup=1
    WAIT 35
    WAIT_FN MAP_TRANSFER 
    NEL_MAP_TRANSFER mount_carabl L !Ev_BB
    __43_ostrea_panup=1
    #CMDRELOAD	IMMEDIATE IMMEDIATE_LOAD 
    WAIT 3
    HIDENOEL 1

    #< 43_ostrea_panup >
    #MS '## w30 >+[0,-300 :180]`'
    PIC_FADEOUT #9 40
    WAIT 55

    HKDS	n   LB @LOUT

    MSG	n_02 

    WAIT_MOVE 80
    WAIT 40

    INIT_MAP_MATERIAL mount_carahole_bl 1
    PIC_FILL #9 DARK
    PIC_FADEIN #9 30
    WAIT 35
    WAIT_FN MAP_TRANSFER 
    NEL_MAP_TRANSFER mount_carahole_bl L !Ev_ostreaR
    WAIT 3
    #CALL2 bright trigger_a
    HIDENOEL 0

    #< % >
    #MS '## ? @L P[stand_ev~] ?' 
    PIC_FADEOUT #9 40
    WAIT 50
    HKDS	n    

    TALKER s L
    TALKER n R
    PIC   n a_1/a22__F1__f1__m1__b1__u0    
    PIC   s s/a0L3R1__F1__f1__m1__e2__u1    

    MSG	s_03 

    PIC_HIDE_ALL	 
    #MS_ ostrea 'w10 @L'
    WAIT 30
    HKDS	s  CRB #<ostrea>
    
    #MS_ Ev_LT '##'

    WAIT 20


    MSG	s_04 


    MSG	s_05 

    WAIT 20
    HKDS	s    
    
    #MS_ % '##'
    WAIT 20

    PIC   s s/a0L3R3__F1__f1__m2__b1__u2    
    PIC_MOVEA	s -1 SCARY 
    PIC_MP  s SWB
    
    PIC   n a_3/a2__F1__f3__m1__b4_uo    
    MSG	n_06 


    #MS_ ostrea '@#[%]'
    PIC   s s/a0L2R2__F1__f1__m2__b1__u1    I
    PIC_MP  s PLE
    MSG	s_07 

    PIC   s s/a0L1R3__F2__f2__m1__e3__u1    
    PIC_MP s HOT
    MSG	s_08 

    PIC   n a_1/a22__F1__f1__m1__b1__u3    
    PIC_MP n QUE
    MSG	n_08 T
    PIC   s s/a0L3R2__F1__f1__m1__e2__u2    

    MSG	s_09 

    QUEST_PROGRESS p200_elec_facil 0

} ELSE {
    IF $1'==0' 
        SEEK_END
    <LOAD>
    PIC   s s/a0L2R1__F1__f1__m1__e2__u1    
    //再度話しかけ
    PIC   n a_3/a2__F1__f3__m1__b1_u2    
    MSG	s_20 

    MSG	s_21 

}
