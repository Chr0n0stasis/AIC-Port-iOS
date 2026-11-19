// 特定マップの WarpTo に飛ぶ。
<NOLOAD>
IF warp_not_injectable 
    SEEK_END

_=
DEF_CURMAP _map 
IF 'GFB[FITTING]' {
    IFSTR $_map IS city_in_forge_testfire {
        CHANGE_EVENT	___city_forge/__portal_testfire
    }
    SEEK_END

}

STOP_LETTERBOX
VALOTIZE
_nomsg=0
DENY_SKIP
#< % >
_goaim=
@___city/_warp
IF $_result==0 {
    IFSTR $_map IS school_in_garage {
        
        SELECTARRAY_CLEAR
        SELECTARRAY &&Select_reset_garage school_in_garage
        _nomsg=1
        GOTO _CANCEL
    }
    SEEK_END
}

IFSTR $_map IS 'city_in_baru' {
    IF 'GFC[BRTU]<8' {
        _result=0
        SEEK_END
    }
}

_106_ground_syugo=
IF 'PVV==106 && ((GFC[TIG0]>=3&&GFC[TIG1]>=2 ) || GFC[TIG0]>=4) ' {
    _106_ground_syugo=Q
}

#MS_ % 'P[stand_ev~]'
HKDS	n RTT #<%> TT

SELECTARRAY_CLEAR
IF 'visitted[city_entrance_left]'
    SELECTARRAY &&MAP_city_entrance_left city_entrance_left

IF 'visitted[city_market_left]'
    SELECTARRAY &&MAP_city_market_left city_market_left

IF 'visitted[city_market_BL]'
    SELECTARRAY &&MAP_city_market_BL city_market_BL
IF 'visitted[city_farm]'
    SELECTARRAY &&MAP_city_farm city_farm
IF 'visitted[city_center]'
    SELECTARRAY &&MAP_city_center city_center
IF 'visitted[city_slam]'
    SELECTARRAY &&MAP_city_slam city_slam
IF 'visitted[city_park]'
    SELECTARRAY &&MAP_city_park city_park
IF 'visitted[city_entrance_right]'
    SELECTARRAY &&MAP_city_entrance_right city_entrance_right
IF 'visitted[city_entrance_rightcave] ' {
    _=
    IF 'PVV==107' {
        _=S
    }
    IF 'PVV==200' {
        _=Q
    }
    SELECTARRAY &&MAP_city_entrance_rightcave city_entrance_rightcave $_
}

IF 'visitted[city_scl_dorm]'
    SELECTARRAY &&MAP_city_scl_dorm city_scl_dorm
IF 'visitted[city_scl_center]'
    SELECTARRAY &&MAP_city_scl_center city_scl_center
IF 'visitted[city_scl_ground]' {

    _=
    IF 'PVV==107' {
        _=Q
    }
    SELECTARRAY &&MAP_city_scl_ground city_scl_ground $_

}
IF 'visitted[city_in_dojo]&&GFC[DJO0]>0'
    SELECTARRAY &&MAP_city_in_dojo city_in_dojo
IF 'visitted[city_in_guild]' {
    _=
    IF 'guildquest_finished[forest]+guildquest_finished[mount]>0' {
        _=Q
    }
    SELECTARRAY &&MAP_city_in_guild city_in_guild $_
}
IF 'visitted[city_in_forge]'
    SELECTARRAY &&MAP_city_in_forge city_in_forge
IF 'visitted[city_in_bar]'
    SELECTARRAY &&MAP_city_in_bar city_in_bar
IF 'visitted[city_in_baru]&&GFC[BRTU]>=8'
    SELECTARRAY &&MAP_city_in_baru city_in_baru
IF 'visitted[city_in_museum]&&(GFC[MUS0])>=4'
    SELECTARRAY &&MAP_city_in_museum city_in_museum
    

IF 'visitted[school_entrance]'
    SELECTARRAY &&map_prefix_bermit[&&MAP_school_entrance] school_entrance
IF 'visitted[school_in_hall_left]'
    SELECTARRAY &&map_prefix_bermit[&&MAP_school_in_hall_left] school_in_hall_left $_106_ground_syugo
IF 'visitted[school_in_hall_right]'
    SELECTARRAY &&map_prefix_bermit[&&MAP_school_in_hall_right] school_in_hall_right 
IF 'visitted[school_in_hall_center]'
    SELECTARRAY &&map_prefix_bermit[&&MAP_school_in_hall_center] school_in_hall_center
IF 'visitted[school_in_health]&&(PVV>105||(PVV==105&&GFC[IXA1]>=4))'
    SELECTARRAY &&map_prefix_bermit[&&MAP_school_in_health] school_in_health
IF 'visitted[school_in_hall_right_2]'
    SELECTARRAY &&map_prefix_bermit[&&MAP_school_in_hall_right_2] school_in_hall_right_2
IF 'visitted[school_in_homeec]' {
    SELECTARRAY &&map_prefix_bermit[&&MAP_school_in_homeec] school_in_homeec
    // _goaim=1
}
IF 'visitted[school_in_cafeteria]' {
    _flag=
    IF 'PVV==106' 
        _flag=S
    SELECTARRAY &&map_prefix_bermit[&&MAP_school_in_cafeteria] school_in_cafeteria $_flag
    // _goaim=1
}
IF 'visitted[school_in_garage]' {
    SELECTARRAY &&map_prefix_bermit[&&MAP_school_in_garage] school_in_garage
    // _goaim=1
}

LABEL _CANCEL

SELECTARRAY	&&Cancel _cancel c


SELECT_FOCUS	$_map 1
STOP_GHANDLE
DENY_MSGLOG

DENY_EVENTHANDLE
IF $_nomsg'==0' {
    TL 40 MSG_SKIPHOLD

    MSG ___House/_backdoor_portal*n_00 T

}
ALLOW_EVENTHANDLE
SELECT	-1 _mapto
MSG_HIDE	  
ALLOW_MSGLOG
IFSTR $_mapto IS '_cancel' {
    SEEK_END
}
<LOAD>

LABEL SELECTED

CHANGE_EVENT2 ___city/_warp_zx_execute
