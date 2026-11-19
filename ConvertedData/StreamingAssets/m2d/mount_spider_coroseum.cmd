##USE_EVENT_VARCON##
// アイテム与えた回数の計上に ALM1 を使う。

IF '200<=PVV&&PVV<210' {
    DEFINENDEF _drop_magicdevice=0
    IF 'quest_progress[p200_alice]>=24' {
        // 行き止まり破壊後
        %DEFINE_ON_POINT Ev_L 
        /* ___ Ev_L ___ */
        {
            trigger_a = {

            }
        }  
        %DEFINE_ON_POINT   
        IF '(GFC[ALC3]&1)==1' {
            /* ___ drop_magicdevice ___ */
            {
                %PXL sub_a
                %SIZE 2,60
                %POSE magicdevice
                %PT Ev_L -10,0
                %SP_SHIFT 0 -50
                %LIGHT 11:#FFFFFF
                check = 200/79_pickup_magicdevice
                
            }
            %DEFINE_ON_POINT Ev_alice
            /* ___ Ev_alice_retouch ___ */
            {
                stand = {
                    IF 'ItemHas[precious_magicdevice200]>0' {
                        #VANISH
                        CHANGE_EVENT	200/81_spidercave1
                    }
                }
            }
            %DEFINE_ON_POINT   
        }
        IF 'Exist_mover[alice]' {
            /* ___ alice ___ */
            {
                %PXL sub_a
                IF '(GFC[ALC3]&1)==1' {
                    talk =	200/81_spidercave1 alice
                } ELSIF 'ItemHas[precious_magicdevice200]>0' {
                    talk =	200/81_spidercave1 alice
                } 
            }
        }
        IF 'GFC[ALC1]&8==8' {
            %DEFINE_ON_POINT Ev_smn_activator
            /* ___ smn_activator ___ */  
            {
                stand = {
                    #VANISH
                    CHANGE_EVENT	200/85_spider_activate
                }
            }
            
        }

          
        
    }
} ELSIF 'PVV==210 && (GFC[ALC1]&2)==0' {
    IF 'Exist_mover[alice]' {
        /* ___ alice ___ */
        {
            %PXL sub_a
            talk = 200/102_spider_giving
        }
    }
    %DEFINE_ON_POINT   Ev_SBRRR
    /* ___ Ev_SBRRR ___ */
    {
        check = 200/101_see_ladder Ev_SBRRR
    }
    %DEFINE_ON_POINT Ev_alice_in
    /* ___ Ev_alice_in ___ */  
    {
        stand = {
            IF 'PVV==210&&(GFC[ALC1]&3)==1' {
                #MS_ '%' 'F >+[-40,0 :36]'
                CHANGE_EVENT	200/103_spider_waiting_prepare 36 0
                
            }
        }
    }
    %DEFINE_ON_POINT   
    
    
}


DEFINENDEF _sb_debug=0
IF $_sb_debug {
    /* ___ alice ___ */
    {
        
        %SIZE 12 68
        %PXL sub_a
        %LIGHT 44:#555555
        %AIM R
        %PHY
        %PT Ev_L -90,0
       
    }
}
