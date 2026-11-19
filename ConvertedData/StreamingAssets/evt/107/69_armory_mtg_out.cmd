IF '!(PVV==107 && GFC[ALC1]>=4)' {
    SEEK_END

}
START_LETTERBOX
#MS_ % '>>[Ev_board.b 30,0 <<0.05] @R'
<LOAD>
_result=0
TALKER	i R   
TALKER	n  L   

PIC   n a_2/a0L3R3__F2__f2__m1__b5_u2    
PIC   i i/a00L1R2__F1__f1__m1__b3_u4    
MSG	i_00 


PIC   i i/a00L3R3__F2__f2__m1__b2_u3    
PIC_MP	i LAG 


TL 40 PIC   n a_3/a2__F1__f3__m1__b2_uo    
TL 40 PIC_MOVEA	n 1 JUMP
TL 40 PIC_MP n AWK


MSG	i_01 

DOTL
PIC   i i/a00L5R1__F1__f1__m1__b3_u0    
PIC_MP	i KIR
MSG	i_02 

PIC   n a_1/a22__F1__f1__m3__b1_u0    
PIC_MP n SMK

MSG	n_03 

PIC_HIDE_ALL	 

WAIT_MOVE
