PIC   so so1/a0L2R4__F1__f1__m2__e2_u2    
PIC   n a_1/a22__F1__f1__m1__b1__u0    
PIC_MP so EXC
MSG	so_00 

PIC   so so2/a0L4R2__F2__f2__m7__e1_ua    
PIC_MP so ONP
MSG	so_01 

PIC   n a_1/a00L1R1__F1__f1__m1__b1__u1    
MSG	n_02 


MSG	so_03 

PIC   n a_3/a0__F1__f3__m1__b3_u2    
PIC_MP n SWT
MSG	n_04 T

PIC   so so1/a0L2R1__F1__f1__m1__e1_ua    
    TL 30 PIC   n a_2/a0L1R3__F2__f2__m1__b5_u0    
MSG	so_04 

DOTL
PIC   so so1/a0L2R4__F1__f1__m4__e1_ua3    
PIC_MP so PLE
MSG	so_05

#< tigrina >
#PHY 1
    #MS_ tigrina '@L P[walk] ! >+[-30,0 :50] P[stand] w100 P[walk] >>[Ev_tig.b 0,0 :90] P[stand] ?'

    PIC_HIDE_ALL	 
    

    WAIT 190
    GFB_SET FG_ENEMY 1
    PIC   n a_1/a22__F1__f1__m1__b1__u0    
    PIC   so so1/a0L2R2__F1__f1__m4__e1_ua3    
    PIC_MP so PLE
    MSG	___Tigrina/t13*so_14 
    MSG	___Tigrina/t13*so_15 
