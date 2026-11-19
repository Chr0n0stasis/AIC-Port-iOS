%TALK_TARGET_TTT 1

/* ___ staff1 ___ */
{
    %SIZE 12 78
    %MOBG	woman_bst_barten stand colvari_1
    %PT Ev_staff1 0,24
    %MOBG_CLIP Clip_counter
    %AIM L
    talk = ___mountain/_caravan_bar_t00 MOB3 staff1 
}

/* ___ museum_lp_focus ___ */
{
    trigger_a = ___mountain/_caravan_bar_t00
}


IF 'PVV<215&&quest_progress_f[p200_alice_mine1]<1' {
    // 坑道匂わせ

    /* ___ man_elf_bst_6 ___ */
    {
        %SIZE 12 78
        %MOBG	man_elf_bst_6 
        %PT Ev_LL.b 0,0 
        %AIM R
        talk = ___mountain/_caravan_bar_t01 '_' man_elf_bst_6

    }



}



IF 'PVV>=210||(PVV>=200&& (quest_progress_f[p200_alice_mine1]>=4&&quest_progress_f[p200_elec_facil]>=5))' {

    /* ___ walross ___ */
    {
        %SIZE 12 98
        %PXL sub_w
        %SP_SHIFT 0 3.5
        %PT Ev_CL.b 28,8
        %AIM L
        talk = ___mountain/_caravan_bar_w_portal        
    }
    /* ___ ostrea ___ */
    {
        %SIZE 12 68
        %PXL sub_s
        %SP_SHIFT 0 3.5
        %AIM R
        %PT Ev_CL.b -28,-8 
        talk = ___mountain/_caravan_bar_s_portal        
    }
    /* ___ glass ___ */
    {

        %PXL_CHIPIMAGE interior_bar/table_glass3.png
        %DOD  N_BACK0
        %PXL_MTR_WITH_LIGHT 1
        %AIM L
        %SIZE 20 20
        %PT Ev_CL.b -14 -35.5 1
        
    }
    /* ___ glass_r ___ */
    {

        %PXL_CHIPIMAGE interior_bar/barrelglass.png
        %DOD  N_BACK0
        %PXL_MTR_WITH_LIGHT 1
        %AIM R
        %SIZE 20 20
        %PT Ev_CL.b 4 -35.5 1
        
    }

} ELSIF 'PVV<210' {

    /* ___ man_bst_arigator_1 ___ */
    {
        %SIZE 12 78
        %MOBG	man_bst_arigator_1 stand colvari_1
        %PT Ev_C.b 28,0 
        %AIM L
    }
    /* ___ man_bst_engineer_5 ___ */
    {
        %SIZE 12 78
        %MOBG	man_bst_engineer_5 stand colvari_1
        %PT Ev_C.b -28,0 
        %AIM R
    }
    %DEFINE_ON_POINT Ev_C

    /* ___ Ev_C_talk ___ */
    {
        %PT Ev_C 8,0 
        talk = ___mountain/_caravan_bar_t02 MOB2 man_bst_engineer_5 man_bst_arigator_1 
    }

    %DEFINE_ON_POINT   
}
