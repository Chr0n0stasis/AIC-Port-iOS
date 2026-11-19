
_phase=~quest_progress_f[p200_alice]

IF $_phase'>=8&&'$_phase'<=11&&Exist_mover[alice]' {

    TALKER	n L   
    PIC   n a_3/a2__F1__f3__m1__b1_u0    
    #MS_ % 'F >>[ExitL_cannonbl.Rb 60,0 <<0.08] P[stand_ev~]' 
    MSG n_00
    _result=0
    DENY_SKIP
    WAIT_MOVE
}
