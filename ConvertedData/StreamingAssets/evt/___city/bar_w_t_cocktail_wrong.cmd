_stop=1
TALKER	w L   
TALKER	n R 

#SND_LOAD ev_mountain
PIC   w w/a0L1R1__F1__f1__m1__e3__u3    
PIC_MP w QUE
PIC   n a_1/a22__F1__f1__m1__b2__uo    
PIC_MP n SWT2
MSG	w_00 


MTL MSG_SKIP
MSG	n_01 

PIC   w w/a0L2R3__F2__f2__m1__e4__u2    
MSG	w_02 

PIC   n a_2/a0L2R3__F2__f2__m1__b5_u2    
PIC_MP n SWT
MSG	n_03 

PIC   w w/a0L1R3__F1__f1__m1__e1__u2    
MSG	w_04 


MSG	n_05

MSG_HOLD

// ↓ここもテロップで出す
// MSG	actihol_06 
TUTO_MSG	___city/bar_w_t_cocktail_wrong*actihol_06 -1000
TUTO_TEMP_FRONT 1


SELECT 2 
&&Select_drink_cocktail DRINK
&&Select_not_drink_cocktail NOT_DRINK C

LABEL NOT_DRINK
WAIT 20
// 飲まない
PIC   w w/a0L2R1__F2__f2__m1__e2__u1   
 
PIC_MP w HOT
MSG	w_07 

PIC   n a_3/a0__F1__f3__m4__b1_ua    
PIC_MP n SWB

MSG	n_08 T




LABEL DRINK
MSG_HIDE
WAIT 30
HALF_BGM 1
PIC_HIDE_ALL	'' 1
PIC_FILL #0 DARK
TL 18 SND gokkun
TL 15 PIC_FLASH	#9 1 10 9 ff:#888888
TL 15 PIC_MOVEA #9 8 SCARY2
TL 25 PIC_MOVEA #0 24 SCARY

HKDS	n C @CCR   

MSG	n_09  A

WAIT 33
TL 18 PIC_FLASH	#9 1 10 20 ff:#aacccc
TL 18 PIC_MOVEA #9 8 SCARY2
TL 22 SND gokkun

TL 37 PIC_FLASH	#9 1 13 20 ff:#aacccc
TL 37 PIC_MOVEA #9 32 SCARY

// 飲む
MSG	n_10  AI

PE ZOOM2 1
PE LAYING_EGG 40 0.4
#< %  
#MS 'P[stand_weak~]'

DOTL
WAIT 40
PIC_FADEOUT #0 90
HALF_BGM 0

WAIT 50
PIC   w w/a0L1R1__F2__f2__m1__e3__u2    
PIC_MP w LAG


MSG	w_11 

HKDS	n
PIC   n a_2/a0L2R2__F2__f1__m2__b2_u1    
PIC_MP n SWT2|BLS|DEP
PIC_MOVEA	n 20 SCARY 

MSG	n_12 T


PIC_HIDE_ALL	 
WAIT 50
PIC   n a_3/a0__F1__f3__m6__ua    
PIC_MP n PIY|QUE|BLS
PE CONFUSED_CAMERA 200 0.4
PE GAS_APPLIED 130 1
PE BGM_AISAC_BATTLE 3400
MSG	n_13 T


WAIT 30
PIC_HIDE_ALL	 
SHOW_BLURSC
START_BLURSC_TO_BEHIND
TUTO_REMOVE

SND	cloth_off
SND	pr_down

PIC_FILL	&10 DARK
PIC_MOVEA	&10 20 SCARY
TL 30 PIC_FADEOUT	&10 50
WAIT 5

PIC_FILL	&11 ff:#999999
WAIT 8
PIC_FADEOUT	&11 8

PIC %4 mountain_bar_029/bar_knockdown_noel 
PIC_MOVE2	%4 0 -180 0 -80 80 ZSIN
PIC_FADEIN %4 100


DOTL

MSG_PREFIX s '<m fadein><font alpha=0.5>'
MSG_PREFIX w '<m fadein><font alpha=0.5>'

TALKER_REPLACE	s 'Mob' ''
TALKER_REPLACE	w 'Mob' ''

HKDS	s LT @LTOUT
HKDS	w RT @RTOUT

HKDS	n CCRT @CCLB



MSG	s_16 

WAIT 20
MSG	w_17 

WAIT 20

MSG	s_18 

WAIT 50
PIC %4 mountain_bar_029/bar_knockdown_noel_2
PIC_FADEIN %4 50 

MSG	n_19 

WAIT 30

MSG	w_20 

STOP_BGM	90 0
WAIT 20
SCN_MANUAL_BGM_REPLACE ''
INIT_MAP_MATERIAL mount_caravan 1

PIC_FILL	&10 DARK
PIC_FADEIN &10 80
WAIT 70


WAIT_FN MAP_TRANSFER
PE BGM_AISAC_BATTLE -1 1
PE ZOOM2 -1 1
PE LAYING_EGG -1 1
PE CONFUSED_CAMERA -1 1
PE GAS_APPLIED -1 1
WAIT 2
HIDE_BLURSC 1
HKDS	n    

PIC_HIDE_ALL	'' 1
PIC_FILL	&10 DARK
PIC_FADEOUT &10 80

#< % >
NEL_MAP_TRANSFER mount_caravan L !Ev_hotel
STOMACH_PROGRESS 3
#MS '@L P[walk_weak] >+[-30,0 :60] P[stand_weak] '
LP_ACTIVATE_TO_CHIP window Ev_hotel
WAIT 60
TALKER	n L   

PIC   n a_3/a2__F1__f3__m1__b3_u0    
PIC_MP n SMK
// 休んで宿から出る
MSG	n_21 


QUEST_PROGRESS subquest_mount_cocktail  2

LOAD_BGM BGM_heiwa_no_hanmokku
REPLACE_BGM 60
