// GFC MOB9: 魚チュートリアルに使用
// GFC MOB8: 連続ミス数
// GFC MOB18: チュートリアルを見たらいったん 1

IF 'GFC[FHM0]==0' {
        
    IF 'GFC[FHM1]==0' {
        %DEFINE_ON_POINT Ev_housefill
        /* ___ ev_first_stand ___ */
        {
            stand = {
                #VANISH
                #CALL	ev_first TALK 
            }
        }
        %DEFINE_ON_POINT   
        
        
    }
    /* ___ firstrod ___ */
    {
        %SIZE 12 42
        %PXL sub_firstman_npc
        %POSE rod_on_wall
        %LIGHT ff:#756C6C 55
        %PT Ev_firstrod.b 8,8
    }

}
/* ___ ev_first ___ */
{
    %SIZE 12 28
    %PT Ev_first 2 22
    %AIM L
    %MOVE SEE_AROUND
    %TALK_TARGET_TTT 0
    talk = ___firstman/_portal        
    PRE_LOAD = {
        #CALL ev_first load_once
    }
    load_once = {
        ENGINE_NNEA Firstman INIT sub_firstman_npc 
        ENGINE_NNEA Firstman CHECKPOINT_ASSIGN FishPond
        ENGINE_NNEA Firstman BGM_ASSIGN FishPond
        IF 'GFC[FHM0]>0' {
            FISBGM fis0 1 
            FISBGM fis1 1 
        } ELSIF 'GFC[FHM1]>0' {
            FISBGM fis0 1 
        }

        IF 'GFB[FISHING_TUTO_FIRST]&& total_mgm_fis_success<=2' {
            GFB_SET FISHING_TUTO_FIRST 0
        }
        IF 'quest_progress_f[subquest_treasurehunt_000]==5' {
            // QUEST_FINISH subquest_treasurehunt_000
        }
        IF 'quest_progress_f[subquest_treasurehunt_001]==5' {
            // QUEST_FINISH subquest_treasurehunt_001
        }
    }
}


IF 'GFB[FISHING_ENABLED]' {

    %DEFINE_ON_POINT Ev_craft   
    /* ___ Ev_craft ___ */
    {
        %CHECK_DESC EV_access_alchemy
        check = ___firstman/_craft
    }
    %DEFINE_ON_POINT Ev_FishChair
    /* ___ Ev_FishChair ___ */
    {
        %CHECK_DESC EV_access_fishing
        check = ___mountain/_mgm_fis_mount_house  

    }
    %DEFINE_ON_POINT
}
