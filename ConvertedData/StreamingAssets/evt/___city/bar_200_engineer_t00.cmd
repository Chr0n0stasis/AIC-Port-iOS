GREETING	R 30
HKDS	mb1 CCRT '#<'$2'>' // 右
#MS_ $2 '@#[%::60]'

DEFINENDEF 1=
_mkey=$1

WAIT 20

HKDS	n  R #<%> 
TALKER_REPLACE	mb1 Mob  talk_mob_m2


IF 'GFC['$_mkey']==0' {
    GFC_SET $_mkey 1


    MSG	mb1_1 
} ELSE {
    MSG	mb1_10 

}



