TALKER	n R    

IF 'GFB[FISHING_TUTO_FIRST]==0' {
    GFB_SET FISHING_TUTO_FIRST 1

    PIC   n a_1/a22__F1__f1__m1__b2__u0    
    PIC_MP n QUE
    MSG n_00 T
} ELSE {
    PIC   n a_3/a0__F1__f3__m1__b4_uo    
    PIC_MP n TTT
    MSG n_10 T
}

