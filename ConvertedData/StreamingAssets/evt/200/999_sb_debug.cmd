
DEF_CURMAP _curmap
#SND_LOAD mg_shinebooster

IFSTR $_curmap IS 'mount_spider_coroseum' {
    #VANISH alice
    #VANISH Alice200
    WAIT 5
    
    _sb_debug=1
    IF '!Exist_mover[alice]' {
        #CMDRELOAD	IMMEDIATE IMMEDIATE_LOAD
    }
    WAIT 3
    #MS_ alice '>>[Ev_alice.R -10,0] P[stand~] ##'
    WAIT 50
    DENY_SKIP
    ENGINE Alice200 SHINEBOOSTER_RUN Ev_SBRR
WAIT 50


    
}
