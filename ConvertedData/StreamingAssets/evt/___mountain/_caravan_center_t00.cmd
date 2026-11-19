GREETING	R 30
HKDS	mb1 CCRT '#<'$2'>' // 右
HKDS	mb2 LT '#<'$3'>'


DEFINENDEF 1=
_mkey=$1

WAIT 20
HKDS	n  R #<%> 
TALKER_REPLACE	mb1 Mob  talk_mob_m0
TALKER_REPLACE	mb2 Mob  talk_mob_m8b

#MS_ $2 '@#[%::60]'
#MS_ $3 '@#[%::60]'


IF 'GFC['$_mkey']==0' {
    GFC_SET $_mkey 1

    MSG	mb1_00 


    MSG	n_01 


    MSG	mb2_02 


    MSG	mb1_03 
} ELSE {
    MSG	mb1_10 


    MSG	mb2_11 
    #MS_ $2 '@L'
    #MS_ $3 '@R'

    MSG	mb1_12 


    MSG	mb2_13 

}
