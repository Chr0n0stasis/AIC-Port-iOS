SF_EVT_SET 1
PIC   n a_1/a22__F1__f1__m1__b1__u0    
PIC   s s/a0L1R1__F2__f2__m1__e1__u5    
MSG	s_00 

PIC   n a_1/a00L1R1__F1__f1__m1__b2__u1    
MSG	n_00 

PIC   s s/a0L2R2__F1__f1__m1__e1__u2    
PIC_MP s PLE
MSG	s_01 

PIC   s s/a0L1R3__F2__f2__m1__e3__u5    
PIC_MP s TTT
MSG	s_02 
PIC   n a_3/a0__F1__f3__m1__b4_uo    
MSG	n_03 

PIC   s s/a0L1R3__F2__f2__m1__e3__u1    
MSG	s_04 
PIC   s s/a0L2R1__F2__f2__m1__e1__u5    
MSG	s_04_2
IF 'PVV<210' {
    PIC   n a_2/a0L1R3__F2__f2__m1__b1_u2    
// まだアリスを助ける前ならノエルのコメントが続く
    MSG	n_05 


    @_TSUKKOMI

    PIC   s s/a0L3R3__F1__f1__m2__b1__u2    
    PIC_MP s EXQ

    MSG	s_06  I

}
