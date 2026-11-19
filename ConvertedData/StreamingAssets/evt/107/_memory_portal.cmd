// 回想シーン！
_setmem=0
GREETING	R -10 
WAIT 20
SELECTARRAY_CLEAR
SELECTARRAY &&Select_playagain_ixia_matoate _MATO
SELECTARRAY &&Select_playagain_td _TD
SELECTARRAY &&Cancel _END C
IF '(GFC[TD_MEM]&3)==1' {
    SELECT_FOCUS 0
}
IF '(GFC[TD_MEM]&3)>=2' {
    SELECT_FOCUS 1
}
SELECT -1
LABEL _END
SEEK_END
//========================
LABEL _MATO
GFC_SET TD_MEM ~1|(GFC[TD_MEM]&12)
TX_BOARD desc_playagain_ixia_matoate  '' N @CCT
TX_BOARD_LOCK
WAIT 30

SELECT_POS CCB
SELECT 2
&&Select_playagain _MATO_EXECUTE
&&Cancel _END C

LABEL _MATO_EXECUTE
_setmem=8
GOTO _EXECUTE
//========================

LABEL _TD
GFC_SET TD_MEM ~2|(GFC[TD_MEM]&12)
TX_BOARD desc_playagain_td  '' N @CCT
TX_BOARD_LOCK
WAIT 30
_achive00=~achive[td_max_dangerous_00]
_achive01=~achive[td_max_dangerous_01]
_achive02=~achive[td_max_dangerous_02]
SELECT_POS CCB
SELECTARRAY_CLEAR
SELECTARRAY &&Select_playagain_td1' <font size=80%>... '&&Smnc_td_cleard_max[$_achive00]'</font>' 1
SELECTARRAY &&Select_playagain_td2' <font size=80%>... '&&Smnc_td_cleard_max[$_achive01]'</font>' 2
SELECTARRAY &&Select_playagain_td3' <font size=80%>... '&&Smnc_td_cleard_max[$_achive02]'</font>' 3
SELECTARRAY &&Cancel 0 C 

IF '(GFC[TD_MEM]&12)==8' {
    SELECT_FOCUS 2
} ELSIF '(GFC[TD_MEM]&12)==4' {
    SELECT_FOCUS 1
} ELSE {
    SELECT_FOCUS 0
}

SELECT -1 _setmem

IF $_setmem'==0' {
    SEEK_END
}

GOTO _EXECUTE
//========================

LABEL _EXECUTE
TX_BOARD_HIDE
_107_first=1
ITEMMNG_PUSH_BYTES
INIT_MAP_MATERIAL city_scl_ground 3
STOP_BGM	110 0
SCN_MANUAL_BGM_REPLACE ''

PIC_FILL #9 DARK
PIC_FADEIN #9 60
GFC_SET P107_MEM  $_setmem
WAIT 65
WAIT_FN MAP_TRANSFER

NEL_MAP_TRANSFER city_scl_ground L !Ev_ground_left
SELECT_POS 

IF $_setmem'==8' {
    CHANGE_EVENT	106/21_matofight_rule
    
} ELSE {
    // TD
    GFC_SET TD_MEM ~2|(4*($_setmem-1))
    CHANGE_EVENT	107/_td_portal 1 1

}
