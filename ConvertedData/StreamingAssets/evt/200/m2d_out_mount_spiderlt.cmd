

IF 'quest_progress_f[p200_alice]==23' {
    IF 'noel_cane_itemdrop' {
        CHANGE_EVENT2	200/69_no_cane
        
        _result=0
        SEEK_END
    }
    SCN_MANUAL_BGM_REPLACE ''


}
