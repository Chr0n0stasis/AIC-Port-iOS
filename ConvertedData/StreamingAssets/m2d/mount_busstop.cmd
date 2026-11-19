##USE_EVENT_VARCON## 
DEFINENDEF _11_escape_after=0

IF '200<=PVV&&PVV<=201' {
    IF $_11_escape_after {
        
        /* ___ ixia ___ */  
        {
            
            %PXL sub_i
            %PHY
            %SIZE 12 68
            %POSE stand
            %SP_SHIFT 0 1.5
            %PT Ev_qa200_8.Lb -130 -30
        }
    } ELSE {
        %DEFINE_ON_POINT Ev_qa200_8rbb 
        /* ___ Ev_qa200_8rbb ___ */  
        {
            %PXL_LOAD sub_i
            stand = {
                #VANISH
                IF '200<=PVV&&PVV<=201&&Exist_mover[alice]' {
                    #< alice >
                    #MS '>>[Ev_center.b 0,0] @R P[beware]'
                }
            }
        }  
            
        %DEFINE_ON_POINT Ev_qa200_8rb
        /* ___ Ev_qa200_8rb ___ */  
        {
            stand = {
                #VANISH
                IF '200<=PVV&&PVV<=201&&Exist_mover[alice]' {
                    CHANGE_EVENT 200/11_escape08 1
                }
            }
        }
        %DEFINE_ON_POINT   
        
    }
}

IFDEF 22b_ixia_rescure_after {
    /* ___ ixia ___ */  
    {
        
        %PXL sub_i
        %PHY
        %SIZE 12 68
        %POSE stand_cane
        %SP_SHIFT 0 1.5
    }
}


IF wplmode {
    %DEFINE_ON_POINT Ev_Tuto  
    /* ___ Ev_wpl_tuto ___ */  
    check = {
        GREETING L 5
        WAIT 15
        TX_BOARD Board_WePlay_busstop
    }
}
