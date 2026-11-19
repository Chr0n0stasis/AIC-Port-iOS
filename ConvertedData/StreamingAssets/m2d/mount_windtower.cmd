##USE_EVENT_VARCON## 

DEFINENDEF __43_ostrea_panup=0 
IF $__43_ostrea_panup {
    %DEFINE_ON_POINT Ev_doorR  
    /* ___ 43_ostrea_panup ___ */
    {
        
        %LIGHT 10:#ffffff 100
    }
    %DEFINE_ON_POINT   
    
}
// %DARK_ACTIVATE


IF 'quest_progress[p200_elec_facil]>=3' {
    %DEFINE_ON_POINT Ev_facility_out  
    /* ___ _46c_elec_facil_escaped ___ */
    {
        stand = 200/46c_elec_facil_escaped _46c_elec_facil_escaped
    }

    %DEFINE_ON_POINT   
        
}
