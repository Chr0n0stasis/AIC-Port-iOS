// _mapto, _goaim
_result=1
IFNDEF _map
    DEF_CURMAP _map
IFNDEF _goaim
    _goaim=
SEND_EVENT_CORRUPTION PRE_UNLOAD
IF $_result'==0' {
    SEEK_END
}

PIC_HIDE_ALL	 

DENY_SKIP
PIC_FILL #9 0xff3A3434
PIC_FADEIN #9 18
#< % >
IFSTR $_goaim ISNOT '' {
    IFSTR $_goaim IS 'R' 
        _mpf=1
    ELSIFSTR $_goaim IS 'L'  
        _mpf=-1
    ELSE
        _mpf=~$_goaim
} ELSE {
    _mpf=~m2d_walkable_mpf[1.25]
}

_walk=~$_mpf*30
#MS	'= P[walk] >+['$_walk',0 :18]'

IF $_mpf'>0'
    _aim=R
ELSE
    _aim=L
INIT_MAP_MATERIAL $_mapto 1
WAIT 20
ENABLE_PUTTED_MAGIC_SAVE
WAIT_FN MAP_TRANSFER

IFSTR $_mapto IS 'city_scl_ground' {
    IF 'PVV==107' {
        _107_first=1
        NEL_MAP_TRANSFER $_map $_aim '!WarpTo'
        CHANGE_EVENT 107/_td_portal 1
    }
}

NEL_MAP_TRANSFER $_map $_aim '!WarpTo'

PIC_FADEOUT #9 35

_walk=~$_mpf*18

#MS	'P[walk] >+['$_walk',0 :20] P[stand_ev~] '
WAIT_MOVE
