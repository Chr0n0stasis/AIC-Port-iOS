HKDS	bt    
TALKER	bt R  

MSG_LEFT_DEFAULT 0.3
MSG_RIGHT_DEFAULT 0.05
STOREFLUSH city_bar_arbeit
PIC_B	#8 bg/bg_bar_backyard '' bgcolor
DEFINENDEF 1=0
DEFINENDEF 2=0
DEFINENDEF 3=0
_alloc_infinity_cocktail_force=$3
_omorashi=$1
_talk_infinity=$2
_alloc_infinity_cocktail=0
_money=0
//粗相をして

_cocktail_money=3780

HALF_BGM 0
IF $_omorashi {
    @___city_bar/_arbeit_noel_hkds 23
    PIC   bt P0/a0L2R1__F2__e3    
    PIC_MP2 %6 $_manpu_n BLS|SWT2
    MSG	bt_00 

    MSG	n_01 
PIC   bt P0/a0L1R4__F1__e2    

    MSG	bt_02  R[bt_02_b]

    @___city_bar/_arbeit_noel_hkds -1

}

PIC_HIDE_ALL	T

WAIT 40
HIDE_BLURSC
MGM_BUN_RESULT
IF $_alloc_infinity_cocktail_force {
    _alloc_infinity_cocktail=1
}
// _money に稼いだ金額が入る
UIBOX_MONEY_ACTIVATE BAR_SCORE 
GETMONEY $_money BAR_SCORE
WAIT 20
<LOAD>
WAIT 40
ALLOW_SKIP
STOP_BLURSC_TO_BEHIND


_talk_init=0
_reselecting=0
_select0_pos=CB

IF $_alloc_infinity_cocktail'&&!GFB[BUN_UNLOCK_INFINIT_COCKTAIL]' {
    _reselecting=1
    TALKER	bt R  
    PIC   bt P0/a0L1R3__F1__e2    
    @___city_bar/_arbeit_noel_hkds 0
    GFB_SET BUN_UNLOCK_INFINIT_COCKTAIL 1

    // 十分な額を稼いだ
    MSG	bt_25 

    MTL MSG_SKIPHOLD
    MSG	bt_26 
    GOTO _SELECT0

}
IF 0 {
    LABEL RESELECT0
    _select0_pos=
}
TALKER	bt R  


PIC   bt P0/a0L3R2__F1__e1    
@___city_bar/_arbeit_noel_hkds 4


IF $_reselecting'==0' {
    _reselecting=1
    MTL MSG_SKIPHOLD
    IF 'cur_money[BAR_SCORE]<'$_cocktail_money {
        //カクテル分が溜まってない
            
        MSG	bt_10 
    } ELSE {
        //溜まっている
        MSG bt_20
    }

}

// ================================================

LABEL _SELECT0

SELECTARRAY_CLEAR
SELECT_POS $_select0_pos

SELECTARRAY &&Select_takeout TAKEOUT 
SELECTARRAY &&Select_quit_takeout TALK C 
SELECT_FOCUS 0
SELECT -1 

// ========================
LABEL TAKEOUT
TUTO_REMOVE
MSG_HIDE

@___city_bar/_arbeit_noel_hkds -1
TALKER bt RR
DENY_SKIP
WAIT 20
MGM_BUN_RESULT_STORE CL $_alloc_infinity_cocktail


WAIT 8
ALLOW_SKIP
IF $_buy_money'>0' {
    _cockquest_flag=~quest_progress_f[subquest_mount_cocktail]
    IF $_cockquest_flag'==2' {
        QUEST_CHECK_INVENTORY 1 1
        // QUEST_PROGRESS subquest_mount_cocktail 3
        SHOW_QUEST_PROGRESS 1
    }
    WAIT 10
    GOTO    RESELECT1
}

_reselecting=1

GOTO RESELECT0

// ========================


LABEL TALK
TUTO_REMOVE
MSG_HIDE
WAIT 20
IF '!'$_talk_init {
    _talk_init=1
    PIC   bt P0/a0L2R2__F2__e1    
    MSG	bt_30 

    PIC   bt P0/a0L1R4__F1__e3    
    MSG	bt_31 
    WAIT 30
} ELSE {
    PIC   bt P0/a0L1R4__F1__e3    
}
TX_BOARD *announce_end_result_00 '' N @CT
TX_BOARD_LOCK
WAIT 5
LOG_RECORD

CHANGE_EVENT2 ___city_bar/_barten_talk_more 0
_reselecting=1
TX_BOARD_HIDE

IFSTR $_result STARTS '&&' {
    MSG_HIDE
    IFSTR $_result IS '&&Select_back_to_takeout' {
        GOTO RESELECT0
    }
    IFSTR $_result IS '&&Select_retry_arbeit_talking' {
        _retry=1
        GOTO RETRY_OR_QUIT
    } ELSE {
        _retry=0
        GOTO RETRY_OR_QUIT
    }
}
SELECT_RESULT_TO_LOG
ALLOW_SKIP
UIBOX_MONEY_DEACTIVATE
CHANGE_EVENT2 $_evt_header$_result
LOG_RECORD

IF $_talk_infinity {
    GOTO RESELECT0
}
WAIT 25


WAIT 10
LABEL RESELECT1
// 再開メニュー ================================================
TALKER	bt R   

ALLOW_SKIP
PIC   bt P0/a0L3R2__F1__e1    
@___city_bar/_arbeit_noel_hkds 0
UIBOX_MONEY_DEACTIVATE

MTL MSG_SKIPHOLD
MSG bt_200
SELECTARRAY_CLEAR
SELECT_POS 
SELECTARRAY &&Select_retry_arbeit 1
SELECTARRAY &&Select_quit_arbeit 0 C
SELECT_FOCUS 
SELECT -1 _retry

LABEL RETRY_OR_QUIT
UIBOX_MONEY_DEACTIVATE
MSG_HIDE
TUTO_REMOVE
__mgm_bun_active=1
#CMDRELOAD	IMMEDIATE IMMEDIATE_LOAD 
#MS_ Barten '>>[Ev_counter 2,0]'
ALLOW_SKIP
PIC_HIDE_ALL T
@___city_bar/_arbeit_noel_hkds -1

PIC_FILL &9 DARK
PIC_FADEIN &9 50
WAIT 60


PIC_HIDE_ALL	'' 1
PIC_FILL &10 DARK


IF $_retry'==1' {
    _arbeit_play=0
    PIC_FILL  #9 DARK
    PIC_FADEOUT &10 50
    
    CHANGE_EVENT2 ___city_bar/_arbeit_portal -1
    IF $_arbeit_play'==1' {
        SEEK_END
        
    }

    CHANGE_EVENT2	___city_bar/_arbeit_change_cloth_back
} ELSE {
    DENY_SKIP
    #MS_ % '= >>[Ev_backyard_door.b 20,0]'
    PIC_FADEOUT &10 50
    CHANGE_EVENT ___city_bar/_arbeit_change_cloth_back 1
}
