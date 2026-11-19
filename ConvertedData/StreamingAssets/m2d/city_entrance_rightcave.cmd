%MOBTYPE _
%DEFINE_ON_POINT Ev..Ev_restroom
{
    /* ___ restroom ___ */
    %CHECK_DESC EV_access_restroom2
    check = {
        CHANGE_EVENT ___House/noelhouse_restroom 1 1 '' Ev_restroom
    }
}  

%DEFINE_ON_POINT Ev..Ev_stop
/* ___ stopper ___ */  
{
    stand = {
        CHANGE_EVENT ___city/entrance_stopper R Ev_stop stopper
    }
}

%DEFINE_ON_POINT Ev..Ev_stop_t
/* ___ stopper_t ___ */  
{
    stand = {
        CHANGE_EVENT ___city/entrance_stopper R Ev_stop_t stopper_t
    }
}


IF 'PVV==200&&quest_progress_f[p200_alice_veryfirst]<=0&&quest_progress_f[p200_alice]==-1' {
    %DEFINE_ON_POINT WarpTo  
    /* ___ p200_intro ___ */  
    {
        load_once = {
            #VANISH
            CHANGE_EVENT 200/00_from_city WarpTo
        }
    }

    
}  

%DEFINE_ON_POINT Ev_board

/* ___ board_event ___ */
{
    %CHECK_DESC     EV_access_read
    check = ___city/guild_news R
}
%DEFINE_ON_POINT 
