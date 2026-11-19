
IF 'GFC[TLD_BOX]==0' {
    GFC_SET TLD_BOX 1
    PIC   n a_1/a22__F1__f1__m4__b1_ua    
    PIC_MP n SWT2
    PIC   d d1/a0L1R2__F1__m1__b1_u2_2    
    MSG n_00

PIC   d d1/a0L1R3__F1__m1__b2_ua    
PIC_MP	d QUE 

    MSG d_01

    PIC   n a_3/a0__F1__f3__m8__b1_u0    
    PIC_MOVEA	n 1 JUMP

    MSG n_02
    PIC   d d1/a0L1R1__F1__m1__b4_ua    
    PIC_MP d HOT
    MSG d_03


    WAIT 15
}
    WAIT 5
TX_BOARD *board_00 '' N @CCT
TX_BOARD_LOCK
WAIT 30
_flag_open=~ItemCategoryHas[@REEL]
SELECTARRAY_CLEAR
IF $_flag_open'>0' {
    _flag_open=
    _select_focus=0
} ELSE {
    _flag_open=S
    _select_focus=1
}
SELECTARRAY &&Select_tilde_open_box OPENBOX $_flag_open
SELECTARRAY &&Select_nothanks SKIP C
SELECT_FOCUS $_select_focus
SELECT_POS CCB
SELECT -1

// ========================
LABEL SKIP
TX_BOARD_HIDE
SEEK_END

// ========================
LABEL OPENBOX
TX_BOARD_HIDE
PIC_HIDE_ALL	

UIGM CHOOSE_ITEM @REEL _result 0

IFSTR $_result IS '' {
    WAIT 20
    SEEK_END
} 
// 選択した

WAIT 10
OPEN_REELBOX_ACTIVATE_ONE $_result $__grade __reel_result 0.3

IF $__reel_result'>0' {
    GFC_SET TLD_BOX 2
}
WAIT 15
