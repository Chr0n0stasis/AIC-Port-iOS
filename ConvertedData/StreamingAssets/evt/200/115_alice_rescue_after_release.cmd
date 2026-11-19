<LOAD_DWARF>
TALKER	a R
TALKER	n L
// ■解放ルート(400文字前後) 
PIC   n a_2/a0L1R3__F2__f2__m1__b5_u2    
#MS_ % '! @R P[walk~] >+[-20,0 :50] P[stand_ev~] ?'

MSG	n_00 T
PIC_HIDE_ALL	 


WAIT 30
  

HKDS	a RT #<alice>

MSG	a_02 


WAIT 35

PIC   n a_2/a0L3R3__F2__f2__m1__b5_u0    

MSG	n_03 
HKDS	 a

PIC   a p1/a0L3R2__F1__e1__ui3    
MSG	a_04 

PIC   n a_3/a0__F1__f3__m1__b1_uo    
PIC_MP n SWT

MSG	n_05 T
HKDS	n CCL #<%> TT
HKDS	a CRT #<alice> TT
PIC_HIDE_ALL	


WAIT 20
#MS_ % '= P[run] w40 P[jump] j[>>20 :9:18] P[fall] F P[run] w40 P[jump] j[>>20 :9:9] P[fall] F P[stand2crouch] w20 P[crouch2stand]:40 P[throw_m_2]'
MSG	n_06 
WAIT 80

MSG	a_07 


// 笑う
HKDS	n    

HKDS	a 
@_PIIN
PIC   a p3/a0L1R2__F1__e4__ua2    I
PIC_MP a PLE2 
MSG	a_08 I 

@_TSUKKOMI
PIC   n a_2/a0L2R2__F2__m6__b2_u0    
PIC_MP n BLS|AWK
MSG	n_09 

PIC   n a_3/a0__F1__f3__m1__b1_u3    
PIC_MP n SWT2
MTL PIC   n a_2/a0L1R1__F2__f2__m1__b1_uo    I
MTL PIC_MVA n 2 JUMP
MTL PIC   n a_3/a0__F1__f3__m5__b1_u1    I
MTL PIC_MVA n 2 SHAKE
MTL PIC   n a_3/a2__F1__f3__m3__b1_uo    I
MTL PIC_MVA n 17 SCARY
MTL PIC_MP n EXC
MSG	n_10 


PIC   a p1/a0L3R2__F1__e2__u1    
PIC_MP a TTT
//……深刻な顔してる。そっか、笑わせたいわけじゃないんだね。
MSG	a_11 


//危険を伝えてるのかな……それにさっきの声。このエルフの声じゃなかった
//もしかして、誰か来るって言ってる?
MSG	a_12 

PIC_HIDE_ALL	 
WAIT 20

TALKER_REPLACE	i Ixia  talk_cane
#MS_ % '= w15 P[guard]'

MSG	i_13 D

WAIT 30
PIC   n a_2/a0L2R3__F2__m6__b2_u1    
PIC_MP n SWT2
PIC_MVA n 3 HOP

MSG	n_14 
PIC_HIDE_ALL	 
#MS_ % '= w15 P[interact] w40 P[stand_ev]'
#MS_ alice '= w50 ! @L P[walk] >+[30,0 :50] P[beware]'
TL 20 PE ZOOM2 80
TL 20 PE ZOOM2 -1
WAIT 70

//……行っていいんだね。
//……また会えるかな? ばいばい。
PIC   a p3/a0L1R1__F1__e1__u1    
MSG	a_15 

PIC   a p1/a0L1R2__F1__e3__ua2    
PIC_MVA a 2 SHAKE
MSG	a_16 
PIC_HIDE_ALL	

TL 15 STOP_BGM 180
DENY_SKIP 
#MS_ alice '= w15 ! @L P[walk] >+[10,0 :20] P[beware] w68 ? @R P[run] ^ >+[300,0 <<0.17] P[stand] '

WAIT 115 

#< QA200_PUPPY >
ENEMY_ADD_TICKET BACKSTEP 190
#MS_ % '= w90 ? P[walk~] >+[50,0 :80] P[stand_ev~]'

WAIT 120 

QA200_REMOVE_MOVER

DOTL 
ALLOW_SKIP
PIC   n a_3/a0__F1__f3__m1__b4_u0    
MSG	n_17 
GFC_SET ALC1 |=4
QUEST_FINISH p200_alice H
QUEST_PROGRESS p200_alice_goback 0

// QUEST_PROGRESS p999_trial_finished 0
// SHOW_QUEST_PROGRESS
// IF wplmode {
//     LOAD_BGM BGM_mountain NormalMountain
//     REPLACE_BGM 4 4 1
// }
