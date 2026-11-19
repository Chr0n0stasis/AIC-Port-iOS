#MS_ % 'F P[walk_wet_weak] >+[20,0 :70] P[knockout]'
TALKER	n L   

PIC   n a_3/a1__F1__f3__m2__b2_u0    
PIC_MP	n BLS|SWT

// 渡った後
MSG	n_00 T

PIC   n a_2/a0L2R3__F2__f2__m2__b1_u0    
PIC_MP	n BLS 
MSG	n_01 
PIC_HIDE_ALL	 

_200_escape07=1
#CMDRELOAD	IMMEDIATE IMMEDIATE_LOAD
#MS_ % 'P[stand_weak]'
WAIT 5
TL 15 PE ZOOM2 80
#MS_ Ev_qa200_7 '>>[Ev_qa200_7] >+[90,50] ##' 
WAIT 20
HKDS	n CRT #<%>  

MSG	n_02 

#MS_ % '##' 
DOTL
PE ZOOM2 -1
