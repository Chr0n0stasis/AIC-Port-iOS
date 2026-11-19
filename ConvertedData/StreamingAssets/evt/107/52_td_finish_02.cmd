DEFINENDEF _bossskip=0

GFC_SET IXA1 |=12
GFC_SET ALM1 0
GFC_SET ALC1 3
PR_CURE 1 1 1 1 1
#MS_ % 'F'

#SND_LOAD ev_city_td
IF '!'$_bossskip {
    WAIT 30
}
QUEST_REMOVE p999_trial_finished 1
IF 'quest_progress[p107_td]>0' {
    SHOW_QUEST_PROGRESS
    QUEST_FINISH p107_td

}
// GOTO _2
PIC_FILL #9 DARK
IF '!'$_bossskip {
    PIC_FADEIN #9 60
    WAIT 60
}
STOP_GMAIN
<LOAD>
PIC_B #0 bg/city_night
PIC_FADEOUT #9 60
DANGER_MANUAL 1 1
WAIT  100

TALKER	n C
PIC   n a_2/a0L1R1__F2__f2__m2__b1_u2     I
PIC_FADEIN n 80
TL 15 PIC_MOVEA n 9 SCARY

HKDS	n RT   

ALLOW_SKIP
MSG	n_00 

DOTL
PIC_FADEOUT n 50
WAIT 60

TALKER	n R
PIC_FINE n 

PIC   n a_3/a2__F1__f3__m4__b1_ua    I
PIC_FADEIN n 80
PIC_MP n SWT
HKDS	n 
//最後の一匹を片付けるノエル
MSG	n_01 

SND ixia_float_l2r
WAIT 95

SND cloth_off
TALKER	i L   
PIC   i i/a00L3R5__F1__f1__m1__b5_u1    

MSG	i_02 


PIC   n a_3/a0__F1__f3__m1__b2_u3    
PIC_MVA n 1 JUMP
// 下手の離れたところから箒に乗って現れるイクシャ
// 徒歩の方が余裕なさそうでいいかも
MSG	n_03 

PIC   i i/a00L1R2__F2__f2__m1__b3_u1    

MSG	i_04 


PIC   n a_1/a22__F1__f1__m1__b3__u1    
PIC_MP n HOT
MSG	n_05 


WAIT 50

LABEL _2
TALKER	n R   
TALKER	i L    
 

//立ち上がってスカートを払うノエル
// デバイスの着信音（いらないかも
// 学生に指示を出している軍の士官からの通信
HKDS cn CB @BOUT  
HKDS	n CCRT  '' TT
HKDS	i CCL  '' TT 

TALKER_REPLACE	cn army talk_cane

TL 40 PIC   n a_3/a2__F1__f3__m1__b4_u0    
TL 40 PIC_MP  n AWK
TL 52 PIC   i i/a00L1R1__F1__f1__m1__b1_u4    
TL 52 PIC_MP   i QUE

SND noise_telephone
MSG	cn_06 DI


DOTL
MSG	n_07 CF
MSG_HOLD

WAIT 20
MSG	i_08 


MSG	cn_09 D


PIC   n a_1/a00L3R1__F1__f1__m1__b3__u1    
PIC_MP n HOT
MSG	n_10

PIC   i i/a00L1R5__F2__f2__m1__b2_u2    
PIC_MP i SWT
MSG	i_11 

HKDS	n '='  '' ''

PIC   n a_3/a0__F1__f3__m1__b3_u0    
MSG	n_12 T


WAIT 50
HKDS	cn C  '=' 

MSG	cn_13 D
WAIT 10
TL 20 PIC   i i/a00L1R2__F1__f1__m1__b1_u4    
TL 44 PIC   n a_2/a0L1R3__F2__f2__m1__b1_u2    
TL 44 PIC_MP n QUE

LOAD_BGM BGM_herghost
WAIT 30

TL 30 REPLACE_BGM 40
DOTL
MSG	cn_14 D

HKDS	i CCLB  '' TT
PIC   i i/a00L5R5__F1__f1__m1__b5_u1    
PIC_MP i EXQ

TL 20 PIC   n a_3/a2__F1__f3__m1__b2_u2    
MSG	i_14 

DOTL 

HKDS	n CCRT  '' TT
MSG	n_15 

SND foot_107_r2l
PIC_HIDE_ALL	T 
WAIT 40

PIC_FILL #9 DARK
PIC_FADEIN #9 70
WAIT 80

START_GMAIN

INIT_MAP_MATERIAL school_in_armory 3
WAIT 40

WAIT_FN MAP_TRANSFER
NEL_MAP_TRANSFER school_in_armory L !Ev_f1


