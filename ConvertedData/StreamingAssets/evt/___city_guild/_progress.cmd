

MSG mb_00

WAIT 15


UI_GUILDQUEST city 1
WAIT 20


IF $_abortcount'>0&&'$_successcount'>0' {
    MSG mb_30   
} ELSIF $_successcount'>0' {
    IF 'GFC[GLD_MAX_RANK]<'$_cur_gq_level {
        GOTO NOWAIT_LEVELUP
    }
    MSG mb_10   
} ELSIF $_abortcount'>0' {
    MSG mb_20   
} ELSIF 'GFC[GLD_MAX_RANK]<'$_cur_gq_level {
    LABEL NOWAIT_LEVELUP
    _levelupcount=0
    @___city_guild/t_rankup 
    GFC_SET_MX GLD_MAX_RANK $_cur_gq_level
}

IF 'GFC[GLD_MAX_RANK]<'$_cur_gq_level {
    WAIT 30
    GOTO NOWAIT_LEVELUP
}

GFC_SET_MX GLD_MAX_RANK $_cur_gq_level

WAIT 20
IF 'guildquest_progressing[city]' {
    // まだ残っている
    _result=0
    MSG mb_60   
    SEEK_END
}

_result=1
MTL MSG_SKIPHOLD
MSG mb_40   

GFC_SET GLD_RENZOKU 0