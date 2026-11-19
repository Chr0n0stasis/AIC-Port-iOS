##USE_EVENT_VARCON##



%MOBTYPE
IF 'GFC[TIG0]>=2' {
    /* ___ tigrina ___ */
    {
        %SIZE 12 68
        %PXL sub_so
        // %PHY
    IF 'PVV==107' {
        %SP_SHIFT 0 111
        %POSE tigrinadoll
        %PT Ev_tig.b -2,55
        %LIGHT ff:#756C6C 35
        

    } ELSE {
        %SP_SHIFT 0 11
        %PT Ev_tig.b 5,0
        %POSE stand

    }
        %AIM L
        talk = ___Tigrina/___portal
    }
}

%DEFINE_ON_POINT Ev_board2

/* ___ Ev_huda ___ */
{
    check = ___Tigrina/board01
}

%DEFINE_ON_POINT 
/* ___ Ev_smnc_center ___ */
{

    %SIZE 12 68
    %PT SmnC_garage.B 0 -30
    load_once = {
        IF 'PVV==107' {
            CHANGE_EVENT2	107/_change_danger 
            
        }
        IF 'GFC[TIG0]==3&&GFC[TIG1]==0' {
            GFC_SET TIG1 1
            CHANGE_EVENT2	___Tigrina/t10
        }
    }
}

IFDEF __sporner_activate {
    %DEFINE_ON_POINT Ev_ccsporner
      
    /* ___ Ev_ccsporner ___ */
    {
        %LIGHT 01:#010101 1
    }
    %DEFINE_ON_POINT 
    
}
