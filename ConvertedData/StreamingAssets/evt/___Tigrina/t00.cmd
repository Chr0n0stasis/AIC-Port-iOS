#< tigrina >

MSG_PREFIX so <tigrina>

LOAD_BGM	BGM_tigrina 
BGM_OVERRIDE_KEY simple BGM_tigrina


TALKER	n R
IF 'GFC[TIG0]==0' {
    #MS_ % 'F >>[Ev_RR_container.R -4,0 <<0.08] @L P[stand_ev~]'

    #MS_SOFT '##'
    PE ZOOM2 60
    TALKER	so BBL
    HKDS	so CLT #<tigrina>   



    WAIT 10
    <LOAD>
    WAIT 20
    TALKER_REPLACE	so elf_student
    STOP_BGM	300 0
        



    PIC   so so2/a0L4R2__F2__f2__m5_ui    
    PIC_MOVEA	so -1 SCARY

    TL 30 PIC   n a_1/a00L1R1__F1__f1__m3__b1_u0    
    TL 30 PIC_MP n QUE
    MSG so_00

    HKDS	so    

    PIC   so so1/a0L1R2__F1__f1__m8__b1_ua2    
    PIC_MOVEA	so 1 HOP    

    MSG so_01 S

    DOTL 

    #MS  'P[stand] @#[%::20]'

    PIC   so so1/a0L2R3__F1__f1__m2__e2_up    
    PIC_MP	so LIG
    @_PIIN
    TALKER	so L 

    MSG so_02

    REPLACE_BGM	0 10 0
    
    MSG so_03



    PIC   n a_3/a0__F1__f3__m1__b4_u0    
    PIC_MP  n TTT
    MSG	n_05 

    PIC   so so1/a0L1R2__F1__f1__m1__e2_ua    
    PIC_MP	so  HOT
    PIC_MOVEA	so 80 DANCE

    MSG	so_06 

    PIC   so so1/a0L3R3__F1__f1__m5__up    
    MSG	so_07 S

    TALKER_REPLACE	so 
    PIC   so so1/a0L1R1__F1__f1__m1__e1_u1    
    PIC_MOVEA	so 1 HOP
    MSG	so_08 

    PIC   n a_1/a22__F1__f1__m1__b2__u1    
    MSG	n_09 

    PIC   so so2/a0L1R1__F2__f2__m1__e2_u2    
    PIC_MP so QUE
    TL 30　PIC   n a_2/a0L1R3__F2__f2__m1__b5_uo    
    MSG	so_10 



    @_PIIN
    PIC   so so1/a0L4R4__F1__f1__m8__b1_f1__m8__b1_u2    
    TL 10 PIC_MOVEA	so 2 HOP
    MSG so_10_2

    CLEARTL

    PIC   n a_3/a0__F1__f3__m1__b2_u5    
    MSG	n_11 

    PIC   so so1/a0L2R4__F1__f1__m3__e2_u0    
    PIC_MP so LAG 
    PIC_MOVEA	so 170 SIN_H

    MSG	so_12 

    PIC   n a_1/a22__F1__f1__m1__b3__u1    
    PIC_MP n SWT2
    MSG	n_13 

    PIC   so so1/a0L1R2__F1__f1__m1__e2_ua2    
    PIC_MP  so SWT2
    PIC_MOVEA	so 2 HOP
    MSG	so_14 

    PIC   so so1/a0L3R2__F1__f1__m4__e1_up    
    PIC_MP	so PLE

    MSG	so_15_2 S

    PIC   n a_2/a0L1R3__F2__f2__m1__b4_u0    
    MSG	n_15 


    #MS_ % '##'
    PE ZOOM2 -1
    PIC   so so2/a0L1R1__F2__f2__m1__e1_u0    
    MSG	so_16 

    QUEST_PROGRESS p106_tigrina_armory 0
    GFC_SET_MX	TIG0 1 

} ELSE {
    <LOAD>

    REPLACE_BGM	80 60 0
    #MS  'P[stand] @#[%::40]'
    GREETING	R 20
    
    TALKER	so L
    PIC   so so2/a0L1R1__F2__f2__m1__e1_u0    
    PIC   n a_1/a22__F1__f1__m1__b1__u0    

}

SELECT	2 
&&Select_s14_help _HELP
&&Select_s14_later _LATER C

LABEL _LATER
SEEK_END
LABEL _HELP


WAIT 10
CHANGE_EVENT	___Tigrina/t01


