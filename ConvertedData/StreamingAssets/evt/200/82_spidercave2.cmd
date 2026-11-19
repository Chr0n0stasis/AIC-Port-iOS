//登録端末を拾った後

TALKER	a L
TALKER	n R   
TALKER_REPLACE	a  Mob 


#MS_ alice '## ! @L P[walk] >+[-40,0 :25] P[beware2] ? W90 @R P[walk] >+[30,0 :65] P[stand2crouch] '
HKDS	a CRT #<alice> TT

MSG	a_00 

WAIT 35
#MS_ alice 'P[crying_2] '

//あの子がいないと、わたし……
MSG	a_02 
WAIT 50

#MS_ % '= . ## >+[-20,0 :30] <<[-0.03,0 h60r15] j[>>80 :40:65] F ! >+[-15,0 :40] P[guard~] @L'
#MS_ alice '= . w40 @R ! P[walk] >+[-60,0:30] P[beware]'
PIC   n a_3/a2__F1__f3__m1__b1_uo    
PIC_MP n QUE
MSG	n_03 

HKDS	a    

//杖を構えてにじり寄るノエル
//完全に腰を抜かしてぐしゃぐしゃに泣きじゃくるアリス
//あの、わたし……ルベっちがいないと生きられなくて……。
TALKER	a L   
PIC   a p1/a0L3R3__F1__e2__u1    
PIC_MP a SWT|BLS
TL 15 PIC_MVA a 10 SCARY 

MSG	a_04 

DOTL
PIC   n a_2/a0L3R1__F2__f2__m1__b5_u2    

MSG	n_05 


// あの子がいなくて、その……ぐすっ探さないと……だからぁ……。
#MS_ alice 'P[crying_2]'
PIC   a p2/a2L2R2__F1__e2__ua    
PIC_MP a BLS|SWT2
PIC_MOVEA	a 6 SHAKE   

MSG	a_06 

PIC_HIDE_ALL	 
HKDS	a LT #<alice>
HKDS	n RT #<%> 

WAIT_MOVE 
WAIT 30
#MS_ % '? ## >+[-30,0 :40] SND[cloth_off] P[interact~]'
#MS_ alice 'w20! @R <<[-0.03,0 a5h6r20] P[sink2fear]:30  P[feared_stop_2] >+[-100,0 :200]'

MSG	n_07 


#MS_ alice '= P[ev_guard]'
//杖の間合いまで近寄るノエル。
//アリス完全にパニックに陥り、対話不可能。
// ごめんなさい!ごめんなさいごめんなさい!
HKDS	a    
HKDS	n    

PIC   a p2/a2L2R2__F1__e2__uaa    I
@_TSUKKOMI a
PIC_MP a BLS|SWT2 I
MSG	a_08  A

PIC   n a_2/a0L3R1__F2__m6__b2_u1    
PIC_MP n DEP|SWT

MSG	n_09  A

PIC_HIDE_ALL	 
WAIT 30
#MS_ alice '= . ##'

HKDS	a LT #<alice>


//うずくまったまま横になり、膝と腕で顔を隠す。
//できる限り生きることから目を逸らした姿勢。
//ぐすっ、ごめんなさい……ごめんなさい……
MSG	a_10 

#MS_ % '= . ## P[guard]'
PIC   n a_3/a2__F1__f3__m1__b3_u0    
PIC_MP n SWT
MSG	n_11 
PIC_HIDE_ALL	 

WAIT_MOVE
WAIT 70
CHANGE_EVENT	200/83_spidercave_flashback

