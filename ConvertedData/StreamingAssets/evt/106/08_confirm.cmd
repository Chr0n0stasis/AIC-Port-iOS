#SND_LOAD ev_city
TUTO_REMOVE
 HKDS	bs LT #<boss>
TALKER_REPLACE	bs instructor talk_mob_w2
KILL_PR_MAGIC

#MS_ % 'F @#[boss::40] P[stand_ev~]'

TALKER	n R   
PIC   n a_2/a0L1R1__F2__f2__m1__b4_u2    
PIC_MP n SWT


MSG	n_00 

WAIT 25

#MS_ boss '##'

// DEFINE_NOEL_CANE _cane

// IFSTR $_cane ISNOT 'cane_bermit' {

//     // 杖がベルミット杖ではない場合
//     MSG	bs_01 
// }

MSG	bs_02 

PIC   n a_3/a2__F1__f3__m1__b4_u0    

MSG	n_03 

SELECTARRAY_CLEAR
SELECTARRAY &&Select_retry_again  _RETRY 
SELECTARRAY &&Select_finish_lecture _FINISH C
SELECT_FOCUS	1
SELECT -1

LABEL _RETRY
PIC   n a_3/a0__F1__f3__m1__b1_u3    

MSG	n_04 


MSG	bs_05 


MSG	bs_06 

PIC_HIDE_ALL	 

PIC_FILL #9 DARK
PIC_FADEIN #9 40
WAIT 40

CHANGE_EVENT 106/04_ensyu_first_orbit
// ========================
LABEL _FINISH
PIC_HIDE_ALL

WAIT 20

#MS_ boss '@L'
WAIT 25

LP_DEACTIVATE PuzzBarrier_sclground_00

SND city_whistle
MSG bs_10
DENY_SKIP
CITYCASTER_AI_ALL idle

WAIT 20
PIC_FILL #9 DARK
PIC_FADEIN #9 80
// 13, 5 がそれぞれ sub_i, sub_l に置き換わっている。 最大14
_i=0
LABEL _LOOP
IF $_i'==5' {
    _mv=citycaster_sub_i
} ELSIF $_i'==13' {
    _mv=citycaster_sub_l
} ELSE {
    _mv=citycaster_$_i

}
_w=~4+rand[14]
_x=~300+rand[340]
_spd=~0.07+rand[100]/100*0.045
#MS_ $_mv 'w'$_w'  >+['$_x',0 <<'$_spd']' 
_i=~$_i+1
IF $_i'<=14' {
    GOTO _LOOP
}

WAIT 250


ALLOW_SKIP

HKDS	bs CRT @LOUT

SND city_whistle
MSG bs_20

WAIT 45

CHANGE_EVENT	106/20_before_matofight



