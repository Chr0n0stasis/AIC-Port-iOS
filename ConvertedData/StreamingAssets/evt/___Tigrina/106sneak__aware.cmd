// 見つかった
// 1: 開始Mv
// 2: phase
_iyapan_phase=~GFC[PVV106_SNEAKING_FAILURE]
IFDEF 2
    _iyapan_phase=~$2
IFDEF _album_categ {
    PIC_FILL	#9 DARK
    GOTO _ALBUM_START
}


// GFC_SET TIG1 |=4


SNEAKINGMG STOPNPC

IFNDEF 1 
    GOTO _DEBUG0

#< $1 >
#MS_ % 'P[ev_run_stop]'
#MS '@#[%::40] ##'

HKDS	mb CRT #<$1> TT
IFSTR $1 IS sneaker_0
    _talksnd=talk_mob_w3 
ELSIFSTR $1 IS sneaker_2
    _talksnd=talk_mob_w3 
ELSIFSTR $1 IS sneaker_3
    _talksnd=talk_mob_w3 
ELSE 
    _talksnd=talk_mob_m0

TALKER_REPLACE	mb Army  $_talksnd 


MSG mb_00


WAIT 30

LABEL _DEBUG0
PIC_FILL	#9 DARK
PIC_FADEIN	#9 50
WAIT 60


LABEL _ALBUM_START
PE ZOOM2 1
<LOAD>
PREPARE_SV_TEXTURE cuts_iyapan 


SNEAKINGMG CLOSE

#MS_ sneaker_0 '>>[Ev_door_out]'
#MS_ sneaker_3 '>>[Ev_door_out]'
#MS_ sneaker_2 '>>[Ev_door_out]'
#MS_ sneaker_1 '>>[Ev_door_out]'
#MS_ sneaker_5 '>>[Ev_door_out]'
#< sneaker_4 >
#LIGHT 77:#ffffff 80
#MS '>>[Ev_RRB.B -10,-36] P[stand] @R'
#MS_ % '## >>[Ev_RRB.b 56,0] #;  P[stand_weak~] @L'
DENY_SKIP
WAIT 5
PIC_FADEOUT	#9 50

__item_dropped=0
IFNDEF _album_categ {
    IF 'ItemHas[precious_memorychip]>0' {
        __item_dropped=1
        REMITEM precious_memorychip 99 -1 Alert_item_reduced_memorychip  
    }
}
WAIT 75

#< % >
CHANGE_EVENT2	___Tigrina/106sneak__iyapan $_iyapan_phase

PIC_FILL	&9 DARK
PIC_FADEIN	&9 50
WAIT 5
IFNDEF _album_categ {

    GFC_SET PVV106_SNEAKING_FAILURE +=1
    GFC_SET TIG2 |=4
    INIT_MAP_MATERIAL school_in_armory_mtgroom 1

}

WAIT 55
UIPICT_GOB_DEACTIVE 1
UIP_EVENT_SETFADE 0
PE ZOOM2 -1
PR_BREATH 

HIDE_BLURSC 1
IFDEF _album_categ
    SEEK_END

WAIT_FN MAP_TRANSFER
NEL_MAP_TRANSFER school_in_armory_mtgroom R !Ev_L
<LOAD>
#CMDRELOAD	IMMEDIATE IMMEDIATE_LOAD

WAIT 5
#< 106_sneaking_init >
#MS '## #;'
#MS_ % '>>[Ev_RR]'
WAIT 5
UIPICT_GOB_DEACTIVE 0
UIP_SETFADE 

PIC_FADEOUT	&9 60
#< % >

CHANGE_EVENT2	___Tigrina/106sneak_kabesiri '' 100


PE ZOOM2 60
PE ZOOM2 -1
#MS_ % '@L P[wakeup_b]: @R '
#MS_ % '## P[walk~] >+[50,0 :60] P[stand~]'
WAIT 40

TALKER	n L   

PIC   n a_3/a1__F1__f3__m2__b2_u1    
PIC_MP	n BLS|SWT2 


MSG n_100

PIC   n a_1/a00L1R1__F1__f1__m1__b3__u1    
PIC_MP	n BLS

MSG n_101
MSG n_102

IF $__item_dropped {
    PIC   n a_2/a0L1R3__F2__f2__m1__b4_u2    
    PIC_MP	n SMK 
    MSG n_110
}

WAIT_MOVE
