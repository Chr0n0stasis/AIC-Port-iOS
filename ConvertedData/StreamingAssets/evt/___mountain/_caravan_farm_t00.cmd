GREETING	L 30
HKDS	mb1 CCRT '#<'$2'>' // 右

DEFINENDEF 1=
_mkey=$1

WAIT 20
HKDS	n  L #<%> 
TALKER_REPLACE	mb1 Mob  talk_mob_w7b
// TALKER_REPLACE	mb2 Mob  talk_mob_m8b


#MS_ $2 '@#[%::60]'
// #MS_ $3 '@#[%::60]'

IF 'GFC['$_mkey']==0' {
    GFC_SET $_mkey 1
    MSG mb1_00
} ELSE {

    MSG	mb1_10
    WAIT 15
    IF '!GFB[FISHING_ENABLED]' {


        MSG	n_11 T
    } ELSE {

        // ファーストに出会っている
        MSG	n_12 T


    }

}
