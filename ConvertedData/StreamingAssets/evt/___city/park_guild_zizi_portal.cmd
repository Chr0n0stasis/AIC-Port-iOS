
_focusto=$1
_ooparts_rank=2
HKDS	mb RT #<$_focusto>
HKDS	 n CLT    #<%>

TALKER_REPLACE	mb  Mob talk_mob_m9
__select_default=0
GREETING	L 26

//GLZ0 
// 1:初対面
// 2:オーパーツ購入後
WAIT 20

//GLZ2 
// 1:このセッションで初対面
IF 'GFC[GLZ0]&1==0' {
    CHANGE_EVENT2	___city/park_guild_zizi_t00

    IF 'GFC[GLZ0]&1==0' {
        SEEK_END
    }
    GFC_SET GLZ2 |=1

} ELSIF 'GFC[GLZ2]&1==0' {
    GFC_SET GLZ2 |=1
    CHANGE_EVENT2	___city/park_guild_zizi_t01
}


LABEL _RESELECT

SELECTARRAY_CLEAR
SELECTARRAY	&&Select_buying_puppet UI 
IF 'GFC[OOP0]>=1' {
    SELECTARRAY	&&Select_business_ooparts OOPARTS 
}
SELECTARRAY	&&Select_nothanks _END C

LABEL _RESELECT_NOMAKE
SELECT_FOCUS	$__select_default

MSG_HOLD
SELECT -1 


// ========================
LABEL UI
__select_default=0
MSG_HIDE
WAIT 5

SHOW_BLURSC

DENY_SKIP
WAIT 15
//STOREFLUSH city_grank
ITEMSTORE city_grank C
WAIT 8
ALLOW_SKIP
IF 'has_gz_tool&&(!gz_tool_assigned)' {
    WAIT 8
    PIC_SWIN swin_gz_tool/swin_gz_tool
    PIC_MV %W C C 0
    PIC_MV %W X Y+100 30 ZSIN
    
    TX_BOARD tips_gztool_1 '' N @CB
    WAIT_BUTTON
    PIC_HIDE_ALL	   
    WAIT 20
    
}


HIDE_BLURSC

WAIT 20
IF 'GFC[OOP0]<=1 && ItemHas[precious_ooparts]>0' {
    GFC_SET_MX OOP0 2
    MSG  ___city/park_guild_zizi_t_ooparts*mb_10
    WAIT 5
    GOTO _RESELECT
}
GOTO _RESELECT_NOMAKE
// ========================
LABEL OOPARTS
__select_default=1
MSG_HIDE
WAIT 5

CHANGE_EVENT2 ___city/park_guild_zizi_t_ooparts


WAIT 25
GOTO _RESELECT
// ========================
LABEL _END
