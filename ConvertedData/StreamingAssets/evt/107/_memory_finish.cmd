
// 回想シーン！ end
DEFINENDEF _need_save=0
DENY_SKIP
PIC_FILL #9 DARK
GFC_SET P107_MEM  0
IFNDEF _add_gameover_count {
    INIT_MAP_MATERIAL city_scl_ground 3
    PIC_FADEIN #9 60
    WAIT 65
    WAIT_FN MAP_TRANSFER



    NEL_MAP_TRANSFER city_scl_ground L !Ev_200_trash
}
DANGER 0 
DANGER_MANUAL 0 1
ITEMMNG_POP_BYTES

IFNDEF _add_gameover_count {
    #MS_ % '## #; >>[Ev_200_trash 40,0] #; @L P[stand_ev~=6]' 
}

ALLOW_FASTTRAVEL
ALLOW_WARPINJECTION
WAIT 2
PR_CURE 1 1 1 1 1

IF $_need_save {
    UI_ALERT Mgm_ui_updated_highscore
    AUTO_SAVE
}
PIC_FADEOUT #9 60
WAIT 65
