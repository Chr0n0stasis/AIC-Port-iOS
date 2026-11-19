SF_EVT_SET
PIC   w w/a0L2R1__F1__f1__m1__e1__u1    
PIC   n a_1/a00L1R1__F1__f1__m1__b2__u1    
PIC_MP n TTT
// 追加会話: なぜ、そこまで？
MSG	n_00 

PIC   w w/a0L2R1__F1__f1__m1__e3__u1    
MSG	w_01 

PIC   n a_3/a0__F1__f3__m1__b4_u0    
MSG	n_02 

PIC   w w/a0L1R1__F3__f3__m1__e1__u1    
MSG	w_03 

PIC   n a_1/a22__F1__f1__m1__b2__uo    
PIC_MP n SWT2
MSG	n_04 


PIC   w w/a0L1R3__F2__f2__m1__e1__u2    
MSG	w_05 

MSG_HIDE 1
STOP_BGM	0 0
PIC_HIDE_ALL	'' 1

PIC_FLASH	&9 0 6 4 ff:#EBEBEB

PIC_FILL #0 DARK
WAIT 10
<LOAD>
WAIT 40
PIC_B   #1   mountain200_still/mountain_flashback2  ''
PIC_FILL   #2  99:#597866
PIC_FADEIN	#2 60
PIC_FADEIN	#1 200
WAIT 100



HKDS	n C CCB MONOLOGUE 


MSG	n_06 

PIC_FADEOUT #1 60
WAIT 50
PIC_FADEOUT #2 70
PIC_FADEOUT #0 120
WAIT 100
TL 60 START_BGM 200

@_TSUKKOMI
PIC   w w/a0L3R3__F1__f1__m1__e2__u2     I
PIC_MP  w LAG
PIC_MOVEA	w 20 SCARY

MSG	w_07 I


HKDS	n

TALKER w CLL
TALKER s LL 
TALKER n R
PIC   s s/a0L2R2__F2__f2__m1__e3__u3    

PIC_MP s SMK
MSG	s_08 


PIC   n a_1/a22__F1__f1__m4__b1_ua    
PIC_MP n SWT
MSG	n_09 

PIC_HIDE s
TALKER w L
TALKER n R
DOTL
