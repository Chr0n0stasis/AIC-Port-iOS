##USE_EVENT_VARCON##

IF 'PVV>=200 && GFC[P107_MEM]==0' {
    %DEFINE_ON_POINT Ev_200_trash
    /* ___ p107_mem ___ */
    {
        %CHECK_DESC EV_remember
        check = 107/_memory_portal
    }
    %DEFINE_ON_POINT   
      
    
}
DEFINENDEF _107_first=0
IF 'PVV==107||(GFC[P107_MEM]&3)!=0' {
    // TowerDefence
    %DEFINE_ON_POINT Ev_ground_left  
    
    /* ___ td_init ___ */
    IF $_107_first'==0' {
        load_once = {
            DEFINENDEF _107_first=0
            IF $_107_first'==0' {
                CHANGE_EVENT	107/_td_portal 0
            }
        }
    } ELSE {
        trigger_a = {

        }
    }

    SEEK_END
}
%DEFINE_ON_POINT
IF 'GFC[P107_MEM]==8' {
    GOTO _107_ENSYU
}
IF 'PVV==106 && GFC[IXA1]>=8&& GFC[IXA1]<15' {
    // 演習中
    LABEL _107_ENSYU
    %DOD_CM_BEHIND_TOP

    /* ___ boss ___ */
    %SIZE 12 78
    %PHY
    %MOBG	woman_bst_teacher_3 stand
    %PT Ev_ground_tc.b 320,1
    %AIM L

    IF 'GFC[IXA1]==8' {

        /* ___ staff ___ */
        %SIZE 12 78
        
        %MOBG	woman_bst_young_teacher_parrot stand
        %DOD CM0
        %PT Ev_ground_left.b -140,0
        %AIM R
        /* ___ dev0 ___ */
        %SIZE 12 30
        %PT Ev_ground_left -100,27
        %PXL sub_l
        %POSE _magicdevice
        %DOD CM0
        
        /* ___ dev1 ___ */
        %SIZE 12 30
        %PT Ev_ground_left -50,27
        %PXL sub_l
        %POSE _magicdevice
        %DOD CM0

        /* ___ dev2 ___ */
        %SIZE 12 30
        %PT Ev_ground_left 75,27
        %PXL sub_l
        %POSE _magicdevice
        %DOD CM0
    }
    SEEK_END
}

___alma_exists=0
IFDEF ___2weekattack {
    // 2weekattack 進行中
    /* ___ 2w0 ___ */
    {
        %SND_LOAD ev_2weekattack
    }
    SEEK_END
}
IF 'PVV==105&&GFC[ALM0]==1&&GFC[ALM1]&2==0' {
    ___alma_exists=1
    /* ___ alma ___ */
    {
        %SIZE 12 68
        %PT Ev_ground_left.b 130 0
        %PXL sub_l
        %PHY
        %POSE stand
        %SP_SHIFT 0 10.5
        %AIM R
        PRE_LOAD = {
            ENGINE AlmaPVV105
        }
        LOAD_ONCE = {
            ENGINE AlmaPVV105
        }
        talk = 105/scl_ground_alma
    }
    
}



IF '104<=PVV&&PVV<=106&&GFB[CITY_2WEEKATTACK]==0' {
    // IF 'PVV==105&&GFC[IXA1]<4' {
    %DEFINE_ON_POINT Ev..Ev_2weekattack  
    /* ___ 2weekattack ___ */
    {
        IF $___alma_exists {
            stand = ___city/2weekattack_00 1
        } ELSE {
            stand = ___city/2weekattack_00 0

        }

    }
}
