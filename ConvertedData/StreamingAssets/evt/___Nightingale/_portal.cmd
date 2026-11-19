// ポータル
HALF_BGM
STOP_LOG_RECORD_SELECTION
LOAD_BGM BGM_shopping
IFNDEF 1 {
    1=@
}
_greeting_aim=$1
_bgm_set=1
_bgm_replace_back=1
_already_t_talk_02=~SfEvt[___Nightingale/t_talk02]

GREETING $1 20
<LOAD>
WAIT 5

_nig_only_bag=-1
IF 'GFC[NIG0]==2&&GFC[NIG1]==15' {
    _nig_only_bag=0
} ELSE {
    #MS '@#[%] P[stand] @#[%::50]'
}


WAIT 15
_first_talk=0
IF GFC[NIG3]'==0' { // このマップで初対面である
    GFC_SET NIG3 1
    _first_talk=1
    IF '(GFC[NIG2]&1)==0' {
        IF 'GFC[NIG1]<14' {
            GFC_SET NIG1 +=1
        }
        GFC_SET NIG2 GFC[NIG2]|1
    }
    IF 'GFC[NIG0]==0' { // そもそも初対面
        GFC_SET_MX NIG0 1
        CHANGE_EVENT2 ___Nightingale/t01
        GOTO EVENT_ENDED
    }
}
IF $_nig_only_bag'==0' {
    CHANGE_EVENT2 ___Nightingale/quest00_bag
    IFSTR $_result ISNOT 'CALLBACK' {
        SEEK_END
    }
    GOTO EVENT_ENDED

}
@___Nightingale/_calc_nigscore

IF $_nigscore'>=2 && SfEvt[___Nightingale/t_talk_nusi]==0&&(PVV==104&&GFC[IXA1]>0)' {
    // ヌシ戦アナウンス
    _bgm_set=0
    _bgm_replace_back=0
    CHANGE_EVENT2 ___Nightingale/t_talk_nusi
    GOTO EVENT_ENDED
}
IF 'SfEvt[___Nightingale/t_talk_hpred]==0&&(SerHas[HP_REDUCE]||noel_torned)' {
    // Hp低下
    TL 60 REPLACE_BGM 60 0 0
    _bgm_set=0
    CHANGE_EVENT2 ___Nightingale/t_talk_hpred
    GOTO EVENT_ENDED
}
IF $_first_talk {
    IF 'quest_progress_f[subquest_nightingale_apple]<0&&GFC[NIG0]==1&&'$_nigscore'>=3&&PVV>=103&&!(PVV==104&&GFC[IXA1]>0)&&'$_already_t_talk_02 {
        // クエスト
        TL 60 REPLACE_BGM 60 0 0
        _bgm_set=0
        CHANGE_EVENT2 ___Nightingale/quest00
        GOTO EVENT_ENDED
    }
}

IF FALSE { // イベントが終わったらここで後始末する。
    LABEL EVENT_ENDED
    IFNDEF _nigscore
        @___Nightingale/_calc_nigscore
    DOTL
    LOG_RECORD
    HIDE_BLURSC
    PIC_HIDE_ALL T
    WAIT 25
}
_quest00_prog1=0
_quest00_qp=~quest_progress[subquest_nightingale_apple]
IF '('$_quest00_qp'==0||'$_quest00_qp'==1)&&ItemHas[fruit_epdmg_apple0]>0' {
    _quest00_prog1=1
}

IF $_bgm_set {
    REPLACE_BGM 60 0 0
}

DENY_SKIP
_foc_default=0
PE ZOOM2 60
#MS_ Nightingale '## P[open_store]'

LOG_RECORD
LABEL RESELECT
// ===== ポータルメニュー
TALKER n L
TALKER t R
PIC   t t/a0L2R1__F1__m2_u1__m2_b1    
PIC   n a_1/a22__F1__f1__m1__b1__u0    

HIDE_BLURSC
_qflag=
IF $_quest00_prog1 {
    _qflag=Q
}
_wpltalk=0
DEFINE_WHOLEMAP _wm
IF 'wplmode' {
    IFSTR $_wm IS 'mount' {
        _wpltalk=1
    }
}
SELECTARRAY_CLEAR
SELECTARRAY &&Select_buying BUYING
IF $_wpltalk
    SELECTARRAY &&Select_Talk_wpl LETSTALK $_qflag
ELSE
    SELECTARRAY &&Select_talk LETSTALK $_qflag
SELECTARRAY &&Select_nothanks SKIP
SELECT_FOCUS $_foc_default
SELECT -1

//================================================
// ===== 買い物
LABEL BUYING

#MS_ Nightingale '## P[open_store]'
_foc_default=0
SHOW_BLURSC
PIC_HIDE n
PIC   t t/a0L3R1__F1__m4_u1__m3_b1    

TALKER t RR
DENY_SKIP
WAIT 20
ITEMSTORE Night CL
WAIT 8
ALLOW_SKIP

HIDE_BLURSC
GOTO RESELECT

//================================================
// ===== お話
LABEL LETSTALK
#MS_ Nightingale 'P[stand]'
_foc_default=1
WAIT 15
SELECTARRAY_CLEAR
SELECT_FOCUS_RANDOM_TALK night

_evt_header=___Nightingale/

IF $_wpltalk {
    _evt_header=wpl/

    _already=~SfEvt[wpl/nig_00_weather]
    SELECTARRAY &&EvTitle_wpl_nig_00_weather nig_00_weather '' $_already

    _already=~SfEvt[wpl/nig_01_poison]
    SELECTARRAY &&EvTitle_wpl_nig_01_poison nig_01_poison '' $_already

    _already=~SfEvt[wpl/nig_03_evade]
    SELECTARRAY &&EvTitle_wpl_nig_03_evade nig_03_evade '' $_already
    
    _already=~SfEvt[wpl/nig_04_magic]
    SELECTARRAY &&EvTitle_wpl_nig_04_magic nig_04_magic '' $_already
    
    _already=~SfEvt[wpl/nig_02_athletic]
    SELECTARRAY &&EvTitle_wpl_nig_02_athletic nig_02_athletic '' $_already


    GOTO TALK_START
}


// 名前のはなし
_already=~SfEvt[___Nightingale/t_talk00]
SELECTARRAY &&EvTitle_YourName t_talk00 '' $_already

_already=~SfEvt[___Nightingale/t_talk01]
IF $_nigscore'>=2 ||'$_already {
    SELECTARRAY &&EvTitle_ReasonForMoving t_talk01 '' $_already
}
_already=$_already_t_talk_02
IF $_nigscore'>=3 ||'$_already {
    SELECTARRAY &&EvTitle_Wanted t_talk02 '' $_already
}

_already=~SfEvt[___Nightingale/t_talk_hpred]
IF '(SerHas[HP_REDUCE]||noel_torned) ||'$_already {
    SELECTARRAY &&EvTitle_hp_red t_talk_hpred '' $_already
}
_already=~SfEvt[___Nightingale/t_talk_nusi]
IF '(PVV==104&&GFC[IXA1]>0) ||'$_already {
    SELECTARRAY &&EvTitle_nusi t_talk_nusi '' $_already
}
IF 'quest_progress[subquest_nightingale_apple]<2&&GFC[NIG0]<2' {
    _already=~SfEvt[___Nightingale/quest00]
    IF $_already {
        SELECTARRAY &&EvTitle_nightingale_quest00 quest00 '' 
    }
}
IF $_quest00_prog1 {
    SELECTARRAY &&EvTitle_nightingale_quest00_1 quest00_1 'Q' 
}

LABEL TALK_START

SELECTARRAY &&Cancel &&Cancel C
SELECT -1 _evt

IFSTR $_evt IS '&&Cancel' {
    GOTO RESELECT
}

SELECT_RESULT_TO_LOG
ALLOW_SKIP
CHANGE_EVENT2 $_evt_header$_evt
LOG_RECORD


//================================================
DOTL
GOTO LETSTALK
// ===== さよなら
LABEL SKIP
//<BREAK>
#MS 'q P[stand]'
#MS_ % '##'
IF $_bgm_replace_back REPLACE_BGM 70 80 
HALF_BGM 0
