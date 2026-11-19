DEFINENDEF 1=0
DEFINENDEF 2=0
_on_auto=$1
_from_restroom=$2

VALOTIZE 
#< % >
_egg_canceled=0
_egged=~pr_egged
IF $_egged'==0&&'$_on_auto {
    SEEK_END
}
_orgasm_abort=0
IF '!'$_from_restroom {
    #MS 'P[bench2stand~] w30 >@[-20 :60]'
    WAIT 20

    //  GOTO EGGREMOVE_FINISHED
    PIC_FILL	#0 DARK
    PIC_FADEIN	#0 45
    WAIT 50
    SND cloth_off_1
    PIC_FILL	&0 DARK
    PIC_FADEIN	&0 25
    WAIT 30
} ELSE {
    PIC_FILL	&15 DARK
    PIC_FADEIN	&15 45
    WAIT 40
    SND cloth_off_1
    WAIT 65
}
IF 'sensitive_level>0' {
    CHANGE_EVENT2 ___House/_restroom_cure_egg
    BENCH_CMD_EXECUTE cure_egged
    GOTO _END
} 

PREPARE_SV_TEXTURE cuts_peeremove




IF '!'$_from_restroom {
    SHOW_BLURSC 1
    WAIT 50
    PIC_FADEOUT	&0 60
    IF 0 {
        LABEL _FAST
        SHOW_BLURSC 1
    }
    PIC_FADEOUT	#0 20
} ELSE {
    PIC_FADEOUT	&15 60
}
IF $_egged'<=0' {
    GOTO _FASTEXECUTE
}
@_SND_SPOT_R heartbeat_l 9 50 
@_VO_SPOT_R breath_e 8 65 Noel

UIP_EVENT_SETFADE  cuts_eggremove 0 1 1 
HIDE_STATUS

// ========================
WAIT 40



UIP_REPOSIT 300 0 
UIP_PTCST ui_flash 'x=4;y=30;z=0.6; t=0'
MSG b00 K[LL]
// 器具とりだし
CLEARTL
@_VO_SPOT_R breath_e 8 65 Noel
UIP_EVENT_SETFADE  cuts_eggremove PROG0 1 1 
UIP_REPOSIT 140 290 2
UIP_PTCST ui_flash 'x=4;y=30;z=0.6; t=0'


MSG b00_2 K[LL]
// ========================
// insert
CLEARTL
@_SND_SPOT_R heartbeat_l 9 50 
UIP_EVENT_SETFADE  cuts_eggremove PROG1 1 1 
UIP_PTCST ui_flash 'x=4;y=30;z=0.6; t=0'

SND cloth_off

// UIP_PTCST ui_cuts_eggremove_p1

UIP_REPOSIT 300 0 
MSG b01 K[LL]

UIP_REPOSIT 140 290 2　// 股アップ
UIP_PTCST ui_flash 'x=4;y=30;z=0.6; t=0'
MSG b02 K[LL]
UIP_REPOSIT 300 -290 2 // 顔アップ
UIP_PTCST ui_flash 'x=4;y=30;z=0.6; t=0'
MSG b03 K[LL]

IF 0 {
    LABEL _FASTEXECUTE
    SHOW_BLURSC 1
}
IF 0 {
    LABEL _RETRY
    MGM_EGGRMV DEACTIVATE_EFFECT
    WAIT 20
}
UIP_EVENT_SETFADE  cuts_eggremove PROG1|PROG0 1 1 
UIP_REPOSIT 0 200 2
UIP_PTCST ui_flash 'x=4;y=30;z=0.6; t=0'
CLEARTL
// ミニゲーム
SHOW_STATUS

DENY_SKIP
LABEL RESTART_GAME
MGM_EGGRMV INIT LLT
IFSTR $_result IS 'orgasm' {
    WAIT 80
    SELECT_POS R
    IF $_egged'<=0' {
    SELECT 2
&&Mgm_eggremove_noegg_retry _RETRY 
&&Mgm_eggremove_noegg_abort _ORGASM_ABORT C
    } ELSE {
    SELECT 2
&&Mgm_eggremove_retry _RETRY 
&&Mgm_eggremove_abort _ORGASM_ABORT C
    }

}
IFSTR $_result IS 'cancel' {
    _egg_canceled=1
    GOTO _END
}
IF $_egged'<=0' 
    GOTO _END

LABEL EGGREMOVE_FINISHED
HIDE_STATUS

ALLOW_SKIP

PR_VOICE  must_orgasm
UIP_EVENT_SETFADE  cuts_eggremove PROG2|SMASH 1 1 
UIP_REPOSIT 200 0 1.25
UIP_PTCST ui_flash 'x=1;y=50;z=0.6; t=~0xFF47BC;'
UIP_PTCST ui_cuts_eggremove_mgm_finished
MSG b04 K[LL]

STOP_GMAIN
UIP_EVENT_SETFADE  cuts_eggremove PROG2|PROG0|SMASH 1 1 
UIP_REPOSIT 100 390 1.75
UIP_PTCST ui_flash 'x=4;y=30;z=0.6; t=0'
UIP_PTCST ui_hs
SND cloth_off
@_SND_SPOT_R heartbeat 9 80 
@_VO_SPOT_R breath_aft 12 150 
MSG b05 K[LL]
UIP_REPOSIT 200 -260 2
UIP_PTCST ui_flash 'x=4;y=30;z=0.6; t=0'
MSG b06 K[LL]
UIP_REPOSIT 140 0 1
UIP_PTCST ui_flash 'x=4;y=30;z=0.6; t=0'
MSG b06_2 K[LL]

CLEARTL

IF 0 {
    LABEL _ORGASM_ABORT
    _orgasm_abort=1
    _egg_canceled=1
}
LABEL _END
PIC_FILL	&0 DARK
PIC_FADEIN	&0 40
WAIT 42
IF '!'$_from_restroom {
    #MS_SOFT '>@[-20:0]'
    WAIT 2
    BENCH_SITDOWN % -1000 -1000 1
}
WAIT 8
MGM_EGGRMV DEACTIVATE
IF '!'$_from_restroom {
    HIDE_BLURSC 1
}
UIP_REPOSIT 0,0,1 

IF $_liqcount'+'$_eggcount'>0||'$_orgasm_abort {
    SER_APPLY SHAMED 900
}
UIP_SYNC_CUTIN HIDE
UIP_EVENT_SETFADE  0
UIP_PTCST_REMOVE ui_excrete_juice_hokahoka
WAIT 20
START_GMAIN
PIC_FADEOUT	&0 50
ALLOW_SKIP
WAIT 45
