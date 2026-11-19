IF 'PVV<=211' {
    SUMMONER_TYPE mount_spider_coroseum NO_EFFECT NO_MANUAL_OPEN
}
IF 'PVV==210' {
    // 撃破後
    #MS_ 'alice' 'q >>[Ev_L -150,0] P[beware2] @R'
    #CMDRELOAD
    SEEK_END
}


IF '(GFC[ALC1]&8)!=0' {
    // 戦闘開始！
    
    #SND_LOAD enemy_boss
    #SND_LOAD enemy_bossspider
    ENGINE Alice200 FLOAT
    #MS_ alice '## ^ >>[Ev_Ceil 0,0] K w40'
    WAIT 2
    ENGINE Alice200 CAPTURE_FROM_CEIL
} ELSIF 'ItemHas[precious_magicdevice200]==0' {
    #MS_ 'alice' 'P[down] @R'
} ELSE {
    #MS_ 'alice' 'P[beware2] @L'
}
