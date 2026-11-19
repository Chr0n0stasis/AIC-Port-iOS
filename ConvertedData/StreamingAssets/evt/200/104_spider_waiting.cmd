HKDS	a CLT #<alice> TT

#MS_ alice '@L P[beware2] >>[Ev_L -20,0] #; w90 @R P[walk] >+[370,0 <<0.08] P[beware2] w140 P[walk] @L >+[-120,0 <<0.08] P[beware2]'
WAIT 120

MSG	a_00 

WAIT 150
#MS_ alice 'P[crying_2]'
HKDS	a CLT #<alice> TT

MSG	a_01 

WAIT 90
#MS_ % '## '
WAIT 50

PIC   n a_3/a0__F1__f3__m1__b4_u0    
MSG	n_02 

PIC_HIDE_ALL	 

PIC_FILL #10 DARK
PIC_FADEIN #10 55
WAIT 60
@200/qa23_load
#MS_ % '>>[Ev_alice.R -20,0] >+[40,0 :70] ## #; ?'
PIC_FADEOUT #10 55

WAIT 70

