_bossskip=1

PR_CURE 1 1 1 1 1 1
IF 'GFC[IXA1]<8' {
    IF '(GFC[IXA1]&4)==0' {
        GFC_SET IXA1 4
    } ELSE {
        GFC_SET IXA1 8

    }
    SCN_MANUAL_BGM_REPLACE ''
    INIT_MAP_MATERIAL city_scl_ground 1
    WAIT 2
    _107_first=1
    WAIT_FN MAP_TRANSFER

    NEL_MAP_TRANSFER city_scl_ground L !ExitL_toground
    WAIT 2
    AUTO_SAVE 1
    CHANGE_EVENT	107/_td_portal 1

}
 // 最終
CHANGE_EVENT	107/52_td_finish_02
