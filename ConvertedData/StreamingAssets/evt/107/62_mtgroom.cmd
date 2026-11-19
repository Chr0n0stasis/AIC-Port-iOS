<LOAD_DWARF>
QUEST_REMOVE p999_trial_finished 1
GFC_SET_MX ALC1 4
DENY_SKIP
WAIT_MOVE
#< % >
PR_KEY_SIMULATE	L 0 
PR_KEY_SIMULATE	R 0 
PR_KEY_SIMULATE	B 0 
LOAD_BGM BGM_nusi_meet_ghost

#MS_ % '>>[Ev_board.b 20,0 <<0.05] @L P[stand_ev] w120 P[guard~]'
#< alice >
#MS '@L P[stand_ev_3=3] w35 P[stand2pet] @BL w50 ## w190 '


WAIT 230
TL 50 LP_DEACTIVATE Effector_sound
#MS  'P[crouch2beware_turnback]   @R '

WAIT 120
DOTL
LP_DEACTIVATE WalkDecline_L

WAIT 40

TALKER	n R   
PIC   n a_3/a2__F1__f3__m1__b1_u2    

WAIT 60

HKDS	n '' '' TT 
TL 40 REPLACE_BGM	20 0 0

MSG	n_00 

DOTL
PIC_HIDE_ALL	T 
WAIT 50

TALKER	a L   
TALKER_REPLACE	a 'Mob' 

DENY_SKIP

PIC   a p3/a0L2R2__F1__e1__uo    
WAIT 35

TL 56 PIC   a p2/a1L1R1__F1__e5__uo    
TL 56 PIC_MVA a SCARY 10
// アリス
TL 90 MSG_SKIP
DENY_EVENTHANDLE
MSG	a_01

PIC_HIDE_ALL	 

ALLOW_EVENTHANDLE
DOTL
MSG_HIDE
#< PUPPY_EVENT_0_0 >
ENEMY_ADD_TICKET BACKSTEP 160
#< alice >
#MS 'P[run] >+[-50,0 :15] P[rolejump] w3 j[>>140 :20] * >+[-120,0 :34]'



TL 66 #MS_ alice 'q P[_hidden] >>[Ev_LL.b -150,0] '

WAIT 20

#MS_ ixia '## P[walk_cane] >+[-110,0 <<0.1] P[stand_cane]'
#MS_ % 'w15 P[stand_ev] @R'
ALLOW_SKIP
TALKER	i R   
TALKER	n L   


PIC   i i/a00L1R5__F1__f1__m1__b5_u1    
MSG	i_02 


HKDS	n ''   

DOTL


PIC   n a_3/a2__F1__f3__m1__b2_u3    
MSG	n_03 

#MS_ % 'w4 P[guard=0] @L'
PIC_HIDE_ALL	
WAIT 35

#MS_ alice '##'
WAIT 70

PIC   i i/a00L1R1__F2__f2__m1__b3_u4    
PIC_MP i SMK
MSG	i_04 


PIC   n a_2/a0L1R3__F2__f2__m1__b3_uo    
PIC_MP n QUE
MSG	n_05 


PIC   i i/a00L3R4__F1__f1__m1__b5_ua    
PIC_MP i KIR
MSG	i_06 

DENY_FASTTRAVEL
DENY_WARPINJECTION


#VANISH alice

