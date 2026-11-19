
// _1: again

DEFINENDEF 1=0
#< tigrina >
IF $1'==1' {
    MSG_PREFIX so <tigrina>
    GREETING	L 25
    #MS '@#[%::40]'
    GOTO AGAIN
}

DOTL
QUEST_PROGRESS p106_tigrina_armory 1
#MS_ % '>>[Ev_L -40,0] >+[100,0 <<0.025]'
#MS '>>[Ev_L 105,0] >+[-40,0] @R P[walk] >+[60,0 <<0.025] P[stand] w25 @L'





WAIT 40

HKDS	so CRT #<tigrina> 



MSG so_03


WAIT 60

TALKER	so R   
HKDS	so
TALKER	n L   
PIC   n a_1/a00L1R1__F1__f1__m1__b1__u0    
PIC   so so2/a0L3R1__F2__f2__m1__e2_u3    
PIC_MP	so TTT 


MSG so_04

MSG n_05

PIC_HIDE_ALL	
#MS 'w20 @R'
WAIT 35


#< cam_elevator >
PE ZOOM2 60 1
#MS '##'

WAIT 50
HKDS	so CLT #<tigrina>



MSG	so_06 


@_PIIN
PIC   so so1/a0L3R3__F1__f1__m2__e2_u2    I
PIC_MP	so KIR 
HKDS	so
TALKER	so L   

MSG	so_06_2 IA


TALKER	so R
TALKER  n L
PIC   n a_3/a0__F1__f3__m5__b2_u0    
PIC_MP n EXQ

MSG	n_07 

PIC_HIDE_ALL	


#< tigrina >
#MS 'w25 ## w20 @L'
WAIT 60
PIC   so so2/a0L4R1__F2__f2__m5_u2    


MSG	so_08 

PIC   n a_2/a0L1R3__F2__f2__m1__b5_u2    
PIC_MP n QUE

MSG	n_09 

PIC_HIDE_ALL	 

WAIT 60

@_TSUKKOMI

PIC   so so1/a0L2R4__F1__f1__m8__b1_u1    I
PIC_MOVEA	so 20 SCARY


MSG	so_10 I

PIC   so so2/a0L2R2__F2__f2__m2__e2_ua2    
PIC_MOVEA	so 7 HOP

MTL PIC   so so1/a0L4R2__F1__f1__m1__e2_ua2    
MTL PIC   so so1/a0L3R3__F1__f1__m2__e1_up    
MTL PIC   so so2/a0L4R2__F2__f2__m2__e1_ua2    
MTL PIC_MP   so BLS|KIR
MTL SND ping
MTL PIC_FLASH	&9 0 6 4 ff:#EBEBEB
MSG so_10_2 S


PIC   n a_3/a0__F1__f3__m1__b1_u2    
PIC_MP n QUE
MSG	n_11 T

MSG	n_12 

PIC   so so1/a0L2R1__F1__f1__m2__e1_up    
PIC_MP so LAG
MTL PIC   so so2/a0L1R1__F2__f2__m1__e3_u3    
MTL PIC_MP so DEP
MSG	so_13  S

PIC   so so2/a0L3R1__F2__f2__m5_ua    
MTL PIC   so so1/a0L1R2__F1__f1__m1__e2_u2    
MSG	so_14 S

PIC   n a_1/a22__F1__f1__m1__b3__u0    

MSG	n_14 


@_TSUKKOMI
PIC   so so1/a0L2R4__F1__f1__m8__b2_u2    I
PIC_MOVEA	so 15 SCARY
PIC_MP so DEP|SWT2

MSG	so_15 IA

PIC   n a_1/a00L3R1__F1__f1__m1__b1__u1    
PIC_MP n QUE

MSG	n_16 
PIC   so so1/a0L3R3__F1__f1__m4__e1_up    
PIC_MP so SWT
MTL PIC   so so2/a0L4R1__F2__f2__m1__e3_u2    
MSG	so_17 S

PIC   n a_2/a0L3R3__F2__f2__m1__b4_u2    
PIC_MP n SMK

MSG	n_18 

PIC   so so1/a0L2R2__F1__f1__m3__e2_ua2    
PIC_MP so PLE
MTL PIC   so so2/a0L2R2__F2__f2__m4__e1_ua3    
MTL PIC   so so1/a0L2R1__F1__f1__m4__e1_ua3    
MTL PIC_MOVEA so 2 HP
MTL PIC_MP so HEA2
MSG	so_19  S


PIC   n a_3/a1__F1__f3__m1__b3_u0    
PIC_MP n SWT
MSG	n_20 
AUTO_SAVE 1

IF 0 {
    LABEL AGAIN
    TALKER	so R  
    TALKER	n L   
    LOAD_BGM	BGM_tigrina 
    BGM_OVERRIDE_KEY simple BGM_tigrina
    
    REPLACE_BGM	80 60 0
    
    PIC   so so1/a0L3R3__F1__f1__m2__e2_u2    I
    PIC_MP	so KIR 
    HKDS	so
    PIC   n a_3/a0__F1__f3__m1__b1_u2     
    PIC_MP n SWT

    MSG	so_06_2 IA

}

SELECT 2    
&&Select_s14_go_armory GOARMORY 
&&Select_wait_a_minute WAITAMINUTE C

LABEL WAITAMINUTE

PIC   n a_3/a0__F1__f3__m5__b1_u0    
PIC_MP n BLS|SWT
PIC_MOVEA	n 2 JUMP

PIC   so so1/a0L1R1__F1__f1__m1__e1_ua    
PIC_MP so 

MSG n_21
PIC   so so1/a0L2R2__F1__f1__m8__b1_u1    
PIC_MP so LAG
MSG so_22

SEEK_END

// ================================================
// 出撃
// ================================================
LABEL GOARMORY
WAIT 20
DOTL
IF 'GFC[TIG0]<2' {
        
    PIC   so so1/a0L2R1__F1__f1__m4__e1_ua3    
    PIC_MP so LAG
    PIC   n a_3/a2__F1__f3__m1__b1_u0    
    PIC_MP n SWT2

    MSG so_31

}
PIC_HIDE_ALL	 


WAIT 25
#MS_ % 'P[walk~] >>[Ev_elevator <<0.078] @L P[stand_ev~]'
PE ZOOM2 60
#MS '## @#[%::90]'

_waitt=170
IF 'GFC[TIG0]<2' {
    WAIT 25

    HKDS	so LB @CRT


    MSG so_32 S



    HKDS	so  
    TALKER	so  L   

    PIC   so so2/a0L4R1__F2__f2__m2__e1_up1    
    PIC_MP so PLE

    MSG so_33 A
    PIC_HIDE_ALL	T 
    WAIT 20
    
    SND garage_old_elevator
    PIC_FLASH	&10 0 5 1 WHITE 

    PIC_FILL   	#9 DARK 
    PIC_MOVEA	#9 15 SCARY
    WAIT 15
    TALKER	n  R   
    PIC   n a_2/a0L3R3__F2__m6__b1_u1    
    PIC_MP n BLS|EXQ
    TL 15   PIC_MOVEA	n 20 SCARY
    MSG n_34

    PIC_HIDE_ALL	T& 

    WAIT 10

} ELSE {
    WAIT 20
    _waitt=140
    PIC_FILL   	#9 DARK 
    PIC_FADEIN #9 50
    WAIT 60
    SND garage_old_elevator
}
CLEARTL
INIT_MAP_MATERIAL school_in_armory_mtgroom 1
PE ZOOM2 -1
WAIT $_waitt


__sneaking=1
SCN_MANUAL_BGM_REPLACE ''
WAIT_FN MAP_TRANSFER
NEL_MAP_TRANSFER school_in_armory_mtgroom R !Ev_LL

#CMDRELOAD	IMMEDIATE IMMEDIATE_LOAD

WAIT 2
