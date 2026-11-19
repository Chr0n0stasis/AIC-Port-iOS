
GREETING	L 20
#MS '@#[%::48]'

IF 'GFC[WLR1]==0' {
    // 岩破壊後話しかけていない
    GFC_SET	 WLR_G  |=1
    GFC_SET_MX WLR1 1
    CHANGE_EVENT2 ___city/bar_w_s12_10a
    CHANGE_EVENT2 ___mountain/_caravan_bar_w_t00 1
    IF 'quest_progress_f[p200_elec_facil]<2' {
        GFC_SET_MX WLR1 8
    }
    SEEK_END
}

TALKER	s R  
TALKER	n L   

IF 'GFC[WLR_G]&8==0' {
    // オストレア初回
    GFC_SET WLR_G |=8
    CHANGE_EVENT2	___mountain/_caravan_bar_s_t00
} ELSE {

    PIC   n a_1/a22__F1__f1__m1__b1__u0    
   PIC   s s/a0L1R1__F1__f1__m1__e1__u3    
}


LABEL LETSTALK
SELECTARRAY_CLEAR
SELECT_FOCUS_RANDOM_TALK 200wlr_g_s

_already=~SfEvt[___city/bar_s_t_about_td]
SELECTARRAY &&EvTitle_about_td about_td '' $_already

IF 'SfEvt[___city/bar_w_t_similar_person]&&quest_progress_f[subquest_mount_cocktail]<4' {
    _already=~SfEvt[___city/bar_s_t_secret_talk]
    SELECTARRAY &&EvTitle_secret_about_walross secret_talk '' $_already

}



SELECTARRAY &&Cancel  
SELECT -1 _evt

IFSTR $_evt IS '&&Cancel' {
    SEEK_END
}

_stop=0
SELECT_RESULT_TO_LOG
ALLOW_SKIP
CHANGE_EVENT2 '___city/bar_s_t_'$_evt
LOG_RECORD
DOTL
IF $_stop {
    GOTO SEEK_END
}

GOTO LETSTALK

