DEFINENDEF 1=0
IF $1'==1' {
    GOTO AGAIN
}

#VANISH
#SND_LOAD ev_mountain

#MS_ % 'P[ev_run_stop] F w20'
PVIB lp_breakable_death
SND mount_error_activate
STOP_BGM 150 
QUEST_PROGRESS p200_elec_facil 3
SETMAGIC_NOMANA EV_ELEC_ALERM
REDRAW_TERM_FLUSH


HKDS	n CCL    #<%> TT
HKDS	dev LT @LOUT
TALKER_REPLACE	dev Mob talk_cane 


MSG	n_03 CA
MSG_HOLD
LOAD_BGM BGM_yocho
WAIT 25

MSG	dev_10  D

HKDS	 n 
TALKER	n R   

PIC   n a_2/a0L3R1__F2__m6__b1_u0    
PIC_MP n EXQ    

REPLACE_BGM	10 10 1


MSG	n_11 



SEEK_END
// ========================
LABEL AGAIN
GREETING	@ -30

TALKER	n R   
PIC   n a_2/a0L2R2__F2__m6__b1_u0    
PIC_MP n BLS|SWB
MSG	n_20 

HKDS	dev L @LOUT

MSG	dev_21 D
PIC   n a_3/a2__F1__f3__m5__b1_u0    
PIC_MP n BLS
@_TSUKKOMI

PIC_MVA n 3 JUMP
MSG	n_22  I
