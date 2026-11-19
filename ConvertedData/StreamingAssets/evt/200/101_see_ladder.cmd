DEFINENDEF 1=Ev_SBRRR
#MS_ % '? >>['$1' 20,0 <<0.07] P[stargaze~]'
WAIT 60
#MS_ $1 '## >+[0,-200: 60] '

WAIT 40
TALKER	n L   
PIC   n a_3/a0__F1__f3__m1__b4_uo    ]
MSG n_00


IF 'GFC[ALM1]>=3||(GFC[ALC1]&1)!=0' {
    SELECT 2
    &&Select_think_hint _HINT
    &&Select_think_myself _END C
    LABEL _HINT

    #MS_ % '##'
    IF '(GFC[ALC1]&1)!=0' {
        PIC   n a_1/a22__F1__f1__m1__b2__u1    
        PIC_MP n TTT
        MSG n_20
    } ELSE {

        PIC   n a_2/a0L1R3__F2__f2__m1__b4_u2    
        PIC_MP n TTT
        MSG n_10
    }


} ELSE {

    PIC   n a_2/a0L1R1__F2__f2__m1__b4_u2    
    PIC_MP n SMK
    MSG n_01
}



LABEL _END
PIC_HIDE_ALL	 

#MS_ $1 '>>['$1' 0,0]'
