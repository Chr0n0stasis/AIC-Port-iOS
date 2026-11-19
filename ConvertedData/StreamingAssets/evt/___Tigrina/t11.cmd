// ガレージ初戦クリア。
MSG_PREFIX	so <tigrina>

IFDEF _album_categ {
    LOAD_BGM	BGM_tigrina 
    REPLACE_BGM	30 20 
    GOTO _ALBUM
}


DENY_SKIP
WAIT 50
START_LETTERBOX
PIC_FILL	#9  DARK
PIC_FADEIN	#9 60
WAIT 60
PR_CURE 1 1

LABEL _ALBUM
#MS_ % '## #; >>[Ev_tig.b -95,0] @R '
#MS_ tigrina '>>[Ev_tig 0,10] @L '
WAIT 5
PIC_FADEOUT	#9 60

WAIT 50

ALLOW_SKIP

// 一度も負けずに勝利
TALKER	so L   
TALKER	n R

PIC   n a_2/a0L1R1__F2__f2__m1__b5_u0    
IF 'GFC[TIG2]<=1' {
    PIC   so so1/a0L2R4__F1__f1__m1__e1_ua    

    MSG	so_00 
    PIC   n a_1/a00L1R1__F1__f1__m1__b3__u1    

    MSG	n_01 
} ELSE {


    PIC   so so1/a0L3R3__F1__f1__m4__e1_up    
    // 一回以上負けてから勝利
    MSG	so_02 

    PIC   n a_1/a22__F1__f1__m4__b1_ua    
    PIC_MP	n SWT 

    MSG	n_03 
}
CHANGE_EVENT	___Tigrina/t13 0
