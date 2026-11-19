START_LETTERBOX

_evt=$1

TALKER	n L   
#MS_ % '>+[70,0:100] P[stand_ev~]'

PIC   n a_3/a2__F1__f3__m1__b1_u2    
PIC_MP n SWT
MSG n_00
PIC_HIDE_ALL	 

WAIT 20

#MS_ $_evt '## >>[Ev_darkcave_first.R 60,0 :0] '

HKDS	n LT #<%>

MSG n_01

WAIT 30

#MS_ % '##'
HKDS	n
PIC   n a_2/a0L3R1__F2__f2__m1__b4_uo    
MSG n_02

#VANISH $_evt

GFC_SET IXA1 |=4
