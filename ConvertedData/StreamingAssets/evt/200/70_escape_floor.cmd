<LOAD_DWARF>

TALKER	a R
TALKER	n L   
TALKER_REPLACE	a  Mob 
STOP_BGM 190 0

#MS_ % 'P[run] >+[70,0 <<0.14] P[interact]'
#MS_ alice '## w15 @L P[beware]'
PIC   n a_2/a0L1R1__F2__f2__m1__b1_u0    
TL 15 PIC_MVA n 2 SCARY
PIC_MP n EXC|SWT
PIC   a p3/a0L2R2__F1__e3__uo2    
PIC_MP a SWT2

MSG	n_00 C
MSG_HOLD
WAIT 30


//*ひっ、怒ってるっ……!　にげ、にげな、きゃ。
PIC_MVA a 2 JUMP
MSG	a_01 

PIC_HIDE_ALL	


#MS_ alice '@R P[run] <<[0.17,0 h150] w150 P[stand]'
WAIT 35
DOTL
