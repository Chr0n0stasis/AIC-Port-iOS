DEFINENDEF 3=0 // bgm stop
DEFINENDEF 4=0 // no wait_move
DEFINENDEF 5=0 // no first_move

PE ZOOM2 -1
PIC_HIDE_ALL
DEFINENDEF 1=-80
DEFINENDEF 2=60
 #< % >
IF $5'==0' {
    #MS '## w10 P[walk] >+['$1',0 :70] P[stand]'
} ELSE {
    #MS '## >+['$1',0]'
}
IF $3
    STOP_BGM	140 1
PIC_FILL	&9 DARK 
IF $5'==0' {
    PIC_FADEIN  &9 50
    WAIT 60
}
DENY_SKIP
SND cloth_dojo_on
WAIT 180
PIC_FADEOUT  &9 50
#< % >
PR_OUTFIT NORMAL
ALLOW_SKIP
#MS 'P[walk] >+[20,0 ] >+['$2',0 :60] P[stand_ev]'
IF $4'==0' {
    WAIT_MOVE
}
