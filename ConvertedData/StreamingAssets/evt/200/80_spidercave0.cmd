/// 落下した後
DENY_SKIP
NIGHTINGALE_SET mount_spider_entrance
<LOAD_DWARF>

PIC_FILL	&10 DARK
LOAD_BGM BGM_spidercave
// #CALL2 Ev_L LOAD_ONCE
CHANGE_EVENT2	200/qa23_load


PE ZOOM2  1
#< % >
#MS_ % '>>[Ev_R.b 20,0] ## #;'
WAIT 2
<NOLOAD>
_x=~m2d_current_x
_y=~m2d_current_y
<LOAD>
PR_DROPCANE $_x ~$_y+0.4 0 0 ~PI*0.014

#MS_ % '. = @L P[down_b] w2 >>[Ev_L.b 20,0] ## #;'
WAIT 2
ALLOW_SKIP
PIC_FADEOUT 	&10 160
WAIT 74
HKDS	n 
HKDS	a 

TALKER_REPLACE	a  Mob 


TALKER	n R   
PIC   n a_3/a1__F1__f3__m2__b2_u1    
PIC_FINE n
PIC_MOVE2 n P P-230 D D 80 ZSIN
PIC_FADEIN n 80

MSG n_00

TALKER	n R   
PIC_HIDE_ALL	 
WAIT 45

#MS_ % '. = @R P[wakeup]:120 P[stand_weak] w20 P[beware]'

PIC   n a_2/a0L2R2__F2__f2__m2__b1_u1    
PIC_FINE n
PIC_MOVEA	n 12 SCARY
PIC_MP	n EXC   


MSG n_01
PIC_HIDE_ALL	 

#MS_ % '. = w40 P[interact]'
DENY_SKIP
WAIT 20

PR_CANE_RETURNBACK 200

WAIT 80
ALLOW_SKIP

PIC   n a_3/a2__F1__f3__m1__b3_u0    
MSG n_02 T

PIC_HIDE_ALL	 
WAIT 30
REPLACE_BGM	90 90

#MS_ % '= P[stargaze]'
#MS_ Ev_L  '= ## >+[0,-600 <<0.14] '
MSG n_02_2 T

WAIT 40
#MS_ Ev_L  '= w1 >>[Ev_L :5] '
#MS_ %  '##'

WAIT 60
#MS_ Ev_L  '= ## >>[Ev_R -60,0 :25] '
WAIT 5
HKDS	n LT #<%>  

MSG n_03 T

WAIT 40
PE ZOOM2 60
PE ZOOM2 -1
#MS_ Ev_L  '= w1 >>[Ev_L :5] '
#MS_ %  '= ## P[beware]'
