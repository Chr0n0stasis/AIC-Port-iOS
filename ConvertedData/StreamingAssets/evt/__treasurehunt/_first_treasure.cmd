
TALKER	n L   

IF $1'==0' {

    IF 'GFC[TRS0]==0' {


        PIC   n a_3/a0__F1__f3__m1__b4_uo    

        MSG	__treasurehunt/000_1*n_00 


        MSG	__treasurehunt/000_1*n_01 
    }

} ELSE {

    IF 'GFC[TRS0]==0' {
        WAIT 80

        PIC   n a_1/a00L3R1__F1__f1__m3__b1_u0    
        PIC_MP	n SMK 

        MSG	__treasurehunt/000_1*n_02 
        
        GFC_SET TRS0 |=1
    } ELSE {
        WAIT_BUTTON
    }

}
PIC_HIDE_ALL	 
