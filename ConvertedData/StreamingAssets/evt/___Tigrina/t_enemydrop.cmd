SF_EVT_SET
// MSG	so_00 
PIC   n a_1/a00L1R3__F1__f1__m1__b1__u0    
PIC   so so1/a0L2R1__F1__f1__m1__e1_ua3    

MSG	so_00
MSG	so_01

PIC   so so2/a0L4R1__F2__f2__m1__e1_u2    
MSG	so_02 


PIC   so so1/a0L4R2__F1__f1__m1__e2_u2    
PIC_MP	so TTT  

MSG	so_03 


PIC   so so1/a0L2R2__F1__f1__m5__ui    
PIC_MP so SWT2
MSG	so_04 


IF 'GFC[PUP0]>0' {
    PIC   n a_3/a0__F1__f3__m1__b4_u5    
    PIC_MP n SWT
    MSG n_05 T

}