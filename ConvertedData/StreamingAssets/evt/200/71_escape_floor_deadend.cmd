<LOAD_DWARF>
#SND_LOAD ev_mountain

STOP_BGM 190 0
TALKER	a R
TALKER	n L   
TALKER_REPLACE	a  Mob 
PIC   a p1/a0L3R3__F1__e7__ua3    
PIC_MP a DEP
PE ZOOM2 60

#MS_ alice '##'
MSG	a_02 

PIC_HIDE_ALL	 


WAIT 12
#MS_ % 'w60 >+[160,0 :92] SND[cloth_off] P[interact~]'
#MS_ alice ' @L !P[sink2fear] >+[30,0 :70] >+[60,0 :100] P[crouch2beware]'
WAIT 30
PIC   a p2/a1L1R1__F1__e2__u1    
PIC_MP a BLS|SWT2 I
MSG	a_03 
PIC_HIDE_ALL	 

#MS_ % '= ##'
WAIT 20
WAIT 35
PIC   n a_2/a0L1R1__F2__f2__m1__b1_u0    

MSG	n_03 


PIC_HIDE_ALL	 
WAIT 60

#MS_ alice '##'
WAIT 60

PIC   a p1/a0L3R3__F1__e6__uia    I
TL 14 PIC_MOVEA	a 15 SCARY2


MSG	a_04 
PIC_HIDE_ALL	 
DENY_SKIP
WAIT 40

DOTL

#< QA200_PUPPY >
#MS_ % '='
#MS_ alice '='
ENEMY_ADD_TICKET NT_MAG1_200_21_ABSORB  200/72_escape_floor_deadend_absorb 150
WAIT 40
#MS '## #;'
PE ZOOM2 1
PE ZOOM2 -1

ENEMY_ADD_TICKET WAITLISTENER
