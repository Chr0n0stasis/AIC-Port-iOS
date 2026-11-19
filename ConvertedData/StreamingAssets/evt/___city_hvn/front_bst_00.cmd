// 1: target Ev
// 2: flag
_target=$1
_flag=$2

GREETING	@ 20

#MS_ $_target '@#[%::40]'
HKDS	mb CCRT #<$_target>
TALKER_REPLACE	mb  'Mob' talk_mob_m0

IF 'GFC['$_flag']==0' {
    GFC_SET $_flag 1
    MSG mb_00
} ELSE {
MSG mb_01
    GFC_SET $_flag 0
}
    