// 1: Summoner key
// 2: added dlevel 
// 3: ノエルがクリアしたかどうか first_defeat: 2 / defeated:1  / other close :0
// 4: after_event
// 5: _recovery_again
_BAREA=$1
_dlevel=$2
_defeated=$3
DEFINENDEF 4=
DEFINENDEF 5=0
_after_event=$4
_recovery_again=$5
STOP_LETTERBOX
_after_event_c=
_after_event_cv1=
_after_event_c_gameover_progressable=0

IFSTR $_BAREA IS forest_senzyo {
    IF 'PVV==102&&GFC[IXA1]<5' {
        #MS_ % 'F' // 復活
        _after_event_c=s11_4a
    }
}

IFSTR $_BAREA IS forest_swamp {
    IF 'PVV==103&&GFC[WLR0]==2&&ItemHas[ostrea_bomb]>=2' {
        _after_event_c=s12_9a
        _after_event_cv1= 20
    }
}
IFSTR $_BAREA IS forest_nusi_coroseum {
    IF 'PVV==104' {
        #MS_ % 'F' // 復活
        _after_event_c=s13_4a
    }
}

IFSTR $_BAREA IS mount_ruinroad {
    IF 'quest_progress[p200_alice]==3&&'$_defeated {
        _after_event_c=200/06_escape04
        IF $_recovery_again
            _after_event_cv1=1
    }
}
IFSTR $_BAREA IS mount_busstop {
    IF 'quest_progress[p200_alice]==8&&200<=PVV&&PVV<=201' {
        _after_event_c=200/12_escape08aft
        IF m2d_is_gameover_active {
            _after_event_cv1=2
            _after_event_c_gameover_progressable=1
        }

    }
}
IF $_dlevel'>0 && m2d_is_gameover_active && '$_after_event_c_gameover_progressable'==0'
    _dlevel=0

IF $_dlevel'>0' {
    PR_CURE 0 0 0 0 0 ~20*$_dlevel
}
<NOLOAD>

IFSTR $_after_event ISNOT '' {
    // ガレージまたは防衛戦での実行
    CHANGE_EVENT	$_after_event
    SEEK_END
}

IF $_dlevel'>=3' {
    PR_FEAR_AUTO_CURE 2
    PR_FEAR_FLUSH
} ELSIF $_dlevel'>0' {
    PR_FEAR_AUTO_CURE 1
    PR_FEAR_FLUSH
}

IFSTR $_BAREA IS 'SmnC_garage' {
    IF 'GFC[TIG0]==3&&GFC[TIG1]==1' {
        CHANGE_EVENT	___Tigrina/t11
    }
}

IF $_recovery_again'==0' 
    CHANGE_EVENT2 __M2D_FINISH_SUMMONER 0

IF $_dlevel'>0&&GFC[TLD_BOX]==2' {
    GFC_SET TLD_BOX 1
}

DENY_SKIP
IFSTR $_BAREA IS forest_tutorial {
    IF 'PVV==2&&GFC[NOE1]<6' {
        DEFEAT_EVENT	s00_5b
    }
}
IFSTR $_BAREA IS forest_coroseum {
    IF 'PVV<100' {
        DANGER 10
        GFB_SET PVV0_YORIMICHI 1
    }
}

IFSTR $_BAREA IS forest_thorn_cage {
    IF 'PVV==102&&'$_defeated'==2' {
        DEFEAT_EVENT2 s10_show_door
    }
}


IF $_defeated {
    DEFINE_SUMMONER_RESCUE _rescued
    IF $_rescued {
        CHANGE_EVENT2	__M2D_FINISH_SUMMONER_RESCUED
    }
}
// ================================================

IF $_recovery_again'==0' 
    ACHIVE_SET defeat_summoner '+=1'
IF 'PVV>=100&& '$_dlevel'>=0' {

    SUMMONER_DEFEAT_NIGHT_PROGRESS $_BAREA 1 $_dlevel
    ACHIVE_SET obtain_danger '+='$_dlevel
    IF $_dlevel'>=1' {
        <NOLOAD>
        WEATHER_PROGRESS 1
    }
}


IFSTR $_after_event_c ISNOT '' {
    WAIT_FN NIGHTCON
    IF $_after_event_c_gameover_progressable
        CHANGE_EVENT	$_after_event_c $_after_event_cv1
    ELSE 
        DEFEAT_EVENT	$_after_event_c $_after_event_cv1
}

IFSTR $_BAREA IS mount_cave_honey0 {
    IF 'Exist_mover[citycaster_sub_i]' {
        DEFINE_SUMMONER_RESCUE _rescued 1
        IF $_rescued {
            WAIT_FN NIGHTCON
            DEFEAT_EVENT	200/22_ixia_rescue_02
        }
    }
}


IFSTR $_BAREA IS mount_spider_coroseum {
    IF '200<=PVV&&PVV<210 && (GFC[ALC1]&8)==8' {
        STOP_BGM	20 1
        WAIT_FN NIGHTCON
        DEFEAT_EVENT	200/90_spider_after
    }
}
