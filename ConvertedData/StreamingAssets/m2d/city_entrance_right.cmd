
IF 'PVV==107' {
    /* ___ woman_elf_thin_army_1 ___ */
    {
        %SIZE 12 78
        %AIM L
        %MOBG	woman_elf_thin_army_1 stand
        %PT Ev_RRT.b 12,0
    }
    /* ___ woman_elf_army_2_3 ___ */
    {
        %SIZE 12 78
        %AIM LR
        %MOVE WALKAROUND_LR
        %MOBG	woman_elf_army_2_3 stand colvari_1
        %PT Ev_RT.b 90,0
    }


    /* ___ woman_elf_thin_army_0 ___ */ 
    {
        %SIZE 12 78 
        %AIM LR
        %PT Ev_T.b 30,-2
        %PHY
        %MOVE WALKAROUND_LR '' 3.12 0.11
        %MOBG	woman_elf_thin_army_0 stand
    }

    /* ___ man_elf_army_1 ___ */ 
    {
        %SIZE 12 78 
        %AIM LR
        %PT Ev_LT.b 30,-2
        %PHY
        %MOVE WALKAROUND_LR '' 3.23 0.11
    %MOBG	man_elf_army_1 stand colvari_1
    }



    /* ___ man_elf_army_0 ___ */ 
    {
        %SIZE 12 78 
        %AIM LR
        %POS_RANDW Area_walkable
        %MOVE WALKAROUND_MAP
        %MOBG	man_elf_army_0 stand colvari_2
    }

    /* ___ woman_elf_army_2 ___ */ 
    {
        %SIZE 12 78 
        %AIM LR
        %POS_RANDW Area_walkable
        %MOVE WALKAROUND_MAP
    %MOBG	woman_elf_army_2 stand colvari_1
    }


    /* ___ woman_elf_thin_army_2 ___ */ 
    {
        %SIZE 12 78 
        %AIM LR
        %POS_RANDW Area_walkable
        %MOVE WALKAROUND_MAP
    %MOBG	woman_elf_thin_army_2 stand colvari_1
    }

    /* ___ woman_elf_army_3 ___ */ 
    {
        %SIZE 12 78 
        %AIM LR
        %POS_RANDW Area_walkable
        %MOVE WALKAROUND_MAP
    %MOBG	woman_elf_army_3 stand
    }

    /* ___ man_elf_army_3 ___ */ 
    {
        %SIZE 12 78 
        %AIM LR
        %POS_RANDW Area_walkable
    %MOBG	man_elf_army_3 stand colvari_1
        %MOVE WALKAROUND_MAP
    }


    /* ___ engineer_1 ___ */
    {
        %SIZE 12 78
        %PT Ev_LLT -120,0
        %MOBG	man_bst_engineer_1 stand
        %MOVE	WALKAROUND_LR
        %AIM LR
        %SP_SHIFT 0 5
    }

    /* ___ engineer_0 ___ */
    {
        %SIZE 12 78
        %PT Ev_LLT 30,0
        %MOBG	man_bst_engineer_0 stand
        %AIM L
        %SP_SHIFT 0 5
    }


    SEEK_END

}
/* ___ woman_bst_young2_3 ___ */
{
    %SIZE 12 78
    %MOBG	woman_bst_young2_3 stand
    %POS_RANDW Area_walkable
    %AIM LR
    %MOVE WALKAROUND_MAP
}

/* ___ man_elf_young_5 ___ */
{
    %SIZE 12 78
    %MOBG	man_elf_young_5 stand
    %POS_RANDW Area_walkable
    %AIM LR
    %MOVE WALKAROUND_MAP
}
/* ___ woman_elf_thin_sudent_13 ___ */
{
    %SIZE 12 78
    %MOBG	woman_elf_thin_sudent_13 stand
    %POS_RANDW Area_walkable
    %AIM LR
    %MOVE WALKAROUND_MAP
}
/* ___ woman_elf_student_9 ___ */
{
    %SIZE 12 78
    %MOBG	woman_elf_student_9 stand
    %POS_RANDW Area_walkable
    %AIM LR
    %MOVE WALKAROUND_MAP
}
IF 'PVV>=106' {
    /* ___ woman_elf_oneesan_student ___ */
    {
        %SIZE 12 78
        %MOBG	woman_elf_oneesan_student stand
        %POS_RANDW Area_walkable
        %AIM LR
        %MOVE WALKAROUND_MAP
    }
    /* ___ woman_elf_student_8 ___ */
    {
        %SIZE 12 78
        %MOBG	woman_elf_student_8 stand
        %POS_RANDW Area_walkable
        %AIM LR
        %MOVE WALKAROUND_MAP
    }

}
