// 女子側

GREETING	@ 30
#MS_ $1 '@#[%::40]'

// HKDS	ma CLT  #<$1> 
HKDS	mb RT  #<$1> 
// TALKER_REPLACE	ma 'Mob' talk_mob_m2
TALKER_REPLACE	mb 'Mob' talk_mob_w0

IF 'GFC[MOB1]==0' {
    GFC_SET MOB1 1
    MSG	mb_00 
    
} ELSE {

// （二回目以降。
MSG	mb_01
}

