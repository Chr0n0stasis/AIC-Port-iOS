#MS_ %  '>>[Ev_qa200_4.Lb 40,0 <<0.08] P[guard~] '
#SND_LOAD ev_mountain

<LOAD_DWARF>

TALKER	a R
TALKER	n L   
TALKER_REPLACE	a  Mob 

PIC   n a_2/a0L1R1__F2__f2__m1__b1_uo    
PIC   a p1/a0L3R3__F1__e7__uia    
TL 14 PIC_MVA n  14 SCARY

#MS_ alice '##  @L ! P[walk] >+[110,0 :40] @L P[crouch2beware] ?'
PE ZOOM2 70

MSG	n_01 C

MSG_HOLD


WAIT 25
DOTL
PIC_MVA a  2 JUMP

MSG a_00 

MSG_HIDE
PIC_HIDE_ALL	 

DENY_SKIP
STOP_BGM 190 0

_escape03_device=1
#MS_ alice 'q ! P[sink2fear] >+[20,0 :35] P[crouch2beware] w54 @L P[run] >>[#<device> 10,0 <<0.12] @LB P[collect] w20 w10 ## w20 @R P[run] >+[470,0 :140] ? P[crouch2stand] '


#< alice >
TL 22 SUMMONER_CUT_NEAREST_WEED mount_ruinroad
TL 78 #< QA200_PUPPY >
TL 78 ENEMY_ADD_TICKET %%ALC_L 151 0
TL 168 ENEMY_ADD_TICKET GUARD 152 -2.2

WAIT 20
#CMDRELOAD	IMMEDIATE IMMEDIATE_LOAD
WAIT 2
#MS_ device '## >>[#<alice> 0,0] P[magicdevice_fall=0] -G >+[0,-40] +G <<[-0.04,0 a0h40r30] w24 PTC[ev_magicdevice_fall] '
WAIT 96
#MS_ device 'q PTC[get_drop_item_simple]  SND[get_item] '
#VANISH device
#MS_ % 'q w140 ##'

WAIT 170
ALLOW_SKIP
PIC   n a_3/a2__F1__f3__m1__b1_uo    
TL 14 PIC_MVA n 14 SCARY 
 PE ZOOM2 -1 
MSG	n_02

DOTL
TL 10 ENEMY_ADD_TICKET BACKSTEP 160
PIC_HIDE_ALL	 

DENY_SKIP
#MS_ % '= q P[run] >+[270,0 :80] P[run_stop] <<[0.06,0 :15:30] w40 P[guard]'

WAIT 75
#< % >
SUMMONER_TYPE mount_ruinroad NO_EFFECT
SUMMONER_ACTIVATE mount_ruinroad
SUMMONER_PLAYER_SET_DELAY mount_ruinroad 1
SUMMONER_ACTIVATE_EFFECT NORMAL_SIMPLE
QUEST_PROGRESS p200_alice 3

WAIT 70
DOTL
PIC   n a_2/a0L1R1__F2__m6__b1_u0   
TL 22 START_BGM 20
ALLOW_SKIP
MSG n_03

SUMMONER_TYPE mount_ruinroad 

QA200_REMOVE_MOVER
DOTL
