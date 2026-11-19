GREETING	R 30
HKDS	mb CCLT '#<'$2'>' // 右

DEFINENDEF 1=
_mkey=$1

WAIT 20
HKDS	n  R #<%> 
TALKER_REPLACE	mb Mob  talk_mob_m2
// TALKER_REPLACE	mb2 Mob  talk_mob_m8b


#MS_ $2 '@#[%::60]'
// #MS_ $3 '@#[%::60]'

IF 'GFC['$_mkey']==0' {
    GFC_SET $_mkey 1
    MSG mb_00
} ELSE {
    MSG	mb_10

}
