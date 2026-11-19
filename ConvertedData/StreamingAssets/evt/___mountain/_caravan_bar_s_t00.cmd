PIC   s s/a0L2R1__F1__f1__m1__e1__u2    
PIC   n a_1/a00L1R1__F1__f1__m1__b1__u3    
IF 'quest_progress_f[p200_elec_facil]>=2' {
    MSG	s_00  
    PIC   n a_1/a22__F1__f1__m1__b2__u3    
    PIC_MP n BLS|SWB

    MSG	n_01 


} ELSE {

// 電力施設を無視してクリアした時
    MSG	s_10 

}
