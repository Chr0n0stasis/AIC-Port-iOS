
MSG	mb_00 


IF '!GFB[GUILD_HEAR_POINT]' {
    // ↑の話を聞いていない場合
    MSG	n_01 

    IF 'guildquest_point<=0' {

        // そもそもギルドの会員ではない場合
        MSG	mb_02 


        MSG	n_03 


        MSG	mb_04 
        SEEK_END
    }

    // ギルドの会員だが、↑の話を聞かず自力で見つけた場合
    MSG	mb_05 
    GOTO _SINAMONO


} 


// ↑の話を聞いていた場合
MSG n_06

MSG mb_06

MSG	n_06_2


MSG	mb_07 


LABEL _SINAMONO
MSG	mb_08 

WAIT 25
HKDS	n   
 TALKER	n L   
 

PIC   n a_3/a2__F1__f3__m1__b1_uo    
MSG	n_09  T
PIC_HIDE_ALL	 

HKDS	 n CLT    #<%>
WAIT 25

GFC_SET GLZ0 |=1

IF 'guildquest_rank>='$_ooparts_rank {
    // この時点で掘り出し物がある場合
    MSG	mb_10 
    
    MSG	___city/park_guild_zizi_t01*n_14 
    GFC_SET_MX OOP0 1
    STOREFLUSH city_grank
    // CHANGE_EVENT2 ___city/park_guild_zizi_t_ooparts	
}
