STOP_LETTERBOX
prev_cane!
prev_cane_grade!

IF '!DEBUGALLSKILL' {
    IF 'PVV<104&&'$loadver'<31' {
        IF 'MagicHas[PR_BURST]' {
            CHANGE_EVENT2	___INITM2D_V022_REMOVE_BURST   
        }
    }
}
IF $loadver'<17 && '$loadver'>0' {
    IF 'GFB[ALCHEMY_RECIPE]' {
        CHANGE_EVENT2	___INITM2D_V023_ATELIER   
    }
}

IF $loadver'<22 && '$loadver'>0' {
    IF 'PVV>=100' TOUCHITEM timecapsule
    IF 'PVV>=104' {
        TOUCHITEM ostrea_bomb
        TOUCHITEM mtr_curry
    }
}

IF $loadver'<27' {
    QUEST_REMOVE p999_trial_finished 1
    IF 'PVV<=105' {
        QUEST_REMOVE p105_grazia
    }
}
IF '0<'$loadver'&&'$loadver'<39' {
    QUEST_REMOVE p999_trial_finished 1
}


// IF '36<='$loadver {
//     IF 'quest_progress[p999_trial_finished]==0' {
//         QUEST_REMOVE p106_grazia_goto_club
//     }
// }

IF $loadver'<37' {
    //ver0.28
   @106/tigrina_after_flag
}


IF $loadver'<39&&PVV>=200' {
    //ver0.29初回読み込み
    QUEST_PROGRESS p200_alice_veryfirst 0
}
IF $loadver'<=39' {
    IF 'ItemHas[precious029_1]>0' {
        REMITEM precious029_1 100 -1  Alert_replaced_temporary_item
        GETITEM Enhancer_windguard 1 0
        
    }
}
IF $loadver'==39' {
    REMSKILL shine_booster
}
IF $loadver'==39&&PVV==215' {
    GFC_SET OST1 0 
}

IF 'quest_progress_f[subquest_treasurehunt_000]>=1' {
    GFC_SET TRS0 |=1
}

IF '0<'$loadver'&&'$loadver'<32' {
    CHANGE_EVENT2	___INITM2D_V025_ADDED_CHECK_KD
}

IF 'PVV>=200&&SkillHas[evade_jump]&&GFB[METAEVADE_ANNOUNCED]==0' {
    WAIT 20
    CHANGE_EVENT2	200/47_evadejump_tips
}

// 030 調整
IF $loadver'<44 && '$loadver'>0' {
    IF 'quest_progress_f[subquest_treasurehunt_001]==5||quest_progress_f[subquest_treasurehunt_000]==5' {
        CHANGE_EVENT2	___INITM2D_V030_TREASURE
    }
    IF 'GFB[FORGE_GET_HOLDER]==0&&ItemCategoryHas[@CANE][4]>0' {
        CHANGE_EVENT2	___INITM2D_V030_FORGE
    }
}
IF $loadver'<45 && '$loadver'>0' {
    IF 'SfBreakable[Breakable_cannonroad_pb0] && !SfBreakable[Breakable_cannonroad_pb1] && (PVV>=200&&PVV<210)' {
        // 左上を破ったが右下は破ってない場合、左上を戻す
       SF_BREAKABLE_SET Breakable_cannonroad_pb0 0
    }
}


// バーの地下で取引を行った
IF 'GFC[BRTU]>=8&&0<'$loadver {
    IF $loadver'<39' { // アプデごとに適宜書き換えを行おう
        UIALERT Alert_new_config_on_barunder ALERT_BARU
        QUEST_REMOVE subquest_new_item_baru 1
        QUEST_PROGRESS subquest_new_item_baru 0 H
        STOREFLUSH BarUnder 
    }
}
IF 'PVV>=200&&0<'$loadver'&&'$loadver'<42' {
    //ver0.29 用fix
    GFC_SET WLR_G 0
}

IF 'GFB[FIRST_CANE_GOTTEN]==0' {
    @___city_forge/get_first_cane
}
// ========================

