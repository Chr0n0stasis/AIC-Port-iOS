// TowerDefence のバトル終了イベント
// _dlevel -1 - -3 が定義されてます

DEFINENDEF _dlevel=-1
START_LETTERBOX
#< % >
IF '!SerHas[DEATH]' {
    #MS 'F'
}
IF 'PVV>=200' {
    STOP_BGM 120
    DENY_SKIP
    SMNCREATOR DEFINE_CLEARED_NEED_SAVE _need_save
    WAIT 50  
    CHANGE_EVENT	107/_memory_finish
}
// ========================
<LOAD>
GATHER_ALL_ITEM

IF $_dlevel'==-3' {
    STOP_BGM 
}
DENY_SKIP
WAIT 40
START_LETTERBOX


IF 'PVV==107' {
    GFC_SET IXA1 |=1
}

WAIT 30
ALLOW_SKIP

IF $_dlevel'==-3' {
    CHANGE_EVENT	107/52_td_finish_02
}
IF $_dlevel'==-2' {
    GFC_SET IXA1 ~(GFC[IXA1]&3)|8
} ELSE {
    GFC_SET IXA1 ~(GFC[IXA1]&3)|4
}

#< % >
IF m2d_current_hp'==0' {
    CHANGE_EVENT	107/50_td_finish_00 -10
} ELSE {
    CHANGE_EVENT	107/50_td_finish_00 $_dlevel

}

