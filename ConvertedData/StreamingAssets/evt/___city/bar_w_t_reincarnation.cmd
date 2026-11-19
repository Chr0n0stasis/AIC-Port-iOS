SF_EVT_SET
PIC   w w/a0L2R1__F2__f2__my__e1__u6    
PIC   n a_1/a00L1R1__F1__f1__m1__b1__u1    
MSG	n_00 

LOAD_BGM BGM_A_suspicion

PIC   w w/a0L1R1__F1__f1__m1__e3__u3    
MSG	w_00 

PIC   n a_1/a22__F1__f1__m1__b2__u1    
MSG	n_01 

PIC   w w/a0L3R3__F2__f2__m1__e2__u2    

MSG	w_02 

PIC   w w/a0L1R1__F1__f1__m1__e3__u2    

MSG	w_03 

PIC   n a_2/a0L1R3__F2__f2__m1__b5_u2    
PIC_MP n SMK
STOP_BGM 400 0

MSG	n_04 

PIC   w w/a0L1R1__F3__f3__m1__e1__u2    
PIC_MP w TTT

MSG	w_05 

PIC   n a_1/a22__F1__f1__m1__b1__u1    
PIC_MP n QUE
MSG	n_06 

REPLACE_BGM	30 30 0

PIC   w w/a0L1R1__F1__f1__m1__e3__u6    
MSG	w_07 

PIC   n a_3/a0__F1__f3__m1__b1_u3    
PIC_MP n EXC
MSG	n_08 

PIC   w w/a0L1R3__F1__f1__m1__e3__u1    
MSG	w_09 

PIC   n a_2/a0L1R3__F2__f2__m1__b1_u2    
MSG	n_10 

PIC   w w/a0L1R1__F1__f1__m2__b2__u3    
MSG	w_11 

STOP_BGM	1 0

PE SHOTGUN 1 0.6
PIC_FLASH	&9 0 6 4 ff:#EBEBEB
PIC   w w/a0L2R3__F2__f2__m1__e4__u2    I
MSG_HIDE 1
HKDS	w C '>w'
MSG	w_12 I

PIC   n a_3/a0__F1__f3__m1__b1_uo    I
PIC_MOVEA	n 1 JUMP

HKDS	w   '' '' 

MSG	n_13 
TL 40 PE SHOTGUN -1 200
TL 50 REPLACE_BGM 60

MTL PIC   w w/a0L1R1__F1__f1__m1__e2__u2    
MTL PIC_MP w  LAG
MSG	w_14


PIC   w w/a0L1R1__F2__f2__m1__e4__u1    
PIC_MP w ONP 
MSG	w_15

DOTL
