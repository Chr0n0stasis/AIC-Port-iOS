// ゲームオーバー処理
// 1.死ぬ前にいたマップ
// 2.変数いろいろ
// 3.fatal_key
// 4.go_title なら 1
// 5. skip_fatal_scene なら 1
<NOLOAD>
_premap=$1 
_killed_by_enemy=~$2&1
_killed_by_worm=~$2&2
_flush_flag=1
DEFINENDEF 4=0
DEFINENDEF 5=0
_go_to_title=$4
_do_not_fatal=~$5||(sensitive_level>=2)
_after_deny_fasttravel=0

rm=~$2&2
_fatal_key=$3
// ベビードールを戻す
_turnback_outfit=1
_add_gameover_count=1
_evt=
_jumpto=
_ev1=
_evt2=
_ev2_1=
STOP_LETTERBOX
DENY_SKIP
STOP_GMAIN
TUTO_REMOVE Tuto_magic_burst

IFSTR $_premap IS 'school_in_garage' {
    // ガレージ
    IF 'GFC[TIG0]==3&&GFC[TIG1]==1' {
        UI_GAMEOVER NO_NFBT // フルボッコタイム省略
        GAMEOVER_MAP_JUMP_TO school_in_garage
        _evt=___Tigrina/t12
        _ev1=-1
        _flush_flag=0
        GOTO _NO_FLUSH
    } ELSE {
        GAMEOVER_MAP_JUMP_TO school_in_garage
        _jumpto=Ev_L
        _evt2=___Tigrina/_gameover_after
        GOTO _NO_FLUSH
    }
}
IFSTR $_premap IS 'city_scl_ground' {
    GAMEOVER_MAP_JUMP_TO school_in_health
    _jumpto=Ev_bed1.b
    IF 'PVV==107' {
        _evt=___Tips/bosshint_107
        BGM_MANUAL_REPLACE_ON_CHANGEMAP
    }
    IF 'PVV >=200' {
        _evt=107/_memory_finish   
    }
    GOTO _NO_FLUSH
}
IFSTR $_premap IS 'mount_ruinroad' {
    IF 'PVV==200&&quest_progress[p200_alice]==3' {
        _evt=200/06_escape04
        _ev1=1
    }
}
IFSTR $_premap IS 'mount_busstop' {
    IF 'PVV==201&&quest_progress[p200_alice]==8' {
        _evt=200/12_escape08aft
        _ev1=1
        _jumpto=Ev_center
        GAMEOVER_MAP_JUMP_TO mount_busstop
        SCN_MANUAL_BGM_REPLACE  ''
    }
}

IF 'PVV>=210&& PVV<215' {
    IFSTR $_premap STARTS 'mount' {
        _jumpto=Ev_C
        GAMEOVER_MAP_JUMP_TO mount_spider_coroseum
        SCN_MANUAL_BGM_REPLACE  ''
    }
}

// STOREFLUSH // UiGO でやってるので Flush しないよ 
CHANGE_EVENT2 __M2D_FINISH_SUMMONER 1

//ADD_MAPFLUSH_FLAG

LABEL _NO_FLUSH
_danger_dep=0
_nowait=0
_bgm=
IF 'PVV<5' {
    GAMEOVER_MAP_JUMP_TO forest_01
    _evt=s00_5c
    _jumpto=Ev_s00_5c.b
    _danger_dep=10
    _bgm=BGM_suzumusi
    _ev1=0
    IF 'GFC[NOE1]<15' {
        _ev1=1
    }
    IF $_killed_by_enemy'||'$_killed_by_worm {
        GFC_SET_MX PVV0_KILLED 2
    } ELSE {
        GFC_SET_MX PVV0_KILLED 1
    }
    GFC_SET_MX	NOE1 15 
}
IFSTR $_premap IS 'forest_senzyo' {
    IF 'PVV==102&&GFC[IXA1]<5' {
        _evt=___Tips/bosshint_102
        BGM_MANUAL_REPLACE_ON_CHANGEMAP
    }
}
IF 'PVV==102&&GFC[IXA1]==5' {
    // イクシャ エナボチュートリアル
    GAMEOVER_MAP_JUMP_TO forest_senzyot
    _jumpto=Ev_pvv102_noel
    _bgm=BGM_ixia
}
IF 'PVV==103&&GFC[WLR0]==2' {
    IFSTR $_premap IS 'forest_swamp' {
        // 沼でのバトル
        GAMEOVER_MAP_JUMP_TO forest_ostrea_swampt
        _jumpto=Ev_s12_defeat.b
        _evt=s12_9b
        _nowait=1
    }
}
IFSTR $_premap IS 'forest_nusi_coroseum' {
    IF 'PVV==104' {
        IF '(GFC[IXA1]&4) ==0 ' {
            _evt=___Tips/bosshint_104_noburst
        } ELSE {
            _evt=___Tips/bosshint_104

        }
        BGM_MANUAL_REPLACE_ON_CHANGEMAP
    }
}

IFSTR $_premap IS 'mount_spider_coroseum' {
    IF 'PVV<210&&(GFC[ALC1]&8)!=0' {
        IF 'PVV<210&&(GFC[ALC1]&4)==0' {
            _evt=___Tips/bosshint_209
        } ELSE {
            _evt=___Tips/bosshint_210
            
        }
        BGM_MANUAL_REPLACE_ON_CHANGEMAP
    }
}
IFSTR $_premap STARTS 'sacred_' {
    GAMEOVER_MAP_JUMP_TO city_slam
    _gameover_now_city_slam=1
    _jumpto=Ev_slam_ground_r.Lb
        _evt=___sacred/_go2city
        _nowait=1
}
IFSTR $_premap STARTS 'mount_in_elec_facility' {
    IF 'PVV<215' {
         GAMEOVER_MAP_JUMP_TO mount_in_elec_facility_console
        _jumpto=Ev_console.Rb

    }
}

IF 'GFB[FITTING]' {
    
    IFSTR $_premap IS 'city_in_forge_testfire' {
        GAMEOVER_MAP_JUMP_TO city_in_forge_testfire
        _jumpto=Ev_fitting.Rb
        _after_deny_fasttravel=1
    }
}


IFSTR $_bgm ISNOT '' {
    IFSTR $_evt ISNOT '' {
        SCN_MANUAL_BGM_REPLACE $_bgm
    }
}
IFSTR $_fatal_key ISNOT '' {
    IF '!'$_do_not_fatal {
        BGM_MANUAL_REPLACE_ON_CHANGEMAP
        AREATITLE_TEMP_HIDE
        MAPTITLE_TEMP_HIDE
        TIPS_TEMPORARY_HIDE
    }
}
IFSTR $_bgm ISNOT '' {
    BGM_MANUAL_REPLACE_ON_CHANGEMAP
}

IF $_add_gameover_count {
    ACHIVE_SET gameover +=1
}

IF '!'$_go_to_title {
    REEL_FLUSH 1
    WAIT_FN REELMNG
    WAIT_FN NM2D_GAMEOVER // 新しいマップがロードされるまで待機

} ELSE {
    WAIT_FN NM2D_GAMEOVER // ふるぼっこモード待機
    LABEL 
    UI_GAMEOVER START_GAMEOVER_RUN

    CHANGE_EVENT __M2D_GAMEOVER_TO_TITLE 0
    <NOLOAD>
    SEEK_END
}

PIC_FILL	&10 DARK
IF $_after_deny_fasttravel {
    DENY_FASTTRAVEL
}
START_GMAIN
STOP_GHANDLE
IF $_flush_flag 
    FLUSHED_MAP 0
DANGER $_danger_dep 1
VALOTIZE 1
IFSTR $_bgm ISNOT '' {
    IFSTR $_evt IS '' {
        LOAD_BGM $_bgm
        REPLACE_BGM	0 30 0
    }
}


WAIT 1
IFSTR $_jumpto ISNOT '' {
    #MS_SOFT_ % '>>['$_jumpto'] #; '
}

IF $_turnback_outfit {
    NOEL_OUTFIT_TURNBACK
}

IFSTR $_fatal_key ISNOT '' {
    IF '!'$_do_not_fatal {
        STOP_BGM	0 0
        
        CHANGE_EVENT ___Other/fatal $_fatal_key 0 0 $_evt $_ev1
       
    }
}
IF '!'$_nowait {
    WAIT 10
}
PIC_FADEOUT	&10 60
PE_FADEINOUT BLUR 120 20 0.9 -120
IFSTR $_evt ISNOT '' {
    CHANGE_EVENT	$_evt $_ev1
}
IFSTR $_evt2 ISNOT '' {
    CHANGE_EVENT2	$_evt2 $_ev2_1
}

WAIT 60

