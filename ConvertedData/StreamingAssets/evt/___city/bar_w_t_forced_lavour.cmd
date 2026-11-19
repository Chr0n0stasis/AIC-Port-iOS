SF_EVT_SET

PIC   n a_1/a00L1R3__F1__f1__m1__b1__u1    
PIC_MP n QUE
PIC   w w/a0L1R1__F1__f1__m1__e1__u1    

MSG	n_00 
PIC   w w/a0L3R1__F2__f2__my__e4__u6    
PIC_MP w SMK

MSG	w_01 


PIC   n a_3/a0__F1__f3__m1__b3_uo    
PIC_MP n SWT2
MSG	n_02 

PIC_HIDE_ALL	 
STOP_BGM	300 0



WAIT 50
PE SHOTGUN 400 0.6
PIC_FLASH	&9 0 6 4 ff:#EBEBEB
PIC   w w/a0L2R1__F1__f1__m1__e2__u1    
MSG	w_03 
PIC   w w/a0L2R3__F1__f1__m2__b1__u2    
MTL MSG_SKIP
MSG	w_03_2

TALKER w CLL
TALKER s LL 
TALKER n R
PIC   n a_3/a2__F1__f3__m1__b2_u0    
PIC   s s/a0L3R1__F1__f1__m1__e2__u1    
TL 30 PE SHOTGUN -1 120
MSG	s_04 
PIC   w w/a0L2R1__F1__f1__m1__e3__u3    
PIC_MP w HOT

TL 20 START_BGM 220

MSG	w_05 
TL 40 PIC   s s/a0L1R1__F1__f1__m1__e1__u3    
PIC   w w/a0L1R3__F2__f2__my__e2__u6    
MSG	w_05_2

PIC   n a_1/a00L1R1__F1__f1__m1__b1__uo    
MSG	n_06 

PIC   w w/a0L1R1__F3__f3__m1__e1__u2    
MSG	w_07 

PIC   n a_1/a22__F1__f1__m1__b2__u0    
MSG	n_08 

PIC   w w/a0L2R1__F1__f1__m1__e3__u6    
MSG	w_09 

DOTL 
PIC   s s/a0L2R1__F2__f2__m1__e1__u5    

MSG	s_10 

PIC   n a_2/a0L1R3__F2__f2__m1__b5_u0    
MSG	n_11 

WAIT 40
PIC_HIDE s
TALKER w L
TALKER n R
PIC   w w/a0L2R3__F1__f1__m1__e3__u4    
PIC_MP w TTT
MSG	w_12 

PIC   w w/a0L3R1__F2__f2__m1__e3__u3    
PIC_MP w LAG
MSG	w_13 

PIC   w w/a0L2R3__F3__f3__m1__e1__u2    
MSG	w_14 
PIC   n a_3/a0__F1__f3__m1__b1_u0    

MSG	n_15 

PIC   w w/a0L2R1__F1__f1__m2__b2__u3    
MSG	w_16 

PIC   w w/a0L2R3__F2__f2__m1__e1__u3    
MTL PIC   w w/a0L3R1__F1__f1__m1__e2__u6    // module
MTL PIC_MP   w LAG    // module
MTL SND tsukkomi
MTL QU_VIB 10 12 8
MSG	w_17 

TL 40 PIC   n a_1/a22__F1__f1__m1__b1__u0    
PIC   w w/a0L2R1__F2__f2__my__e4__u6    
MSG	w_18 

DOTL
