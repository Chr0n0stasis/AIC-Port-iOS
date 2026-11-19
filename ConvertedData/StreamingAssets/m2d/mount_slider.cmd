##USE_EVENT_VARCON## 
DEFINENDEF _200_escape06=0
DEFINENDEF _200_escape07=0
IF 'quest_progress[p200_alice]==5||quest_progress[p200_alice]==6' {
    _200_escape06=1
}
IF $_200_escape06 {
    %DEFINE_ON_POINT Ev_qa200_7_prerope  
    
    /* ___ Ev_qa200_7_prerope ___ */  
    {
        stand = {
            
            CHANGE_EVENT 200/08_rope_pre Ev_qa200_7_prerope
        }
    }
    %DEFINE_ON_POINT   
    
}

IF $_200_escape07 {
    %DEFINE_ON_POINT Ev_qa200_7
    /* ___ Ev_qa200_7 ___ */  
    {
        %LIGHT 11:#000000
    }
    %DEFINE_ON_POINT   
    
}
