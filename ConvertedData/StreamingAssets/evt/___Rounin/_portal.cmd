GREETING	@ 10
_ev_name=$1
#MS_ $_ev_name '@#[%::40]'
HKDS	ro CCRT '#<'$_ev_name'>'
TALKER_REPLACE	ro Mob  talk_mob_w1



WAIT 20
// RON2...
// 1: : 話したかどうか
// 2: 回復をした
// 4: TIPSを出し切ったためにつなぎのテキストをあげる
_cnct=0 // ところで……とかを出すかどうか
IF 'GFC[RON2]&2==0&&(SerHas[HP_REDUCE]||noel_torned||SerHas[POISON])' {
    GFC_SET_MX RON0 1
    GFC_SET RON2 |=1

    CHANGE_EVENT2	___Rounin/t_cure
    IF $_result {
        GFC_SET RON2 &=11
        GFC_SET RON2 |=2
        SEEK_END
    }
    // ところで……でTIPSをあげる
    _cnct=1
} ELSIF 'GFC[RON2]&1==0' {
    GFC_SET RON2 |=1
    CHANGE_EVENT2	___Rounin/t_intro 
    
    GFC_SET RON0 +=1
    ROUNIN DEFINE_ALL_SHOWN _all_shown
    IF $_all_shown'&&PVV>=103&&rand[100]<75' {
        GFC_SET RON2 |=4
        ROUNIN PROGRESS_TIPS_TSUNAGI  
        IF $_cnct {
            WAIT 25
            _cnct=0
        }
    }

}

IF $_cnct {
    // ところで……
    CHANGE_EVENT2	___Rounin/t_cnct_tips
}

IF 'GFC[RON2]&4' {
    // つなぎ
    CHANGE_EVENT2	___Rounin/t_tsunagi
    SEEK_END
}   

ROUNIN DEFINE_CURRENT_KEY _key
ROUNIN WATCHED
MSG '___Rounin/'$_key'*ro_00'
