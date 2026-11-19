
_manual=0
_pee_time=210
START_BLURSC_TO_BEHIND
IFDEF 1
    _manual=$1
<NOLOAD>
IF '!'$_manual {
    MGM_BUN_RESTROOM 0

    IF $_result'==0' 
        SEEK_END
}
MGM_BUN_RESTROOM_LOCK 1
<LOAD>
#SND_LOAD ev_restroom

// ========================

IF $_manual'<2' {
    DENY_SKIP
    #MS_ %  'P[walk_weak~] >>[Ev_restroom.b -10,0 :40]` P[stand~]'
    WAIT 15
    LP_ACTIVATE_TO_CHIP Ev_restroom
    WAIT 25
    SHOW_BLURSC
    WAIT 20
} ELSE {
    // 飛び込む
    SHOW_BLURSC
    SND door_wood_s_open_power
    TL 15 SND foot_floor_walkin
    TL 10 SND cloth_gosogoso
    TL 50 SND cloth_off_1
    IF 'sensitive_level>0' {
        WAIT 90
        GOTO _END
    }
    WAIT 145
}

DOTL
PIC %3 mgm_bun_restroom/bg 
PIC_FADEIN %3 45
IF 'sensitive_level>0' {
    PIC_MOVE2 %3 C C-110 C C-20 50 ZSIN
    SND cloth_off_1
    GOTO _GOOUT

}
PIC_MOVE2 %3 C C+30 C C-120 50 ZSIN

IF mgm_suit_bunnyrev {
    PIC %4 mgm_bun_restroom/Costume1
} ELSE {
    PIC %4 mgm_bun_restroom/Costume0
}
PIC_FADEIN %4 60

IF $_manual'>=2' {
    SND restroom_pee_power
    PIC_MOVE2 %4 C C+940 C C-0 400 ZSIN
    PIC_MOVEA	%4  25 SCARY
    
    WAIT 160   
    WAIT_BUTTON
    SND restroom_flush
} ELSE {
    SND restroom_pee
    PIC_MOVE2 %4 C C+940 C C-0 220 ZSIN
    LABEL _GOOUT
    WAIT $_pee_time   
    PIC_HIDE_ALL	 
    MGM_BUN_RESTROOM 1
    SND restroom_flush
    HIDE_BLURSC
    #MS_ %  '= P[walk_weak~] >+[-30,0 :50] '
    WAIT_MOVE
    LP_DEACTIVATE_TO_CHIP Ev_restroom
}
LABEL _END

IF $_manual'<2' {
    HIDE_BLURSC
    ALLOW_SKIP
} ELSE {
    PIC_HIDE_ALL % 
    PIC_FILL #9 DARK
    PIC_FADEIN #9 90
    WAIT 120
}

MGM_BUN_RESTROOM_LOCK 0
