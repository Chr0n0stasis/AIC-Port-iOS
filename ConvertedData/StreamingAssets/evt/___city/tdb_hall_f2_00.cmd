
GREETING	L 30
#MS_ $1 '@#[%::40]'

// HKDS	ma CLT  #<$1> 
HKDS	ma RT  #<$1> 
// TALKER_REPLACE	ma 'Mob' talk_mob_m2
TALKER_REPLACE	ma 'Mob' talk_mob_w8

IF 'GFC[MOB1]==0' {
    GFC_SET MOB1 1
    // TD後 怖かった 東2F
    MSG	ma_00 


} ELSE {
//（二回目以降。
    MSG	ma_01 
}
