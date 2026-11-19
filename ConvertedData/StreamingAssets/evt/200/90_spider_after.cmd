#SND_UNLOAD
STOP_BGM 90 0
DEFINENDEF _bossskip=0
START_LETTERBOX
// ここで死ぬとバグるので…
// PVV 200
DENY_SKIP
TALKER	a L    
TALKER	n R
TALKER_REPLACE	a  Mob 

IF $_bossskip {
    PIC_HIDE_ALL '' 1	 
    PIC_FILL #9 DARK
    WAIT 30
} ELSE {

    PIC_FILL #9 DARK
    PIC_FADEIN #9 55
    WAIT 60
}

PR_CURE 1 1 1 1 1 1
ENGINE Alice200 RELEASE
WAIT 2
#MS_ % '>>[Ev_C -61,0] P[collect] @LB ## #; '
#MS_ alice '>>[Ev_C -66,0] @R P[down]'
PIC_FADEOUT #9 60
ALLOW_SKIP
WAIT 30

PIC   a p1/a0L3R2__F1__e5__ua2    
MSG	a_00 
PIC_HIDE_ALL	 


WAIT 70
@_PIIN
HKDS	a  CRT #<alice> TT
#MS_ alice '! P[feared_stop] >+[-70,0 :45] ? P[crouch2beware] '
#MS_ % '! w5 P[walk] >+[30,0 :40] P[stand_ev~] ? @L'

MSG	a_01
WAIT 30

PIC   n a_1/a22__F1__f1__m1__b1__u3    
MSG	n_01 

HKDS	a    


PIC   a p1/a0L3R2__F1__e2__u1    
PIC_MP	a QUE 
// 私を殺さない……？どうして？
MSG	a_02 

PIC   n a_3/a0__F1__f3__m1__b4_u0    
MSG	n_03 
PIC   a p3/a0L2R2__F1__e3__u1    
MSG	200/102_spider_giving*a_103

PIC_HIDE_ALL	
PVV 210
GFC_SET ALC1 0
GFC_SET ALM1 0
SUMMONER_TYPE mount_spider_coroseum NO_EFFECT NO_MANUAL_OPEN
AUTO_SAVE
LOAD_LAYER RT_light
#CMDRELOAD

// HKDS	n LT 
// HKDS	alice  CRT #<alice> TT
// #MS_ alice 'P[run] @R >+[630,0 <<0.17] P[stand]'
// #MS_ % 'w25 @R P[stand_ev~]'

// MSG	n_200 

// PIC_FILL #9 DARK
// PIC_FADEIN #9 55
// WAIT 60
// SND foot_200_aliceclimb
// QA200_REMOVE_MOVER
// WAIT 120

// #MS_ Ev_L '>>[Ev_RR 0,0] ##'
// PIC_FADEOUT #9 60
// WAIT 45
// LP_ACTIVATE Layer Extender_ladder
// WAIT 80

// PIC   n a_3/a2__F1__f3__m1__b1_u0    
// MSG 200/95_spider_ladder*n_90
