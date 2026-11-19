// 1: skip area

VALOTIZE 1
UI_ENABLE
START_LETTERBOX
STOP_LOG_RECORD_SELECTION
STOP_BGM 10 0
STOP_GMAIN

DEFINENDEF 1=
_skip_event=$1
DEFINENDEF 2=
DEFINENDEF 3=0
_hint_header=$2
_hint_max=$3
//========================
_end_fatal_after=1
PIC_HIDE_ALL	 
 PIC_FILL #9 DARK
PIC_FILL &9 BLACK
TITLECALL_HIDE 1
MAPTITLE_HIDE 1
PIC_FADEOUT &9 60
WAIT 50


_cur_hint=0
_foc_default=-1

IF 0 {
    LABEL _TOP
    TX_BOARD_HIDE
    WAIT 20
}
SELECTARRAY_CLEAR
SELECT_POS 

_foc_skip_index=0
IF $_hint_max'>0' {
    _foc_skip_index=1
    SELECTARRAY &&Select_hint _SHOW_HINT
}

IFSTR $_skip_event ISNOT '' {
    SELECTARRAY &&Select_skipboss_q _SKIP_Q

}
SELECTARRAY &&Select_hint_cancel _END C
SELECT_FOCUS $_foc_default 
// SELECT_CLMS 2
SELECT -1
// ========================
LABEL _SHOW_HINT
_foc_default=0
TX_BOARD_HIDE
WAIT 4

TX_BOARD $_hint_header$_cur_hint  '' N @CCT
TX_BOARD_LOCK
WAIT 18

SELECTARRAY_CLEAR
SELECT_POS CB
SELECT_CLMS 2
_hint_focus=2
_enable=
IF $_cur_hint'==0' {
    _enable=s
}
SELECTARRAY &&Select_hint_previous __SHOW_HINT_PREV $_enable

SELECTARRAY &&Cancel _TOP C
_enable=
IF $_cur_hint'>='$_hint_max'-1' {
    _enable=s
    _hint_focus=1
}
SELECTARRAY &&Select_hint_next __SHOW_HINT_NEXT $_enable
SELECT_FOCUS $_hint_focus
SELECT -1

LABEL __SHOW_HINT_PREV
_cur_hint=~$_cur_hint-1
GOTO _SHOW_HINT 

LABEL __SHOW_HINT_NEXT
_cur_hint=~$_cur_hint+1
GOTO _SHOW_HINT 




// ========================
LABEL _SKIP_Q
WAIT 10
_foc_default=$_foc_skip_index
TX_BOARD skipboss_confirm_boss  '' N @CCT
TX_BOARD_LOCK
WAIT 10

SELECTARRAY_CLEAR
SELECT_CLMS 2
SELECT_POS CB
SELECTARRAY &&Cancel _TOP
SELECTARRAY &&Select_skipboss _SKIP_EXECUTE
SELECT_FOCUS 0
SELECT -1

LABEL _SKIP_EXECUTE
// スキップ実行

TX_BOARD_HIDE
WAIT 50
START_GDRAW
START_GMAIN
START_LOG_RECORD_SELECTION
HALF_BGM 0
PR_CURE 1 -1 0 0 0
CHANGE_EVENT	$_skip_event
// ========================

LABEL _END
WAIT 30
PIC_HIDE_ALL	'' 1

PE_FADEINOUT BLUR 120 20 0.9 -120
PIC_FLASH #10 0 10 80 DARK
START_GMAIN
START_GDRAW
START_LOG_RECORD_SELECTION
HALF_BGM 0
REPLACE_BGM 90 90
START_BGM 90
WAIT 40
