// トレジャーハントの最後があるかどうか
_treasurehunt_finish_pic=
_treasure_quest=
IF 'quest_progress_f[subquest_treasurehunt_000]==5&&visitted[mount_junku]' {
    _treasure_quest=subquest_treasurehunt_000
    _treasurehunt_finish_pic=treasurehunt2/treasurehunt_000__5
    SEEK_END
} ELSIF 'quest_progress_f[subquest_treasurehunt_001]==5&&visitted[mount_junku]' {
    _treasure_quest=subquest_treasurehunt_001
    _treasurehunt_finish_pic=treasurehunt2/treasurehunt_001__5
    SEEK_END
}
