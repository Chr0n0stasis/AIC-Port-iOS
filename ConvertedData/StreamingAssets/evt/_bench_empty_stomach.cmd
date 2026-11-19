<NOLOAD>
BENCH_UIPIC_SLIDE 0
IF 'is_safe_area' {
    UI_ALERT Alert_do_it_in_restroom
    SEEK_END
}
IF 'stomach==0' {
    UI_ALERT Alert_no_pee_go_out
    SEEK_END
}
IF 'sensitive_level>0' {
    DENY_SKIP
    PIC_FILL	%9 DARK
    PIC_FADEIN	%9 45
    WAIT 75
    BENCH_CMD_EXECUTE_O pee_excrete
    PIC_FADEOUT	%9 45
    WAIT 50

    SEEK_END
}

_add_level=0

#SND_LOAD ev_city
#< % >
_pr_x=~m2d_current_x
_pr_y=~m2d_current_y
#MS_ % 'P[bench2stand~] w25 >+[-20,0 :70]'

DENY_SKIP
WAIT 40
PIC_FILL	%9 DARK
PIC_FADEIN	%9 45

WAIT 50

TL 10 SND collect_leaf
TL 52 SND collect_leaf

PREPARE_SV_TEXTURE cuts_peeremove
SHOW_BLURSC 1
<LOAD>
WAIT 55
ALLOW_SKIP

UIP_EVENT_SETFADE  cuts_peeremove 0 1 1 
HIDE_STATUS
WAIT 3
PIC_FADEOUT	%9 50
WAIT 52
CLEARTL

// ========================

SELECTARRAY_CLEAR
SELECT_POS R
IF 'empty_bottle==0' {
    SELECTARRAY &&Bench_Cmd_empty_stomach_get_juice 2 S
} ELSE {
    SELECTARRAY &&Bench_Cmd_empty_stomach_get_juice 2
}
SELECTARRAY &&Bench_Cmd_empty_stomach_juice_drop 1
SELECTARRAY &&Cancel 0 C

SELECT -1 _result

IF $_result'==0' {
    GOTO _END
}

WAIT 50



IF $_result'==1' {
    // drop
    _add_level=1
    @_bench_excrete_juice_splash 'BATTLE|SMASH' 1 1 FPBCNM

} ELSE {
    // ジュース回収
    @_bench_excrete_juice_splash '' 0 1 JM
}
BENCH_CMD_EXECUTE_O pee_excrete
WAIT 80
WAIT_BUTTON 

PIC_FLASH	%9 1 0 45  99:#000000
@_VO_SPOT_R breath_sleep 12 80 Noel
IF $_result'==1' {
    // drop
    UIP_EVENT_SETFADE  cuts_peeremove PROG2|BATTLE|SMASH 1 1
    UIP_SYNC_CUTIN HIDE
    UIP_PTCST_REMOVE ui_excrete_juice_splash
    UIP_PTCST ui_excrete_juice_hokahoka '_delay=8.2;_count=110;'
} ELSE {
    // ジュース回収
    UIP_PTCST_REMOVE ui_excrete_juice_splash
    UIP_EVENT_SETFADE  cuts_peeremove PROG2 1 1
    UIP_SYNC_CUTIN HIDE
}
WAIT 80
WAIT_BUTTON 


LABEL _END


DENY_SKIP
PIC_FILL	%9 DARK
PIC_FADEIN	%9 45


WAIT 50

CLEARTL
UIP_SYNC_CUTIN HIDE
UIP_EVENT_SETFADE  0
WAIT 20
HIDE_BLURSC 1
PIC_FADEOUT %9 60

#MS_ % '>+[20,0 :60]'
WAIT 60

BENCH_SITDOWN % $_pr_x $_pr_y 1

IF $_add_level {
    DANGER_ADDITIONAL 4 0
    WAIT_FN NIGHTCON
}
