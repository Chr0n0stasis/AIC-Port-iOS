%DOD_CM_BEHIND_TOP
%SHADOW 40
%TALK_TARGET_TTT 

/* ___ front_R ___ */
{
    
    %SIZE 12 68
    %MOBG	woman_bst_sister_2 stand
    %PT Ev_counterR 0,20
    %SHADOW_USE 0
    
    %AIM R 
    %DOD CM0
    talk = ___city_hvn/___portal_front front_R MOB0 R
}

/* ___ front_L ___ */
{
    
    %SIZE 12 68
    // %SP_SHIFT 0 3.5
    %MOBG	woman_bst_sister_1 stand
    %PT Ev_counterL 0,20
    %SHADOW_USE 0
    %AIM L
    %DOD CM0
    talk = ___city_hvn/___portal_front front_L MOB0 L
}


/* ___ mob00 ___ */
{
    
    %SIZE 12 68
    // %SP_SHIFT 0 3.5
    %MOBG	man_bst_young_6 stand
    %MOVE WALKAROUND_LR '' 0.4
    %PT Ev_RR.b 120 -6
    %AIM LR
    talk = ___city_hvn/front_bst_00 mob00 MOB1
}





/* ___ walker_00 ___ */
{
    
    %SIZE 12 82
    %PHY
    %MOBG	woman_bst_sister_3 stand
    %AIM LR
    %MOVE	WALKAROUND_MAP
    %POS_RANDW

}
