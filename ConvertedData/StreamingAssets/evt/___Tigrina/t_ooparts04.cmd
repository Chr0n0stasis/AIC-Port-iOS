TALKER	so R   
TALKER	n L   

IF 'GFC[OOP0]>=10' {
    GOTO    _ALREADY_MADE
}
IF 'GFC[OOP0]<5' {
    #SND_LOAD ev_club
    // すでに一度話しかけている場合
    IF 'SfEvt[___Tigrina/t_ooparts02]' {
        PIC   so so1/a0L1R3__F1__f1__m1__e1_ua    
        PIC   n a_2/a0L2R3__F2__f2__m1__b5_u0    
        MSG	n_00 
        PIC   so so1/a0L2R1__F1__f1__m2__e2_u2    
        PIC_MP	so  PLE
    

        MSG	so_01 
    } ELSE {
        PIC   so so1/a0L1R3__F1__f1__m1__e1_ua    
        // ##はじめて話しかける場合
        PIC   n a_1/a22__F1__f1__m1__b1__u1    

        MSG	n_10 
        PIC   so so2/a0L3R1__F2__f2__m7__e1_ua    
        PIC_MP so KIR

        MSG	so_11 

        PIC   n a_3/a0__F1__f3__m8__b1_u3    
        PIC_MP n SWB
        MSG	n_12 

        PIC   n a_1/a22__F1__f1__m1__b2__uo    
        MSG	n_13 



        PIC   so so2/a0L4R2__F2__f2__m2__e1_ua2    
        PIC_MOVEA	so 1 JUMP
        
        MSG	so_15 
        

    }
    TOUCHITEM Recipe_precious_ooparts_cc_sporner
    TOUCHITEM precious_ooparts_cc_sporner
    PIC_HIDE_ALL	 
    HALF_BGM	1
    PIC_FILL #1 DARK
    PIC_FADEIN	#1 45
    WAIT 50
    REMITEM precious_ooparts 1 0 Alert_item_reduced_ooparts_tigrina
    WAIT 60
    PIC_FADEOUT	#1 70
    HALF_BGM	0
    WAIT 60
    
    // 合流

    // ～暗転～
    PIC   n a_1/a00L1R1__F1__f1__m1__b1__u0    
    PIC   so so1/a0L2R4__F1__f1__m2__e2_up    
    PIC_MP so PLE
    MSG	so_16 

    PIC   n a_3/a0__F1__f3__m1__b4_uo    
    MSG	n_17 
    PIC   so so1/a0L3R3__F1__f1__m4__e1_ua3    
    PIC_MP so ONP2

    MSG	so_18   

    // 〜〜〜〜

    PIC_HIDE_ALL	 
    HALF_BGM	1
    PIC_FILL #1 DARK
    PIC_FADEIN	#1 45
    WAIT 95
    PIC_FADEOUT	#1 70
    HALF_BGM	0
    WAIT 60

    PIC   n a_1/a22__F1__f1__m1__b1__u0    
    // 合流
    PIC   so so2/a0L4R1__F2__f2__m1__e2_u3    
    PIC_MP so TTT

    MSG	so_30 
    HKDS	so CCRCT   @B

    PIC   so so2/a0L3R1__F2__f2__m8__e1_ua    
    PIC_HIDE_ALL	'' 1
    
    HALF_BGM	1
    PIC_FILL #1 DARK
    SND garage_gosogoso

    MSG	so_31 

    WAIT 80

    // #ガラクタの山の中から何かを取り出す
    MSG	so_32 
    WAIT 40
    PIC_FADEOUT	#1 70
    HALF_BGM	0
    WAIT 90

    PIC   n a_1/a00L1R1__F1__f1__m1__b1__u3        
    PIC   so so1/a0L1R1__F1__f1__m1__e2_u2    

    WAIT 65
HKDS	so    
    PIC   so so1/a0L1R2__F1__f1__m1__e2_u2    
    MSG	so_33

    PIC   n a_1/a22__F1__f1__m1__b1__u1    
    PIC_MP n QUE
    MSG	n_33 
    GFC_SET OOP0 5
} ELSE {
    IFDEF _ooparts04_activated {
        GOTO _alchemy
    } 
    PIC   n a_1/a00L1R1__F1__f1__m3__b1_u0    
}


PIC   so so1/a0L2R4__F1__f1__m5__ui    
PIC_MP so SWT2

MSG so_34 S

LABEL _alchemy
PIC_HIDE_ALL	 

WAIT 20
_ooparts04_activated=1
ALCHEMY_CCSPORNER
_reselect=1

IF 'ItemHas[precious_ooparts_cc_sporner]==0' {
    // 作ってない
    QUEST_PROGRESS ooparts03 3
    SEEK_END
}

WAIT 20
LABEL _ALREADY_MADE
CHANGE_EVENT2 ___Tigrina/t_ooparts05
GFC_SET OOP0 10
GFB_SET SMNC_CC_GUEST_ENABLED  1
QUEST_FINISH ooparts03
SF_EVT_SET
_cc_guest_enabled=1
