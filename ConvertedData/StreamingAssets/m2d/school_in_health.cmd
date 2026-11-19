##USE_EVENT_VARCON##

_primla_enabled=0

%DEFINE_ON_POINT rows..Ev_door_shower 
/* ___ Ev_door_shower ___ */
{
    check = ___Laevi/trm_bath  Ev_door_shower
    %CHECK_DESC EV_access_bath
}
%DEFINE_ON_POINT 


IF 'PVV==105 || PVV==106' {
    _primla_enabled=1
    /* ___ ixia_shoe ___ */
    {
        %SIZE 12 68
        %PT Ev_bed0.b 18.5 -1.5
        %PXL sub_i
        %POSE shoe
        %PXL_MTR_USE_MASK 1
    }
        /* ___ ixia ___ */
        {
            %SIZE 82 68
            %PT Ev_bed0.b 6.5 0
            %PXL sub_i
            %POSE ev_on_bed_0
            %SP_SHIFT 0 -1.5
            talk = 105/health_ixia_portal
            %AIM T
            IF 'GFC[IXA1]>=4||PVV==106' {
                IF '(GFC[IXA3]&1)==1' {
                    %AIM L
                    %POSE ev_on_bed_1
                }
                stand = {
                    IF '(GFC[IXA3]&1)==0' {
                        #MS '@LT'
                    }
                }
            }
        }  
    IF 'PVV==105&&GFC[IXA1]<4' {
        %DEFINE_ON_POINT Ev..Ev_w_desk 
        /* ___ Ev_w_desk_105 ___ */
        {
            stand = 105/health_primula_portal
        }  
        /* ___ Ev_w_bed0_105 ___ */
        %DEFINE_ON_POINT Ev..Ev_w_bed0 
        {
            stand = 105/health_ixia_portal
        }  
        
    }
} 
IF 'PVV>=200' {
    _primla_enabled=1
}
IF $_primla_enabled {
    /* ___ primula_cane ___ */
    {
        %SIZE 12 68
        %PT Ev_primula.b 19 -0.5
        %PXL sub_p
        %AIM R
        %POSE cane_on_wall
        %PXL_MTR_USE_MASK 1
    }
    /* ___ primula ___ */
    {
        %SIZE 12 68
        %PT Ev_primula.b -5 -0.5 1
        %PXL sub_p
        %PHY
        %POSE chair
        %MOVE SEE_AROUND
        %SP_SHIFT 0 10.5
        talk = 105/health_primula_portal
        %AIM T
    }  
}


IFDEF ___2weekattack {
    // 2weekattack 進行中
    /* ___ 2w0 ___ */
    {
        %SND_LOAD ev_2weekattack
    }
}
