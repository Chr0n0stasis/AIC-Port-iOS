_aim=$1

IF 'PVV>=210 || !Exist_mover[alma] || (GFC[ALM1]&8)>0' {
    SEEK_END
}
_result=0 

START_LETTERBOX
TALKER	n L   
#MS_ % 'F'

PIC   n a_3/a0__F1__f3__m1__b4_u0    
PIC_MP n TTT
MSG 200/35_alma_magic*n_20

PIC_HIDE_ALL
DENY_SKIP
#< % >
_btmy=~lp_mapb[Ev_enter]
IF $_aim' == 0' {
    // left
    #MS_ % '>>[#<alma> -200,0 <<0.08] '
} ELSIF $_aim' == 2' {
    // left
    #MS_ % '>>[#<alma> 250,0 <<0.08] '
} ELSE {
    LABEL _REJUMP
    #MS_ % 'j[ >>130 :40:5] F'
    WAIT_MOVE
    IF 'm2d_current_y+m2d_current_sizey>='$_btmy {
        GOTO _REJUMP
    }
    #MS_ % '! @R >>[#<alma> -130,0 <<0.041] ?'

}

WAIT_MOVE

