<LOAD_DWARF>

TALKER	n R  

TALKER	a L
TALKER_REPLACE	a  Mob 


PIC   n a_2/a0L1R3__F2__f2__m1__b5_u2    
MSG	n_06 

PIC   a p1/a0L1R1__F1__e7__uia    
PIC_MOVEA	a 2 JUMP
PIC_MP	a QUE|SWT2 

MSG	a_07 
PIC_HIDE_ALL	T 
WAIT 55

PIC   a p3/a0L1R2__F1__e5__uaa   
PIC_MP	a SWC 
TL 22 PIC_MOVEA	a 14 SCARY
MSG	a_08 

DOTL
PIC_HIDE_ALL	T 
WAIT 55
PIC   n a_2/a0L3R1__F2__f2__m1__b1_u2    
MSG	n_08 


// -----
// アリスは首を振り、床を指さす。端末はノエルの背後に落ちていた。
// -----
PIC   a p2/a1L1R1__F1__e1__ua    
PIC_MOVEA	a 40 SIN_H
PIC_MP a EXC

MSG	a_09 

PIC_HIDE_ALL	 T
WAIT 70


PIC   n a_3/a2__F1__f3__m1__b4_uo    

MTL PIC   n a_2/a0L1R1__F2__m6__b2_u0    
MTL PIC_MP n AWK
MTL PIC_MOVEA	n 1 JUMP

//アリス、指差し後退り。
MSG	n_10 

PIC   n a_3/a2__F1__f3__m8__b1_u2   
PIC_MOVEA	n 20 SIN_H 
PIC_MP n KIR
MSG	n_11  T

PIC   a p2/a2L2R2__F1__e2__u1    
PIC_MOVEA	a 15 SCARY
PIC_MP a SWT


MSG	a_12 


PIC_HIDE_ALL	T 
WAIT 20
CHANGE_EVENT	200/52_fallen_found_installer
