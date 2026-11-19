##USE_EVENT_VARCON##
%remove_all_on_event_load 1
%TALK_TARGET_TTT 1
 
DEFINENDEF __mgm_bun_active=0

// ========================================================
// MARK : bartender
// ========================================================
%DEFINE_ON_POINT 
/* ___ ev_barten ___ */  
{
    %SIZE 12 78
    %PT Ev_counter 2 0
    %AIM L
    %TALK_TARGET_TTT 0
    IF '!'$__mgm_bun_active {

        talk = ___city_bar/_barten_portal        
        PRE_LOAD = {
            #CALL ev_barten load_once
        }
        load_once = {
            #SND_LOAD ev_bar
            ENGINE_NNEA Barten INIT sub_barten_npc 
            ENGINE_NNEA Barten INIT_AREA Ev_behind_counter
        }
        JUICE_EXPL = {
            CHANGE_EVENT ___city_bar/_barten_juice_explode   
        }
    }

}

%DEFINE_ON_POINT wallpaper_door..Ev_restroom
{
    /* ___ restroom ___ */
    %CHECK_DESC EV_access_restroom
    IF $__mgm_bun_active {
        %SIZE 8 78
        %PT Ev_restroom 45,0 1
        check = {
            CHANGE_EVENT ___city_bar/_arbeit_restroom
        }
        IF '!mgm_suit_bunnyrev' {
            %SET_ENABLE check 0
        }
    } ELSE {
        check = {
            CHANGE_EVENT ___House/noelhouse_restroom 0 1 '' Ev_restroom 80
        }
        %SET_ENABLE check 1
    }
}  
%DEFINE_ON_POINT 



IF $__mgm_bun_active {
    {
        /* ___ bun_receipt ___ */
        %CHECK_DESC MgmBun_Receipt
        %PXL sub_barten_npc
        %POSE receipt
        %SIZE 8 78
        %PT Ev_bun_receipt -10,12.5 
        check = {
            ENGINE_NNEA Barten ALLOW_PLAY_SOUND
            STOP_LETTERBOX
            GREETING	L 
            MGM_BUN_RECEIPT
            // 
            // CHANGE_EVENT ___House/noelhouse_restroom 0 1 '' Ev_restroom 80
        }
        /* ___ bun_trash ___ */
        %CHECK_DESC MgmBun_Trash
        %PXL sub_barten_npc
        %POSE trash
        %SIZE 10 78
        %PT Ev_bun_receipt 18,12.5 
        %TRIGGER_X
        check = {
            ENGINE_NNEA Barten ALLOW_PLAY_SOUND
            STOP_LETTERBOX
            #MS_ % '@R ! >>[#<bun_trash> -10,0 <<0.07]  P[trash] w50 ?'
            DENY_SKIP
            WAIT 18
            MGM_BUN_TRASH
            IF $_result {
                SND discard_water
            }
            WAIT_MOVE
            DOTL

            // 
            // CHANGE_EVENT ___House/noelhouse_restroom 0 1 '' Ev_restroom 80
        }
    }
    SEEK_END
}


%DEFINE_ON_POINT Ev..Ev_table_ttr  
/* ___ table_ttr ___ */
{
    IF 'GFB[TTR_PLAYED_BAR]||PVV>=200' {
        %CHECK_DESC  EvTitle_4ascend_play
    } ELSE {
        %CHECK_DESC  EvTitle_4ascend
    }
    check = ___city/bar_4ascend_table 

}

%DEFINE_ON_POINT   




// ========================================================
// MARK : Mob
// ========================================================

_army105_defined=0
IF '(PVV==105||PVV==106)&&GFC[TIG0]<2' {
    /* ___ army105_0 ___ */
    {

        %SIZE 12 78
        %PT Ev_table_1 -28 3
        %AIM R
        %MOBG	woman_elf_thin_army_0 stand

    }
    _army105_defined=1
    /* ___ army105_1 ___ */
    {

        %SIZE 12 78
        %PT Ev_table_1 28 3 1
        %AIM L
        %MOBG	woman_elf_army_2 stand
    }
    %DEFINE_ON_POINT Ev..Ev_table_1
    
    /* ___ talk_105 ___ */
    {
        talk = ___city/bar_t00
    }
     %DEFINE_ON_POINT
}



IF '105<=PVV&&PVV<=106' {
    IF 'GFC[WLR_G]<=1' {
        IF '!'$_army105_defined {
            /* ___ army105_1 ___ */
            {

                %SIZE 12 78 
                %PT Ev_table_0 38 3 1
                %AIM L
                %MOBG	woman_elf_army_2 stand
            }
        }
        /* ___ army_4 ___ */
        %SIZE 12 78
        %PT Ev_table_0 62 0
        %AIM L
        %MOBG	man_elf_army_2 stand
        load = ___city/bar_w_t_first_battle
    }
    /* ___ walross ___ */
    {
        %SIZE 12 98
        %PXL sub_w
        %SP_SHIFT 0 3.5
        %PT Ev_table_0 28 0
        %AIM L
        talk = ___city/bar_w_portal        
    }
    /* ___ ostrea ___ */
    {
        %SIZE 12 68
        %PXL sub_s
        %SP_SHIFT 0 3.5
        %AIM R
        %PT Ev_table_0 -28 0
        talk = ___city/bar_s_portal        
    }

}

IF 'PVV>=200' {


    /* ___ engineer_1 ___ */
    {
        %SIZE 12 78
        %PT Ev_table_0 28 0
        %MOBG	man_bst_engineer_1 stand
        %AIM R
        %SP_SHIFT 0 5
        talk = ___city/bar_200_engineer_t00 MOB0 engineer_1
    }

    /* ___ engineer_0 ___ */
    {
        %SIZE 12 78
        %PT Ev_table_0 -28 0
        %MOBG	man_bst_engineer_0 stand
        %AIM R
        %SP_SHIFT 0 5
    }

    %TARGET_MAP _city_in_bar_behind

    /* ___ man_bst_engineer_3 ___ */
    {
        %SIZE 12 90
        %MOBG	man_bst_engineer_3 stand colvari_1
        %PT Ev_L 10  3
        %AIM R
    }

    /* ___ man_bst_engineer_2 ___ */
    {
        %SIZE 12 90
        %MOBG	man_bst_engineer_2 stand colvari_1
        %PT Ev_R -14 3
        %MOVE WALKAROUND_LR '' 1.2 0.04
        %AIM L
    }


    %TARGET_MAP
}
