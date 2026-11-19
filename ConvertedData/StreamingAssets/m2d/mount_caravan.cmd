%TALK_TARGET_TTT 1

%DEFINE_ON_POINT Ev_hotel  

/* ___ hotel ___ */
{
    %CHECK_DESC EvTitle_inn_caravan
    check = {
        CHANGE_EVENT ___mountain/_hotel_caravan_portal
    }   
}

%DEFINE_ON_POINT door..Ev_restroom  
{
    /* ___ restroom ___ */
    %CHECK_DESC EV_access_restroom
    check = {
        CHANGE_EVENT ___House/noelhouse_restroom 0 1 '' Ev_restroom 66
    }
}  
%DEFINE_ON_POINT 



// ================================================
/* ___ man_bst_young_6 ___ */
{
    %SIZE 12 78
    %MOBG	man_bst_young_6 stand colvari_1
    %PT Ev_RRR 28,0 
    %AIM L
}
/* ___ man_bst_fat_6 ___ */
{
    %SIZE 12 78
    %MOBG	man_bst_fat_6 stand colvari_1
    %PT Ev_RRR -28,0 
    %AIM R
}
%DEFINE_ON_POINT Ev_RRR

/* ___ Ev_RRR_talk ___ */
{
    %PT Ev_RRR 8,0 
    talk = ___mountain/_caravan_center_t00 MOB0 man_bst_young_6 man_bst_fat_6
}

%DEFINE_ON_POINT   
// ================================================

/* ___ woman_bst_young_teacher_lion ___ */
{
    %SIZE 12 78

    %MOBG	woman_bst_young_teacher_lion stand colvari_1
    %SP_SHIFT 0 -8
    %PT Ev_barL ~-700+rand[600]
    %AIM L
    %MOVE WALKAROUND_LR '' 22.4 0.05
}

/* ___ man_elf_fat_1 ___ */
{
    %SIZE 12 78
    %MOBG	man_elf_fat_1 stand 
        %SP_SHIFT 0 -8
    %PT Ev_barL  ~-200+rand[600]
    %AIM R
    %MOVE WALKAROUND_LR ''  26.4 0.042
}

/* ___ man_bst_horse_1 ___ */
{
    %SIZE 12 78
    %MOBG	man_bst_horse_1 stand
    %PT Ev_barL ~300+rand[600]
    %SP_SHIFT 0 -8
    %AIM R
    %MOVE WALKAROUND_LR '' 26.4 0.054
}


// ================================================
// ================================================
// ================================================
%TARGET_MAP _mount_caravan_bg_house_hiraya


/* ___ man_bst_engineer_3 ___ */
{
    %SIZE 12 78
    %MOBG	man_bst_engineer_3 stand colvari_1
    %AIM L
    %PT Ev_LL
    %MOVE WALKAROUND_LR '' 2 0.04

}

