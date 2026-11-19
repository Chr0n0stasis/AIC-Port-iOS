


#SND_LOAD mg_shinebooster
#MS_ alice '>>[Ev_alice.R -10,0] P[stand~] ## #;'
WAIT 90
DENY_SKIP
ENGINE Alice200 SHINEBOOSTER_RUN Ev_SBRR
WAIT 80
ALLOW_SKIP
#MS_ % '? @R >>[Ev_R -20,0] ## >+[230,0 <<0.07] P[stargaze~]'
WAIT 130
TALKER	n L    

PIC   n a_2/a0L2R3__F2__f2__m1__b5_uo    
PIC_MP n EXC
MSG	n_00 
PIC_HIDE_ALL	 
#MS_ % 'w20 P[beware~]'

WAIT 45

PIC   n a_3/a0__F1__f3__m5__b2_u0    
PIC_MP n SWT2
MSG	n_01 
PIC_HIDE_ALL	 
LP_ACTIVATE ladder Extender_ladder



WAIT 82

PIC   n a_1/a22__F1__f1__m4__b1_ua    
PIC_MP n SWT
//ロープが降りてくる
MSG	n_02 
PIC_HIDE_ALL	 


#MS_ % '= >+[40,0 :60] ?'
WAIT_MOVE
// ========================
GFC_SET ALC1 |=2
GFC_SET ALM1 0
QUEST_PROGRESS p200_alice 28
IF 'Exist_mover[Ev_SBRRR]' {

    #< Ev_SBRRR >
    #VANISH 
}
IF 'Exist_mover[Ev_alice_in]' {

    #< Ev_alice_in >
    #VANISH 
}

AUTO_SAVE
