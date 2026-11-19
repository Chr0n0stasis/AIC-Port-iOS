// キャラバンのバー ヴァーロス
GREETING	R 20
#MS '@#[%::48]'

WAIT 20
TALKER	w L     
TALKER	n R  

IF '(GFC[WLR_G]&1)==0' {
    GFC_SET	 WLR_G  |=1
    IF 'GFC[WLR1]==0' {
        // 岩破壊後話しかけていない
        GFC_SET_MX WLR1 1
        CHANGE_EVENT2 ___city/bar_w_s12_10a
        CHANGE_EVENT2 ___mountain/_caravan_bar_w_t00 1
        PIC_HIDE s
        TALKER	w L     
        TALKER	n R  

    } ELSE {
        CHANGE_EVENT2 ___mountain/_caravan_bar_w_t00 0
    }
} ELSE {

    PIC   n a_1/a22__F1__f1__m1__b1__u0    
   PIC   w w/a0L2R1__F2__f2__m1__e1__u1    
}



LABEL LETSTALK
SELECTARRAY_CLEAR
SELECT_FOCUS_RANDOM_TALK 200wlr_g_w


_already=~SfEvt[___city/bar_w_t_about_td]
SELECTARRAY &&EvTitle_about_td about_td '' $_already

_already=~SfEvt[___city/bar_w_t_forklore]
SELECTARRAY &&EvTitle_forklore forklore '' $_already
_already_similar=0
IF $_already {
    _already=~SfEvt[___city/bar_w_t_replacable]
    SELECTARRAY &&EvTitle_replacable replacable '' $_already
    IF '(GFC[WLR_H]&10)!=0' {
        _already=~SfEvt[___city/bar_w_t_similar_person]
        SELECTARRAY &&EvTitle_similar_person similar_person '' $_already
        _already_similar=~$_already
    }
}

_already=~SfEvt[___city/bar_w_t_reincarnation]
SELECTARRAY &&EvTitle_reincarnation reincarnation '' $_already
_prog=~quest_progress_f[subquest_mount_cocktail]
IF $_already {
    IF $_prog'>=4' {
        SELECTARRAY &&EvTitle_primula_is_villain primula_is_villain '' 1
        IF $_already_similar {

            _already=~SfEvt[___city/bar_w_t_forced_lavour]
            SELECTARRAY &&EvTitle_forced_lavour forced_lavour '' $_already
            IF $_already {
                _already=~SfEvt[___city/bar_w_t_reason_walross]
                SELECTARRAY &&EvTitle_reason_walross reason_walross '' $_already
            }
        }
    } ELSE {

        _flag=
        IF $_prog'>=0' {
            _flag=Q 
        }
        // ___city/bar_w_t_primula_is_villain
        SELECTARRAY &&EvTitle_primula_is_villain primula_is_villain $_flag 0
    }
}


SELECTARRAY &&Cancel  
SELECT -1 _evt

IFSTR $_evt IS '&&Cancel' {
    SEEK_END
}

_stop=0
SELECT_RESULT_TO_LOG
ALLOW_SKIP
CHANGE_EVENT2 '___city/bar_w_t_'$_evt
LOG_RECORD
DOTL
IF $_stop {
    SEEK_END
}

GOTO LETSTALK

