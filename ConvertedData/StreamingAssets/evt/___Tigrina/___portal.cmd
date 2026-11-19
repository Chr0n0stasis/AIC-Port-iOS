MSG_PREFIX so <tigrina>
__unusual=0

GREETING	L 35
#< tigrina > 
IF 'PVV==107' {
    // TD最中
    __unusual=1
    IF '(GFC[TIG2]&1)==0' {
        GFC_SET TIG2 1
        CHANGE_EVENT2	___Tigrina/t_107_not_here
        
    }
} ELSE {

    #MS '@#[%::40]'
    IF 'GFC[OOP0]==2&&SfEvt[___Tigrina/t_ooparts02]==0' {
        CHANGE_EVENT2	___Tigrina/t_ooparts02
        WAIT 15
    }
    IF 'GFC[OOP0]==4&&SfEvt[___Tigrina/t_ooparts04]==0' {
        CHANGE_EVENT2	___Tigrina/t_ooparts04
        WAIT 15
    }
}
<LOAD>

_foc_default=0
_alloc_fgenemy=0
_autosave=0
_cc_guest_enabled=~GFB[SMNC_CC_GUEST_ENABLED]

// 勝利時イベント
IFDEF _BAREA {
    WAIT 40
    GOTO SMNC
}
WAIT 20

DENY_SKIP
_foc_default=0
LOG_RECORD
LABEL RESELECT

TALKER n L
TALKER so R
IF $__unusual'==0' {
    PIC   n a_1/a22__F1__f1__m1__b1__u0    
    PIC   so so1/a0L1R1__F1__f1__m1__e1_u1    
}
HIDE_BLURSC

LABEL RESELECT_NOCREATE
SELECTARRAY_CLEAR
SELECTARRAY &&Select_smnc SMNC
IF $__unusual'==0' {

    _q=
    IF 'GFC[OOP0]==5' {
        _q=Q 
    }
    SELECTARRAY &&Select_talk LETSTALK $_q
} ELSE {
    SELECTARRAY &&Select_return_BGM RETURN_BGM 

}
SELECTARRAY &&Select_nothanks SKIP
SELECT_FOCUS $_foc_default
SELECT -1


// ========================
LABEL SMNC
GFB_SET SMNC_RESTORE_ITEMS 0
_foc_default=0
#PHY 0
PIC_HIDE_ALL	 

#MS '@R'

// SMNCREATOR TARGET_SCRIPT 
SMNCREATOR TARGET_SCRIPT
SMNCREATOR PREPARE SmnC_garage ___Tigrina/___after_summoner $_cc_guest_enabled
IF $_result'==-1' {
    // game end
    SEEK_END
}
IF $_result'==1' {
    // SMNC opened
    IF 'GFB[SMNC_RESTORE_ITEMS]' {
        ITEMMNG_PUSH_BYTES
    }
    SEEK_END
}
#MS '@#[%::40]'
GOTO RESELECT

// ========================
// ===== お話
LABEL LETSTALK
_foc_default=1
WAIT 15

SELECTARRAY_CLEAR
SELECT_FOCUS_RANDOM_TALK tigrina
IF '(ItemHas[recipe_collection]&&GFB[FG_ENEMY]==0)||'$_alloc_fgenemy {
    // _already=~SfEvt[___Tigrina/t_fg_enemy]
    _already=~GFB[FG_ENEMY]
    _alloc_fgenemy=1
    SELECTARRAY &&_NelItem_name_recipe_collection t_fg_enemy '' $_already

}

_already=~SfEvt[___Tigrina/t_unlock_enemy]
SELECTARRAY &&EvTitle_t_unlock_enemy t_unlock_enemy '' $_already

_already=~SfEvt[___Tigrina/t_enemydrop]
SELECTARRAY &&EvTitle_t_enemydrop t_enemydrop '' $_already

IF $_already {
    _already=~SfEvt[___Tigrina/t_elecboard]
    SELECTARRAY &&EvTitle_t_elecboard t_elecboard '' $_already
}

IF 'PVV>=200' {
    _already=~SfEvt[___Tigrina/t_after_td]
    SELECTARRAY &&EvTitle_t_after_td t_after_td '' $_already
}
IF 'GFC[OOP0]==2||GFC[OOP0]==3' {
    _already=~SfEvt[___Tigrina/t_ooparts02]
    SELECTARRAY &&Select_ooparts t_ooparts02 '' $_already
}

IF 'GFC[OOP0]>=4' {
    _already=~SfEvt[___Tigrina/t_ooparts04]
    _q=
    IF 'GFC[OOP0]==5' {
        _q=Q 
    }
    SELECTARRAY &&Select_ooparts t_ooparts04 $_q $_already
}


SELECTARRAY &&Cancel &&Cancel C
SELECT -1 _evt
IFSTR $_evt IS '&&Cancel' {
    GOTO RESELECT
}

SELECT_RESULT_TO_LOG
ALLOW_SKIP
_reselect=0
CHANGE_EVENT2 '___Tigrina/'$_evt
LOG_RECORD
IF $_reselect'==1' {
    GOTO RESELECT
}

GOTO LETSTALK

// ========================
// ===== お話
LABEL RETURN_BGM
WAIT 10
LOAD_BGM BGM_tigrina
WAIT 10
REPLACE_BGM	20 20 0
GOTO RESELECT_NOCREATE
// ========================
LABEL SKIP
