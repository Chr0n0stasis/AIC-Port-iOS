%TALK_TARGET_TTT 1
IF '!is_night' {
        

    /* ___ staff1 ___ */
    {
        %SIZE 12 78
        %MOBG	woman_bst_sister_7 stand
        %PT Ev_staff1.b 0,-8
        %MOBG_CLIP Clip_counter
        %AIM L
        talk = ___mountain/_caravan_church_t00 MOB0 staff1
    }


    /* ___ staff2 ___ */
    {
        %SIZE 12 78
    %MOBG	woman_bst_sister_6 stand
        %PT Ev_C.b
        %AIM R
        talk = ___mountain/_caravan_church_t01 0 staff2
    }


    /* ___ ltl_elf_boy_3 ___ */
    {
        %MOBG	ltl_elf_boy_3 stand colvari_1
            %SIZE 12 78// %DARK_ACTIVATE
            %SP_SHIFT 0 -1
        %AIM LR
        %MOVE WALKAROUND_LR '' 1.3 0.035
        %PT Ev_L.b 30,0
    }

    /* ___ ltl_elf_boy_4 ___ */
    {
            // %MOBG	ltl_elf_boy_3 stand colvari_1
        %MOBG	ltl_elf_boy_4 stand colvari_1
        %SIZE 12 78// %DARK_ACTIVATE
        %SP_SHIFT 0 -1
        %AIM LR
        %MOVE WALKAROUND_LR '' 0.4 0.035
        %PT Ev_R.b 30,0
    }

    /* ___ ltl_elf_girl_2 ___ */
    {
            // %MOBG	ltl_elf_boy_3 stand colvari_1
        %MOBG	ltl_elf_girl_2 stand colvari_1
        %SIZE 12 78// %DARK_ACTIVATE
        %SP_SHIFT 0 -1
        %AIM LR
        %MOVE WALKAROUND_LR '' 0.3 0.032
        %PT Ev_R.b 60,0
        talk = ___mountain/_caravan_church_treasure_t00 ltl_elf_girl_2
    }
    /* ___ ltl_elf_girl_4 ___ */
    {
            // %MOBG	ltl_elf_boy_3 stand colvari_1
        %MOBG	ltl_elf_girl_4 stand colvari_1
            %SIZE 12 78// %DARK_ACTIVATE
            %SP_SHIFT 0 -1
        %AIM R
        %PT Ev_L.b 60,0
    }
    


}
