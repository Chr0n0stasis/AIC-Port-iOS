%DEFINE_ON_POINT row..Ev_restroom
{
    /* ___ restroom ___ */
    %CHECK_DESC EV_access_restroom
    check = {
        CHANGE_EVENT ___House/noelhouse_restroom 0 1 '' Ev_restroom 40
    }
}  


%DEFINE_ON_POINT row..Ev_door_shower 
/* ___ Ev_door_shower ___ */
{
    check = ___Laevi/trm_bath  Ev_door_shower
    %CHECK_DESC EV_access_bath
}


%DEFINE_ON_POINT   

IF 'PVV==107' {
    /* ___ man_elf_young_student_1 ___ */ 
    {

        %SIZE 12 78
        %PT Ev_restroom_r.b -10 0
        %AIM R
        %MOBG	man_elf_young_student_1 stand colvari_1
    }
    /* ___ woman_elf_thin_sudent_13 ___ */ 
    {

        %SIZE 12 78
        %AIM L
       %MOBG	woman_elf_thin_sudent_13 stand colvari_1
        %PT Ev_restroom_r.b 40 0
    }
    /* ___ icha_b ___ */

    {

        %TALK_TARGET_TTT 1
        %PT Ev_restroom_r 15 0
        talk = ___city/tdb_hall_r man_elf_young_student_1 woman_elf_thin_sudent_13
        %SIZE 52 70

    }
}
IF 'PVV==107' {
    SEEK_END
}

IF 'PVV!=106' {

    /* ___ woman_elf_pocha_2 ___ */
    {
        %SIZE 12 78
        %MOBG	woman_elf_pocha_2 stand
        %PT	ExitD_1f_b1.b 25 0
        %AIM L
        %MOVE	WALKAROUND_LR  
        
    }

    /* ___ student_2 ___ */
    {
        %SIZE 12 78
        %MOBG	woman_elf_oneesan_2 stand
        %SP_SHIFT 0 7
        %POS_RANDW
        %MOVE	WALKAROUND_MAP  
        
    }
}


IF 'PVV<200' {
    
    IF 'PVV==106&&GFC[IXA1]>=10' {
        // afternoon_tea
        /* ___ woman_elf_student_8 ___ */
        %SIZE 12 78
        %LIGHT 77:#756C6C 55
        IF 'GFC[IXA1]==11' {
            %MOBG	woman_elf_student_8 stand

        } ELSE {

            load_once = 106/30_shower
        }
        %AIM L // 10=>11 とする

        
        /* ___ alma ___ */
        %SIZE 12 68
        %PT Ev_door_shower 270 2
        %PHY
        %SP_SHIFT 0 10.5
        %AIM L
        SEEK_END
    } ELSIF 'PVV==106 && ((GFC[TIG0]>=3&&GFC[TIG1]>=2 ) || GFC[TIG0]>=4) ' {
        // 学園からグラウンドへ出撃
        @_school106_goto_ground

        SEEK_END
    }


    /* ___ student_1 ___ */
    {
        %SIZE 12 78
        %MOBG	woman_elf_thin_student_9 stand
        %PT	Ev_door0r.b -18 0
        %AIM R
    }
    /* ___ student_3 ___ */
    {

        %SIZE 12 78
    %MOBG	woman_elf_thin_sudent_6 stand colvari_1
        %PT	Ev_door0r.b 18 0
        %AIM L
    }

    IF '(PVV==105&&GFC[IXA1]>=4)||PVV==106' {

        /* ___ 105_scl_hall_mob_t01 ___ */
        %DEFINE_ON_POINT Ev..Ev_door0r
        {
            %TALK_TARGET_TTT 1
            talk = ___city/105_scl_hall_mob_t01 student_1 student_3 
        }
        %DEFINE_ON_POINT  

    } ELSE {

        /* ___ student_1 ___ */
        %POS_RANDW
        %MOVE	WALKAROUND_MAP  
        /* ___ student_3 ___ */
        %POS_RANDW
        %MOVE	WALKAROUND_MAP  
    }




} ELSE {

    /* ___ woman_elf_student_10 ___ */
    {
        %SIZE 12 78
        %MOBG	woman_elf_student_10 stand
        %PT Ev_door0 80,3
        %AIM R
        %MOVE	WALKAROUND_LR
        %TALK_TARGET_TTT 1
        talk = ___city/tdb_hall_f1_00 woman_elf_student_10
    }
}
