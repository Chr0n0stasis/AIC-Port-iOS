// 1 マップ位置
// 2 bgm
DEFINENDEF 2=
_bgm_timing=$2
GREETING L -5
#MS_ % 'P[stand_ev~] @RB '
WAIT 20
_danger=~danger_level
DEF_CURMAP _premap
_premappos=$1
TITLECALL_HIDE 1

AREATITLE_TEMP_HIDE
MAPTITLE_TEMP_HIDE


// PVV	101  


SHOW_BLURSC
UIALBUM $_bgm_timing

IF 0 {
    LABEL ALBUM_RELOAD_SWITCH_MAP
    DOTL
        PIC_FILL	&1 DARK
        PIC_FADEIN	&1 50
        
        WAIT 60
        
    PE ZOOM2 -1
    UIALBUM_RELOAD_GF
    DENY_SKIP
    // PIC_FILL	&1 DARK
    WAIT 2
    INIT_MAP_MATERIAL $_premap 1
    SCN_MANUAL_BGM_REPLACE ''
    WAIT_FN MAP_TRANSFER 
    NEL_MAP_TRANSFER $_premap L '!'$_premappos
    WAIT 2
    TITLECALL_HIDE 1
    PIC_HIDE_ALL '' 1
    #< % >
    #MS 'q @RB P[stand_ev~ =4] >>[ '$_premappos'.Lb -20,0 ] @RB'
    PIC_FILL	&1 DARK
    PIC_FADEOUT	&1 80
    PE_FADEINOUT BLUR 60 10 0.9 -60
    DANGER $_danger 1
    ALLOW_SKIP
    WAIT_BUTTON 70 
    SHOW_BLURSC
    EV_CLEAR_ALL_STACK
    UIALBUM_RELOAD
}
IF 0 {
    LABEL ALBUM_RELOAD
    DOTL
    PIC_HIDE_ALL	 
    SHOW_BLURSC
    UIALBUM_RELOAD_GF
    UIALBUM_RELOAD
}
UIP_SETFADE 
UIPICT_GOB_DEACTIVE 0


ALLOW_EVENTHANDLE
IFSTR $_scene IS '' {
    // quit
    HIDE_BLURSC
    WAIT 60
    WALKCOUNT 99
    EV_CLEAR_ALL_STACK
    SEEK_END
}
<NOLOAD>
    DOTL

_memory_playing=1
IFSTR $_album_categ IS 'MEMORY' {
    // memory
    IFSTR $_scene IS 'cuts_nightingale_0_0' {
        GOTO FATAL
    }
    DENY_SKIP
    START_GMAIN
    PIC_FILL	&1 DARK
    PIC_FADEIN	&1 50
    STOP_BGM 100 0
    PE_FADEINOUT BLUR 60 10 0.9 0
    TL 40 HIDE_BLURSC
    WAIT 60
    ALLOW_SKIP
    TL 10 PIC_FADEOUT	&1 70
    // ========================
    IFSTR $_scene STARTS '005_ixia' {
        _amap=house_center
        _apos=AREA_right
        GFC_SET IXA0 0
        GFC_SET IXA3 1
        PVV_ABSOLUTE 5
        IFSTR $_scene IS '005_ixia_a' {
            _noel_defeated=0
            _evt=s01_ixia_2a_00
            DANGER 7 1
        } ELSE {
            GFC_SET PVV0_KILLED 2
            _evt=s01_ixia_2b_00
            _noel_defeated=1
            DANGER 9 1
        }
        <LOAD>
        @___House/_album_switch_map $_amap R $_apos 
        #< ixia >!
        CHANGE_EVENT2 $_evt
        <NOLOAD>
         
        GOTO ALBUM_RELOAD_SWITCH_MAP   
    }
    IFSTR $_scene STARTS '009_primula' {
        _amap=house_barn
        _apos=Ev_outright
        GFC_SET PRM3 0
      
        PVV_ABSOLUTE 9
        DANGER 10 1
        <LOAD>
        IFSTR $_scene IS '009_primula_a' {
            GFC_SET PVV0_KILLED 0
        } ELSE {
            GFC_SET PVV0_KILLED 2
        }
        @___House/_album_switch_map $_amap R $_apos 
        CHANGE_EVENT2 s03_6a
        WAIT 4
        #< primula >!
        CHANGE_EVENT2 s03_6a_p
        CHANGE_EVENT2 s03_7a_2
        <NOLOAD>


        GOTO ALBUM_RELOAD_SWITCH_MAP   
    }
    IFSTR $_scene IS '010_primula' {
        _amap=house_cliff
        _apos=AREA_near_grave
        PVV_ABSOLUTE 10
        DANGER 10 1
        <LOAD>
        @___House/_album_switch_map $_amap R $_apos 
        CHANGE_EVENT2 s03_8a
        <NOLOAD>

        GOTO ALBUM_RELOAD_SWITCH_MAP   
    }
    IFSTR $_scene IS '011_primula' {
        _amap=house_road
        _apos=Ev_pvv11_foot_noel
        GFC_SET PRM3 0
        PVV_ABSOLUTE 11
        DANGER 11 1
        <LOAD>
        PIC_FILL	&3 DARK
        @___House/_album_switch_map $_amap L $_apos 
        CHANGE_EVENT2 s04_6a
        <NOLOAD>

        GOTO ALBUM_RELOAD_SWITCH_MAP   
    }
    IFSTR $_scene IS '102_alma' {
        _amap=forest_ruin_station
        _apos=Ev_alma_r
        PVV_ABSOLUTE 101
        DANGER 5 1
        <LOAD>
        @___House/_album_switch_map $_amap R $_apos 
        #< alma >!
        CHANGE_EVENT2 s12_2a
        <NOLOAD>

        GOTO ALBUM_RELOAD_SWITCH_MAP   
    }
    IFSTR $_scene STARTS '106_tigrina_garage' {
        GFC_SET TIG0 3
        GFC_SET TIG1 2
        _amap=school_in_garage
        _apos=Ev_tig
        PVV_ABSOLUTE 106
        GFC_SET TIG2 0
        <LOAD>
        @___House/_album_switch_map $_amap R $_apos 
        GFC_SET TIG1 1
        CHANGE_EVENT2	___Tigrina/t10
        <NOLOAD>

        GOTO ALBUM_RELOAD_SWITCH_MAP   

    }
    IFSTR $_scene IS '104_mepha' {
        CHANGE_EVENT2 s13_4b
    }
    IFSTR $_scene IS '100_restroom' {
        <LOAD>
        @___Other/still bg/bg_restroom
        CHANGE_EVENT2 s10_3a
        <NOLOAD>
    }
    IFSTR $_scene IS '105_classroom' {
        PVV_ABSOLUTE 105
        GFC_SET ALM0 1
        CHANGE_EVENT2	105/main_classroom 
    }
    ELSIFSTR $_scene STARTS '105_2weekattack' {
        #SND_LOAD ev_2weekattack
        PVV_ABSOLUTE 105
        CHANGE_EVENT2 ___city/2weekattack_00
        GOTO ALBUM_RELOAD_SWITCH_MAP   
    }
    // ========================
    DOTL
    ALLOW_SKIP
    WAIT 70
} ELSIFSTR $_album_categ IS 'TROOM' {
    // memory
    HIDE_BLURSC
    @___Other/fatal $_scene 1 1
} ELSIFSTR $_album_categ IS 'FATAL' {
    // memory
    LABEL FATAL
    HIDE_BLURSC
    @___Other/fatal $_scene 1 1
} ELSIFSTR $_album_categ IS 'OSOK' {
    // memory
    DENY_SKIP
    START_GMAIN
    PIC_FILL	&1 DARK
    PIC_FADEIN	&1 50
    STOP_BGM 100 0
    PE_FADEINOUT BLUR 60 10 0.9 0
    TL 40 HIDE_BLURSC
    WAIT 60
    ALLOW_SKIP
    TL 10 PIC_FADEOUT	&1 70
    IFSTR $_scene IS '106_sneaking_mistake' {
        GFC_SET TIG0 0
        _amap=school_in_armory
        _apos=Ev_RRB
        PVV_ABSOLUTE 10
        DANGER 10 1
        <LOAD>
        @___House/_album_switch_map $_amap R $_apos 
        CHANGE_EVENT2 ___Tigrina/106sneak__aware album $_scene_index
        <NOLOAD>

        GOTO ALBUM_RELOAD_SWITCH_MAP   
    }
    WAIT 120
}

GOTO ALBUM_RELOAD


// SELECTARRAY_CLEAR
// SELECT_FOCUS_RANDOM_TALK scenemem
// fatal_key=
// IF 'sensitive_level>=2' {
//     fatal_key=S
// }

// _already=~fatal_watched[snake]
// IF '('$_already'||PVV>=103)' {
//     SELECTARRAY	&&Fatal_snake snake $fatal_key $_already
// }

// IF 'PVV>=105' {
//     SELECTARRAY	&&Talker_Mepha ev_mepha '' 1
// }
// SELECTARRAY	&&Cancel _cancel c

// SELECT	-1 _

// IFSTR $_ IS _cancel {
//     SEEK_END
// }
// IFSTR $_ IS ev_mepha {
//     PIC_FILL	&1 DARK
//     PIC_FADEIN	&1 40
//     STOP_BGM	150 0
//     WAIT 40
//     STOP_GMAIN
//     LOAD_BGM	BGM_morinokioku 
//     CHANGE_EVENT s13_4b
// }


// CHANGE_EVENT	___Other/fatal $_ 1 1
