PIC_FILL #9 DARK
LP_DEACTIVATE Focus_0
IF 'Exist_mover[citycaster_9]' {
    GOTO _WALKIN
}
// 
@106/_put_citycaster Ev_ground_tl
#MS_ citycaster_9 '>+[-60,0] @R P[walk] >+[60,0:80] P[stand_cane2] '

WAIT 10
PIC_FADEOUT #9 80

WAIT 60


HKDS	n   

HKDS	i   
HKDS	bs RT #<boss>
TALKER_REPLACE	bs teacher talk_mob_w2
MSG	bs_00 

#MS_ % '##'
TALKER	n L
PIC   n a_2/a0L2R3__F2__m6__b2_u0    
PIC_MP n SWT2

MSG	n_01 
HKDS	bs R '='


MSG	bs_02 



TALKER	n CLL
TALKER	i LL  
PIC   i i/a00L1R1__F1__f1__m1__b5_u0    
PIC_MP  i HOT
MSG	i_03 

PIC   n a_3/a2__F1__f3__m1__b3_u5    
PIC_MP n SMK

MSG	n_04 

LABEL _WALKIN
PIC_HIDE_ALL	
#MS_ % 'P[walk~] >+[80,0 :70] '

PIC_FILL #9 DARK
PIC_FADEIN #9 80

WAIT 84


CHANGE_EVENT 106/04_ensyu_first_orbit
