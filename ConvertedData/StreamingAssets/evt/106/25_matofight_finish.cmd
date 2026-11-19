
HKDS	bs LT #<boss>
TALKER_REPLACE	bs instructor talk_mob_w2
#MS_ boss '## @R'

#< citycaster_sub_i >
CITYCASTER_AI  idle 

MSG	bs_00 I


LP_DEACTIVATE PuzzBarrier_sclground_1
ENGINE SclTeacherPVV106 MGM_TIMER_DEACTIVATE
PIC_FILL        #9 DARK
PIC_FADEIN          #9 55
WAIT 60

#MS_ boss '@R >>[PuzzBarrier_sclground_1.b -460,0]'

#MS_ % '## @R #; >>[PuzzBarrier_sclground_1.b -330,0] P[stand_ev~=5]'
#MS  '@L >>[PuzzBarrier_sclground_1.b -240,0] P[stand_cane]'
#SND_LOAD ev_city
#SND_LOAD ev_grazia_dojo
#SND_LOAD minigame
WAIT 2

PIC_FADEOUT  #9 55

WAIT 50

TALKER	n L   
TALKER	i R   


PIC   n a_3/a2__F1__f3__m5__b2_u1    
PIC_MP n SWB
PIC   i i/a00L5R1__F1__f1__m1__b2_ua    

MSG	n_01 
PIC   i i/a00L1R4__F1__f1__m1__b3_u0    
PIC_MP i KIR

MSG	i_02 


MSG	bs_03

PIC_HIDE_ALL	 
ENGINE SclTeacherPVV106 MGM_UPDATE_RESULT _score
WAIT_BUTTON
TALKER	n LL  
TALKER	i RR  
HKDS	n  CLB
HKDS	i  CRB



IF $_score'<0' {
    // イクシャの勝ち
    SND dojo_clap_small
    PIC   i i/a00L1R2__F1__f1__m1__b4_u0    
    PIC_MP i PLE
    PIC   n a_3/a1__F1__f3__m5__b1_u1    
    PIC_MP n SWT
    MTL    PIC   i i/a00L3R2__F1__f1__m4__b2_u2    
    MTL    PIC_MP i SWT
    MTL    PIC_MVA i SCARY 5
    MTL SND tsukkomi
    MTL QU_VIB 10 12 8
    MSG	i_04 

    PIC   n a_3/a1__F1__f3__m5__b1_u0    
    PIC_MOVEA	n HOP 3 
    PIC_MP n BSM
    

    MSG	n_05 

} ELSIF $_score'>0' {
    // ノエルの勝ち
    SND mgm_applause
    PIC   n a_1/a00L1R1__F1__f1__m1__b3__u1    
    PIC_MP n HOT
PIC   i i/a00L3R3__F2__f2__m3__b1_u0    
PIC_MP i BSM
    MSG	n_06 

    MSG	i_07 
} ELSE {
    SND dojo_clap_small
    PIC   n a_3/a0__F1__f3__m1__b1_u2    
    PIC_MP n SWT

    PIC   i i/a00L1R1__F1__f1__m1__b5_u5    
    PIC_MP i AWK

    // 引き分け
    MSG	i_10
}

HKDS	n  
HKDS	i  

PIC_HIDE_ALL	 
#MS_ boss 'w18 ## w16 @L P[walk] >+[-20,0 :13] P[stand]'

WAIT 25
MGM_UI_DEACTIVATE
WAIT 20
// 合流

SND city_whistle
MSG	bs_100 
#MS_ citycaster_0 'w8 >+[-340,0 <<0.14] '
#MS_ citycaster_1 'w20 @L w15 >+[-310,0 <<0.13] '
#MS_ citycaster_2 'w35 >+[-430,0 <<0.21] '
#MS_ citycaster_3 'w5 @L w18 >+[-460,0 <<0.13] '
#MS_ citycaster_4 'w13 @R >+[760,0 <<0.12] '
#MS_ citycaster_sub_l 'w35 @L w45 >+[-220,0 <<0.08] '
#MS_ citycaster_6 'w20 @L >+[-160,0 <<0.11] '


TALKER	n L   
TALKER	i R   
WAIT 65

PIC   i i/a00L1R3__F2__f2__m1__b1_u3    
PIC_MP	i LAG 
    MTL    PIC   i i/a00L1R2__F1__f1__m4__b2_u1    
    MTL    PIC_MP i SWT
    MTL    PIC_MVA i SCARY 5
    MTL SND tsukkomi
    MTL QU_VIB 10 12 8

PIC   n a_2/a0L1R3__F2__f2__m1__b5_u0    

MSG	i_101 

PIC   n a_1/a22__F1__f1__m3__b1_u0    
PIC_MP n QUE
MSG	n_102 

PIC   i i/a00L5R3__F1__f1__m4__b3_u2    
PIC_MP i EXC

IF $_score'>=0' {
    // ノエルが勝っていた or 引き分け
    MSG	i_103 
} ELSE {

    // イクシャが勝っていた
    MSG	i_104 
}

PIC_HIDE_ALL	 

#MS_ % 'q w13 @R w40 >+[130,0 :180]'
#MS 'q P[stand2fly] >+[60,0 :50] >+[360,0 <<0.2] P[fly2stand] >+[60,0 :50] w90 @L'


WAIT 60

IF 'PVV>=200' {
    CHANGE_EVENT	107/_memory_finish
}

DENY_SKIP
PIC_FILL        #9 DARK
PIC_FADEIN          #9 85
WAIT 100

GFC_SET IXA1 10

INIT_MAP_MATERIAL school_in_hall_right 3
ALLOW_FASTTRAVEL
ALLOW_WARPINJECTION
STOP_IGNORE_PLAYER_ATK_BUFF


SCN_MANUAL_BGM_REPLACE ''
WAIT_FN MAP_TRANSFER
NEL_MAP_TRANSFER school_in_hall_right_2 R !Ev_righttable


WAIT 2


GFC_SET IXA1 10
#CMDRELOAD	IMMEDIATE IMMEDIATE_LOAD 
// AUTO_SAVE 1
WAIT 2

// #CALL woman_elf_student_8 load_once // 106/30_shower
