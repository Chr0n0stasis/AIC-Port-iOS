<LOAD_DWARF>

TALKER	n R

TALKER	a L
TALKER_REPLACE	a  Mob 



//ノエルが背後の端末に気づくと同時にアリスは仔犬がいないことに気づき無言で慌て始める
PIC   a p1/a0L3R3__F1__e6__uia    

MSG	a_00 

PIC   n a_3/a0__F1__f3__m1__b1_u2    

MSG	n_01 


MSG	a_02 


PIC   n a_3/a2__F1__f3__m1__b1_uo    
MSG	n_03 

PIC_HIDE_ALL	T 
WAIT 35

//杖を構えてにじり寄るノエル
//完全に腰を抜かしてぐしゃぐしゃに泣きじゃくるアリス
MSG	a_04 


PIC   n a_2/a0L2R3__F2__f2__m1__b5_u2    
MSG	n_05 


MSG	a_06 


PIC_HIDE_ALL	T 
WAIT 25

MSG	n_07 

PIC_HIDE_ALL	T 
WAIT 55

//杖の間合いまで近寄るノエル。
//アリス完全にパニックに陥り、対話不可能。
PIC   a p3/a0L1R2__F1__e5__uaa    
PIC_MP a SWB|BLS
PIC_MOVEA n 14 SCARY
MSG	a_08 

PIC   n a_3/a2__F1__f3__m5__b2_u2    
PIC_MP n AWK
PIC_MOVEA n 1 JUMP
MSG	n_09 


PIC_HIDE_ALL	T 
WAIT 35
//うずくまったまま横になり、膝と腕で顔を隠す。
//できる限り
MSG	a_10 


WAIT 35
PIC   n a_1/a00L1R1__F1__f1__m3__b1_u0    
PIC_MP n SMK
MSG	n_11 
