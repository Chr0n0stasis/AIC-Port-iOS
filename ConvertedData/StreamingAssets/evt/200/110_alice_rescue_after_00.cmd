IF 'PVV!=210' {
    SEEK_END
}
#SND_LOAD ev_msg_noise
#SND_LOAD enemy_puppy
GFC_SET ALC1 0
STOP_BGM 120 0
LOAD_BGM BGM_hazimari_no_asa
<LOAD_DWARF>
TALKER	a R
TALKER	n L   
TALKER_REPLACE	a  Mob 
_camera=Ev_yuri_no_aida_ni_hasamaru_camera

// ========================================================================
#MS_ % '@R ! >>[#<alice> -50,0 <<0.034 ] P[stand_ev]?'
#MS_ alice 'w20 @L P[walk] ! >+[30,0:25]  P[beware] ? '
<LOAD>
PIC   n a_1/a00L1R3__F1__f1__m1__b1__u3    
PIC   a p1/a0L1R2__F1__e1__u1    

MSG	n_00 

PIC_HIDE_ALL	 
WAIT 20
#MS_ $_camera 'snd[puppy_grawl]'
#MS_ alice '= w10 @R P[beware2=5] w10'

HKDS	a CRT  #<alice>
WAIT 30
DENY_SKIP
#MS_ alice '= P[run] >>[#<QA200_PUPPY> -40,0 <<0.13] P[pet]'
MSG	a_00 
#MS_ % 'w20 P[walk] >+[180,0 <<0.084 ]  >>[#<alice> -280,0 <<0.084 ] P[stand_ev] @R'
WAIT_MOVE
ALLOW_SKIP
#< QA200_PUPPY >
#MS '@L'
ENEMY_ADD_TICKET GUARD 151 -3.1 // 威嚇

#MS_ alice '= w10 @L P[crouch2beware_turnback=2] w48 P[walk] >+[-50,0 <<0.066] P[stand2pet]'
#MS_ % '= w25 P[guard]'

//ルベっち、大丈夫だよ。

HKDS	a RT  '='
MSG	a_01 
WAIT_MOVE
WAIT 25

ENEMY_ADD_TICKET %%ALC_R 151
#MS_ % '= w55 P[walk] >+[30,0 :55] P[stand_ev]'
#MS_ alice '= w35 P[crouch2stand]:40 P[stand_ev]'
TL 20 #MS_ $_camera '##'
TL 10 PE ZOOM2 120
WAIT 60
HKDS a   
HKDS	n  
 
TL 25 REPLACE_BGM	10 10   0

PIC   a p1/a0L1R2__F1__e1__u1    
PIC   n a_1/a22__F1__f1__m1__b1__u3    

MSG	n_02 


MSG	a_03 

DOTL
PIC   n a_1/a00L1R1__F1__f1__m1__b1__u1    
MSG	n_04 

//名前を、聞かれてる? ワタシ……?

PIC   a p1/a0L3R2__F1__e3__u2    
PIC_MP a TTT
MSG	a_05 

PIC   n a_1/a00L1R3__F1__f1__m4__b1_ua    
MSG	n_06 

//ここから読める言葉を使い始める
PIC   a p1/a0L3R2__F1__e1__u1    

MSG	a_07 
PIC   n a_1/a22__F1__f1__m1__b1__u3    

MSG	n_08 

PIC   a p1/a0L3R1__F1__e3__ui    
MSG	a_09 

PIC   n a_2/a0L1R3__F2__f2__m1__b5_u3    
MSG	n_10 

PIC   a p1/a0L1R1__F1__e3__ua2    
PIC_MVA a 1 JUMP
PIC_MP a KIR
TALKER_REPLACE a 

//*a_
//……うん!
MSG	a_11 

PIC_HIDE_ALL	 

WAIT 30

// 杖の通信機から通信が入り始める
TALKER_REPLACE	i Ixia  talk_cane
#MS_ % 'w20 P[guard]'
HKDS	i CRT #<%>

HALF_BGM 1
MSG	i_12  D


PIC   n a_3/a0__F1__f3__m1__b4_uo    
MSG	n_12 

#MS_ % '= P[walk] >+[-20,0 :15] P[stand_ev]'

PIC   n a_3/a2__F1__f3__m1__b4_u3    
PIC_MVA n 2 SHAKE
MSG	n_13 

PIC   a p3/a0L1R1__F1__e1__u1    
//通信機の声を不思議がるアリス
MSG	a_14 
PIC_HIDE_ALL	 
HALF_BGM 0


WAIT 50
#MS_ % '= ? P[walk] >+[20,0 :40] w25 P[stand~ ]'
HKDS	n LT #<%>  

MSG	n_15 T



MSG	n_16  T
MSG_HOLD

PVV 211

SELECTARRAY_CLEAR
SELECTARRAY	&&Select_arrest_ghost 200/120_alice_rescue_after_arrest
SELECTARRAY	&&Select_leave 200/115_alice_rescue_after_release C

SELECT	-1 _goto_evt
MSG_HIDE
WAIT 25
HKDS	n   
HKDS	a    
 

CHANGE_EVENT $_goto_evt

