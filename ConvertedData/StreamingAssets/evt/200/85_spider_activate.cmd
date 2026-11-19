IF 'PVV>=210' {
    #VANISH
    SEEK_END
}
IF '(GFC[ALC1]&8)==0' {
    GFC_SET ALC1 8
    WAIT 15
    TALKER	n L    
    PIC   n a_3/a2__F1__f3__m1__b1_u0    
    MSG n_00
    PIC   n a_2/a0L3R1__F2__f2__m1__b1_u0        
    MSG n_01 A
}

SUMMONER_TYPE mount_spider_coroseum NO_REVERT NO_EFFECT
SUMMONER_ACTIVATE mount_spider_coroseum
SUMMONER_ACTIVATE_EFFECT EVENT
