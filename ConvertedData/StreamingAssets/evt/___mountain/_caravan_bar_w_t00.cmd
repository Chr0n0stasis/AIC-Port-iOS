DEFINENDEF 1=0

IF $1'==0' {
    PIC   n a_1/a22__F1__f1__m1__b1__u0    
    PIC   w w/a0L1R3__F2__f2__m1__e1__u3    
    MSG	w_00  


    PIC   n a_1/a22__F1__f1__m4__b1_ua    
    PIC_MP n PLE
    MSG	n_01 

    PIC   w w/a0L2R1__F1__f1__m1__e3__u2    
    PIC_MP w ONP
    MSG	w_02 
} ELSE {
    PIC   w w/a0L1R3__F2__f2__m1__e1__u3    
    PIC_MP w PLE
    // ヴァーロスと自己紹介をしなかった場合は ___city/bar_w_s12_10a が代わりに再生し、「奇遇だな」からここに繋がる
    MSG	w_10 
}
