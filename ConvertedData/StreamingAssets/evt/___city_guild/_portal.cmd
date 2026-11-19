_focusto=$1
HKDS	mb CCRT #<$_focusto>
TALKER_REPLACE	mb Mob talk_mob_w3
__select_default=0


GREETING	L 15
// #MS_ $1 '@#[%::40]'
// UI_GUILDQUEST_REFINE
WAIT 20

// 1: 初回会話
// 2: 帰宅後会話
// 4: 安全地帯への帰宅フラグ

IF 'GFC[GLD0]==0' {
    _result=0
    CHANGE_EVENT2	___city_guild/t00
    IF $_result'==0' GOTO _END

    GFC_SET GLD0 3

    LABEL FROM_DESC
    
    MTL MSG_SKIPHOLD
    MSG mb_50

} ELSE {
    IF '(GFC[GLD0]&1)==0' {
        IF 'guildquest_progressing[city]' {
            // 進行中の依頼がある
            // 1: success

            _result=0
            CHANGE_EVENT2	___city_guild/_progress
            
            IF $_result'==0' 
                GOTO _END
            
            GFC_SET GLD0 |=1
            GOTO _RESELECT

        }

        GFC_SET GLD0 |=1
        MTL MSG_SKIPHOLD
        MSG mb_51
    }
}


LABEL _RESELECT

GFC_SET GLD0 &=11

SELECTARRAY_CLEAR
SELECTARRAY	&&Select_guild_get_quest UI 
SELECTARRAY	&&Select_guild_desc DESC
IF 'GFB[GUILD_HEAR_POINT]' {
    SELECTARRAY	&&Select_guild_enough_point2 ENOUGH_POINT
} ELSIF 'guildquest_rank>=1' {
    SELECTARRAY	&&Select_guild_enough_point1 ENOUGH_POINT

}
SELECTARRAY	&&Select_nothanks _END C


LABEL _RESELECT_NOMAKE
SELECT_FOCUS	$__select_default


SELECT	-1 _label
MSG_HIDE
GOTO $_label
// ========================
LABEL UI
__select_default=0
UI_GUILDQUEST city
IF 'GFC[GLD_MAX_RANK]<'$_cur_gq_level {
    WAIT 20
    @___city_guild/t_rankup 
    GFC_SET_MX GLD_MAX_RANK $_cur_gq_level
    WAIT 25
}

IF $_newquest'>0' {
    MSG ___city_guild/_progress*mb_70
    GOTO _END
}



WAIT 30

GOTO _RESELECT
// ========================
LABEL DESC
CHANGE_EVENT2	___city_guild/descryption
__select_default=1

GOTO FROM_DESC


// ========================
LABEL ENOUGH_POINT
CHANGE_EVENT2	___city_guild/enough_point
__select_default=2
IF '!GFB[GUILD_HEAR_POINT]' {
    GFB_SET GUILD_HEAR_POINT 1
    GOTO _RESELECT
}

GOTO _RESELECT_NOMAKE
// ========================
LABEL _END
