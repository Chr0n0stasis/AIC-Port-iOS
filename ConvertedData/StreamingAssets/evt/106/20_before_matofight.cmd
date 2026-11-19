#SND_LOAD ev_wander_npc

PIC_FILL #9 DARK

IF '!Exist_mover[citycaster_9]' {
    @106/_put_citycaster Ev_ground_tl
}
_lp=Ev_ground_tc.b
// 13, 5 がそれぞれ sub_i, sub_l に置き換わっている。 最大14

#MS_ % '## >>['$_lp' 0,0] @L #; P[stand_ev~]'

#MS_ citycaster_sub_l 'q >>['$_lp' -80,0] @R >+[45,0 :80] '
#MS_ citycaster_0 'q >>['$_lp' -210,0] @L P[stand_cane~] '
#MS_ citycaster_1 'q >>['$_lp' -440,0] w60  >+[260,0 <<0.04] '
#MS_ citycaster_2 'q >>['$_lp' -940,0] '
#MS_ citycaster_3 'q >>['$_lp' -840,0] '
#MS_ citycaster_4 'q >>['$_lp' 420,0] >+[-200,0 <<0.052] @R P[stand_cane~]'
#MS_ citycaster_sub_i 'q >>['$_lp' 320,0] >+[-200,0 <<0.08] >+[-70,0 <<0.04] '
#MS_ citycaster_6 'q >>['$_lp' 450,0] w40 >+[-530,0 <<0.046] @R P[stand_cane2~]'
#MS_ citycaster_7 'q >>['$_lp' 480,0] w40 >+[-100,0 <<0.042] P[stand_cane2~]'
#MS_ citycaster_8 'q >>['$_lp' 350,0] w90 >+[-100,0 <<0.042] P[stand_cane2~]'
#MS_ citycaster_10 'q >>['$_lp' -750,0] w50 >+[930,0 <<0.05] @R P[stand_cane~]'
#MS_ citycaster_9 'q >>['$_lp' -780,0] w50 >+[930,0 <<0.05] @R P[stand_cane2~]'
#MS_ citycaster_11 'q >>['$_lp' -780,0] w320 >+[440,0 <<0.06] @R P[stand_cane~]'
#MS_ citycaster_12 'q P[stand_cane~] >>['$_lp' 80,0] w40 >+[60,0 :120] @R '
#MS_ citycaster_14 'q >>['$_lp' -150,0] >+[500,0 <<0.053] @L P[stand_cane2~]'
#MS_ boss 'q >>['$_lp' 250,0] P[walk] @R >+[40,0 :90] @L P[stand]'
WAIT 2
PIC_FADEOUT #9 60

WAIT 50


TALKER	n R  
TALKER	l L   
PIC   l l1/a0L2R3__F1__m1__b8_u1    
PIC_MP l SWT
PIC   n a_2/a0L1R1__F2__f2__m1__b5_u2    

MSG	l_00 

PIC   n a_3/a2__F1__f3__m1__b4_uo    
PIC_MP n TTT

MSG	n_01 


SND noel_onaka_left

WAIT 20

TL 30 PIC   n a_1/a22__F1__f1__m1__b1__u0    
PIC   l l1/a0L2R2__F1__m1__b6_ua    
PIC_MP l BLS|EXC
WAIT 95

PIC   l l1/a0L2R2__F1__m1__b2_ua4    
PIC_MP l BLS|SWT2
PIC_MOVEA	l 3 HOP

WAIT 5
//（お腹がなる。
MSG	l_02 

DOTL
PIC   l l1/a0L3R2__F1__m1__b1_ua4    
PIC_MP l BLS|SWT2
MSG	l_03 

PIC   n a_1/a00L1R1__F1__f1__m4__b1_ua    
PIC_MP n SWT
MSG	n_04 
PIC   l l1/a0L1R1__F1__m1__b3_u2    
PIC_MP l BLS|SWT2
PIC_MOVEA	l 1 HOP

MSG	l_05 

PIC_HIDE_ALL	

#MS_ boss 'w25 ##'
#MS_ citycaster_sub_i 'w45 @R'
WAIT 40

HKDS	bs CRT #<boss>
TALKER_REPLACE	bs instructor talk_mob_w2

MSG	bs_06 

TALKER	i L
HKDS	bs R #<boss>
PIC   i i/a00L1R2__F1__f1__m1__b3_u0    
PIC_MP i KIR

MSG	i_07 


MSG	bs_08 


TALKER	i CLL
TALKER	n LL
PIC   n a_3/a2__F1__f3__m1__b2_uo    
PIC_MP n QUE
MSG	n_09 

PIC_HIDE_ALL	 
STOP_BGM	150 1

PIC_FILL #9 DARK
PIC_FADEIN #9 80


INIT_MAP_MATERIAL city_scl_ground 1
GFC_SET_MX IXA1 10
SCN_MANUAL_BGM_REPLACE '' 




#MS_ citycaster_sub_i 'q @R >+[120,0 :80] '
#MS_ % 'w15 @R w15 P[walk~] >+[60,0 :50] '



WAIT 85

WAIT_FN MAP_TRANSFER
NEL_MAP_TRANSFER city_scl_ground R !!
CHANGE_EVENT 106/21_matofight_rule







