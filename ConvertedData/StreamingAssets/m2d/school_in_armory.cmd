##USE_EVENT_VARCON## 
IF 'PVV < 107' {
    %DARK_ACTIVATE 1
    {

        /* ___ sneaker_0 ___ */
        {
            %SIZE 12 78
            %PT Ev_door_out
            %MOBG	woman_elf_thin_army_1 stand colvari_1
            %MOBG_ATLAS_WH 220 0
            load_once = ___Tigrina/106sneak__first
        }
        /* ___ sneaker_1 ___ */
        {
            %SIZE 12 78
            %PT Ev_door_out
            %MOBG	man_elf_army_3 stand
            %MOBG_ATLAS_WH 220 0
        }
        /* ___ sneaker_2 ___ */
        {
            %SIZE 12 78
            %PT Ev_door_out
            %AIM L
            %MOBG	woman_elf_thin_army_2 stand colvari_1
            %MOBG_ATLAS_WH 220 0
        }
        /* ___ sneaker_3 ___ */
        {

            %SIZE 12 78
            %PT Ev_door_out
            %AIM L
            %MOBG	woman_elf_army_2 stand
            %MOBG_ATLAS_WH 220 0
        }

        /* ___ sneaker_4 ___ */
        {
            // 竿
            %SIZE 12 78
            %PT Ev_door_out
            %AIM R
            %MOBG	man_elf_army_0 stand colvari_1
            %MOBG_ATLAS_WH 220 0

        }
        /* ___ sneaker_5 ___ */
        {

            %SIZE 12 78
            %PT Ev_door_out
            %AIM L
            %MOBG	man_elf_army_1 stand 
            %MOBG_ATLAS_WH 220 0
        }

        IF 'ItemHas[precious_memorychip]==0' {
            IF 'GFC[TIG0]==2' {
                IF '(GFC[TIG1]&3)<2' 
                    %DEFINE_ON_POINT Ev..Ev_pickup_checker
                ELSE 
                    %DEFINE_ON_POINT Ev..Ev_pickup_checker_2
                /* ___ pickup_checker ___ */
                {
                    stand = {
                        IF 'ItemHas[precious_memorychip]!=0' {
                            #VANISH
                            CHANGE_EVENT	___Tigrina/106sneak__pickup_notice
                            
                        }
                    }
                }
                %DEFINE_ON_POINT  
            }
            
        }   
        
    }



    %DEFINE_ON_POINT Ev..Ev_out
    /* ___ Ev_out ___ */
    {
        stand = ___Tigrina/106sneak__return_success
    }
} ELSIF 'PVV==107' {
    // IF '(GFC[IXA1]&12)==12' {
        // 107 TD後
        
    // }
    
    /* ___ ixia ___ */
    {
        %SIZE 12 68
        %PXL sub_i
        %PHY
        %SP_SHIFT 0 10.5
        %POSE stand
        %PT Ev_f2.b -120 0 1
         %MOVE	WALKAROUND_LR '' 2.5 0.08
    }
    
    /* ___ 107_armory_60 ___ */
    DEFINENDEF _107_60=0

    IF $_107_60'==0&&GFC[ALC1]<4' {
        load_once = 107/60_td_after_00 107_armory_60
    }

    %DEFINE_ON_POINT Ev_ExitBR  

    /* ___ Ev_ExitBR ___ */
    {

        stand = 107/59_td_after_armory_BR Ev_ExitBR
    }
    %DEFINE_ON_POINT Ev_ExitBL
    /* ___ Ev_ExitBL ___ */
    {

        stand = 107/59_td_after_armory_BR Ev_ExitBL
    }
    %DEFINE_ON_POINT Ev_f2

    /* ___ Ev_f2 ___ */
    {

        stand = 107/59_td_after_armory_BR _
    }
    %DEFINE_ON_POINT 
}
