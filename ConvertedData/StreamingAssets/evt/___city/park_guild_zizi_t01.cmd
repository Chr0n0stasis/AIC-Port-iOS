


// 2度目の来訪

MSG	mb_11 


IF 'guildquest_rank>='$_ooparts_rank'&&GFC[OOP0]==0' {
    // 2度目の来訪以降、掘り出し物がある場合
    MSG	mb_13 


    MSG	n_14 
    GFC_SET_MX OOP0 1
    STOREFLUSH city_grank

    // CHANGE_EVENT2 ___city/park_guild_zizi_t_ooparts	
} ELSE {

    MSG	mb_12 
}



