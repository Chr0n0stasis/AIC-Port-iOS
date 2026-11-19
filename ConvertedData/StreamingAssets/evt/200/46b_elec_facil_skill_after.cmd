IF 'PVV>=215||quest_progress_f[p200_elec_facil]>=4' {
    SEEK_END
}

WAIT 15
START_LETTERBOX
TALKER	n L    

PIC   n a_3/a2__F1__f3__m1__b1_u3    
PIC_MP n EXC

MSG	n_00 

PIC_HIDE_ALL	 
WAIT 20

#MS_ Ev_cam '##'

WAIT 80
QUEST_PROGRESS p200_elec_facil 4
REDRAW_TERM_FLUSH


// 物置に設置されたトラップ作動
HKDS	n CCRCT #<%> TT
WAIT 22

MSG	n_02 A


#MS_ % '= w40 ## P[guard]'
HKDS	n    



PIC   n a_2/a0L1R3__F2__f2__m3__b1_u1    
PIC_MP n SWB

MSG	n_03 

PIC   n a_3/a2__F1__f3__m1__b1_u3    

MSG	n_04 

PIC_HIDE_ALL	 
#CMDRELOAD	  


WAIT 35
CHANGE_EVENT2	200/47_evadejump_tips
