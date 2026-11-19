##USE_EVENT_VARCON## 

IFDEF _tigrina__t01 {
    /* ___ tigrina ___ */
    {

        %SIZE 12 68
        %SP_SHIFT 0 10.5
        %PXL sub_so
        %PT Ev_L 85,0
        %POSE stand
        %PHY
        %AIM R
        check = {

        }
    }
    SEEK_END
}

IF 'PVV<108&& GFC[ALC1]<2' {
    /* ___ ghost_enemy ___ */
    {
        load_once = ___a/106_school_ghost_enemy_0
    }
}
