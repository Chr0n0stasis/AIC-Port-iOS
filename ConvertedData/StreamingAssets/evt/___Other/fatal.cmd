// おうち回想は ＿scenemem_portal にある
// 1: key
// 2: fadein もやるなら 1
// 3: メモリーから送る場合は true
// 4: endevent
// 5: endevent v1
// 6: afterdelay_skip
DEFINENDEF 2=0
DEFINENDEF 3=0
DEFINENDEF 4=
DEFINENDEF 5=
DEFINENDEF 6=0
__fatal_go_to_title=0
_endevent=$4
_endevent_v1=$5
_afterdelay_skip=$6
DENY_SKIP
// VALOTIZE 0
UI_DISABLE

PIC_FILL	&10 DARK
IF $2 {
    PIC_FADEIN	&10 60
    STOP_BGM	60 0
    PE_FADEINOUT BLUR 60 0 0.9 0
    
    WAIT 60
}

STOP_GHANDLE
STOP_GMAIN
STOP_GDRAW
UI_DISABLE
PIC_FADEOUT	&10 30
TITLECALL_HIDE 1
MAPTITLE_HIDE 1
FATAL $1 $3
TIPS_TEMPORARY_SHOW
<NOLOAD>
IF $__fatal_go_to_title {
    WAIT 70
    CHANGE_EVENT __M2D_GAMEOVER_TO_TITLE 1
}
IFSTR $_endevent ISNOT '' {
    <LOAD>
    _end_fatal_after=0
    CHANGE_EVENT2	$_endevent $_endevent_v1
    IF $_end_fatal_after {
        // PE_FADEINOUT BLUR 120 20 0.9 -120
        SEEK_END
    }
}

PE_FADEINOUT BLUR 120 20 0.9 -120
PIC_FILL	&10 DARK
UI_ENABLE
START_GMAIN
START_GDRAW
IF $_afterdelay_skip {
    ALLOW_SKIP
    
} ELSE {
    PIC_FADEOUT	&10 60

    WAIT 40
    ALLOW_SKIP
    WAIT_BUTTON	40 
}
