// 男子側
DEFINENDEF 2=MOB0
_gfcm=$2
GREETING	@ 30
#MS_ $1 '@#[%::40]'

HKDS	ma CLT  #<$1> 
// HKDS	mb RT  #<$2> 
TALKER_REPLACE	ma 'Mob' talk_mob_m2
// TALKER_REPLACE	mb 'Mob' talk_mob_w0

IF 'GFC['$_gfcm']==0' {
    GFC_SET $_gfcm 1
    MSG	ma_00 
    WAIT 25

    MSG	ma_01

} ELSE {

// （二回目以降。
MSG	ma_04 
}

