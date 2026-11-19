STOP_LETTERBOX


#MS 'PTC[get_drop_item]'
TALKER	 n   L 

#VANISH 
GFC_SET ALC3 ~=14
GETITEM precious_magicdevice200 1 0
GREETING	L -6
#MS_ % 'P[collect] @RB'
WAIT 50

START_LETTERBOX
PIC   n a_1/a22__F1__f1__m1__b2__u1    

MSG n_30


PIC   n a_3/a2__F1__f3__m1__b4_u0    
PIC_MP n TTT
MSG n_31

#MS_ % 'P[crouch2stand~]'

#MS_ alice '@L >+[90,10] P[beware2] '
