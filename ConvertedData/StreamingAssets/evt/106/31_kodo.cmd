PIC_HIDE_ALL	'' 1
LOAD_BGM BGM_dungeon3

HIDE_BLURSC
PIC_B #1 106_31_kodo/bg_kodo

PIC_FILL #9 DARK
PIC_FADEOUT #9 50
PIC_TFADE #9 DOOR_OPEN

#SND_LOAD ev_city
WAIT 15
SND pee_zattou_s


WAIT 160



HKDS	bs0  T @C WIDE
TALKER_REPLACE	bs0 instructor talk_mob_m9 

MSG	bs0_00 


REPLACE_BGM	30 30 
MSG	bs0_01
WAIT 30


HKDS	mb0  L @LOUT TT


HKDS	mb1  CRB @ROUT TT
TALKER_REPLACE	mb0  Mob ''
TALKER_REPLACE	mb1  Mob ''

SND pee_zattou_s

MSG	mb0_02  BC


TL 25 MSG	mb1_03  BC


WAIT 140

DOTL
MSG	bs0_04 

WAIT 30
TALKER	n L 
PIC   n a_2/a0L1R3__F2__f2__m1__b1_u2    


MSG	n_05 T

PIC_HIDE n
WAIT 25

MSG	bs0_06 


DOTL
WAIT 15
SND pee_zattou_s

HKDS	mb2 CRB @RBOUT TT 
TALKER_REPLACE	mb2 '' ''
HKDS	mb4 R @ROUT TT 
TALKER_REPLACE	mb4 '' ''
HKDS	mb3 CLLTT @LBOUT TT 
TALKER_REPLACE	mb3 '' ''


TL 25 MSG	mb2_07  BC


TL 52 MSG	mb3_08  BC

TL 68 MSG mb4_09 BC


WAIT 190
MSG	bs0_09 

DOTL
MSG_HOLD _

WAIT 50

TALKER	so R   

PIC   so so1/a0L1R1__F1__f1__m3__e2_ua    

MSG	so_11 

HKDS	bs1 L @LOUT 
TALKER_REPLACE	bs1 instructor talk_mob_w2 

MSG	bs1_12 

WAIT 30
PIC   so so1/a0L2R1__F1__f1__m3__e1_u1    

MSG	so_13 

PIC   so so2/a0L1R2__F2__f2__m2__e1_ua    

MSG	so_14 

HKDS	bs2 CRT @ROUT 
TALKER_REPLACE	bs2 instructor talk_mob_m0 

MSG	bs2_15 

PIC   so so1/a0L1R2__F1__f1__m5__ui    
PIC_MP so SWT|TTT
PIC_MVA so 1 HOP

MSG	so_16 


PIC   so so2/a0L4R1__F2__f2__m1__e3_ua    
PIC_MVA so 1 SHAKE

MTL MSG_SKIPHOLD
MSG	so_17  S


MSG	bs1_18 

PIC   so so1/a0L4R4__F1__f1__m7__e1_ui    
PIC_MP so AWK
PIC_MVA so 1 HOP
MTL TALKER	so ROUT   

MSG	so_19 

PIC_HIDE_ALL	T   1   
WAIT 50
MSG	bs0_20 

SND pee_zattou_s


TL 20 MSG	mb0_21 BC

HKDS	mb3 R @ROUT   TT

TL 70 MSG	mb3_21  BC

TL 95 MSG	mb1_22  BC
WAIT 180


MSG	bs0_23 

DOTL
MSG_HIDE
WAIT 80

TALKER	n L  
HKDS	n    
HKDS	i

PIC   n a_3/a2__F1__f3__m1__b1_u0     

MSG	n_24 

TALKER	i R  
PIC   i i/a00L1R2__F1__f1__m1__b1_u4     


MSG	i_25 

PIC   n a_1/a00L3R1__F1__f1__m1__b2__u1    
MSG	n_26 

PIC   i i/a00L5R5__F1__f1__m1__b5_u1    
MSG	i_27 


MSG	n_28 

WAIT 10
PIC_HIDE_ALL	T 
WAIT 40
STOP_BGM 200

PIC_FILL #9 DARK
PIC_FILL #10 BLACK
PIC_FADEOUT #10 100

HKDS	n C #<%> MONOLOGUE
TALKER_REPLACE n '=' ''


MSG	n_29 

WAIT 50

MSG	n_30

WAIT 90

CHANGE_EVENT	106/32_prepare_defence
