// mount_spider_entrance から右に出る際にチップを持っていなかった場合の処理

IF '211<=PVV&&PVV<215' {

    <LOAD>
    START_LETTERBOX
    _result=0
    DEF_CURMAP _curmap
    IFSTR $_curmap IS 'mount_spiderrt' {
        #MS_ % 'F >>[ExitR_spiderright.L -40,0 <<0.08] @R P[stand_ev~]'
    } ELSE {
        #MS_ % 'F >>[ExitL_spe.R 40,0 <<0.08] @L P[stand_ev~]'

    }
    TALKER	n L   
    
  PIC   n a_1/a22__F1__f1__m1__b2__u1    
    MSG n_00
DENY_SKIP
WAIT_MOVE
}
