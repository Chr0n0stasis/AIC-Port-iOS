IF 'PVV==106 && ((GFC[TIG0]>=3&&GFC[TIG1]>=2 ) || GFC[TIG0]>=4)' {
    IF 'quest_progress[p106_grazia_goto_club]!=0' {
        QUEST_REMOVE  p106_grazia_goto_club 1
        QUEST_PROGRESS p106_grazia_goto_club 0
    }

    
}
