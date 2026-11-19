

IF 'PVV==107' {
    SEEK_END
}


IF '(PVV==106)&&GFC[TIG0]<=1 && quest_progress[p106_tigrina_armory]<=0' {
    IF '(PVV==106)&&GFC[TIG0]==0' {
        %DEFINE_ON_POINT Ev_RR_container
        /* ___ p106 ___ */
        stand = {
            #VANISH
            #CALL	tigrina talk
        }

    }
    %DEFINE_ON_POINT 
    /* ___ tigrina ___ */
    {

        %SIZE 12 68
        %SP_SHIFT 0 10.5
        %PXL sub_so 
        %PT Ev_RR.b -20,0
        %MOVE CRAWLAROUND_LR 
        %POSE crawl
        %PHY
        %AIM L
        talk = ___Tigrina/t00
    }
}
%DEFINE_ON_POINT 

IF 'GFC[PHASE]==2' {
    /* ___ woman_elf_thin_sudent_13 ___ */ 
    {

        %TALK_TARGET_TTT 1
        %SIZE 12 78
       %MOBG	woman_elf_thin_sudent_13 stand colvari_1
        %PT Ev_LL.b 0,0
        %MOVE WALKAROUND_LR 
        talk =  ___city/tdb_hall_b_after01 woman_elf_thin_sudent_13
    }
}

/* ___ woman_elf_student_1 ___ */
{
    %SIZE 12 78
    %MOBG	woman_elf_student_1 stand colvari_2
    %PT	Ev_R.b  10 0
    %AIM LR
    %MOVE	WALKAROUND_LR '' 0.3
}

/* ___ man_elf_young_student ___ */
{

    %SIZE 12 78
    %MOBG	man_elf_young_student stand colvari_1
    %PT	Ev_L.b ~-50+rand[100]
    %AIM LR
    %MOVE	WALKAROUND_LR '' 5.5
}
