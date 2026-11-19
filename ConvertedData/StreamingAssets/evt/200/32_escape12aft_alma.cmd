GREETING	R   14
WAIT 20
#MS_ alma '@#[%::40]'
TALKER	n R   
TALKER	l L

IF 'GFC[ALM3]==0' {
    PIC   n a_3/a0__F1__f3__m1__b2_u3    
    PIC_MP n SWT2
    PIC   l l1/a0L2R1__F1__m1__b1_u4    

    MSG	n_00 
    PIC   l l1/a0L2R2__F1__m1__b8_ua    
    PIC_MP l SWT2

    MSG	l_01 

    PIC   l l1/a0L1R3__F1__m1__b1_ua4    
    PIC_MVA l 14 SCARY
    MSG	l_02 

    PIC   n a_1/a00L3R1__F1__f1__m1__b2__u0    
    MSG	n_03 

    PIC   n a_1/a22__F1__f1__m1__b2__u0    
    MSG	n_04  T

PIC   l l1/a0L2R3__F1__m1__b2_ua    
PIC_MP l QUE
    MSG	l_03 

PIC   n a_2/a0L1R3__F2__f2__m1__b5_u2    
    MSG	n_05 
    GFC_SET ALM3 |=1

} ELSE {
    PIC   n a_1/a00L1R3__F1__f1__m1__b1__u3    
    PIC   l l1/a0L2R1__F1__m1__b4_u2    
    // 2回目
    MSG	l_20 

}


