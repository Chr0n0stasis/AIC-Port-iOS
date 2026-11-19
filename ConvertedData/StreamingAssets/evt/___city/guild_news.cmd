DEFINENDEF 1=@

GREETING	$1 -45
_evt_p104_phase=0
_evt_p200claim_phase=0
TALKER	n L   

LABEL RESELECT

SELECTARRAY_CLEAR
SELECT_FOCUS_RANDOM_TALK guild_news


IF 'PVV<=106' {
    _already=~SF[city_guild_news_p104_nusi]
    SELECTARRAY &&EvTitle_news_p104_nusi p104_nusi '' $_already
}
IF 'PVV==107' {
    _already=~SF[city_guild_news_p107_td]
    SELECTARRAY &&EvTitle_news_p107_td p107_td '' $_already
}

IF '200<=PVV&&PVV<300' {
    _already=~SF[city_guild_news_p200_lost]
    SELECTARRAY &&EvTitle_news_p200_lost p200_lost '' $_already

    IF 'PVV<210&&!MagicHas[FLOWERYCIRCLE]' {
        _already=~SF[city_guild_news_p200_claim]
        SELECTARRAY &&EvTitle_news_p200_claim p200_claim '' $_already
    }

    _already=~SF[city_guild_news_p200_spider]
    SELECTARRAY &&EvTitle_news_p200_spider p200_spider '' $_already
}

IF 'PVV<300' {
    
    _already=~SF[city_guild_news_p105_lost]
    SELECTARRAY &&EvTitle_news_p105_lost p105_lost '' $_already
}

//=========== 広告欄 =============

IF 'PVV<=106' {
    _already=~SF[city_guild_news_ad_p104]
    SELECTARRAY &&EvTitle_news_ad ad_p104 '' $_already
} ELSIF 'PVV<210&&!MagicHas[FLOWERYCIRCLE]' {
    _already=~SF[city_guild_news_ad_p107]
    SELECTARRAY &&EvTitle_news_ad ad_p107 '' $_already
} ELSIF 'PVV<400' {
    _already=~SF[city_guild_news_ad_p205]
    SELECTARRAY &&EvTitle_news_ad ad_p205 '' $_already
}

// ========================
SELECTARRAY &&Cancel &&Cancel C
SELECT -1 _evt

IFSTR $_evt IS '&&Cancel' {
    SEEK_END
}

SELECT_RESULT_TO_LOG
ALLOW_SKIP
SF_SET 'city_guild_news_'$_evt 1
IFSTR $_evt IS 'p104_nusi' {
    TX_BOARD ___city/guild_board_105*board FRAMED_PAPER
    IF $_evt_p104_phase'==0' {
        _evt_p104_phase=1
        WAIT 20

        PIC   n a_1/a00L3R1__F1__f1__m3__b1_u0    
        PIC_MP	n SWT 

        MSG ___city/guild_board_105*n_00 T
    }
} ELSE {
    TX_BOARD '___city/guild_news*'$_evt FRAMED_PAPER

    IFSTR $_evt IS 'p200_claim' {
        IF $_evt_p200claim_phase'==0' {
            _evt_p200claim_phase=1
            WAIT 20
            PIC   n a_3/a0__F1__f3__m1__b4_uo    
            MSG n_200 T
        }
    }

}
LOG_RECORD

DOTL
PIC_HIDE_ALL	

GOTO RESELECT
