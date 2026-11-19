
SF_EVT_SET


PIC   so so1/a0L2R1__F1__f1__m1__e1_ua    
PIC   n a_1/a00L1R1__F1__f1__m1__b1__uo    

MSG	so_00 
PIC   so so2/a0L4R1__F2__f2__m1__e3_u0    
MSG	so_00_2

PIC   so so2/a0L1R2__F2__f2__m4__e1_u2    
MSG	so_00_3


PIC   so so1/a0L1R2__F1__f1__m1__e2_u2    
PIC_MP	so HOT 

// （若干のウェイト。喋りがトーンダウンするイメージ。
MSG	so_01 

PIC   n a_3/a0__F1__f3__m1__b3_uo    
MSG	n_02 

PIC   so so1/a0L1R1__F1__f1__m8__b1_u2     
MSG	so_03 

WAIT 40

SELECT 1
&&Select_ruokay _RUOKAY C 
LABEL _RUOKAY

LOAD_BGM BGM_light

STOP_BGM	200 0

TL 35 PIC   n a_2/a0L1R3__F2__f2__m1__b5_u2    
PIC   so so2/a0L3R1__F2__f2__m1__e1_ua    
PIC_MP so SWT2
MSG	so_04 

DOTL
WAIT 40
PIC   so so1/a0L1R2__F1__f1__m1__e2_u2    

MSG	so_05 

PIC   n a_1/a22__F1__f1__m1__b2__uo    

MSG	n_06 
PIC   so so1/a0L1R3__F1__f1__m3__e2_u1    

MSG	so_07 

WAIT 30
PIC   so so1/a0L1R3__F1__f1__m6_ua    
MSG	so_08 
WAIT 5
//（ページ送り挟んで。

PIC   so so2/a0L4R1__F2__f2__m1__e2_u2    
WAIT 30

MSG	so_09 

PIC   n a_3/a0__F1__f3__m1__b4_uo    
MSG	n_10 

WAIT 45
MSG_PREFIX so <s2>


PIC   so so1/a0L1R1__F1__f1__m3__e2_ua    
TL 20 REPLACE_BGM	40 50 0


MSG	so_11 

PIC   n a_3/a1__F1__f3__m1__b1_uo    
WAIT 30

PIC   so so2/a0L3R1__F2__f2__m8__e2_u2    
MSG	so_12 

WAIT 30
PIC   so so2/a0L4R1__F2__f2__m8__e2_u2_2    
MSG	so_13


PIC   n a_2/a0L1R3__F2__f2__m1__b4_u2    
MSG	n_12

PIC   so so1/a0L2R3__F1__f1__m8__b1_u2    
MSG	so_13_2

PIC   so so2/a0L4R2__F2__f2__m1__e3_u0    
PIC_MP so KIR
MSG	so_13_3

PIC   n a_1/a22__F1__f1__m1__b1__u0    
WAIT 45

MSG_PREFIX so <s1>
PIC   so so1/a0L1R2__F1__f1__m3__e1_u1_2    


MSG	so_14 
PIC   so so1/a0L1R1__F1__f1__m1__e3_ua    

MSG	so_14_2
PIC   so so2/a0L1R2__F2__f2__m1__e1_u0    


MSG	so_15

PIC   n a_3/a0__F1__f3__m1__b4_u3    
PIC_MP n BLS|SWT2
MSG	n_15 

STOP_BGM 200 1
MSG_PREFIX so '<s1>'
PIC   so so1/a0L1R2__F1__f1__m6_ua    
MSG	so_16 

PIC   n a_1/a00L1R3__F1__f1__m4__b1_u0    
PIC_MP n BLS
MSG	n_17 

@_PIIN
MSG_PREFIX so '<tigrina>'
PIC   so so2/a0L1R2__F2__f2__m2__e1_up1    
MSG	so_18 I

@_TSUKKOMI so
 REPLACE_BGM	40 50 1

TL 20 PIC   n a_1/a22__F1__f1__m3__b1_u0    
TL 20 PIC_MP n QUE
PIC   so so1/a0L3R3__F1__f1__m4__e1_ua2    
PIC_MOVEA	so 1 JUMP
PIC_MP so LAG

MTL PIC   so so2/a0L4R2__F2__f2__m2__e2_ua2    
MTL PIC_MP so KIR
MSG so_19 S

PIC   n a_3/a1__F1__f3__m5__b1_u4    
PIC_MP n SWT2|BLS
PIC_MOVEA	n 1 JUMP
MSG	n_20


