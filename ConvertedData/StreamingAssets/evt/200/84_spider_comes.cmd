ENGINE Alice200
#SND_LOAD enemy_boss
#SND_LOAD enemy_bossspider

TALKER	a L
TALKER	n R   
TALKER_REPLACE	a  Mob 
#MS_ % '= @L P[interact=3]'
#MS_ alice 'q ## #; P[ev_guard] @R'
LOAD_BGM BGM_dungeon3
WAIT 70 
#MS_ % '## P[guard]'
HKDS	n    

PIC   n a_3/a2__F1__f3__m3__b1_u0    
MSG	n_00  T
PIC_HIDE_ALL	 


WAIT 60

#< alice >
#PTCST ev200_bossspider_capture_init // arrow_beam_web
PE ZOOM2 1
PE ZOOM2 -1
ENGINE Alice200 CAPTURE_INIT

//杖を下ろす
//直後、大きな魔族の鳴き声・唸り声
HKDS	a LB #<alice> TT 
HKDS	 n RT #<%> TT 

MSG	a_01 AFC
MSG_HOLD
DENY_SKIP
#MS_ % 'w5 P[ev_run_stop]'
WAIT 15 
MSG	n_02 A

WAIT 70
#MS_ % '= ## ? P[run] >>[Ev_C.b -10,0 <<0.18] P[run_stop] <<[0.12,0 a0h1r30] w30 P[beware~] '
WAIT 10
HKDS	n    

PIC   n a_3/a2__F1__f3__m3__b2_uo    
MSG	n_03 T
PIC_HIDE_ALL	 

WAIT_MOVE
#MS_ alice '## ^ >>[Ev_Ceil 0,0]'
WAIT 2
ENGINE Alice200 CAPTURE_FROM_CEIL
TL 160 REPLACE_BGM	20 40 

WAIT 128

MSG	a_04 A

WAIT 30
#MS_ % '= ##'
WAIT 20
PIC   n a_3/a0__F1__f3__m2__b3_u1    
TL 12 PIC_MVA n 5 SCARY

MSG	n_05  T

DOTL
WAIT 15
PIC_HIDE_ALL	'' 1

PE BGM_LOWER 20
SND flashback_noise
PIC_FLASH	&4 0 5 4 0xffBBA0A0
TL 30 PIC_FLASH	&4 4 2 25 0xffBBA0A0
PIC_FILL	&3 0xff3A3434

TALKER_REPLACE	n  '' ''
HKDS	n C ''  MONOLOGUE
WAIT 80

MSG	n_06 I
MSG	n_07 I

HKDS	n   
TALKER_REPLACE	n  
 

#MS_ % 'P[interact]'
PIC_FADEOUT	&3 120
PE BGM_LOWER 60
PE BGM_LOWER -1
WAIT 70
PIC   n a_2/a0L1R1__F2__f2__m1__b1_u2    
MSG	n_08

LOAD_LAYER treasure_blackhole

