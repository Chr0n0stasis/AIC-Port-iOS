#< % >
_aim=R
_lpname=ExitD_garagepre
_result=1
IF 'noel_torned' {
    _result=0

    #< % >
    _x=~m2d_current_x
    #< 
    IFSTR $_aim IS 'R' {
        _sx=~(m2d_current_x+m2d_current_sizex+1.5)-$_x
        _sxc=~$_sx*CLEN
        _sd=90
        #MS_ % 'F >+['$_sxc',0 <<0.09] @L P[stand_ev~]'
    } ELSE {
        _sx=~(m2d_current_x-m2d_current_sizex-1.5)-$_x
        _sxc=~$_sx*CLEN
        _sd=-90
        #MS_ % 'F >+['$_sxc',0 <<0.09] @R P[stand_ev~]'
    }

    TALKER	n $_aim


    PIC   n a_3/a1__F1__f3__m2__b2_u1    
    PIC_MP	n BLS 
    PIC_MOVEA	n 15 SCARY
    
    
    MSG	___Tigrina/t_garage_pre_goout*n_00


}
