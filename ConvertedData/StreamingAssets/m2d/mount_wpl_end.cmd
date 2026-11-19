##USE_EVENT_VARCON##

IF 'GFC[ALM0]==0&&PVV<=200' {
    %DEFINE_ON_POINT Ev_wpl200  
    /* ___ ixia_call ___ */
    {
        stand = {
            #VANISH
            #CALL ixia talk
        }

    }

    %DEFINE_ON_POINT   
    /* ___ ixia ___ */
    %CLEAR 

    %SIZE 12 68
    %PT Ev_ixia
    %PXL sub_i
    %PHY
    %SP_SHIFT 0 10.5
    talk = wpl/01_ixia
}
