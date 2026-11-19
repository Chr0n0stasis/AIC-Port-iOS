BENCH_UIPIC_SLIDE 0
#SND_LOAD ev_city
_bench_auto_decline=1 // 他のベンチイベントに接続しない
#< % > 
_second=10
_actihol=~SerHas[DRUNK]
_add_level=1

IF $_actihol'!=0' {
    _second=5
}

// GOTO _FAST

HKDS	n CCL @LB

PIC_FILL	#0 DARK
PIC_FADEIN	#0 25

WAIT 30

MSG	n_00 T

TL 10 SND collect_leaf
TL 52 SND collect_leaf

MSG	n_01 T

CLEARTL
WAIT 20
SND cloth_off_1




PIC_FILL	&0 DARK
PIC_FADEIN	&0 25
WAIT 30

<LOAD>
PREPARE_SV_TEXTURE cuts_peeremove
SHOW_BLURSC 1
WAIT 50

IF 0 {
    LABEL _FAST
    SHOW_BLURSC 1
    PIC_FILL	&0 DARK
    PIC_FILL	#0 DARK
}
PIC_FADEOUT	#0 20
PIC_FADEOUT	&0 60

UIP_EVENT_SETFADE  cuts_peeremove 0 1 1 
HIDE_STATUS


WAIT 40

HKDS	n LB @T TT


MSG	n_02 T
DOTL

SELECTARRAY_CLEAR
IF 'empty_bottle==0' {
    SELECTARRAY &&Select_choose_bottle CHOOSE_BOTTLE S
} ELSE {
    SELECTARRAY &&Select_choose_bottle CHOOSE_BOTTLE
}
SELECTARRAY &&Select_excrete EXCRETE C
SELECT -1

// ========================
LABEL CHOOSE_BOTTLE

SND cloth_off
TL 30 

HKDS	n LB @C ''
// 空瓶を出す

PIC_FLASH	%9 1 2 40  aa:#000000
UIP_EVENT_SETFADE  cuts_peeremove 1 1
UIP_SYNC_CUTIN 630,-520,1.76 -200 300 1.6 T 40
@_SND_SPOT_R heartbeat 14 70


MSG	n_03 T

UIP_EVENT_SETFADE 0
UIP_SETFADE 'osgm' 1 1

UI_MGMTIMER_ACTIVATE 10 0 !FAIL_PICK
UI_MGMTIMER_ADDSCORE_TX small_bottle Timer_find_bottle
TL 1 UIP_EVENT_TEMP_HIDE 1
UIGM CHOOSE_ITEM 'mtr_bottle0' _success 1

CLEARTL


IFSTR $_success IS 'mtr_bottle0' {

    // 成功
    // 放尿
    _add_level=0
    UI_MGMTIMER_DEACTIVATE
    UIP_EVENT_SETFADE  cuts_peeremove PROG0 1 1
    UIP_SYNC_CUTIN 630,-520,1.76 -270 300 1.6 T 40
    SND cloth_off_0
    TL 34 PR_VOICE must Noel

    MSG	n_50_0 T

    CLEARTL

    @_bench_excrete_juice_splash '' 0  1

    MSG	n_50 T

    PIC_FLASH	%9 1 0 45  99:#000000
    @_VO_SPOT_R breath_sleep 12 80 Noel
    UIP_PTCST_REMOVE ui_excrete_juice_splash
    UIP_EVENT_SETFADE  cuts_peeremove PROG2 1 1
    UIP_SYNC_CUTIN HIDE
    BENCH_CMD_EXECUTE_O pee 

    HKDS	n LB @T TT
    MSG	n_51 


    MSG	n_52 T


    MSG	n_53 T


} ELSIF 1 {
    LABEL FAIL_PICK
    CLEARTL
    UIP_PTCST ui_hs
    SND sys_wrong
    SND cloth_off_0
    UIGM DEACTIVATE
    UI_MGMTIMER_DEACTIVATE
    HKDS	n LB @T TT
    // ビンを出そうとしたが失敗
    UIP_EVENT_SETFADE  cuts_peeremove PROG0|SMASH 1 1
    UIP_SYNC_CUTIN HIDE
    TL 60 SND foot_ground
    MSG	n_100 

    CLEARTL
    @_bench_excrete_juice_splash 'SMASH' 1 0

    MSG	n_101 
    
    @_VO_SPOT_R breath_e 12 80 Noel
    
    PIC_FLASH	%9 1 0 45  99:#000000
    UIP_EVENT_SETFADE  cuts_peeremove PROG2|SMASH 1 1
    UIP_SYNC_CUTIN HIDE
    UIP_PTCST_REMOVE ui_excrete_juice_splash
    UIP_PTCST ui_excrete_juice_hokahoka '_delay=8.2;_count=110;'

    HKDS	n LB @T TT
    WAIT 40

    MSG	n_102 T


    MSG	n_103 
    WAIT 25


    MSG	n_104 T


    MSG	n_105 T

} ELSE {
    

    LABEL EXCRETE
    _add_level=1
    UIP_EVENT_SETFADE  cuts_peeremove PROG1|SMASH 1 1
    UIP_SYNC_CUTIN HIDE
    HKDS	n LB @T TT
    // ビンを出さない
    MSG	n_150 T

    @_bench_excrete_juice_splash 'BATTLE|SMASH' 1 1
    MSG	n_151 T
    @_VO_SPOT_R breath_e 12 80 Noel

    PIC_FLASH	%9 1 0 45  99:#000000
    UIP_EVENT_SETFADE  cuts_peeremove PROG2|BATTLE|SMASH 1 1
    UIP_SYNC_CUTIN HIDE
    UIP_PTCST_REMOVE ui_excrete_juice_splash
    UIP_PTCST ui_excrete_juice_hokahoka '_delay=8.2;_count=110;'
    WAIT 35
    HKDS	n LB @T TT
    MSG	n_152


    MSG	n_153 T

}


CLEARTL
PIC_FILL	&0 DARK
PIC_FADEIN	&0 50
WAIT 55
PIC_HIDE_ALL #T 1

HIDE_BLURSC 1


SER_APPLY SHAMED 900
UIP_SYNC_CUTIN HIDE
UIP_EVENT_SETFADE  0
    UIP_PTCST_REMOVE ui_excrete_juice_hokahoka

WAIT 20
PIC_FADEOUT	&0 50
IF $_add_level {
    DANGER_ADDITIONAL 6 0
}

WAIT 30
