##USE_EVENT_VARCON## 
IF 'PVV<107' {
    /* ___ 106_sneaking_init ___ */
    {
        %PT Ev_window
        %SIZE 10,10
        IFDEF __sneaking {
            load = ___Tigrina/106sneak_00 106_sneaking_init
        } ELSE {
            trigger_a = {

            }
        }
    }


    %DEFINE_ON_POINT Ev..Ev_board
    /* ___ board ___ */
    {
        %CHECK_DESC EV_access_read
        check = {
            CHANGE_EVENT	___Tigrina/106sneak__board
        }
    }



    %DEFINE_ON_POINT Ev..Ev_device
    /* ___ device ___ */
    {
        check = {
            CHANGE_EVENT	___Tigrina/106sneak_mtgroom_device
        }
    }

    %DEFINE_ON_POINT 

    /* ___ goout ___ */
    {
        %PT Ev_LL 10,0
        %SIZE 10,90
        %CHECK_DESC Select_back

        check = {
            CHANGE_EVENT	___Tigrina/106sneak__returnback
        }
    }
} ELSIF 'PVV==107||PVV==108' {
    /* ___ ixia ___ */
    {
        %SIZE 12 68
        %PXL sub_i
        %PHY
        %SP_SHIFT 0 10.5
        %POSE stand
        %PT Ev_Rout -10 38 1
    }
    IF 'PVV==107' {
        /* ___ alice ___ */
        {
            %SIZE 12 68
            %PXL sub_a
            %PT Ev_device.b -160,0 1
            %LIGHT 99:#555555
            %AIM L
            %PHY
            %POSE stand_ev_3
            //%PXL_MTR_WITH_LIGHT
            %DOD CM0
            %SP_SHIFT 0 10.5
            PRE_LOAD = 107/61_mtgroom_preload
            IFNDEF wpl_hachan {
                load_once = 107/62_mtgroom
            }
        }
        %DEFINE_ON_POINT Ev..Ev_device
        /* ___ device ___ */
        {
            check = {
                CHANGE_EVENT	107/70_device
            }
        }
        %DEFINE_ON_POINT   
    } ELSIF 'PVV==108' {
        %DEFINE_ON_POINT Ev..Ev_device
        /* ___ device ___ */
        {
            %PXL_CHIPIMAGE grazia_heaven_attach/magicdevice.png
            %AIM R
            %SIZE 20 20
            %PT Ev_device 0 -7
            check = {
                CHANGE_EVENT	107/70_device
            }
        }
        %DEFINE_ON_POINT   
        
    }

}
