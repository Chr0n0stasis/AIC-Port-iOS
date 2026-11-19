
HKDS	fd RT #<$_focusto>
TALKER_REPLACE	fd Mob talk_mob_w2
// HKDS	n CCLT #<Noel>

@___city_forge/father_comment ___city_forge/t01*ff_06 

TALKER	n R

PIC   n a_2/a0L1R3__F2__f2__m1__b5_uo    
PIC_MP	n QUE

MSG	n_07 
PIC_HIDE_ALL	
WAIT 30

#MS_ % 'w40 @R w20 P[walk~] >+[30,0 :40] P[stand_ev~]'

#MS_ $_focusto '##'

TALKER	n L


MSG	fd_08 

@_TSUKKOMI

PIC   n a_3/a2__F1__f3__m1__b2_u5    
PIC_MP  n EXC
MSG	n_09  AI
PIC_HIDE_ALL	
WAIT 20

MSG	fd_10 

PIC   n a_1/a22__F1__f1__m3__b1_u0    
PIC_MP n SMK
MSG	n_11 T

PIC   n a_3/a0__F1__f3__m1__b3_uo    
PIC_MP n TTT

MSG	n_12 
MSG_HIDE n

PIC_HIDE_ALL	

MSG	fd_13 

#MS_ % 'q w130 @L P[stand_ev~=0]'

@___city_forge/father_comment ___city_forge/t01*ff_14  $_focusto

#MS_ % 'q w30 @R P[stand_ev~=0]'

MSG	fd_15 


#MS_ % 'q w130 @L P[stand_ev~=0]'
@___city_forge/father_comment ___city_forge/t01*ff_16  $_focusto


#MS_ % 'q w30 @R P[stand_ev~=0]'
MSG	fd_17 

PIC   n a_2/a0L1R3__F2__m6__b2_u0    I
PIC_MP  n EXQ
@_TSUKKOMI n


MSG	n_18 I


PIC_HIDE_ALL	 
WAIT 10
PIC_FILL	#9 DARK
PIC_FADEIN	#9 50
WAIT 60

DENY_SKIP

#MS_ % 'q @R >>[Ev_board] P[walk] >+[140,0 :140] P[stand_ev~]'
WAIT 2
ALLOW_SKIP
PIC_FADEOUT	#9 50

WAIT 40

TX_BOARD	*board_forge
WAIT_MOVE

GFC_SET_MX FORGE0 2

@___city_forge/get_first_cane
