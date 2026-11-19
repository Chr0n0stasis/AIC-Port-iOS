<NOLOAD>
_q=~quest_progress_f[p200_alice_mine1]

IF $_q'!=1||GFC[MOB1]==1' {
    SEEK_END
}
IF 'SkillHas[evade_jump]' {
    SEEK_END
}

<LOAD>

GFC_SET MOB1 1
TALKER	n L 

PIC   n a_2/a0L3R3__F2__f1__m2__b2_u2    I
PIC_MVA n 24 SCARY 

MSG	n_00 AI

PIC_HIDE_ALL	 

WAIT 100
PIC   n a_3/a2__F1__f3__m2__b1_u1    
PIC_MP n BLS|SWT

MSG	n_01 


MSG	n_02 

