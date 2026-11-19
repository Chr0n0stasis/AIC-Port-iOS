#< %
GREETING	R -3

TALKER	n R   

PIC   n a_1/a22__F1__f1__m1__b2__u0    
MSG	n_00 

SELECT 2 
&&Select_ask_you_are_monster3 _END C
&&Select_guessing _GO

LABEL _END
SEEK_END

LABEL _GO
#MS q
PVV 108
SND memoryback
PIC_FILL &9 0xffDCDCDC
PIC_FADEIN &9 20
INIT_MAP_MATERIAL school_in_armory_mtgroom 1
SCN_MANUAL_BGM_REPLACE ''

WAIT 25

LOAD_BGM	 BGM_A_suspicion 

WAIT_FN MAP_TRANSFER
NEL_MAP_TRANSFER school_in_armory_mtgroom L !Ev_device
LP_DEACTIVATE Effector_sound
#CMDRELOAD	IMMEDIATE  
<LOAD>
#SND_LOAD ev_city_td

PIC_HIDE_ALL	T 1
PIC_FADEOUT &9 80
#MS_ % '>>[Ev_device.b 50,0] @L P[stand_ev~]'
HIDENOEL 1
#< device >
PE ZOOM2 1
WAIT 2
#MS '## #;'
PE SEPIA 1

WAIT 150


PE SEPIA 60
PE SEPIA -1
#TE FADEOUT 70
HIDENOEL 0
#< % >
#TE FADEIN 70
#< ixia >

#TE FADEIN 70
#MS 'w30 P[walk_cane] >>[Ev_device.b 95,0 <<0.09] P[stand_cane~]'

WAIT 100


<LOAD>


TALKER	n R   
PIC   n a_1/a00L1R1__F1__f1__m1__b2__uo    

MSG	n_01  T

PIC_HIDE_ALL	 


WAIT 40
HKDS cn C @BOUT  
TALKER_REPLACE	cn army talk_cane

SND noise_telephone

#MS_ % '## w15 P[guard~]'
MSG	cn_02 DI

TALKER	n   L 
HKDS	n CCLT
TALKER	i R   
HKDS	i CCRB

PIC   n a_3/a2__F1__f3__m1__b4_uo    
PIC   i i/a00L1R2__F1__f1__m1__b1_u4    

MSG	n_03 FC
MSG_HOLD
WAIT 25


MSG	i_04 I


MSG	cn_05 D
REPLACE_BGM	5  


MSG	cn_06 D

PIC   i i/a00L5R2__F1__f1__m5__b0_u3    
PIC_MP i EXQ
MSG	i_06 I


MSG	cn_07  D


PIC   n a_2/a0L1R1__F2__f2__m1__b5_u0    
TL 15 PIC   i i/a00L5R5__F2__f2__m1__b4_u1    
MSG	n_08 

DOTL
MSG	i_09 

SND noise_telephone
WAIT 15
STOP_BGM 80 1
PIC_HIDE_ALL	 

WAIT 65

#MS_ % 'P[walk] @R ! >+[-10,0 :20] ? P[stand_ev]'
LOAD_BGM	BGM_ixia_battle Ixia_Battle 

WAIT 70
HKDS	n   
HKDS	i   

PIC   n a_3/a2__F1__f3__m1__b1_uo    
PIC_MP n SWT

MSG	n_10 

PIC   i i/a00L1R1__F2__f2__m1__b5_u2    

MSG	i_11 

PIC   n a_1/a22__F1__f1__m1__b1__uo    

MSG	n_12 

PIC   i i/a00L1R3__F1__f1__m5__b0_u1    
PIC_MP i BSM
@_TSUKKOMI i
REPLACE_BGM	4 4 1

MSG	i_13 I

PIC   n a_3/a1__F1__f3__m1__b2_u3    
PIC_MP n EXQ
MSG	n_14 


PIC   i i/a00L1R4__F1__f1__m1__b3_u5    
PIC_MP i EXC
PIC_MVA i 1 JUMP
MSG	i_15 



MSG	n_16 

PIC_HIDE_ALL	 
#MS_ ixia '## P[appeal]'

WAIT 10
HKDS	i   RT #<ixia>


MSG	i_17 

#MS_ ixia '= ? @R P[stand2fly] >+[40,0 :50] #~ >+[440,0 :120] P[stand]'
#MS_ % 'w10 ##'
TL 10 PE ZOOM2 60
TL 10 PE ZOOM2 -1
WAIT 35

TALKER	 n L   

PIC   n a_2/a0L1R1__F2__m6__b1_u0    
PIC_MP n SWT2
MSG	n_18 

DOTL
PIC_HIDE_ALL	 
#MS_ % '= P[run] >+[320,0 <<0.14] P[stand_ev~]' 

WAIT 10
PIC_FILL #9 DARK
PIC_FADEIN #9 60
WAIT 80

HKDS	n C #<%> MONOLOGUE
TALKER_REPLACE n '=' ''
STOP_BGM 240 1
MSG n_30


GFC_SET ALC1 0
GFC_SET IXA1 0


IF 0 {
    // ver028
    PVV 200
    INIT_MAP_MATERIAL city_scl_ground 3
    WAIT 60
    WAIT_FN MAP_TRANSFER

    NEL_MAP_TRANSFER city_scl_ground L !Ev_ground_left
    WAIT 4
    PIC_FADEOUT #9 60

    // QUEST_PROGRESS p999_trial_finished 0
    #MS_ % '## #; >>[Ev_ground_left 190,0] >+[-120,0 :100] @L P[stand_ev~]' 

    LOAD_BGM BGM_school


    WAIT_MOVE
    REPLACE_BGM 100 100 1
} ELSE {
    INIT_MAP_MATERIAL city_entrance_rightcave 3
    WAIT 60
    WAIT_FN MAP_TRANSFER
    SCN_MANUAL_BGM_REPLACE ''
    NEL_MAP_TRANSFER city_entrance_rightcave R !!
}
DANGER 0
DANGER_MANUAL 0 1
SHOW_QUEST_PROGRESS
ALLOW_FASTTRAVEL
ALLOW_WARPINJECTION
QUEST_FINISH p107_td_after  H
QUEST_FINISH p107_td H

IF 1 {
    // ver029
    WAIT 3
    LOAD_BGM BGM_title grazia
    PVV 200
    TL 2 PIC_FADEOUT #9 5
    CHANGE_EVENT2 200/00_from_city WarpTo
    DOTL
    REPLACE_BGM 60 60 1
}
AUTO_SAVE
