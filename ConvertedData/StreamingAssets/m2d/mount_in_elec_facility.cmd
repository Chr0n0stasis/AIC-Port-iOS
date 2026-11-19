IF 'quest_progress_f[p200_elec_facil]==0&&(PVV>=200&&PVV<210 &&GFC[OST1]==2)' {
    %DEFINE_ON_POINT Ev_RB
    /* ___ facility_console ___ */
    {
        stand = 200/44_elec_facil_enter 
    }
    %DEFINE_ON_POINT 
    
    


}


IF mount_caravan_elec_facil_error {
    /* ___ facility_error_alerm ___ */
    {
        PRE_LOAD = {
            SETMAGIC_NOMANA EV_ELEC_ALERM
        }
    }
    
}
