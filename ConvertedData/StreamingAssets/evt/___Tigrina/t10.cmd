QUEST_PROGRESS p106_tigrina_armory 2 H
LOAD_BGM	BGM_tigrina  
STOP_BGM	120 




MSG_PREFIX  so <tigrina>
DANGER 0
PREPARE_ENEMY_RESOURCES SLIME_0

#< tigrina >
#PHY
#MS 'P[walk] @R >>[Ev_tig.b -140,0 ] >+[140,0 :120] P[stand] w30 @L'
#MS_ % '>>[Ev_tig.b -200,0 ] >+[100,0 :180] w40 P[stand_ev~]'

WAIT 50

HKDS	so RT #<tigrina>  

MSG	so_00 

HKDS	n CLT #<%>  TT

MSG	n_01 

<LOAD>
WAIT 40
REPLACE_BGM	150 150 


HKDS	so
HKDS	n 
TALKER	so   R 
TALKER	n L     
PIC   so so2/a0L1R1__F2__f2__m1__e3_u0    
PIC   n a_3/a0__F1__f3__m1__b4_uo    

MSG	so_02 

@_PIIN
PIC   so so1/a0L3R1__F1__f1__m2__e2_up    
PIC_MP	so KIR 
PIC_MOVEA	so 2 JUMP

MSG	so_03

PIC   n a_1/a00L1R1__F1__f1__m1__b1__u1    
PIC_MP n SWT2   

MSG	n_03 

PIC   so so1/a0L2R3__F1__f1__m3__e2_ui    

MSG	so_04 

PIC   so so2/a0L4R1__F2__f2__m5_u2    

MSG	so_05 S

PIC   n a_3/a0__F1__f3__m1__b1_u2    
PIC_MP n QUE
MSG	n_05 

PIC_HIDE_ALL	 
WAIT 20
#MS '@R P[walk] >+[50,0 :70] P[stand]'
WAIT 30


HKDS	so RB  @CRT 

SND garage_keyboard

PIC %6 scl_garage/garage_so
PIC_MOVE2	%6 C C+600 C C-45 60       ZSIN
PIC_FADEIN %6 20
PIC_MOVEA	%6 340 HANDSHAKE



//無視してホログラム機に歩み寄る
MSG	so_06 


MTL PIC_FILL %9 DARK
MTL PIC_FADEIN %9 60

MSG	so_07 S

<LOAD>
WAIT_FN PXL_LOAD 
PE ZOOM2 1
DENY_SKIP
#MS '='
#MS_ % '='
#MS_ % '#; P[walk~] >>[SmnC_garage.b -190,0] >+[30,0 :40] P[stand_ev~]'

PIC_FADEOUT %6 0
PIC_FADEOUT %9 60
WAIT 70



SMNCREATOR TARGET_SCRIPT school_in_garage
SUMMONER_TYPE SmnC_garage NO_EFFECT NO_BORDER NO_HIDE_LAYER NO_REVERT
SUMMONER_ACTIVATE SmnC_garage
WAIT 5

#< SLIME_TUTORIAL_GARAGE_0 >
#MS '##'

#MS_ % 'w50 P[guard~]' 
ENEMY_ADD_TICKET WALK 250 -1 0

WAIT 70

ALLOW_SKIP
PIC   n a_3/a2__F1__f3__m5__b2_u0    
PIC_MP n EXQ
HKDS	n CRB   

//ホログラム機に寄るノエル、ホログラム機でなんかカチャカチャするティグ
MSG	n_07  A
HKDS	so CRT   


TALKER	so LL   
TALKER	n CLL  
PIC   so so1/a0L2R1__F1__f1__m4__e1_ua2    
PIC_MP so PLE

MSG	so_08 
PIC   so so2/a0L4R1__F2__f2__m2__e2_up1    
PIC_MP so HEA
MTL PIC   so so1/a0L2R2__F1__f1__m1__e1_ua3    
MSG	so_09 S

PIC   n a_2/a0L2R3__F2__m6__b2_u0    
PIC_MOVEA	n 2 JUMP


MSG	n_09 
DENY_SKIP

#< SLIME_TUTORIAL_GARAGE_0 >
ENEMY_ADD_TICKET WARP 250 0 0

PIC_HIDE_ALL	 
WAIT 10
#MS_ % 'w10 ## P[walk~] >+[70,0 :60] P[guard] @#[SLIME_TUTORIAL_GARAGE_0::70] P[stand_ev~] @#[SLIME_TUTORIAL_GARAGE_0,1::90] '



ENEMY_ADD_TICKET WALK 250 -1 0
TL 40 ENEMY_ADD_TICKET WALK 250 -1 0
TL 80 ENEMY_ADD_TICKET WALK 250 1 0
TL 120 ENEMY_ADD_TICKET WALK 250 -1 0
TL 160 ENEMY_ADD_TICKET WALK 250 1 00
TL 200 ENEMY_ADD_TICKET WALK 250 1 0
TL 240 ENEMY_ADD_TICKET WALK 250 1 0


WAIT 230
ALLOW_SKIP
TALKER	n L


PIC   n a_3/a0__F1__f3__m1__b4_u0    
PIC_MP n TTT
// 抜ける
MSG	n_10 
WAIT 20

PIC_HIDE_ALL	 
HKDS	so L @CRT
SND garage_keyboard
PIC %6 scl_garage/garage_so
PIC_FADEIN %6 30
PIC_MOVEA	%6 340 HANDSHAKE


DOTL
MSG	so_11 

HKDS	n RB #<%> TT


MSG	n_12 
SND  garage_pico0


MSG	so_13 

WAIT 60
ENEMY_ADD_TICKET WALK 250 1 0

MSG	so_14 

DENY_SKIP
PIC_FADEOUT %6 30
WAIT 10
PE ZOOM2 60
PE ZOOM2 -1
#MS_ % '@#[SLIME_TUTORIAL_GARAGE_0] P[guard~]'

WAIT 40

DOTL
STOP_LETTERBOX
START_IGNORE_PLAYER_ATK_BUFF
TUTO_MSG Tuto_magic
TUTO_NO_WRITE_TIPS
TUTO_POS C T
PR_CURE 0 1 

ALLOW_EVENTHANDLE_KEY X 
#MS_ % '= @#[SLIME_TUTORIAL_GARAGE_0,1]'
WAIT_PR_EXPLODE_MAGIC WHITEARROW @
ALLOW_EVENTHANDLE_KEY 
WAIT 30
TUTO_REMOVE

WAIT 40
ENEMY_ADD_TICKET WALK 250 1 0
TL 50 ENEMY_ADD_TICKET WALK 250 -1 0
WAIT 20
#MS_ % 'P[stand_ev~] @#[SLIME_TUTORIAL_GARAGE_0,1]'
WAIT 100
PIC %6 scl_garage/garage_so
PIC_MOVE %6    0,-30 0
PIC_FADEIN %6 20
PIC_MOVEA	%6 340 HANDSHAKE

ALLOW_SKIP
START_LETTERBOX

HKDS	so '=' '=' TT 


MSG	so_15 
SND garage_keyboard

WAIT 30

MSG	so_16 S 
PIC %7 scl_garage/garage_n0
PIC_MOVE %6    -70,-30 50 ZSIN
PIC_MOVE2 %7    C+360,C-60  C+360,C 50 ZSIN
PIC_FADEIN %7 30
HKDS	n '=' '@R' 


MSG	n_16 

WAIT 20
SND  garage_pico3
TL 30 SND garage_keyboard

HKDS	so '=' '=' 

MSG	so_17 

HKDS	cane  T @C  WIDE
TALKER_REPLACE	cane NoelCane talk_cane

DOTL
WAIT 100

SND  garage_pico_error
//エラーメッセージ出る
PIC %8 scl_garage/garage_n1
PIC_MOVE2 %8    C,C-190  C,C-130 20 ZSIN
PIC_FADEIN %8 30
TL 15 PIC_MOVEA	%8 15 SCARY

MSG	cane_18  D

DOTL
HKDS	so LB @CCLT  
HKDS	n RB @CCRT

MSG	so_19 


MSG	n_20 


MSG	so_21 


MSG	n_22 

SELECT 1 __
&&Select_accept __
WAIT 20
PIC_FADEOUT %8 60

//権限を許可し、さらにぽちぽちするティグ
MSG	so_23 
SND  garage_pico0
MSG	so_23_2 

SND  garage_pico3
WAIT 130
MSG	so_24 
PIC_FADEOUT %7 40
PIC_FADEOUT %6 40
DENY_SKIP

WAIT 40
// ========================
ENEMY_ADD_TICKET WARP 250 0 0

DOTL
STOP_LETTERBOX

TUTO_MSG Tuto_magic
TUTO_NO_WRITE_TIPS
TUTO_POS C T
PR_CURE 0 1 

ALLOW_EVENTHANDLE_KEY X 
#MS_ % '= @#[SLIME_TUTORIAL_GARAGE_0,1]'
WAIT_PR_EXPLODE_MAGIC WHITEARROW @
ALLOW_EVENTHANDLE_KEY 
WAIT 30
TUTO_REMOVE

// ========================
WAIT 30
ALLOW_SKIP
START_LETTERBOX
// 今度は貫通せずスライムに魔術が当たる
HKDS	so    
TALKER	so L  

HKDS	n    
TALKER	n R

PIC   so so2/a0L3R1__F2__f2__m7__e1_ua    
PIC_MP so ONP2
PIC   n a_2/a0L1R1__F2__f2__m1__b5_u0    
PIC_MP n 
MSG	so_25 


MSG	n_25 

PIC   so so1/a0L2R4__F1__f1__m2__e2_u2    
PIC_MP so LAG
MTL PIC   so so1/a0L1R3__F1__f1__m1__e3_ui    
MTL PIC   so so2/a0L2R2__F2__f2__m1__e2_ui1    
MTL PIC   so so1/a0L1R3__F1__f1__m3__e2_u1    

MTL SND ping
MTL PIC_FLASH	&9 0 6 4 ff:#EBEBEB
MSG	so_26  S


PIC   n a_3/a0__F1__f3__m1__b2_uo    
PIC_MP n SWT2
MSG	n_27 


PIC   so so1/a0L1R2__F1__f1__m1__e2_ua_2    
PIC_MP so ONP
MSG	so_28 

PIC   so so2/a0L3R1__F2__f2__m2__e1_up1    
PIC_MP so KIR
MSG	so_29

PIC_HIDE_ALL	 

STOP_IGNORE_PLAYER_ATK_BUFF
GFC_SET TIG2 1
SUMMONER_RECHECK_HR_BUFFER  SmnC_garage
WAIT 60
#MS_ % 'P[guard~]'

PIC   n a_3/a2__F1__f3__m5__b2_u0    
PIC_MP n EXQ|SWT2

MSG	n_29  A
#< tigrina >
#PHY 0

IFDEF _album_categ {
    PIC_HIDE_ALL	 
    
    PIC_FILL	#9  DARK
    PIC_FADEIN	#9 60
    WAIT 70
    @___House/_album_switch_map school_in_garage R Ev_tig
    CHANGE_EVENT2 ___Tigrina/t11	
    
}


SUMMONER_TYPE SmnC_garage NO_REVERT 
