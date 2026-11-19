
%DEFINE_ON_POINT row..Ev_restroom
{
    /* ___ restroom ___ */
    %CHECK_DESC EV_access_restroom
    check = {
        CHANGE_EVENT ___House/noelhouse_restroom 0 1 '' Ev_restroom 40
    }
}  


%DOD_CM_BEHIND_BG
%DEFINE_ON_POINT   Ev..Ev_counter


/* ___ tuckshop ___ */
{
    %CHECK_DESC EV_access_tuckshop

    %SIZE 12 78
    %MOBG	woman_bst_young_teacher_lion stand
    %PT Ev_counter 10,-18
    %DOD CM0
    %AIM R

    talk = ___city/scl_koubai
}



IF 'PVV==107' {
    SEEK_END
}
%DEFINE_ON_POINT   

/* ___ woman_elf_thin_sudent_12 ___ */
{
    %SIZE 12 78
    %MOBG	woman_elf_thin_sudent_12 walk 

    %POS_RANDW 
    %MOVE	WALKAROUND_MAP
    %AIM LR
}
/* ___ woman_elf_thin_sudent_13 ___ */
{
    %SIZE 12 78
    %MOBG	woman_elf_thin_sudent_13 walk 

    %PT Ev_store.b 40,0
    %MOVE	WALKAROUND_LR
    %AIM LR
}

%TARGET_MAP _school_in_shop


/* ___ woman_elf_thin_sudent_8 ___ */
{
    %SIZE 12 78
    %MOBG	woman_elf_thin_sudent_8 walk colvari_1
    %PT Ev_R -20,4
    %AIM LR
    %MOVE WALKAROUND_LR
}

/* ___ woman_elf_thin_sudent_11 ___ */
{
    %SIZE 12 78
    %MOBG	woman_elf_thin_sudent_11 walk colvari_1
    %PT Ev_L 40,4
    %AIM LR
    %MOVE WALKAROUND_LR
}



