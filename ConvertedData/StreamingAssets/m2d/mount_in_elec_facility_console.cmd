v=~quest_progress_f[p200_elec_facil]
IF '0<='$v'&&'$v'<=4' {
    %DEFINE_ON_POINT Ev_console
    /* ___ facility_console ___ */
    {
        check = 200/_elec_facility_console 
    }
    %DEFINE_ON_POINT 
    
    IF $v'==2' {
        %DEFINE_ON_POINT Ev_FrontR
        /* ___ FrontR ___ */
        {
            stand = 200/45b_elec_facil_alert 0 
        }
        %DEFINE_ON_POINT 

    }
} 
  


IF mount_caravan_elec_facil_error {
    /* ___ facility_error_alerm ___ */
    {
        PRE_LOAD = {
            SETMAGIC_NOMANA EV_ELEC_ALERM
        }
    }
    
}
