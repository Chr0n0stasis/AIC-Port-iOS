

#MS_ % 'w130 @L P[stand_ev~=0]'

@___city_forge/father_comment ___city_forge/t_buy01*ff_06  $_focusto

#MS_ % 'w30 @R P[stand_ev~=0]'


MSG	fd_07 


TALKER	n L

PIC   n a_2/a0L1R3__F2__f2__m1__b5_u2    
PIC_MP	n SWT

MSG	n_08 

PIC_HIDE_ALL	 


#MS_ % 'q w130 @L P[stand_ev~=0]'

@___city_forge/father_comment ___city_forge/t_buy01*ff_09  $_focusto

#MS_ % 'q w30 @R P[stand_ev~=0]'


MSG	fd_10 

PIC   n a_3/a2__F1__f3__m1__b4_u0    
PIC_MP  n TTT

MSG	n_11 


MSG	fd_12 


PIC_HIDE_ALL	 
#MS_ % 'q w130 @L P[stand_ev~=0]'

@___city_forge/father_comment ___city_forge/t_buy01*ff_13  $_focusto

#MS_ % 'q w30 @R P[stand_ev~=0]'


MSG	fd_14 

HKDS	n CLT #<%>  TT  

MSG	n_15 


PIC_HIDE_ALL	 
WAIT 10
PIC_FILL	#9 DARK
PIC_FADEIN	#9 50
WAIT 60

DENY_SKIP

#MS_ % 'q @R >>[Ev_board 80,0] P[walk] >+[60,0 :60] P[stand_ev~]'
WAIT 2
ALLOW_SKIP
PIC_FADEOUT	#9 50
WAIT 25

GETITEM_BOX precious_testor_lisence 1 0
WAIT_FN ITEMDESC


WAIT_MOVE

GFC_SET_MX FORGE0 4
