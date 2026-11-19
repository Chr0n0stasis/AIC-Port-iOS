
IF 'quest_progress_f[p200_alice]>=13' {
    SEEK_END
}
STOP_LETTERBOX
STOP_BGM 10 0

DENY_SKIP
WAIT 190

START_LETTERBOX
<LOAD>
<LOAD_DWARF>

#< alice >

TALKER	n L   
TALKER	a R    

HKDS	a CLT    

TALKER_REPLACE	a  Mob 

#MS_ alice '= ##' 
PIC   a p3/a0L2R2__F1__e2__uaa    
TL 15 PIC_MOVEA	a 15 SCARY
PIC_MP a EXC

ALLOW_SKIP
MSG a_00
PIC_HIDE_ALL	

DOTL
#MS_SOFT_ % 'w30 ##'

#MS 'P[run] >+[80,0 <<0.12]'
#MS_ alice 'P[crouch] w4 <<[0.076,0 a5h50r10]  @R P[rolejump] j[>>160:38:38] F'
#MS_ alice 'P[crouch] w4 <<[-0.066,0 a5h20r10]  @L P[jump] j[>>240:78:78] P[fall]'

WAIT 120

#< QA200_PUPPY >
ENEMY_ADD_TICKET BACKSTEP 131

WAIT 80
TL 50 QA200_REMOVE_MOVER 

QUEST_PROGRESS p200_alice 13 H



WAIT 40

#< % >
#MS 'q ## P[wakeup_b]:60 P[stand_weak~] ##'
PIC   n a_2/a0L1R3__F2__f2__m2__b1_u0     i
PIC_FINE n
PIC_MOVE2 n P P-230 D D 60 ZSIN
PIC_MP n BLS|SWT
PIC_FADEIN n 60
MSG n_02

PIC_FINE n
PIC   n a_3/a2__F1__f3__m5__b1_u1    
PIC_MP n BLS|BSM
PIC_MVA n 2 JUMP
MSG n_03

DOTL
TALKER	n L 

PIC_HIDE_ALL	 

WAIT 40
DENY_SKIP
_200_31_aft_alma=1
#CMDRELOAD	IMMEDIATE IMMEDIATE_LOAD
WAIT 10
ALLOW_SKIP
#< alma >
#MS '##'
TALKER	l R   
PIC   l l1/a0L2R2__F1__m1__b5_ua4    
PIC_MP l AWK
TL 90 START_BGM 160
MSG l_03

PIC_HIDE_ALL	   
#MS 'w20 @R P[walk] >+[40,0 <<0.03] SND[cloth_off] P[chant] w55' 

WAIT_MOVE
LP_ACTIVATE_TO_CHIP wood Ev_qa200_12_cover  
#MS 'w20  ! P[walk] >+[-10,0 :40] ? @L P[stand]'
WAIT 60

GFC_SET ALM1 0
DOTL
