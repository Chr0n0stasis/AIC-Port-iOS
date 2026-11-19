GREETING	L -35
#MS_ % 'snd[cloth_gosogoso] P[collect~] @RB'
WAIT 5
#SND_LOAD ev_club
TALKER	n L    

PIC   n a_3/a0__F1__f3__m3__b1_uo    
PIC_MP	n SWT2

MSG	n_00 A
PIC_HIDE_ALL	    


WAIT 8

PIC_FILL #9 DARK
PIC_FADEIN #9 45
WAIT 55
SND cloth_gosogoso1
HKDS	n CCRCT @RB


MSG	n_01 A


MSG	n_02 


MSG	n_03 
WAIT 20
PIC_FADEOUT #9 45
#MS_ % '@L >+[-40,0 :45] P[stand_ev~]'

WAIT 10
LOAD_LAYER treasure
#VANISH

WAIT 60
