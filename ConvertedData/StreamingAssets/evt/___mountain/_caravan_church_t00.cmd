GREETING	L 20


DEFINENDEF 1=
_mkey=$1



WAIT 20
HKDS	mb CRT '#<'$2'>' // 右
HKDS	n  LT #<%> 
TALKER_REPLACE	mb Mob  talk_mob_w12

// #MS_ $2 '@#[%::60]'


IF 'GFC['$_mkey']==0' {
    GFC_SET $_mkey 1
    MSG	mb_0
} ELSE {
    MSG	mb_10

}
