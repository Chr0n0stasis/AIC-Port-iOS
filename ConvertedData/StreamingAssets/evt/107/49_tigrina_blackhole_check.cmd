// ティグリナブラックホール

<NOLOAD>
IF 'PVV==107&&GFC[IXA1]&2 ==0' {
    START_LETTERBOX
    
    GFC_SET IXA1 |=2
    STOP_GMAIN
    DENY_SKIP
    SHOW_BLURSC
    WAIT 40
    <LOAD>
    ALLOW_SKIP
    #SND_LOAD mg_blackhole
    SMNCREATOR DEFINE_CC_IS_ACTIVE citycaster_sub_i _s
    @107/51_tigrina_blackhole $_s
    #MS_ % '## #;'
    WAIT 20
    HIDE_BLURSC
} ELSE {
    #SND_LOAD mg_blackhole
}
