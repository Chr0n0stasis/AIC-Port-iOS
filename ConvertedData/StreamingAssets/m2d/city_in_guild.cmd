
/* ___ staff1 ___ */
{
    %SIZE 12 78
    %MOBG	woman_bst_frog_1
    %PT Ev_staff1.b 0,-8
    %MOBG_CLIP Clip_counter
    %AIM L
    talk = ___city_guild/_portal staff1 L
}

/* ___ staff2 ___ */
{
    %SIZE 12 78
    %MOBG	man_bst_fat_6 stand
    %PT Ev_staff2.b 0,-8
    %MOBG_CLIP Clip_counter
    %AIM R
    talk = ___city_guild/_shop
}


%DEFINE_ON_POINT Ev_board

/* ___ board_event ___ */
{
    %CHECK_DESC     EV_access_read
    check = ___city/guild_news L
}
%DEFINE_ON_POINT   


// _board_evt=
// IF '105<=PVV&&PVV<=107' {
//     _board_evt=___city/guild_board_105
// }
// IFSTR $_board_evt ISNOT '' {
// }



IF 'PVV!=107' {
        
    /* ___ mb3 ___ */
    {
        %SIZE 12 78
        %MOBG	man_elf_braveman_0 stand
        %PT Ev_board.b -130,0
        %MOVE WALKAROUND_LR '' 0.55
        %AIM LR
    }

    /* ___ mb4 ___ */
    {
        %SIZE 12 78
        %MOBG	woman_elf_student_oneesan stand colvari_1
        %PT Ev_table_r1.b 30,0
        %AIM R
    }
    /* ___ mb5 ___ */
    {
        %SIZE 12 78
        %MOBG	woman_elf_thin_student_9 stand colvari_1
        %PT Ev_table_r1.b 60,0
        %AIM L
    }


    /* ___ mb6 ___ */
    {
        %SIZE 12 78
        %MOBG	man_elf_army_1 stand colvari_1
        %PT Ev_staff2.b 10 0
        %MOVE WALKAROUND_LR '' 1.2
        %AIM LR
    }

}
