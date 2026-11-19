%TALK_TARGET_TTT 1



%DEFINE_ON_POINT house..Ev_restroom
{
    /* ___ restroom ___ */
    %CHECK_DESC EV_access_restroom
    check = {
        CHANGE_EVENT ___House/noelhouse_restroom 0 1 '' Ev_restroom 50
    }
}  

%DEFINE_ON_POINT 

IF 'PVV==107' {
    SEEK_END
}


/* ___ woman_elf_student_6 ___ */
{
    %SIZE 12 78
    %AIM LR
    %MOBG	woman_elf_student_6 stand
    %PT Ev_doorside0.b -30 0
    %MOVE WALKAROUND_LR
}
