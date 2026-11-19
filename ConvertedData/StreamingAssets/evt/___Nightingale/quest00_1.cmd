SF_EVT_SET

TALKER t R
TALKER n L
PIC   t t/a0L2R2__F1__m5_u1__m5_b1    
PIC   n a_1/a22__F1__f1__m1__b1__u0   

PIC_MP	t EXC 

MSG	t_08

PIC   n a_2/a0L1R3__F2__f2__m1__b4_u2    
MSG	n_09

@_NPC_LOVE_UP Nightingale
GFC_SET_MX	NIG0 2
IF 'GFC[NIG1]>=4' {
    GFC_SET NIG1 1
}



PIC   t t/a0L4R3__F1__m2_u1__m2_b1    
PIC_MP  t HEA
PIC_MOVEA	t 2 JUMP
MSG	t_10

PIC_HIDE_ALL	 


GETMONEY_BOX 480
WAIT_FN ITEMDESC

WAIT 20

QUEST_FINISH subquest_nightingale_apple
_quest00_prog1=0
REMITEM fruit_epdmg_apple0 1 -1
