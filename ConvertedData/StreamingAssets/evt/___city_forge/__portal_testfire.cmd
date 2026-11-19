// 鍛冶屋の試し撃ちで鍛冶屋メニューを出した X+Z
IF 'GFC[FORGE0]<4' {
    _flag_buyable=BUY_LISTEN
} ELSE {
    _flag_buyable=BUY
}


UI_FORGE TESTABLE $_flag_buyable TESTABLE_REPLACABLE
IFSTR $_result IS 'CANCELED' {
    SEEK_END
}
IFSTR $_result IS 'TESTFIRE' {
    GFB_SET FITTING 1
    DENY_FASTTRAVEL
    FORGE_TESTFIRE_INIT $_cane $_cane_grade
    SND cane_assign_equip
    SEEK_END
}
_after_wait=2
IFSTR $_result IS 'BUY' {
    GOTO _STOPBGM
}
IFSTR $_result IS 'REPLACE' {
    LABEL _STOPBGM
    STOP_BGM 90
    _after_wait=15
    SCN_MANUAL_BGM_REPLACE ''
}

WAIT 5
INIT_MAP_MATERIAL city_in_forge 1
PIC_FILL	#9 DARK
PIC_FADEIN	#9 60

WAIT 65
WAIT_FN MAP_TRANSFER 
NEL_MAP_TRANSFER city_in_forge_testfire L !ExitD_forgefst

WAIT $_after_wait


IFSTR $_result IS 'BUY' {
    CHANGE_EVENT	___city_forge/__buy_or_replace 1
    
}
IFSTR $_result IS 'REPLACE' {
    CHANGE_EVENT	___city_forge/__buy_or_replace 1
    
}

ALLOW_FASTTRAVEL
FORGE_TESTFIRE_INIT
GFB_SET FITTING 0



PIC_FADEOUT	#9 50

#MS_ % '>+[-120,0] >+[-100,0 :80]'

WAIT 60

IFSTR $_result IS 'BUY_LISTEN' {
    _focusto=mobsrng
    HKDS	fd RT #<$_focusto>
    TALKER_REPLACE	fd Mob talk_mob_w2
    HKDS	n CCLT #<Noel>
    CHANGE_EVENT	___city_forge/t_buy00
}
