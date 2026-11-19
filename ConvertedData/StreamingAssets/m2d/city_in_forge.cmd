// MOB7 ... 杖なし会話
%TALK_TARGET_TTT 1
%DOD_CM_BEHIND_TOP

/* ___ mobsrng ___ */
{
    %SIZE 12 68
    %PXL sub_mob
    %SP_SHIFT 0 3.5
    %PT Ev..Ev_counter
    %POSE srng_stand
    %DOD CM0
    %AIM L
    talk = ___city_forge/__portal mobsrng
    load_once = {
        ALLOW_FASTTRAVEL
        FORGE_TESTFIRE_INIT
        GFB_SET FITTING 0
        IF 'quest_progress[city_forge_access]==0' {
            QUEST_FINISH city_forge_access H
        }
    }
}


/* ___ smith ___ */
{
    %SIZE 12 68
    %PXL sub_mob_forger
    %SP_SHIFT 0 -3.5
    %PT Ev..Ev_chair -12 0
    // %PXL_MTR_USE_MASK 1
    %POSE sit_hammer
    %DOD CM0
    %AIM L
    talk = ___city_forge/___smith_portal mobsrng
}

%DEFINE_ON_POINT Ev_board  

/* ___ board_recruit ___ */
{
    %CHECK_DESC EV_access_read
    check = ___city_forge/board_recruit mobsrng
}
