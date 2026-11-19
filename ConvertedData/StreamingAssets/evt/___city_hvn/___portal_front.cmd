_target=$1
_flag=$2
_a=$3




IF 'GFC['$_flag']==0' {
    GREETING	$_a 20
    HKDS	mb CCRT #<$_target>
    TALKER_REPLACE	mb  'Mob' talk_mob_w5
    GFC_SET $_flag 1
    MSG mb_00
} ELSE {
    GREETING	$_a 50
    TALKER	n L   
    PIC   n a_1/a22__F1__f1__m1__b3__u0    
    
    MSG n_10 T
}
    

