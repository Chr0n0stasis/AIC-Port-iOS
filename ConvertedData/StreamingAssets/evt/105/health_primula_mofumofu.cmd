
PIC_HIDE_ALL	'' 1
PIC_FILL #0 DARK 
PIC_FADEOUT #0 55

PE ZOOM2 1
PE ZOOM2_EATEN -1


_mofu_fast=~300+rand[300]
_mofu_fast2=~350+rand[500]
// もふもふタイム
#MS_ % 'q >>[Ev_primula 21,0] P[primula_mofu] @L #; w'$_mofu_fast' TS[2] w'$_mofu_fast2' TS[4]'
#MS_ primula '##  q P[chair_mofu] @L'


WAIT 50
WAIT_BUTTON
STOP_BGM	150 1
// ========================

PIC_FILL	#0 DARK
PIC_FADEIN #0 50
WAIT 60

PE ZOOM2 -1
#MS_ % 'q'
#MS_ % '. ## #; >>[Ev_primula 14,0] @L ! P[walk~] >+[30,0 :60] ? P[stand_ev~]'
#MS_ primula 'q P[chair] @R'
HALF_BGM	 0
LOAD_BGM BGM_school

PIC_FADEOUT #0 55
WAIT 20
_reshow_picture=1
