
IF 'ItemHas[precious_errorchip]==0&&PVV<210' {
    START_LETTERBOX
    <LOAD>
    #MS_ % 'F >+[-50,0 :30] P[stand_ev~]' 
    _result=0
    TALKER	n R   
    PIC   n a_1/a22__F1__f1__m1__b2__u0    

    MSG n_00 T
    DENY_SKIP
    WAIT_MOVE

}
