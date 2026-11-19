// TowerDefence Portal
// 1: walk from left
// 2: memory (available bomb)
_debug_bgm_c=0
LOG_RECORD

HKDS	n    
DENY_SKIP
SHOW_QUEST_PROGRESS
SHOW_LOGBOX
DEACTIVATE_PUTTED_MAGIC 1
STOP_IGNORE_PLAYER_ATK_BUFF

IFDEF _td_autosave {

}

DEFINENDEF 1=0
DEFINENDEF 2=0
DEFINENDEF 3=0
_fromleft=$1
_in_memory=$2
_edit_file=$2
_no_replace_bgm=$3
PIC_HIDE_ALL	'' 1
PIC_FILL #9 DARK
IF '!'$_fromleft {
    WAIT 10
}
START_LETTERBOX

ALLOW_PR_CANE_SWITCH
ALLOW_FASTTRAVEL
IF $_in_memory {
    DENY_FASTTRAVEL
    IF '(GFC[P107_MEM]&3)==3' {
        GOTO _PHASE3
    }
    IF '(GFC[P107_MEM]&3)==2' {
        GOTO _PHASE2
    }
    GOTO _PHASE1
}

IF '(GFC[IXA1]&8)==8' {
    LABEL _PHASE3
    _bgm_dep_block=E
    _target_script=school_106td_02
    SMNCREATOR TARGET_SCRIPT $_target_script
    SMNCREATOR AFTER_EV_VAR2 -3
    DANGER_MANUAL 1 1
    SMNCREATOR NEED_GRAVITY_CANNON
    IF 'PVV==107' {
        SMNCREATOR TD_ALMA citycaster_sub_l
    }
} ELSIF '(GFC[IXA1]&4)==4' {
    LABEL _PHASE2
    _bgm_dep_block=D
    SMNCREATOR TARGET_SCRIPT school_106td_01
    SMNCREATOR AFTER_EV_VAR2 -2

    DANGER_MANUAL 0.5 1
} ELSE {
    IF '!'$_in_memory'&& (GFC[IXA1]&1)==0' {
        SMNCREATOR   TD_FIRST_SHOW_RULE 1
    }
    LABEL _PHASE1
    _bgm_dep_block=C
    SMNCREATOR TARGET_SCRIPT school_106td_00
    SMNCREATOR AFTER_EV_VAR2 -1
    DANGER_MANUAL 0 1
}

WAIT 2
PIC_FADEOUT #9 50
LOAD_BGM	 BGM_towerdefence 
LP_DEACTIVATE_TO_CHIP ExitD_groundh


#< td_init >
IF $_fromleft { 
    #MS_ % 'q ## >>[ExitL_toground.B 30,-20] #; >>[ExitL_toground.b 190,0 <<0.1] @R'
    WAIT_MOVE
    WAIT 20
} ELSE {
    #MS_ % 'q ## >>[ExitL_toground.B 190,-20] #; @R'
    WAIT 50
}
IFDEF _td_autosave {
    AUTO_SAVE 1
}
// #REMOVE load_once

<LOAD>

DENY_DANGER_ITEM_USE
IF $_in_memory {
    ALLOW_DANGER_ITEM_USE
    SMNCREATOR EDITABLE_ENEMY_ATTR 1
}

LP_ACTIVATE WalkDecline_R 
// LP_DEACTIVATE ExitL_toground 
LP_DEACTIVATE ExitR_caveT
// LP_ACTIVATE WalkDecline_L
// LP_DEACTIVATE ExitD_groundh

REPLACE_BGM	5 0 1
IF '!'$_no_replace_bgm {
    BGM_GOTO_BLOCK A

}

_result=0
_gm_open=0

MAPTITLE_HIDE 1
CITYCASTER_LOAD 1
// TowerDefence UI定義
TITLECALL_HIDE 
SMNCREATOR PREPARE_TD SmnC_td 107/___after_summoner $_edit_file
_107_first=1
IF $_result'==-1' {
    SEEK_END
}

IF $_result'==1' {
    // start
    IF $_debug_bgm_c {
        BGM_GOTO_BLOCK C
    } ELSE {
        BGM_GOTO_BLOCK $_bgm_dep_block
    }
    IF 'PVV<200' {
        GFC_SET IXA1 |=1
    }
    DENY_FASTTRAVEL
    DENY_WARPINJECTION
} ELSE {

    IF 'PVV>=200' {
        CHANGE_EVENT	107/_memory_finish
    }
    ALLOW_SKIP
    SMNCREATOR DEACTIVATE_UI
    IFDEF _CANCELCMD {
        CHANGE_EVENT	107/_td_cancel $_CANCELCMD
    }
    
}
