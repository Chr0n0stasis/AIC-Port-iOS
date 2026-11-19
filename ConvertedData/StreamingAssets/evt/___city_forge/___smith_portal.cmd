_focusto=$1
GREETING	R 50


IF 'GFC[FORGE0]<1' {
    CHANGE_EVENT	___city_forge/t01
}

HKDS	fd RT #<$_focusto>
TALKER_REPLACE	fd Mob talk_mob_w2
#< smith >
WAIT 20

PE ZOOM2 60
#MS '##'
WAIT 45


HKDS	n RB #<%>  
MSG n_00 T

@___city_forge/father_comment ___city_forge/___smith_portal*ff_01  $_focusto

#MS_ % 'q w30 @R P[stand_ev~=0]'

HKDS	n    
TALKER	n L   
MSG fd_02

PIC   n a_2/a0L1R3__F2__f2__m1__b4_uo    
PIC_MP n SWT|SMK
MSG n_03

PIC_HIDE_ALL	 
PE ZOOM2 -1
#MS_ % '## >+[40,0 :60]'

WAIT_MOVE
