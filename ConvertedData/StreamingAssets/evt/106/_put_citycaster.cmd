DEFINENDEF 1=Ev_ground_tc
DEFINENDEF 2=0
DEFINENDEF 3=0
DEFINENDEF 4=0
_lp=$1
_sx=$2
_afterx=$3
_donot_pr_set=$4

LP_DEACTIVATE ExitL_toground 
LP_DEACTIVATE ExitR_caveT
LP_ACTIVATE WalkDecline_R 
LP_ACTIVATE WalkDecline_L
LP_DEACTIVATE ExitD_groundh
DENY_FASTTRAVEL
DENY_WARPINJECTION
START_IGNORE_PLAYER_ATK_BUFF


CITYCASTER_LOAD  1

ENABLEMAGIC _ 0 
ENABLEMAGIC WATERSHARD 1 


_x=~-340+($_sx)
_i=0
LABEL _LOOP
_casterid=~$_i+2
IF $_casterid'==3' {
    _casterid=15
} ELSIF $_casterid'==7' {
    _casterid=0
} ELSIF $_casterid'>7' {
    _casterid=~$_casterid-1
    IF $_casterid'==14' {
        _casterid=1
    } ELSIF $_casterid'>14' {
        _casterid=~$_casterid-1
    }
}
CITYCASTER $_casterid _mv idle
#< $_mv >

#MS '>>['$_lp' '$_x',0] @R P[stand_cane2~]'
IF $_i'==6' {
    _mvh_f=$_mv
}
IF $_i'==10' {
    #MS '## #;'
}
IF $_i'==14' {
    _mvh_e=$_mv
}


_i=~$_i+1
_x=~$_x+15+rand[3]
_x=~$_x+10
IF $_casterid'==0' {
    _x=~$_x+3
    IF $_donot_pr_set'==0' {
        #MS_ % 'q @R >>['$_lp' '$_x',0] P[stand_ev=5]'

    }
    _x=~$_x+28
}
IF $_casterid'==7' {
     _x=~$_x+16
}
IF $_i'<15' {
    GOTO _LOOP
}


LABEL _BOSS
_x=~$_x+40+$_afterx
#MS_ boss '>>['$_lp'.b '$_x',-2] @L'
