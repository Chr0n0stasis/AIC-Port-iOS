IF 'PVV>=105 && wplmode' {

    %DEFINE_ON_POINT Ev_RR  

    /* ___ wpl_end ___ */
    {
        check = {
            GREETING L
            WAIT 20
            TX_BOARD Board_forest2grazia_wpl
        }
    }
}
