%DEFINE_ON_POINT row..Ev_restroom
{
    /* ___ restroom ___ */
    %CHECK_DESC EV_access_restroom
    check = {
        CHANGE_EVENT ___House/noelhouse_restroom 0 1 '' Ev_restroom 40
    }
}  


IF 'PVV==107' {
    SEEK_END
}

%DEFINE_ON_POINT


/* ___ student_0 ___ */
{
    %SIZE 12 78
    %MOBG	woman_bst_young_teacher_parrot stand
    %AIM LR
    %MOVE	WALKAROUND_MAP  
    %POS_RANDW
}

    /* ___ student_2 ___ */
    {
        %SIZE 12 78
        %MOBG	woman_elf_thin_student_sister_3 stand
        %AIM LR
        %MOVE	WALKAROUND_MAP  
        %POS_RANDW
    }

IF 'GFC[PHASE]<2' {

/* ___ student_1 ___ */
{
    %SIZE 12 78
    %MOBG	woman_elf_student_10 stand
    %AIM LR
    %MOVE	WALKAROUND_MAP  
    %POS_RANDW
}
} ELSE {

    /* ___ woman_elf_thin_sudent_11 ___ */
    {
        
        %TALK_TARGET_TTT 1
        %SIZE 12 78
        %MOBG	woman_elf_thin_sudent_11 stand colvari_1
        %AIM R
        %PT Ev_RR.b 10 0
        talk = ___city/tdb_hall_f2_00 woman_elf_thin_sudent_11
    }
    

}


