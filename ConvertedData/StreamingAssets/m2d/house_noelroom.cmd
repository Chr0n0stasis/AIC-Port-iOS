%SHADOW 40

IF 'PVV==7' {
    /* ___ pvv7_load ___ */
    %PT exit..Ev_scene_memory -38 0
    load = s03_1a
}

%DEFINE_ON_POINT exit..Ev_scene_memory
/* ___ scene_memory ___ */  
IF 'PVV<100' {
    check = s03_letter L
    %CHECK_DESC EV_access_read
} ELSE {
    _bgm_key=
    IF 'PVV==100' {
        _bgm_key=BGM_cornehl
    }
    check = ___House/_album_portal　Ev_scene_memory $_bgm_key
    %CHECK_DESC EV_access_scene_memory
}

%DEFINE_ON_POINT

// IF 'PVV==100 && GFC[NOE1]==1' {
//     /* ___ s10_1a ___ */
//     load_once = s10_1a
// }


// ========================================================
// MARK : 実績系
// ========================================================

%DEFINE_ON_POINT
IF 'PVV>=105' {
    
    /* ___ ixiadoll ___ */
    {
        %SIZE 12 68
        %PT Ev_ixia105 
    %SHADOW_USE 0
        %PXL sub_i
        %AIM L
        //%PXL_MTR_WITH_LIGHT
        %LIGHT 14:#333333
        %SP_SHIFT 0 31
        %POSE ixiadoll
        %DOD CM0
    }
}

IF 'PVV>=107' {
    /* ___ tigrinadoll ___ */
    {
        %SIZE 12 68
        %PT Ev_tigrina107 
        %SHADOW_USE 0
        %PXL sub_so
        %AIM R
        //%PXL_MTR_WITH_LIGHT
        %LIGHT 14:#333333
        %SP_SHIFT 0 34
        %POSE tigrinadoll
        %DOD CM0
    }
}
