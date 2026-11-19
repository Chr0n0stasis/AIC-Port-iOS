
GREETING	@ 30
#MS_ $1 '@#[%::40]'



// HKDS	ma CLT  #<$1> 
HKDS	ma LT  #<$1> 
HKDS	n CRT #<%>

// TALKER_REPLACE	ma 'Mob' talk_mob_m2
TALKER_REPLACE	ma 'Mob' talk_mob_w11

IF 'GFC[MOB2]==0' {
    GFC_SET MOB2 1
    MSG	ma_00 
    MSG	 n_01  T
    
} ELSE {

// （二回目以降。
    MSG	ma_02
}

