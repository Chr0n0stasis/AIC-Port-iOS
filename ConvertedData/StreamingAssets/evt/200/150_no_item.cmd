// mount_spider_entrance から右に出る際にチップを持っていなかった場合の処理

IF 'PVV<211' {

    IF 'ItemHas[precious_errorchip]==0' {
        <LOAD>
        START_LETTERBOX
        _result=0
        #MS_ % 'F >>[Ev_bench <<0.08] @R P[stand_ev~]'
        TALKER	n L   
        
        PIC   n a_3/a0__F1__f3__m1__b4_u0    
        PIC_MP n TTT
        MSG n_00
        MSG n_01
DENY_SKIP
WAIT_MOVE
    }
}
