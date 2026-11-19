// バーテンダーポータル
GREETING	L  18
ENGINE_NNEA Barten ALLOW_PLAY_SOUND

// MOB9 
// bit 2 :バイト話初回
// bit 4 :込み入った話初回
// bit 8 :マップでの会話対面
__cloth_changed=0

#< Barten >
ENGINE_NNEA Barten TALK
// #MS 'q ## @L w40 P[bar_stand~]'
PE ZOOM2 60

_def=0
_first=1
WAIT 20
LABEL RESHOW
TALKER	bt R   
TALKER	n L   
 
IF 'SerHas[DRUNK]' {
    PIC   n a_3/a1__F1__f3__m6__uo    
    PIC_MP	n BLS 
    
} ELSE {
    PIC   n a_1/a22__F1__f1__m1__b1__u0    
}
PIC   bt P0/a0L1R2__F1__e1    
HKDS	bt '' '' 

IF '(GFC[MOB9])==0&&'$_first {
    GFC_SET MOB9 |=8 
    _first=0
    MSG bt_00   
}




LABEL LETSTALK
SELECTARRAY_CLEAR

#< % > 
// SELECTARRAY &&Select_buy_order _ORDER
SELECTARRAY &&Select_buy_order _ORDER_RESTAULANT
IF 'SerHas[DRUNK]' {
    SELECTARRAY &&Select_drunker ___city_bar/_barten_t_drunk
} ELSE {
    IF 'GFC[BRT0]==0' {
        SELECTARRAY &&Select_ask_you_are_monster0 ___city_bar/_barten_t00
    }
    IF 'GFC[BRT0]==1' {
        SELECTARRAY &&Select_ask_you_are_monster1 ___city_bar/_barten_t01
    }
    IF 'GFC[BRT0]==2' {
        SELECTARRAY &&Select_ask_you_are_monster2 ___city_bar/_barten_t02
    }
    IF 'GFC[BRT0]==3' {
        SELECTARRAY &&Select_ask_you_are_monster3 ___city_bar/_barten_t03
    }
}

IF 'PVV>=200' {
    SELECTARRAY &&Select_talk_more _TALK_MORE
}

_qf=~quest_progress_f[subquest_mount_cocktail]
IF $_qf'>=0' { //////
    _flag=
    IF $_qf'<4' {
        _flag=Q
    }
    IF $_qf'==0' {
        SELECTARRAY &&Select_takeout_liquir _ARBEIT $_flag
    } ELSE {
        SELECTARRAY &&Select_arbeit _ARBEIT $_flag

    }
}
SELECTARRAY &&Cancel _CANCEL C
SELECT_FOCUS $_def

SELECT -1 _sres

// ========================
IFSTR $_sres IS '_ORDER' {

    _def=0

    SHOW_BLURSC
    TALKER bt RR
    PIC_HIDE n
    PIC   bt P0/a0L3R3__F2__e1    
    IF '!store_already_created[city_bar][_DRINK2]' {
        STOREFLUSH city_bar
    }
    
    ITEMSTORE city_bar CL
    WAIT 8
    ALLOW_SKIP
    HIDE_BLURSC
    GOTO RESHOW
} ELSIFSTR $_sres IS '_ORDER_RESTAULANT' {
    _def=0
    SHOW_BLURSC
    PIC_HIDE n
    PIC_HIDE bt
    IF '!store_already_created[city_bar][_DRINK2]' {
        STOREFLUSH city_bar
    }
    
    
  DENY_SKIP
    LUNCHSTORE city_bar
    WAIT 4
    ALLOW_SKIP
    HIDE_BLURSC
    GOTO RESHOW
} ELSIFSTR $_sres IS '_TALK_MORE' {
    _def=2
    PIC   bt P0/a0L2R3__F3__e2    
   IF 'GFC[MOB9]&4==0' {
        GFC_SET MOB9 |=4
        PIC   n a_1/a22__F1__f1__m1__b1__u0    
        MSG bt_50
        PIC   n a_3/a0__F1__f3__m1__b4_u0    
        MSG n_51

   } ELSE {
        HKDS	n BB
    
        PIC   n a_3/a0__F1__f3__m1__b4_u0    
        MTL MSG_SKIPHOLD
        MSG n_51
   }
   LABEL _RESELECT_TALK_MORE
   CHANGE_EVENT2 ___city_bar/_barten_talk_more 1
    HKDS	n
    IFSTR $_result IS '&&Cancel' {
        MSG_HIDE
        GOTO LETSTALK
    }
    SELECT_RESULT_TO_LOG
    ALLOW_SKIP
    _reselect=0
    CHANGE_EVENT2 $_evt_header$_result
    LOG_RECORD
    IF $_reselect'==1' {
        DENY_SKIP
        WAIT 20
    ALLOW_SKIP
        GOTO RESHOW
    }

    GOTO LETSTALK
} ELSIFSTR $_sres IS '_ARBEIT' {
    _def=3
    _arbeit_play=0
    _bait_first=0
   IF 'GFC[MOB9]&2==0' {
        GFC_SET MOB9 |=2
        _bait_first=1
   }

    CHANGE_EVENT2	___city_bar/_arbeit_portal $_bait_first
    IF $_arbeit_play'==1' {
        SEEK_END
       
    }
    IF $_reselect'==1' {
        WAIT 20
        GOTO RESHOW
    }
    GOTO _SKIP

} ELSIFSTR $_sres IS '_CANCEL' {
   GOTO _SKIP
} ELSE {
    _def=0
    CHANGE_EVENT2	$_sres
    GOTO LETSTALK
}
// ========================



// ========================
LABEL _SKIP


IF $__cloth_changed {
    __cloth_changed=0
    // 着替えている
    CHANGE_EVENT2	___city_bar/_arbeit_change_cloth_back
}
