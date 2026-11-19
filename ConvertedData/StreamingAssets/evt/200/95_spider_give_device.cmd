STOP_BGM 240 1
PIC_FILL #10 DARK
PIC_FADEIN #10 40 

WAIT 42

PIC_FADEOUT #10 45

#MS_ 'alice' '= >>[Ev_L 70,0] @R P[stand_ev]'
#MS_ '%' '= >>[Ev_L 140,0] @L  ## #; >+[-30,0 :60] P[stand_ev~]'
WAIT 50

<LOAD> // アリスにデバイスを渡す
PIC   n a_3/a0__F1__f3__m1__b4_uo    
PIC   a p1/a0L3R2__F1__e3__u1    


MSG	n_200 

PIC   a p1/a0L3R1__F1__e3__u2    
MSG	a_201 
WAIT 20
REMITEM precious_errorchip 1 -1 Alert_item_reduced_alice
SND cloth_gosogoso
TL 35 PIC   n a_1/a22__F1__f1__m1__b1__u0    
WAIT 85

PIC   a p2/a2L1R2__F1__e3__u1    
MSG	a_202 

DOTL
MSG	n_203 T
PIC_HIDE_ALL	 

#MS_ 'alice' '@R ! P[walk] >+[-50,0 :60] P[stand_ev]  '
#MS_ '%' '@L ! w20 >+[10,0 :80] P[stand_ev~] ? '
WAIT 64
#< alice >
#MS 'q ? _ -G _ <<[0,-0.04 h1r30] P[learning] . w180 P[fall] +G F P[crouch2stand=4]:10 P[stand_ev_3]  '
TRESURE_PR_ABSORB_EFFECT_PT 0 -3 
WAIT 260


PIC   n a_1/a00L1R1__F1__f1__m1__b1__u1    
PIC_MP n EXC
PIC   a p2/a1L1R1__F1__e1__uo    
PIC_MP a QUE

MSG	a_204 
MSG	n_205

PIC   n a_3/a0__F1__f3__m1__b4_u0    
MSG	n_206

GFC_SET ALC1 |=1
