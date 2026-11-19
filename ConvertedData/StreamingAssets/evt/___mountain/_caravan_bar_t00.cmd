GREETING	L 20

DEFINENDEF 1=MOB9
_mkey=$1



WAIT 20
HKDS	mb CRT '#<'$2'>' // 右
HKDS	n  LT #<%> 
TALKER_REPLACE	mb Mob  talk_mob_m4

// #MS_ $2 '@#[%::60]'


IF 'GFC['$_mkey']==0' {
    GFC_SET $_mkey 1
    MSG	mb_00 


    MSG	mb_01 


    MSG	mb_02 


    MSG	mb_03 
}

// _foc_default=0
SHOW_BLURSC

DENY_SKIP
WAIT 20
ITEMSTORE caravan_bar C
WAIT 8
ALLOW_SKIP

HIDE_BLURSC


// } ELSE {
//     MSG	mb_10

// }
