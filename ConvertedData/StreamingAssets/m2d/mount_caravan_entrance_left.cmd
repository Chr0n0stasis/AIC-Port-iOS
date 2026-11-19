##USE_EVENT_VARCON##
%TALK_TARGET_TTT 1
// %DARK_ACTIVATE
DEFINENDEF _alma_appear=0
_define_farmer=0
IF '!is_night'
    _define_farmer=1

IF 'PVV<210' {
    IF $_alma_appear'||Exist_mover[alma]' {
        _define_farmer=1
        /* ___ alma ___ */  
        {
            %TALK_TARGET_TTT 0
            %PXL sub_l
            %PHY
            %SIZE 12 68
            %POSE stand
        %SP_SHIFT 0 12.5
            %PT Ev_bottom 90 -30
            talk = 200/35_alma_magic 1
        }
        %DEFINE_ON_POINT Ev_exit_b
        /* ___ alma_exitting ___ */
        {
            stand = 200/35b_alma_magic_exitting 3
        }
        %DEFINE_ON_POINT   
        
    } ELSIF '(GFC[ALM1]&8)==0' {
        _define_farmer=1
        %DEFINE_ON_POINT Ev_enter  
        /* ___ alma_enter ___ */
        {
            stand = 200/35_alma_magic 0
        }
        %DEFINE_ON_POINT   
    }
}
IF $_define_farmer {
    
    /* ___ man_bst_cow_farmer_1 ___ */
    {
        %SIZE 12 78// %DARK_ACTIVATE
        %MOBG	man_bst_cow_farmer_1 stand
        %PHY
        %MOBG_ATLAS_WH 240 0
        %PT Ev_farmR.b 90 -2
        %AIM R
        %MOVE WALKAROUND_LR '' 1.24 
        talk = ___mountain/_caravan_farm_t00 MOB0 man_bst_cow_farmer_1    
    }
}

IF '!is_night' {
    IF 'quest_progress_f[p200_elec_facil]>=3||PVV>=210' {
        /* ___ ltl_elf_girl_3 ___ */
        {
            %SIZE 12 58// %DARK_ACTIVATE
            %MOBG	ltl_elf_girl_3 stand colvari_1
            // %SP_SHIFT 0 -2
            %PT Ev_farmR.b -140 -2
            %AIM R
            talk = ___mountain/_caravan_farm_t01 MOB1 ltl_elf_girl_3    
        }

    }
}
