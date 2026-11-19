#< % >
REMSKILL shine_booster
#MS 'SND[heartbeat_ll] PTC[ev_general_qu_vib]'
PVIB lp_cannon_hit error_skill_gotten
HIDE_STATUS
PE ZOOM2 40
PE BGM_WATER 30 1
PE JAMMING 30 0.5
HKDS	cane  CRT #<%> 
TALKER_REPLACE	cane NoelCane talk_cane
TL 15 SND flashback_noise 

TALKER	n L    
HKDS	n B '' TT
<LOAD>

START_LETTERBOX
#MS 'P[stand_hardbreathe]'
SND  garage_pico_error//  puzzle_rope はらばいアリス
MSG cane_00 DCP[150]
MSG_HOLD

WAIT 15

PIC   n a_2/a0L2R3__F2__f1__m2__b2_u2     I
PIC_MP n BLS|EXQ I
MSG n_00 A
PIC   n a_3/a2__F1__f3__m2__b3_u0    
PIC_MP n BLS|SWT I
PIC_MVA n 25 SCARY
MSG n_01 A

DOTL
PIC_HIDE_ALL	 
#MS 'w25 SND[smallalert] w8 SND[smallalert] w8 SND[smallalert] w8 SND[smallalert]'

WAIT 40
HKDS	n
PE ZOOM2 -200
PE BGM_WATER -150

WAIT 40
#MS 'q P[knockout_fear]'
PVIB puzz_box_activate_once ground_gogogo_s
WAIT 34

PIC   n a_2/a0L2R3__F2__f2__m2__b1_u0    
PIC_MP n SWT|BLS
MSG	n_02 
TL 30 PE JAMMING -100
PIC_HIDE_ALL	%&#T or empty 1 to immediate

#MS 'w24 P[stand_weak]'
WAIT 65

PIC   n a_1/a22__F1__f1__m1__b3__uo    
MSG	n_03  T


IF 'quest_progress_f[p200_alice_mine1]>=0' {
    QUEST_FINISH p200_alice_mine1
}

DOTL
GETITEM precious_errorchip 1 0
// REMSKILL shine_booster
