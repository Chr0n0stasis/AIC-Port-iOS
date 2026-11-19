//  mount_busstop 洞窟逃げアリス 戦闘終了後
#< % >
DEFINENDEF 1=0
_noel_defeated=$1
_11_escape_after=1
START_LETTERBOX

HIDE_STATUS
ALLOW_SKIP
HALF_BGM
IF $_noel_defeated {
    // defeated 2なら敗北時に無理やり進行している

    LOAD_BGM BGM_mountain NormalMountain
    STOP_BGM 40 0
    PIC_FILL	%9 DARK
    PIC_FADEIN	%9 20
    WAIT 20
    STOP_GMAIN
    WAIT 15
    HKDS	i CLT @C TT 
    

    // 11_escape08に負けた時
    MSG	i_50 

    START_GMAIN
    DENY_SKIP
    WAIT 20
    #CMDRELOAD	IMMEDIATE IMMEDIATE_LOAD
    
    
    WAIT 10
    ALLOW_SKIP
    PE ZOOM2 1
    #MS_ ixia '>>[Ev_center.b -40,-13] P[stand_cane] @R'
    #MS '>>[Ev_center.b] P[down_b] @L'
    PIC_FADEOUT	%9 100
    WAIT 80

    @__M2D_GAMEOVER_WAKEUP_WAIT
    IF $_noel_defeated'==2' {
        #MS '! P[wakeup_b]:60'
    } ELSE {
        #MS '! P[stand_weak~] w60'
    }
    #MS '>+[20,0 :70] ? P[stand_weak~]'

    WAIT 70
    HKDS	i
    TALKER	i L   
    TALKER	n R   
    
    PIC   n a_3/a1__F1__f3__m2__b1_u1     I
PIC_FINE n
    PIC_MOVE2 n P P-230 D D 80 ZSIN
    PIC_FADEIN n 80
PIC   i i/a00L1R1__F1__f1__m1__b5_u3    

    TL 50 REPLACE_BGM 200
    MSG	n_51 
    PIC   i i/a00L1R2__F2__f2__m1__b4_u1    
    PIC_MP i HOT

    MSG	i_52 

    PIC   n a_2/a0L1R3__F2__f1__m2__b1_u0    
    PIC_FINE n
    PIC_MOVEA	n 14 SCARY

    MSG	n_53 

PIC   i i/a00L1R5__F1__f1__m1__b1_u1    
PIC_MP i EXC
    MSG	i_54 
DOTL
    PE ZOOM2 50

} ELSE {

    TALKER	n L
    PIC_FILL	%9 DARK
    PIC_FADEIN	%9 60
    WAIT 62

    #MS '>>[Ev_center.b] @R P[stand_ev]'

    WAIT 2
    PIC_FADEOUT	%9 60

    WAIT 45
    PIC   n a_3/a2__F1__f3__m1__b3_u0    
    PIC_MP n SMK
    MSG	n_02 
    PIC_HIDE_ALL	 
    DENY_SKIP
    WAIT 10
    #CMDRELOAD	IMMEDIATE IMMEDIATE_LOAD
    WAIT 20
    

    #MS_ ixia ' >>[Ev_qa200_8.Lb 30,-40 ] @R P[fly] >+[290,0 :120] ^ -G K >>[Ev_center -50,-80 <<0.13] _ +G P[fly2stand]'
    #MS_ % 'P[beware] w120 @L w25 ! P[walk] >+[30,0 :70] P[stand_ev~] ?'

    WAIT 180

    ALLOW_SKIP
    TALKER	i L   
    TALKER	n R   
    PIC   i i/a00L1R5__F1__f1__m1__b1_u1    
    PIC_MP i SWT2
    PIC   n a_1/a00L1R3__F1__f1__m1__b1__u1    
    MSG	i_03 

}


    TALKER	i L   
    TALKER	n R

PIC   n a_3/a0__F1__f3__m1__b4_u0    
MSG	n_04 


PIC   i i/a00L5R3__F1__f1__m5__b0_u3     I
PIC_MOVEA	i 2 JUMP
PIC_MP i AWK
@_TSUKKOMI

MSG	i_04 I
PIC   n a_1/a22__F1__f1__m5__b1_u1    
PIC_MP n SWT

MSG	n_05 

PIC_HIDE_ALL	 
WAIT 30
#MS_ ixia '## P[appeal]'

HKDS	i LT #<ixia>

MSG	i_06 

PE ZOOM2 -1
#MS_ ixia '#~ _ P[stand2fly] ? @R >>[Ev_center.Rb 0,0<<0.12] <<[0.12,0 h200] A[4] K <<[0.03,0 r20] P[fall] '
#MS 'w20 P[stand_awake] w110 @R P[stand_ev]'
WAIT 120
TALKER	n L    

PIC   n a_2/a0L1R3__F2__f2__m1__b5_u2    
MSG	n_07 

PIC_HIDE_ALL	   
WAIT 35
// TX_BOARD Board_WePlay_busstop

PVV 202
GFC_SET IXA1 |=1
#VANISH ixia
AUTO_SAVE
