DENY_MSGLOG
STOP_LETTERBOX
DENY_SKIP

_on_sitdown=0
_success_event=
_fail_event=
IFDEF 1 
    _on_sitdown=$1 // ベンチに座った時点での強制実行なら 1
IFDEF 2
    _success_event=$2
IFDEF 3
    _fail_event=$3

_masturb_success=1

IF 'sensitive_level>=2' {
    GOTO SEE
}
VALOTIZE 1
STOP_GHANDLE
WAIT 20
ALLOW_SKIP
IF 'masturbate_count>0 || TRUE' {
    // BENCH_UIPIC_SLIDE
    _bench_auto_decline=1 // 他のベンチイベントに接続しない

    SELECT 2
    &&Select_see_masturbate SEE
    &&Select_skip SKIP C

    LABEL SKIP
    PIC_FILL #9 0xff3A3434 
    PIC_FADEIN #9 15
    WAIT 17
    BENCH_CMD_EXECUTE cure_ep 1
    PIC_FADEOUT #9 30
    WAIT 20
    // BENCH_EVENT_SUCCESS
    GOTO _RESULT
}

LABEL SEE

IF 'SENSITIVE' {
    DENY_SKIP
    // UIP_VALOTIZE 0
    PIC_FILL &9 DARK
    PIC_FADEIN &9 40
    IF 'sensitive_level<2' {
        _bench_auto_decline=1 // 他のベンチイベントに接続しない
        WAIT 65
        #< % >
        _c=~4+rand[3]
        // ========================
        LABEL ____LOOP

        PIC_FLASH	&10 15 0 20 ff:#99628F 
        PR_VOICE must
        SND kuchu
        
        WAIT ~45+rand[10]

        _c=~$_c-1
        IF $_c'>0' GOTO ____LOOP
        // ========================
        WAIT 20
        _c=~12+rand[5]
        // 
        LABEL ____LOOP2

        PIC_FLASH	&10 8 0 30 ff:#DF8CCF 
        PR_VOICE mustll
        SND kuchul

        
        WAIT ~20+rand[6]

        _c=~$_c-1
        IF $_c'>0' GOTO ____LOOP2
        // ========================
        WAIT 80
    
    } ELSE {
        WAIT 50
    }
    BENCH_CMD_EXECUTE cure_ep 1
    // START_GHANDLE
    PIC_FADEOUT &9 30
    WAIT 20
    

} ELSE {
    
    _bench_auto_decline=1 // 他のベンチイベントに接続しない
    // BENCH_ALLOC_MASTURB
    // BENCH_CMD_EXECUTE cure_ep 1
    START_GHANDLE
    BENCH_UIPIC_SLIDE
    UNLOCK_GZTOOL_SOFT
    PR_MASTURB
    LOCK_GZTOOL_SOFT
    
}

LABEL _RESULT
STOP_GHANDLE

IFSTR $_masturb_success ISNOT '' {
    IF $_masturb_success'==1' {
        IFSTR $_success_event ISNOT '' {
            CHANGE_EVENT2	$_success_event
        }
        
    } ELSIF $_masturb_success'>=0' {
        IFSTR $_fail_event ISNOT '' {
            CHANGE_EVENT2	$_fail_event
        }
    }
}
