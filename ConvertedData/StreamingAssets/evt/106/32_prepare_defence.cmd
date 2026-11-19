<LOAD_EMOJI>
MSG_PREFIX so <tigrina> 

// GOTO MOBTALK

HKDS	n ''  '' '' 
TALKER_REPLACE	n '' 'talk_noel' 
PIC_HIDE_ALL	'' 1
STOP_BGM 80 1
LOAD_BGM BGM_strigiformes
PIC_HIDE_ALL	 1
PIC_B #0 106_31_kodo/bg_collidor
PIC_FILL #9 DARK
PIC_FADEOUT #9 50
PIC_TFADE #9 DOOR_OPEN
WAIT 40

HKDS	so T   @ROUT WIDE

MSG	so_00 

WAIT 30

TALKER	n CL
TALKER	i LL

PIC   n a_3/a2__F1__f3__m1__b2_uo    
PIC   i i/a00L1R2__F2__f2__m1__b3_u2    

MSG	n_01  T
MSG	i_02 T

PIC_HIDE_ALL	%&T

WAIT 25

TALKER	so R 
HKDS	so    '' '' ''

PIC   so so1/a0L3R1__F1__f1__m3__e1_u1    

WAIT 15

TALKER_REPLACE	bs1  army talk_mob_m2
HKDS	bs1  RT @ROUT


MSG	bs1_02 


PIC   so so2/a0L4R2__F2__f2__m1__e2_ua    I
PIC_MOVEA so SCARY 15

REPLACE_BGM	1 10 1

MSG	so_03 

PIC   so so1/a0L2R1__F1__f1__m8__b1_ua    

MTL PIC   so so1/a0L2R4__F1__f1__m3__e1_u1    
MTL QU_VIB 10 12 8
MTL SND tsukkomi
MTL PIC_MVA so 2 JUMP

MSG	so_04 S


MSG	bs1_05 


PIC   so so1/a0L1R3__F1__f1__m8__b1_ua    

MTL PIC   so so2/a0L4R1__F2__f2__m5_ui    
MTL PIC_MOVEA   so SCARY 12

MTL PIC   so so1/a0L4R3__F1__f1__m1__e2_u2    
MTL PIC_MP so TTT

MTL PIC   so so2/a0L1R2__F2__f2__m2__e1_ui1    
MTL PIC_MP so KIR

MSG	so_06 S


MSG	bs1_07 



WAIT 15
PIC   so so1/a0L1R1__F1__f1__m1__e1_ua    
TALKER so C
HKDS	so LT 

WAIT 45
MSG	so_08 

WAIT 28
//急に冷静になるやつ
HKDS	bs1 R @ROUT

MSG	bs1_09 

PIC   so so2/a0L3R2__F2__f2__m7__e1_ua    
PIC_MP so HEA2
PIC_MVA so 1 JUMP
MSG	so_10 


MSG	bs1_11 


PIC   so so1/a0L1R2__F1__f1__m2__e2_up    
PIC_MP so PLE
MSG	so_12 S



MSG	bs1_13 


PIC   so so1/a0L4R1__F1__f1__m4__e1_ua2      
PIC_MP so ONP

MSG	so_14 

WAIT 60

TALKER	so R   
TALKER	n L   

PIC   so so1/a0L1R2__F1__f1__m3__e2_u0    
WAIT 10

PIC   n a_1/a22__F1__f1__m3__b1_u0    
PIC_MP n TTT

WAIT 15

STOP_BGM 400 2
HKDS	so ''   '' ''
MSG	so_15 


MSG	n_16 


PIC   so so2/a0L1R2__F2__f2__m1__e2_u0    
MSG	so_17 

PIC_HIDE_ALL	  %&T

WAIT 50

TALKER	i L
TALKER	l LL

PIC   i i/a00L1R2__F1__f1__m1__b5_u4    
PIC_MP i SWT

MSG	i_18  T

TALKER	i CL
PIC   l l1/a0L3R1__F1__m1__b6_u1    
PIC_MP l SMK

MSG	l_19  T

PIC_HIDE_ALL	 %&T

WAIT 50

TALKER	so  R   

PIC   so so2/a0L4R1__F2__f2__m1__e3_u3    

TALKER	n L   

PIC   n a_3/a1__F1__f3__m1__b1_uo    

WAIT 20
MSG	so_20 

@_PIIN
PIC   n a_3/a0__F1__f3__m3__b2_uo    
PIC_MP n AWK
PIC_MVA n 1 JUMP

MSG	n_21 


PIC   so so1/a0L2R3__F1__f1__m4__e1_u1    
PIC_MP so KIR

MSG	so_22 



WAIT 40

STOP_BGM 0 1
PIC_HIDE_ALL	%&T 1
SND flashback_noise
PIC_FLASH	&4 0 5 4 0xffBBA0A0
TL 30 PIC_FLASH	&4 4 2 25 0xffBBA0A0
PIC_FILL	&3 0xff3A3434


//フラッシュバック
TALKER_REPLACE	n  '' ''
HKDS	n C ''  MONOLOGUE
WAIT 50
LOAD_BGM BGM_towerdefence
WAIT 30

MSG	n_23 

DOTL


TALKER	n C

PIC   n a_2/a0L2R1__F2__f1__m2__b2_u0    I
WAIT 25
PIC_FADEOUT &3 90
TL 18 PIC_MVA n 18 SCARY

WAIT 140


TALKER	n R    
TALKER	 l L   

DOTL
PIC   l l1/a0L2R2__F1__m1__b3_u2    

MSG	l_24 

WAIT 20
PIC_HIDE l
LABEL MOBTALK
TALKER	n C
PIC   n a_3/a2__F1__f3__m1__b2_uo    

WAIT 30


HKDS	mb1 LT @LB TT3
TALKER_REPLACE	mb1 ''  talk_mob_w0
HKDS	mb2 RT @RB TT3
TALKER_REPLACE	mb2 ''  talk_mob_w9


HKDS	mb3 B @CRT TT3
TALKER_REPLACE	mb3 ''  talk_mob_w3

// DENY_EVENTHANDLE


TL 90 REPLACE_BGM	1 30 1

BG_MSG_FRONT 1

PIC %1 106_cutin/106mob_cutin_0
PIC_FADEIN %1 20
PIC_MOVE2 %1 -370 -160 -370 -130 35 ZSIN

MSG	mb1_25  


WAIT 20
PIC %2 106_cutin/106mob_cutin_2
PIC_FADEIN %2 30
PIC_MOVE2 %2 350 -180 350 -150 35 ZSIN
MSG	mb2_26   


WAIT 20
PIC %3 106_cutin/106mob_cutin_1
PIC_FADEIN %3 20
PIC_MOVE2 %3 220 110 220 140 35 ZSIN

TL 60 ALLOW_EVENTHANDLE
MSG	mb3_27

MSG_HIDE

WAIT 50
LABEL _END
TALKER	n R   

TALKER	i L   
TL 30 PIC_FADEOUT %1 60
TL 30 PIC_FADEOUT %2 60
TL 30 PIC_FADEOUT %3 60
PIC   i i/a00L3R1__F2__f2__m1__b3_u3    

WAIT 10

DOTL
MSG	i_27 
PIC   i i/a00L2R3__F1__f1__m1__b4_u0    
PIC_MP i KIR
MSG	i_28
BG_MSG_FRONT 0


WAIT 24
PIC_HIDE i
TALKER	n C    
HKDS	n LT  '' '' 
TALKER_REPLACE	n '' 'talk_noel' 
WAIT 5
PIC   n a_2/a0L1R1__F2__f2__m1__b2_u3    

WAIT 40

DOTL

MSG	n_28 // TD 前のブリーフィング

IF 'PVV>=200' 
    SEEK_END

TL 40 PIC_FILL #9 DARK
TL 40 PIC_FADEIN #9 100
TL 40 PIC_FADEOUT n 100
MSG	n_29 // TD 前のブリーフィング

DOTL

SHOW_QUEST_PROGRESS
QUEST_PROGRESS p107_td 0

WAIT 120


_107_first=1
PVV 107
GFC_SET IXA1 0

PIC_HIDE_ALL	'' 1

PIC_FILL #9 DARK

INIT_MAP_MATERIAL city_scl_ground 3
SCN_MANUAL_BGM_REPLACE BGM_towerdefence 
ALLOW_FASTTRAVEL
ALLOW_WARPINJECTION
STOP_IGNORE_PLAYER_ATK_BUFF


WAIT_FN MAP_TRANSFER
NEL_MAP_TRANSFER city_scl_ground R !ExitL_toground

#CMDRELOAD	NO_LOAD IMMEDIATE_LOAD
WAIT 2

PIC_FADEOUT #9 50
_td_autosave=1
CHANGE_EVENT 107/_td_portal 1 0 1
