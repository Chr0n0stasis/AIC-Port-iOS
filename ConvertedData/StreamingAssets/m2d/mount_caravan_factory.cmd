%TALK_TARGET_TTT 1


/* ___ man_bst_engineer_4 ___ */
{
    %SIZE 12 78
    %MOBG	man_bst_engineer_4 stand colvari_2
    %PT Ev_LT.b 40
    %MOVE WALKAROUND_MAP
    %AIM LR
}

/* ___ man_bst_engineer_1 ___ */
{
    %SIZE 12 78
    %MOBG	man_bst_engineer_1 stand colvari_1
    %PT Ev_RT.b 20
    %MOVE WALKAROUND_MAP
    %AIM LR
}

/* ___ man_bst_engineer_2 ___ */
{
    %SIZE 12 78
    %MOBG	man_bst_engineer_2 stand colvari_2
    IF '!mount_caravan_elevator_enabled' {
        %PT Ev_C.b -10
        // %MOVE WALKAROUND_MAP
        %AIM R
        talk = ___mountain/_caravan_elevator_t00 'MOB0' man_bst_engineer_2
    } ELSE {
        %PT Ev_LL.b 50
        // %MOVE WALKAROUND_MAP
        %AIM L
    }
}

/* ___ man_bst_arigator_2 ___ */
{
    %SIZE 12 78
    %MOBG	man_bst_arigator_2 stand colvari_2
    %PT Ev_R.b -80
    %MOVE WALKAROUND_MAP
    %AIM LR
}
