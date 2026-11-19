GREETING	L 20


DEFINENDEF 1=
_mkey=$1

WAIT 20
HKDS	mb1 CRT '#<'$2'>' // 右
HKDS	n  LT #<%> 
TALKER_REPLACE	mb1 Mob  talk_mob_w9

#MS_ $2 '@#[%::60]'


IF 'GFC['$_mkey']==0&&PVV<210' {
    GFC_SET $_mkey 1
    MSG	n_00 


    MSG	mb1_01 


    MSG	n_02 


    MSG	mb1_03 


    MSG	mb1_04 


    MSG	n_05 


    MSG	mb1_06 


    MSG	n_07 


}

// _foc_default=0
SHOW_BLURSC

DENY_SKIP
WAIT 20
ITEMSTORE caravan_vegi C
WAIT 8
ALLOW_SKIP

HIDE_BLURSC
