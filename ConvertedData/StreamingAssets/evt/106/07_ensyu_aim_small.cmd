 HKDS	bs LT #<boss>
TALKER_REPLACE	bs instructor talk_mob_w2
LP_ACTIVATE PuzzBarrier_sclground_00

#MS_ % 'F @#[boss::40] P[stand_ev~]'

MSG bs_00
WAIT_MOVE

#MS_ % 'w20 >>[PuzzBarrier_sclground_00.b 0,0 <<0.1] @L P[stand_ev~]'
WAIT 30


MSG bs_01
ENGINE SclTeacherPVV106 AIM_SMALL 106/08_confirm 106/09_failure
MSG bs_02

TUTO_MSG  Tuto_watershard_07
TUTO_POS R B
TUTO_CAP_MOVIE	tuto_watershard07  
TUTO_CAP    '' '<key WATERSHARD/>' 0
TUTO_CAP    '' '<key x/>' 1.2
TUTO_CAP    '' ''  4.0
