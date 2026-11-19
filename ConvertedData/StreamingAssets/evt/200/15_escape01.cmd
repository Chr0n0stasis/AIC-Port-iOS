<LOAD_DWARF>

TALKER	n L   

TALKER	a R
TALKER_REPLACE	a  Mob 


PIC   a p2/a2L2R2__F1__e2__ua    
PIC_MP	a AWK
TL 14 PIC_MOVEA	a 2 JUMP

MSG	a_01  A

DOTL
PIC_HIDE_ALL	T 

WAIT 40
//アリス、立ち上がりゆっくり歩き去る。

PIC   n a_3/a1__F1__f3__m5__b1_u2    
PIC_MOVE2	n P P-200 D D 60 ZSIN
PIC_FADEIN	n 50

PIC_MP n SWT2


MSG	n_02 

WAIT 40


PIC   n a_1/a22__F1__f1__m1__b2__u0    
PIC_MP n QUE
MSG	n_03 
