DEFINENDEF 1=0

GREETING	R 8
WAIT 20

IF $1'==1' {
    // 2度目
    GOTO AGAIN
}


SELECT 2
&&Select_launch_elec_faciliy _LAUNCH C
&&Select_stop_sitdown _SEEK_END C

LABEL _SEEK_END
SEEK_END
// ========================

LABEL _LAUNCH

TALKER	n R     
GREETING	R -28

PIC   n a_2/a0L2R3__F2__f2__m1__b5_u2    
PIC_MP n SWT
MSG	n_00 
PIC_HIDE_ALL	  

#MS_ Noel 'snd[cloth_off] P[interact~] w20 snd[mount_elec_device_input] w70 ptcT[puzz_box_activate_once]'
WAIT 115

MSG dev_10 D
WAIT 30
#MS_ Noel '= ptc[ev200_mount_facil_activate0] w20 @L ! >+[40,0:66] ? @R P[beware]'
QUEST_PROGRESS p200_elec_facil 2 XH
REDRAW_TERM_FLUSH
WAIT_BUTTON 140



INIT_MAP_MATERIAL mount_carabl 1
PIC_FILL #9 DARK
PIC_FADEIN #9 30
__43_ostrea_panup=1
WAIT 35
QUEST_PROGRESS p200_elec_facil 1 XH
WAIT_FN MAP_TRANSFER 
HALF_BGM 1
NEL_MAP_TRANSFER mount_carabl L !Ev_BB
__43_ostrea_panup=1
#CMDRELOAD	IMMEDIATE IMMEDIATE_LOAD 
WAIT 3
HIDENOEL 1

#< 43_ostrea_panup >
#MS '## #~'
PIC_FADEOUT #9 40
WAIT 45
QUEST_PROGRESS p200_elec_facil 2 XH
#MS 'ptc[ev200_mount_facil_activate1]'
REDRAW_TERM_FLUSH
WAIT_BUTTON 120






INIT_MAP_MATERIAL mount_windtower 1
PIC_FILL #9 DARK
PIC_FADEIN #9 30
__43_ostrea_panup=1
WAIT 35
QUEST_PROGRESS p200_elec_facil 1 XH
WAIT_FN MAP_TRANSFER 
NEL_MAP_TRANSFER mount_windtower L !Ev_doorRR
__43_ostrea_panup=1
#CMDRELOAD	IMMEDIATE IMMEDIATE_LOAD 
WAIT 3
HIDENOEL 1

#< 43_ostrea_panup >
#MS '## #~'
PIC_FADEOUT #9 40
WAIT 45
QUEST_PROGRESS p200_elec_facil 2 XH
#MS 'ptc[ev200_mount_facil_activate1]'
REDRAW_TERM_FLUSH
WAIT_BUTTON 120




INIT_MAP_MATERIAL mount_in_elec_facility_console 1
PIC_FILL #9 DARK
PIC_FADEIN #9 30
WAIT 35
WAIT_FN MAP_TRANSFER 
NEL_MAP_TRANSFER mount_in_elec_facility_console L !Ev_consoleR
#CMDRELOAD	IMMEDIATE IMMEDIATE_LOAD 
WAIT 3
HIDENOEL 0
HALF_BGM 0

#< % >
#MS '@L P[beware] ?'
PIC_FADEOUT #9 40
WAIT 55


QUEST_PROGRESS p200_elec_facil 2

LABEL AGAIN

PIC   n a_3/a0__F1__f3__m1__b4_uo    
PIC_MP n TTT
MSG	n_11 

IF 'quest_progress_f[p200_alice_mine1]>=1' {
    MSG	n_12 
}

// 
SEEK_END
//================================================
