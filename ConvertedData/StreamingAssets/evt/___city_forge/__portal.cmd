_focusto=$1
HKDS	fd RT #<$_focusto>
TALKER_REPLACE	fd Mob talk_mob_w2
HKDS	n CCLT #<Noel>
__select_default=0

GREETING	L 15
// #MS_ $1 '@#[%::40]'
// UI_GUILDQUEST_REFINE
WAIT 20

IF 'GFC[FORGE0]==0' {
    CHANGE_EVENT	___city_forge/t00
    // END
} ELSIF 'GFC[MOB7]==0&&noel_cane_itemdrop' {
    GFC_SET MOB7 1
    CHANGE_EVENT2	___city_forge/t_no_src_cane
    WAIT 20

} ELSIF 'GFB[FORGE_GET_HOLDER]==0&&ItemCategoryHas[@CANE][4]>0' {
    CHANGE_EVENT2 ___city_forge/t_prize_holder 1
}




LOG_RECORD
IF 0 {
    LABEL _RESELECT
    WAIT 20
}

SELECTARRAY_CLEAR
IF 'GFC[FORGE0]<4' {
    SELECTARRAY	&&Select_forge_choose UI 
    SELECTARRAY	&&Select_forge_buy WANNA_BUY
    IF $__select_default'>0' 
        __select_default=~$__select_default+1
    _flag_buyable=BUY_LISTEN
    SELECTARRAY	&&Select_guild_talk LETSTALK
} ELSE {
    SELECTARRAY	&&Select_forge_choose_buy UI 
    _flag_buyable=BUY
    SELECTARRAY	&&Select_guild_talk2 LETSTALK

}
SELECTARRAY	&&Select_nothanks _END
SELECT_FOCUS	$__select_default


SELECT	-1 _label
MSG_HIDE
GOTO $_label
// ========================
LABEL UI
__select_default=0
#< smith >
#PTCST_PREFIX _nosnd 1 


WAIT 10

_result=
UI_FORGE TESTABLE $_flag_buyable
IFSTR $_result IS 'BUY_LISTEN' {
    GOTO WANNA_BUY
}
IFSTR $_result IS 'TESTFIRE' {
    GOTO TESTFIRE
}
IFSTR $_result IS 'BUY' {
    GOTO REPLACE_OR_BUY
}
IFSTR $_result IS 'REPLACE' {
    GOTO REPLACE_OR_BUY
}
WAIT 10

GOTO _RESELECT
// ========================
LABEL LETSTALK
WAIT 15
_foc_default=1
SELECTARRAY_CLEAR
SELECT_FOCUS_RANDOM_TALK forge

_already=~SfEvt[___city_forge/t_desc_near_punch_speed]
SELECTARRAY &&Cane_graph_near_punch_speed near_punch_speed '' $_already
_already=~SfEvt[___city_forge/t_desc_near_reach]
SELECTARRAY &&Cane_graph_near_reach near_reach '' $_already
_already=~SfEvt[___city_forge/t_desc_near]
SELECTARRAY &&Cane_graph_near near '' $_already
_already=~SfEvt[___city_forge/t_desc_far]
SELECTARRAY &&Cane_graph_far far '' $_already
_already=~SfEvt[___city_forge/t_desc_lockon]
SELECTARRAY &&Cane_graph_lockon lockon '' $_already
_already=~SfEvt[___city_forge/t_desc_stability]
SELECTARRAY &&Cane_graph_stability stability '' $_already
_already=~SfEvt[___city_forge/t_desc_mp_use_ratio]
SELECTARRAY &&Cane_graph_mp_use_ratio mp_use_ratio '' $_already
_already=~SfEvt[___city_forge/t_desc_neutral]
SELECTARRAY &&Cane_graph_neutral neutral '' $_already
_already=~SfEvt[___city_forge/t_desc_casttime]
SELECTARRAY &&Cane_graph_casttime casttime '' $_already

IF 'GFC[FORGE0]>=4'  {

    _already=~SfEvt[___city_forge/t_desc_buy]
    SELECTARRAY &&EvTitle_t_desc_buy buy '' $_already
    

    _already=~SfEvt[___city_forge/t_desc_switch]
    SELECTARRAY &&EvTitle_t_desc_switch switch '' $_already
    
}


SELECTARRAY &&Cancel &&Cancel C
SELECT_FOCUS	-1
SELECT -1 _evt
IFSTR $_evt IS '&&Cancel' {
    GOTO _RESELECT
}
SELECT_RESULT_TO_LOG
ALLOW_SKIP

SF_SET 'EV____city_forge/t_desc_'$_evt 1
IFSTR $_evt IS 'switch' {
    CHANGE_EVENT2 ___city_forge/t_desc_switch
} ELSE {
    MSG '___city_forge/t_desc_'$_evt'*fd_00'

}
LOG_RECORD



DOTL
GOTO LETSTALK


// ========================
LABEL WANNA_BUY

WAIT 20
CHANGE_EVENT	___city_forge/t_buy00



// ========================
LABEL REPLACE_OR_BUY
DENY_SKIP
WAIT 20
#MS_ % '>+[-70,0 :80]'
STOP_BGM	90 0
WAIT 20
PIC_FILL	#9 DARK
PIC_FADEIN	#9 60
WAIT 65

CHANGE_EVENT ___city_forge/__buy_or_replace


SEEK_END
// ========================
LABEL TESTFIRE
IFSTR $_cane ISNOT '' {
    // 試し撃ち開始
    DENY_SKIP
    #MS_ % '>+[70,0 :80]'
    INIT_MAP_MATERIAL city_in_forge_testfire 1
    WAIT 20
    PIC_FILL	#9 DARK
    PIC_FADEIN	#9 60

    WAIT 65
    GFB_SET FITTING 1
    WAIT_FN MAP_TRANSFER 
    NEL_MAP_TRANSFER city_in_forge L !ExitD_forgefst
    PIC_FADEOUT	#9 50

    DENY_FASTTRAVEL
    FORGE_TESTFIRE_INIT $_cane $_cane_grade

    // LP_ACTIVATE_TO_CHIP door ExitD_forgefst

    #MS_ % '>+[-40,0 :50]'
    WAIT_MOVE

    SEEK_END
}


// ========================
LABEL _END
