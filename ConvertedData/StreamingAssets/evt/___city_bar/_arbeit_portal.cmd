DEFINENDEF 1=0
#SND_LOAD ev_restroom
_foc_default=0


_talk_skip=0
_reselect=0
IF $1'==-1' {
    _talk_skip=1 
    #MS_ Barten '>>[Ev_counter -32,0] @L P[bar_stand~]'
    GOTO CLOTH_CHANGED
}
IF $1'==0' {

    _talk_skip=1 
    GOTO TALK_END
}
// 初回語り

_qf=~quest_progress_f[subquest_mount_cocktail]

IF $_qf'<=0' {
    // 初回
    PIC   bt P0/a0L1R2__F1__e1    
    
    PIC   n a_2/a0L1R3__F2__f2__m1__b5_u2    
    MSG	n_00 

PIC   bt P0/a0L2R1__F1__e2    
    MSG	bt_01 

    PIC   n a_3/a0__F1__f3__m1__b4_u0    
    MSG	n_02 

PIC   bt P0/a0L1R1__F2__e2    
    MSG	bt_03 


    PIC   n a_1/a22__F1__f1__m1__b1__u3    
    MSG	n_04 
    
PIC   bt P0/a0L2R1__F3__e2    
    MSG	bt_05

    PIC   n a_1/a00L1R1__F1__f1__m1__b2__uo    
    PIC_MP n SWT
    MSG	n_05 

PIC   bt P0/a0L1R3__F1__e3    
    MSG	bt_06 

PIC   bt P0/a0L4R1__F1__e1    
    MSG	bt_07 

    @_PIIN
    PIC   n a_3/a1__F1__f3__m1__b2_u5    
    PIC_MP n EXQ
    PIC_MOVEA	n 2 JUMP
    
    MSG	n_08 I  

PIC   bt P0/a0L2R3__F2__e3    
    MSG	bt_09 

    PIC   n a_1/a00L1R1__F1__f1__m1__b3__u1    
    PIC_MP n HOT

    MSG	n_10 

PIC   bt P0/a0L1R4__F1__e2    
    TL 55 PIC   n a_1/a00L1R1__F1__f1__m1__b1__u1    
    TL 55 PIC_MP n  SWT2
    MSG	bt_11 


    QUEST_PROGRESS subquest_mount_cocktail 1
    SHOW_QUEST_PROGRESS 1
    _foc_default=1
}

LABEL TALK_END

CLEARTL
PIC_HIDE_ALL	 


MGM_BUN_LOAD
SHOW_BLURSC
WAIT 25
_costume=-1

MGM_BUN_INITIALIZE // costume select

IF $_costume'==-1' {
    WAIT 20
    HIDE_BLURSC
    _reselect=1
    SEEK_END

}

HIDE_BLURSC
_insert_in_costume_change=
IF $_qf'<4&&'$_qf'>=2&&!SfEvt[___city_bar/_arbeit_pretalk_0]' {
    // 2回目以降
    WAIT 20
    CHANGE_EVENT2 ___city_bar/_arbeit_pretalk_0
   
} ELSIF $_qf'>=4&&!SfEvt[___city_bar/_arbeit_pretalk_1]' {
    // クリア
    WAIT 20
    CHANGE_EVENT2 ___city_bar/_arbeit_pretalk_1
}
#SND_LOAD minigame
// お着替え ========================================================================

@___city_bar/_arbeit_change_cloth
// __ お着替え終わり
LABEL CLOTH_CHANGED
HIDE_BLURSC 1
PE ZOOM2 1
#MS_ % '= >>[Ev_backyard_door 20,0] @R P[walk] >>[#<Barten> -50,0 :140 ] P[stand]'
TL 60 LP_DEACTIVATE_TO_CHIP Ev_backyard_door
PIC_FADEOUT  #9 50
WAIT 120
DOTL

MSG_LEFT_DEFAULT 0.3
MSG_RIGHT_DEFAULT 0.05
//================================================
_hide_picture=0
IF '!mgm_suit_bunnyrev' {
    IF '!GFB[BUN_BUNNY_FIRST]' {
        GFB_SET BUN_BUNNY_FIRST 1
        _hide_picture=1
        CHANGE_EVENT2 ___city_bar/_arbeit_first_cloth 0
    }
} ELSE {
    IF '!GFB[BUN_BUNNYREV_FIRST]' {
        GFB_SET BUN_BUNNYREV_FIRST 1
        _hide_picture=1
        CHANGE_EVENT2 ___city_bar/_arbeit_first_cloth 1
    }
    
}


_reselect=0
_rule_flag=0
IF $_hide_picture {
    LABEL _RESELECT_ARBEIT_RULE
    @___city_bar/_arbeit_noel_hkds -1
    PIC_HIDE_ALL	T#&
}
LABEL _RESELECT_ARBEIT
MGM_UI_ACTIVATE BUNNY

SELECTARRAY_CLEAR
SELECT_POS 
SELECTARRAY &&Select_arbeit_start STARTGAME B
SELECTARRAY &&Select_arbeit_rule0 CHECKRULE0 '' ~($_rule_flag&1)
SELECTARRAY &&Select_arbeit_rule1 CHECKRULE1 '' ~($_rule_flag&2)
SELECTARRAY &&Select_arbeit_rule2 CHECKRULE2 '' ~($_rule_flag&4)
SELECTARRAY &&Select_nothanks_mini_game _SKIP C
SELECT_FOCUS $_foc_default
SELECT -1 _result

MGM_UI_DEACTIVATE


// __ お着替え直す
IFSTR $_result IS '_SKIP' {
    LABEL _SKIP
    PIC_HIDE_ALL	
    
    PE ZOOM2 70
    MGM_BUN_QUIT
    WAIT 20
    __mgm_bun_active=0
    HALF_BGM	0
    SEEK_END
}

IFSTR $_result IS 'CHECKRULE0' {
    CHANGE_EVENT2     ___city_bar/_arbeit_rule 0
    _rule_flag=~$_rule_flag|1
    _foc_default=2
    GOTO _RESELECT_ARBEIT_RULE
}
IFSTR $_result IS 'CHECKRULE1' {
    CHANGE_EVENT2     ___city_bar/_arbeit_rule 1
    _rule_flag=~$_rule_flag|2
    _foc_default=3
    GOTO _RESELECT_ARBEIT_RULE
}
IFSTR $_result IS 'CHECKRULE2' {
    CHANGE_EVENT2     ___city_bar/_arbeit_rule 2
    _rule_flag=~$_rule_flag|4
    _foc_default=0
    GOTO _RESELECT_ARBEIT_RULE
}

IFSTR $_result IS 'STARTGAME' {
    PE ZOOM2 70
    PE ZOOM2 -1
    #< Barten >
    _arbeit_play=1
    MGM_BUN_INIT_GAME ___city_bar/_arbeit_end_game ___city_bar/_arbeit_omorashi
    HALF_BGM	0
    SEEK_END
}


GOTO _RESELECT_ARBEIT
