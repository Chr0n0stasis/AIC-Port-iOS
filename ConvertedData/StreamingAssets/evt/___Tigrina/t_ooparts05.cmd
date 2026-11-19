//完成
MSG_PREFIX so <tigrina>

#SND_LOAD ev_club
#SND_LOAD minigame
TALKER	so R   
TALKER	n L   
IF 'GFC[OOP0]>=10' {
    PIC_HIDE_ALL	 
    
    __sporner_activate=1
    #CMDRELOAD	IMMEDIATE IMMEDIATE_LOAD 
    WAIT 20
    STOP_BGM 20 0
    GOTO    _ALREADY_MADE
}

PIC   n a_2/a0L2R3__F2__f2__m1__b5_u0    
PIC   so so2/a0L4R2__F2__f2__m7__e1_ua    
PIC_MP so ONP 
MSG	so_01 

STOP_BGM 120 0
PIC_HIDE_ALL	 
PIC_FILL #1 DARK
PIC_FADEIN	#1 25
WAIT 30
SND garage_make_supermecha

WAIT ~60*6.5


PIC_FADEOUT	#1 1
#MS_ tigrina '@L'
LOAD_LAYER ccsporner
__sporner_activate=1
#CMDRELOAD	IMMEDIATE IMMEDIATE_LOAD 
WAIT 6
LABEL _ALREADY_MADE
PE ZOOM2 1
#MS_ Ev_ccsporner '## #;'
#MS_ % 'P[ev_run_stop]'
PIC_FLASH	#9 0 7 0 aa:#ffffff


SND mgm_tsukuten
HALF_BGM	0
QU_VIB 6 15 4
PIC_RADIATION  #3 ff:#cccccc
WAIT 60
// ～暗転～
DENY_SKIP
TL 80 PIC_FADEOUT #3 80
// テテーン（SE）（イェー!でも可。
HKDS	so CRT  #<tigrina> WIDE_TT
HKDS	n L  #<Noel> TT

MSG	so_02 ACIF
WAIT 140
MSG	so_02_2 ACIF
WAIT 70
DOTL
ALLOW_SKIP
MSG	n_03 A

WAIT 50

PIC_FLASH	#9 0 4 0 aa:#ffffff
PE ZOOM2 -1
#MS_ % '## #; P[stand_ev]'
@_PIIN

START_BGM 60
HKDS	so    
HKDS	n 

PIC   n a_1/a00L1R1__F1__f1__m1__b1__u1    
PIC   so so1/a0L1R2__F1__f1__m4__e1_u1    
MSG	so_04 I

PIC   so so2/a0L3R1__F2__f2__m1__e3_ua    
MTL PIC   so so2/a0L1R2__F2__f2__m8__e1_u1    
MTL PIC   so so1/a0L3R3__F1__f1__m4__e1_ua2    
MTL PIC_MP so KIR
MTL PIC   so so1/a0L2R1__F1__f1__m1__e1_ua3    
MTL PIC_MP so PLE
MSG	so_05 S
PIC   n a_3/a0__F1__f3__m1__b1_u3    
PIC_MP n QUE

MSG	n_06 

PIC   so so1/a0L2R2__F1__f1__m1__e2_ua2    

MSG	so_07 

WAIT 10
PIC   n a_1/a22__F1__f1__m1__b1__u0    
WAIT 25
MSG	n_08 
PIC   n a_1/a00L1R3__F1__f1__m1__b1__u1    
 PIC_MP n QUE
MSG	n_08_2

WAIT 20
PIC   so so2/a0L1R2__F2__f2__m8__e1_u2    
STOP_BGM 120 0
MSG	so_09 

MTL PIC   so so1/a0L2R1__F1__f1__m7__e1_ui    
MTL SND tsukkomi
MTL  QU_VIB 10 12 8
MTL  PIC_MP so SWB
MSG	so_10

START_BGM 120 

