
TALKER n L
TALKER so R
PIC   so so1/a0L2R1__F1__f1__m1__e1_ua3    
PIC_MP	so PLE 
PIC   n a_1/a22__F1__f1__m3__b1_u0    
MSG	so_00 

PIC   n a_1/a00L1R1__F1__f1__m1__b2__u1    
MSG	n_01 

PIC   so so2/a0L4R1__F2__f2__m1__e1_ua    
PIC_MP so QUE
PIC_MVA so 2 JUMP

MSG	so_02 
PIC_HIDE_ALL	 

PIC_FILL #9 DARK
PIC_FADEIN #9 40
WAIT 60
HKDS	so   CCRCT


MSG	so_03 
PIC_FLASH #10 1 6 3 77:#ffffff
SND cane_poki

MSG so_03_2 IA

HKDS	so    
WAIT 10

PIC_FADEOUT #9 40
WAIT 30

PIC   n a_1/a22__F1__f1__m3__b1_u0    
PIC   so so1/a0L4R3__F1__f1__m1__e2_u2    
MSG	so_04 
PIC   so so1/a0L4R3__F1__f1__m1__e2_ua   
TL 30 PIC   n a_1/a22__F1__f1__m1__b1__u0     
MSG	so_04_2

DOTL
TL 40 PIC   n a_3/a0__F1__f3__m1__b2_uo    
PIC   so so1/a0L2R3__F1__f1__m1__e1_ua    
MTL PIC   so so1/a0L4R2__F1__f1__m3__e1_u1_2    
MTL PIC_MP so SMK

MTL PIC   so so2/a0L1R2__F2__f2__m1__e3_u2    
MTL PIC_MVA so SHAKE 2 
MSG	so_05 S

DOTL
PIC   n a_1/a22__F1__f1__m1__b2__uo    
PIC_MP n QUE
MSG	n_05 

PIC   so so1/a0L1R2__F1__f1__m4__e1_up    
PIC_MP so KIR
MSG	so_06 

PIC   so so1/a0L2R1__F1__f1__m3__e2_ui    
MSG	so_07 

PIC   n a_2/a0L1R3__F2__f2__m1__b5_u3    
MSG	n_08 

PIC   so so2/a0L3R1__F2__f2__m1__e1_ui1  
PIC_MP so PLE  
MSG	so_09 
SF_EVT_SET
