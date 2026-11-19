<LOAD_DWARF>
TALKER	a R
TALKER	n L


PIC   n a_2/a0L1R3__F2__f2__m1__b1_u2    
MSG	n_00 T

PIC   n a_3/a0__F1__f3__m1__b1_uo    
MSG	n_01 

PIC   a p1/a0L3R1__F1__e1__u1    
PIC_MP	a QUE  

MSG	a_02 

PIC   n a_3/a2__F1__f3__m1__b1_u2    
MSG	n_03 

PIC   a p1/a0L3R2__F1__e2__ui3    
PIC_MP	a TTT
//……一緒に来いって言ってる?
MSG	a_04 

PIC_HIDE_ALL	 
WAIT 5
#MS_ % '= ## >>[#<alice> -30,0 <<0.07]'
WAIT_MOVE
#MS_ % 'P[interact~]'
WAIT 15
PIC_FLASH	#10  0 5 0 77:#ffffff
SND hit_binta 

#MS_ % '! >+[-30,0 :10] P[guard~]?'
#MS_ alice '= @L ! ## P[run] >+[50,0 :15] P[guard~]?'

WAIT 30


PIC   a p2/a1L1R1__F1__e2__uaa    
PIC_MP a SWT2
//アリス、手をはたき返す
//イヤッ! 私は行かない!
//私はここから出たらきっと死んじゃう。だから!
MSG	a_05 

PIC   n a_3/a0__F1__f3__m1__b4_u0    
MSG	n_06 

PIC   n a_1/a22__F1__f1__m1__b1__u3    
MSG	n_07 

PIC   a p2/a1L1R1__F1__e5__u3    
PIC_MP a BLS
MSG	a_08 

PIC   n a_1/a22__F1__f1__m4__b1_ua    
MSG	n_09 

PIC   a p3/a0L1R2__F1__e3__uo    
MSG	a_10 

PIC   n a_2/a0L1R2__F2__f2__m1__b5_u3    
MSG	n_11 

#MS_ % '= ? ## >>[#<alice> -25,0 <<0.07] @R P[stand_ev~]'
PIC_HIDE_ALL	 
WAIT 70
START_BLURSC_TO_BEHIND
SHOW_BLURSC
WAIT 15
TL 14 SND foot_bare
PIC #9 mountain210_alice/alice_arrest 
PIC_MOVE2	#9 0,-90 0,0 100 ZSIN

PIC_FADEIN #9 60

HKDS	n LB @BOUT  TT
HKDS	a RB @R TT

//ノエルの手を取るアリス
MSG	n_12 

DOTL
WAIT 30

//わかった。信じる。
MSG	a_13 
DENY_SKIP
HIDE_BLURSC
PIC_FADEOUT #9 50
ENEMY_ADD_TICKET %%ALC_R 160
#MS_ alice '= @R ! P[walk] >+[-4,0 :30] P[pet] ? w80'
#MS_ % '= ! w40 >+[-30,0 :30] P[stand_ev~] ? @RB '

WAIT 70
#< QA200_PUPPY >
ENEMY_ADD_TICKET NT_GUARD1_210_BACK2ALICE 161 -3.1 // 威嚇
WAIT 40

#MS_ alice 'P[crouch2stand]:30 @L P[walk] >+[-54,0:50] @R P[stand_ev~] ?'
#MS_ % 'w45 @R ! >+[70,0 :65] ?'
WAIT 150
GFC_SET ALC1 |=8
GFB_SET PVV210_ALICE_ARREST 1
ENGINE Alice200 TRACE_NOEL
// QUEST_FINISH p200_alice H
QUEST_PROGRESS p200_alice 29 H
QUEST_PROGRESS p200_alice_goback 0
AUTO_SAVE
