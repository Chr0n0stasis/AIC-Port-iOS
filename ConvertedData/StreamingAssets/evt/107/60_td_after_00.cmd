DENY_FASTTRAVEL
DENY_WARPINJECTION
DEFINENDEF 1=%
// DEFINENDEF _from_51=0
_evtop=$1
#< % >
PIC_HIDE_ALL	'' 1

PIC_FILL #9 DARK
DENY_SKIP
#SUBMAP_HIDE _school_in_armory_tank

DANGER 0
DANGER_MANUAL 1 1
PR_CURE 1 1 1 1 1
<LOAD>

#< $_evtop >
#MS '>>[Extender_RB] ## #;'

#MS_ % '>>[Extender_RB.b 70,0] '
#MS_ ixia '>>[Extender_RB.b 70,0] '
WAIT 2

PIC_FADEOUT #9 70
IF 'GFC[ALC1]==3' {
    GFC_SET ALC1 0
    AUTO_SAVE 1
}
WAIT 40
ALLOW_SKIP


LP_ACTIVATE Extender_RB
LP_ACTIVATE Extender_LB
WAIT 40

#MS_ % '>+[-320,0 <<0.09] @R P[stand_ev~] '
#MS_ ixia 'w30 P[walk_cane] >+[-250,0 <<0.078] P[stand_cane]'

WAIT 140


#MS_ % '##'

TALKER	i R   

TALKER	n   L   
HKDS	n    
HKDS	i    

PIC   n a_3/a2__F1__f3__m1__b4_u0    
PIC   i i/a00L1R1__F2__f2__m1__b3_u2    
MSG	i_00 

PIC   i i/a00L1R2__F1__f1__m1__b1_u4    
PIC_MP i QUE
MSG	i_01 


PIC   n a_2/a0L2R3__F2__f2__m1__b3_u0    
PIC_MP n SWT2
PIC_MVA n 1 JUMP
MSG	n_02  I
PIC   i i/a00L5R1__F1__f1__m1__b5_u1    
PIC_MP i ANG

MSG	i_03 


PIC   n a_1/a22__F1__f1__m1__b3__u0    
PIC_MP n BSM|BLS
MSG	n_04 

PIC   i i/a00L1R4__F2__f2__m1__b4_u1    
MSG	i_05 


PIC_HIDE_ALL	T 
PIC_FILL #9 DARK
PIC_FADEIN #9 60

WAIT 70
#MS_ % '='
#MS_ ixia 'q'
_107_60=1
#CMDRELOAD	  IMMEDIATE IMMEDIATE_LOAD
WAIT 5

IF 'GFC[ALC1]<4' {

    SUMMONER_TYPE school_b1_out NO_EFFECT NO_BORDER NO_HIDE_LAYER NO_REVERT EVENT_ENEMY
    SUMMONER_ACTIVATE school_b1_out

    QUEST_PROGRESS p107_td_after 
}
PIC_FADEOUT #9 60

#MS_ % '>+[-30,0 :50]'
WAIT 60




IF 'GFC[ALC1]<4' {
    #< PUPPY_EVENT_0_0 >
    ENEMY_ADD_TICKET ___a/107_school_ghost_enemy_1
}
