MSG_PREFIX so <tigrina>

TALKER	so L

PIC   so so2/a0L3R1__F2__f2__m7__e1_ua    
PIC_MOVEA	so 70 SHAKE
PIC_MP	so ONP2|BLS


MSG so_00 


MTL PIC   so so1/a0L3R3__F1__f1__m4__e1_up    
MTL PIC_MOVEA	so 3 HOP
MTL PIC_MP so HEA2
MSG so_01 S

PIC_HIDE_ALL	 

WAIT 15

DENY_SKIP


#< tigrina >
#MS '@R P[walk] >>[ ExitD_b1out.b 20,0 <<0.064 ] P[stand] w10 @L'
#MS_ % 'w60 @R w35 P[walk~] >>[ ExitD_b1out.b -40,0 <<0.014 ] P[stand_ev~]'
TL 80 LP_ACTIVATE_TO_CHIP	row ExitD_b1out

WAIT 20
INIT_MAP_MATERIAL school_b1_out 1

ALLOW_SKIP

WAIT 50


PIC_FILL	#9 DARK
PIC_FADEIN	#9 50
WAIT 70

SCN_MANUAL_BGM_REPLACE BGM_tigrina
_tigrina__t01=1
CLEARTL
WAIT_FN MAP_TRANSFER
NEL_MAP_TRANSFER school_b1_out R !Ev_L

#CMDRELOAD	IMMEDIATE IMMEDIATE_LOAD



ALLOW_SKIP
WAIT 5

PIC_FADEOUT	#9 50

#< tigrina >
#MS_ % '>+[150,0] >+[350,0 <<0.037] P[stand_ev~]'
#MS '@R >+[150,0]  P[walk] >+[370,0 <<0.037] P[stand] w25 @L'

WAIT 40

HKDS	so CRT #<tigrina> 



MSG so_02

WAIT 40


TALKER	so R   
HKDS	so
TALKER	n L   
PIC   n a_1/a00L1R1__F1__f1__m1__b1__u0    
PIC   so so1/a0L2R1__F1__f1__m4__e1_u2    
PIC_MP so ONP

MSG so_02_2 
PIC_HIDE_ALL	 

WAIT 20

INIT_MAP_MATERIAL school_garage_right 1

PIC_FILL	#9 DARK
PIC_FADEIN	#9 50
WAIT 60
SCN_MANUAL_BGM_REPLACE BGM_tigrina
WAIT_FN MAP_TRANSFER
NEL_MAP_TRANSFER school_garage_right R !Ev_L

#CMDRELOAD	IMMEDIATE IMMEDIATE_LOAD



ALLOW_SKIP
WAIT 5
PIC_FADEOUT	#9 50

CHANGE_EVENT2	___Tigrina/106sneak__init
