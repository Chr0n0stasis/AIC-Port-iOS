


IF 'PVV==106 && ((GFC[TIG0]>=3&&GFC[TIG1]>=2 ) || GFC[TIG0]>=4) ' {
    // 学園からグラウンドへ出撃
    @_school106_goto_ground

    SEEK_END
}


IF 'GFC[PHASE]==2' {


    /* ___ woman_elf_thin_sudent_4 ___ */
    {
        %TALK_TARGET_TTT 1
        %SIZE 12 78
        %MOBG	woman_elf_thin_sudent_4 stand colvari_1
        %PT Ev_R.b 10,0
        %AIM R
        %MOVE	WALKAROUND_LR
        talk = ___city/tdb_hall_cafe_00 woman_elf_thin_sudent_4
    }
}

%TARGET_MAP _school_in_cafeteria_kitchen
%DEFINE_ON_POINT 



/* ___ woman_elf_young_1_c0 ___ */
{
    %SIZE 12 78
   %MOBG	woman_bst_cook_1 stand
    %PT Ev_LL 0 14
    %AIM L
    %MOVE WALKAROUND_LR '' 2 0.04
}


/* ___ woman_elf_young_1_cn ___ */
{
    %SIZE 12 78
    %MOBG	woman_bst_cook_3 stand
    %PT Ev_L 0 14
    %AIM R
    %MOVE WALKAROUND_LR '' 2 0.04 
}


/* ___ woman_elf_young_1_cn2 ___ */
{
    %SIZE 12 78
  %MOBG	woman_bst_cook_2 stand
    %PT Ev_R 0 14
    %AIM L
    %MOVE WALKAROUND_LR '' 2 0.04
}


    
