

IF mount_caravan_elec_facil_error {
    /* ___ facility_error_alerm ___ */
    {
        PRE_LOAD = {
            SETMAGIC_NOMANA EV_ELEC_ALERM
        }
    }
    
}

IF 'quest_progress_f[p200_elec_facil]==3' {
    %DEFINE_ON_POINT Ev_box
    /* ___ Ev_box ___ */
    {
        check = 200/46a_elec_facil_search 
    }

    %DEFINE_ON_POINT Thunder_0  
    /* ___ Ev_cam ___ */
    {
        %LIGHT 11:#000000 4
    }

    %DEFINE_ON_POINT 
       
}

IF 'quest_progress_f[p200_elec_facil]>=4' {
    %DEFINE_ON_POINT Ev_47_evadejump_tips
    /* ___ Ev_47_evadejump_tips ___ */
    {
        %CHECK_DESC EV_access_read
        check = {
            GREETING L 
            WAIT 20
            CHANGE_EVENT 200/47_evadejump_tips
        }
    }
    %DEFINE_ON_POINT 
       
}
