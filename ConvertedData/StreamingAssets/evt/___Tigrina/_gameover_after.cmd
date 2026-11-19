
IF 'PVV==107' {
    @107/_change_danger 1
    GFC_SET TIG2 |=1 // 冒頭のメッセージ省略
}
IF 'GFB[SMNC_RESTORE_ITEMS]' {
    GFB_SET SMNC_RESTORE_ITEMS 0
    ITEMMNG_POP_BYTES
}

