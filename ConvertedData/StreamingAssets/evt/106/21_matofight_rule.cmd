
PIC_FILL #9 DARK


IF '!Exist_mover[citycaster_9]' {
    @106/_put_citycaster Ev_ground_tl 140 240 1
}

// 13, 5 がそれぞれ sub_i, sub_l に置き換わっている。 最大14
#MS_ citycaster_0 '>>[PuzzBarrier_sclground_1.Lb 10,0] @R'
#MS_ citycaster_1 '>>[PuzzBarrier_sclground_1.Lb 26,0] @R'
#MS_ citycaster_2 '>>[PuzzBarrier_sclground_1.Lb 40,0] @R'
#MS_ citycaster_3 '>>[PuzzBarrier_sclground_1.Lb 55,0] @R'
#MS_ citycaster_4 '>>[PuzzBarrier_sclground_1.Lb 67,0] @R'
#MS_ citycaster_sub_l '>>[PuzzBarrier_sclground_1.Lb 45,0] @R'
#MS_ citycaster_6 '>>[PuzzBarrier_sclground_1.Lb 86,0] @R'
#MS_ citycaster_7 '>>[PuzzBarrier_sclground_1.Rb -18,0] @L'
#MS_ citycaster_8 '>>[PuzzBarrier_sclground_1.Rb -22,0] @L'
#MS_ citycaster_9 '>>[PuzzBarrier_sclground_1.Rb -32,0] @L'
#MS_ citycaster_10 '>>[PuzzBarrier_sclground_1.Rb -46,0] @L'
#MS_ citycaster_11 '>>[PuzzBarrier_sclground_1.Rb -58,0] @L'
#MS_ citycaster_12 '>>[PuzzBarrier_sclground_1.Rb -69,0] @L'
#MS_ citycaster_14 '>>[PuzzBarrier_sclground_1.Rb -86,0] @L'

WAIT 4

#MS_ boss '@R'
#MS_ % 'q ## >>[PuzzBarrier_sclground_1.b -450,0] ## #; >+[260,0 :190] @L P[stand_ev~]'
#MS_ citycaster_sub_i 'q >>[PuzzBarrier_sclground_1.b -160,0] >+[240,0 :170] @L'
LP_ACTIVATE PuzzBarrier_sclground_1
// CITYCASTER_AI_ALL idle_float
// #< citycaster_sub_i >
// CITYCASTER_AI idle

HKDS	bs CT #<boss>
TALKER_REPLACE	bs instructor talk_mob_w2

PIC_FADEOUT #9 80

WAIT 30


_say_rule10=1
_say_rule11=1
IF 'PVV>=200' {
    _say_rule10=0
    _say_rule11=0
    GOTO INIT_SELECT
}
IF 'GFC[IXA1]==11' {
    GOTO INIT_SELECT
}


MSG	bs_00 


MSG	bs_01 

TALKER	i R
TALKER	n L    
@_PIIN
PIC   n a_2/a0L1R1__F2__m6__b2_u0    I

MSG	n_02 I

PIC   i i/a00L1R3__F1__f1__m1__b3_u2    
PIC_MP	i PLE  


MSG	i_03 

MTL PIC   i i/a00L5R5__F2__f2__m3__b1_u1     
MTL PIC_MP i BLS|SWT2
MTL PIC_MOVEA i 20 SCARY 
MTL SND tsukkomi
MTL QU_VIB 10 12 8




MSG	i_04 

PIC   n a_1/a22__F1__f1__m3__b1_u0    
PIC_MP n QUE

MSG	n_05 

PIC   i i/a00L1R5__F1__f1__m4__b3_u0    
MSG	i_06 

LABEL INIT_SELECT
PIC_HIDE_ALL	 
#MS_ boss 'w20 ##'

WAIT 40

HKDS	bs '=' '=' WIDE
IF $_say_rule10 {
    MSG	bs_10
}

SELECTARRAY_CLEAR
SELECTARRAY &&Select_check_rule _CHECK_RULE

IF 'PVV>=200' {
    SELECTARRAY &&Select_start_mini_game _START
    SELECTARRAY &&Select_nothanks _CANCEL C
} ELSE {
    SELECTARRAY &&Select_start_mini_game _START C
}
SELECT_FOCUS 1

IF 0 {
    LABEL _CHECK_RULE
    _say_rule11=11
}
MGM_UI_DEACTIVATE
PIC_HIDE_ALL	

IF $_say_rule11 {
    MSG	bs_11
    IF 'PVV<200&& GFC[IXA1]==10' {
        GFC_SET IXA1 11

        WAIT 20
        PIC   i i/a00L3R3__F2__f2__m1__b1_u3    
        PIC_MP	i LAG 
        PIC   n a_3/a0__F1__f3__m1__b1_u2    

        MSG	i_11 
        PIC   n a_3/a2__F1__f3__m1__b4_u5    
        PIC_MP n SWT


        MSG	n_12 


    }
}

MGM_UI_ACTIVATE MATOFIGHT106
SELECT -1

LABEL _START
    MGM_UI_DEACTIVATE
ENGINE SclTeacherPVV106 MGM_PREPARE 106/25_matofight_finish

SEEK_END
LABEL _CANCEL
IF 'PVV>=200' {
    MGM_UI_DEACTIVATE
    CHANGE_EVENT	107/_memory_finish
    
}
