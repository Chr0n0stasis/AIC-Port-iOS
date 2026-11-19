// 初回びっくり

#MS_ % '>>[Ev_housefill.b -90,0 <<0.09] w20 P[guard~] '
#MS_ Firstman 'w50 ## w30 P[wait~] @L'


WAIT 120
<LOAD>
WAIT 40
@_PIIN

PIC   n a_3/a2__F1__f3__m1__b2_u3    
PIC_MOVEA	n 2 HOP
PIC_MP n EXC

MSG	n_00 AI

PIC   fh P1/a0L1R1__F2__m1    
MSG	fh_01 V

TL 50 FISBGM fis0 1 300
PIC   n a_3/a2__F1__f3__m1__b2_u0    
MSG	n_02 

PIC   fh P1/a0L1R1__F1__m2f2_2    
MSG	fh_03 V

PIC   n a_3/a2__F1__f3__m1__b1_u2    
MSG	n_04 

PIC_HIDE_ALL	%&#T or empty 1 to immediate

DOTL

#MS_ Firstman 'w20 @T'
#MS_ % '= w30 ## '
WAIT 60

PIC   n a_2/a0L1R3__F2__f2__m1__b5_u2    
PIC_MP	n TTT 

MSG	n_05 T

GFC_SET FHM1 1
