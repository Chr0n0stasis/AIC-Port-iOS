
GREETING	L 30

DEFINENDEF 1=
_mkey=$1

WAIT 20
HKDS	n  R #<%> 
TALKER_REPLACE	mb1 Mob  talk_mob_w3
HKDS	mb1 CCRT '#<'$2'>' // 右
#MS_ $2 '@#[%::60]'

// 獣人のシスター。小さなお墓の前で

IF GFC[$_mkey]==0 {
    GFC_SET $_mkey 1
    MSG	mb1_0
} ELSE {

    MSG	mb1_10
}

