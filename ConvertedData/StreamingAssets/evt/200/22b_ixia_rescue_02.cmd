PIC_HIDE_ALL	 
WAIT 25
__202_ixia_rescue_after=1
SUMMONER_TYPE mount_cave_honey0 NO_EFFECT NO_BORDER EVENT_ENEMY NO_HIDE_LAYER
SUMMONER_ACTIVATE mount_cave_honey0
DENY_SKIP
WAIT 5

#< HONEYCOMB_0_0 >
#MS_SOFT '##'
is_left=0
PE ZOOM2 40
IF 'GFC[IXA2]==1' {
    // left
    is_left=1
    #MS '>>[Summon_mount_cave_honey0.R -40,20]` #; '
    
} ELSE {
    is_left=0
    #MS '>>[Summon_mount_cave_honey0.L 40,20]` #; '
}
ENEMY_ADD_TICKET WALK 150
#MS_ % '@#[HONEYCOMB_0_0] P[ev_run_stop]'

WAIT 35
ALLOW_SKIP

<LOAD>
HKDS	i LT #<citycaster_sub_i>
HKDS	n RT #<%>

DOTL
TL 140 ENEMY_ADD_TICKET GUARD 152


// ハニカム型登場
MSG	i_00  A


MSG	n_01 


MSG	i_03 


// 逃走
WAIT 20
_depmap=
_deplp=
IF $is_left {
    _depmap=mount_busstop
    _deplp=Ev_center
    #MS_ % '. ## P[run] >+[-200,0 << 0.15] '
    #MS_ citycaster_sub_i '@L w11 . P[run] >+[-200,0 << 0.137] '

} ELSE {
    _depmap=mount_junk_portal
    _deplp=Ev_TR
    #MS_ % '. ## P[run] >+[200,0 << 0.15] '
    #MS_ citycaster_sub_i '@R w11 . P[run] >+[200,0 << 0.137] '
}
INIT_MAP_MATERIAL $_depmap 1

PIC_FILL #9 DARK
PIC_FADEIN #9 55

22b_ixia_rescure_after=1
WAIT 45
WAIT_FN MAP_TRANSFER

SCN_MANUAL_BGM_REPLACE ''
NEL_MAP_TRANSFER $_depmap L '!'$_deplp
WAIT 2
CLEARTL

IF $is_left {
    #MS_ % '>>['$_deplp' 15,0] @L'
    #MS_ ixia '>>['$_deplp' -40,0] @R'
    TALKER	n  R
    TALKER	i  L
    
} ELSE {
    #MS_ ixia '>>['$_deplp' 25,0] @L'
    #MS_ % '>>['$_deplp' -30,0] @R'
    TALKER	n   L 
    TALKER	i  R
}
PIC_FADEOUT #9 65
WAIT 60
HKDS	n   
HKDS	i    
 
 PIC   i i/a00L1R1__F1__f1__m1__b5_u3    
PIC   n a_3/a2__F1__f3__m1__b3_u3    
PIC_MP n HOT
22b_ixia_rescure_after!


MSG	n_10 
PIC   i i/a00L5R5__F2__f2__m1__b4_u1    

MSG	i_11 
PIC   n a_1/a00L1R1__F1__f1__m1__b2__uo    
PIC_MP n TTT

MSG	n_12 T


MSG	n_13 T

PIC   i i/a00L1R5__F1__f1__m1__b1_u1    
PIC_MOVEA i 1 HOP

PIC_MP	i ANG

MSG	i_14  A
PIC   n a_1/a22__F1__f1__m3__b1_ua    
MSG	n_15 

@_TSUKKOMI
PIC   i i/a00L5R3__F2__f2__m3__b1_u0    
PIC_MP i BLS|SWB I

MSG	i_16 IA

PIC   i i/a00L3R4__F1__f1__m1__b1_u1    
PIC_MP i EXC
MSG	i_17 
PIC   i i/a00L5R5__F2__f2__m1__b4_u1    
MSG	i_17_2 

PIC   n a_3/a0__F1__f3__m8__b1_u3    
MSG	n_18 

PIC   i i/a00L1R2__F1__f1__m4__b3_u1    
PIC_MP i SMK 
MSG	i_19 I



// →とにかく私はこの先に犯人の捜索をするから！に続く
