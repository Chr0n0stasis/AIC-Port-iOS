//タワーディフェンス前後 寮生
<LOAD_EMOJI>
GREETING	R 40
MSG_PREFIX mb <s3>
HKDS	mb CLT  #<$1> 
HKDS	ma CRT  #<$2> 
TALKER_REPLACE	mb 'Mob' talk_mob_w10
TALKER_REPLACE	ma 'Mob' talk_mob_w9


IF 'PVV<200' {
    MSG_PREFIX ma <s3>

    MSG	ma_00 


    MSG	mb_01 


    MSG	ma_02 


    MSG	mb_03 


    MSG	ma_04 


    MSG	mb_05 


    MSG	ma_06 

} ELSE {
    MSG	ma_50 


    MSG	mb_51 


    MSG	ma_52 


    MSG	mb_53 


    MSG_PREFIX ma <s3><W3>
    MSG	ma_54 


    MSG_PREFIX mb <s1>
    MSG	mb_55 
}
