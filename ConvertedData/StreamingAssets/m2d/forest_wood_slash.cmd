IF 'PVV<5&&!GFB[PVV0_YORIMICHI]' {
    %DEFINE_ON_POINT Ev_s00_4a
    /* ___ s00_4a ___ */  
    {
        stand = s00_4a
    }
}
%DEFINE_ON_POINT



IF 'GFB[FISHING_ENABLED]' {
    %DEFINE_ON_POINT Ev_FishChair
    /* ___ Ev_FishChair ___ */
    {
        %CHECK_DESC EV_access_fishing
        check = ___mountain/_mgm_fis_forest_wood_slash  

    }
    %DEFINE_ON_POINT
}
