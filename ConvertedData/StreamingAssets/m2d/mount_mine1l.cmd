##USE_EVENT_VARCON##

%DEFINE_ON_POINT Ev_board
IF 'quest_progress_f[p200_alice]>=16' {
    /* ___ Ev_board ___ */
    {
        check = {
            GREETING R
            WAIT 20
            TX_BOARD 200/40_mine_alice*board_10

        }
    }  
}
IF Exist_mover[alice] {
    /* ___ alice ___ */ 
    {
        load_once = {

            #< alice >
            ENGINE Alice200
        }
    }
}
IF 'PVV<215' {
    IFDEF _duct_alice {
        IF $_duct_alice {
            
            
            %DEFINE_ON_POINT Ev_duct
            /* ___ Ev_duct ___ */ 
            {
                %LIGHT 44:#ffffff 90
            }

            %DEFINE_ON_POINT   
        }

    }
}
