GREETING	@ 40
HKDS	mb1 LT '#<'$2'>' // 右
HKDS	mb2 CCRT '#<'$3'>'

// ファーレン古株の獣人。顔が広そうだ。

DEFINENDEF 1=
_mkey=$1


WAIT 20
HKDS	n R  #<%> 
TALKER_REPLACE	mb1 Mob  talk_mob_w7b
TALKER_REPLACE	mb2 Mob  talk_mob_m9


IF 'GFC['$_mkey']==0' {
    GFC_SET $_mkey 1
// 酔っ払い1 (アリス発見前)
MSG	mb1_00 


MSG	mb2_01 


MSG	mb1_02 


MSG	mb2_03 

} ELSE {
MSG	mb1_10 


MSG	mb2_11 



}
