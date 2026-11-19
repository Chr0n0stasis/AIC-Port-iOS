##USE_EVENT_VARCON##
DEFINENDEF _199_alice_recast=0

IF 'PVV<211' {
    
    %DEFINE_ON_POINT Ev_yuri_no_aida_ni_hasamaru_camera
    /* ___ Ev_yuri_no_aida_ni_hasamaru_camera ___ */
    {
        trigger_a = {
            
        }
    }
    %DEFINE_ON_POINT   
      
    
}

IF 'PVV<215' {
    %DEFINE_ON_POINT Ev_200finish
    /* ___ Ev_200finish ___ */
    {
        stand = 200/199_alice_unconscious Ev_200finish
        load_once = {
            #SND_LOAD ev_mountain
        }
    }

    %DEFINE_ON_POINT   
    IF $_199_alice_recast {
        /* ___ alice ___ */
        %SIZE 12 68
        %PXL sub_a
        %LIGHT 44:#555555
        %AIM R
        %PHY
        %PT Ev_qa200_26

    }
    
}
