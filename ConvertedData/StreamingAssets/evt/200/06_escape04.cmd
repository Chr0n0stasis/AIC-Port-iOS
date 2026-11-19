//05_escape3 mount_ruinroad 撃破後
DEFINENDEF 1=0
START_LETTERBOX

QA200_REMOVE_MOVER
WAIT 20
#< % >
TALKER	n L 
IF $1 {
    @__M2D_GAMEOVER_WAKEUP_WAIT
    // gameover
    PIC   n a_3/a1__F1__f3__m2__b2_u0    
    MSG n_50    
} ELSE {
    #MS 'F P[stand_ev~]'
}

PIC   n a_1/a22__F1__f1__m1__b2__u1    

MSG n_00

IF '(GFC[ALC1]&1 )==0' {
    PIC   n a_1/a00L1R1__F1__f1__m1__b2__u1    
    MSG n_01
    @___Other/Tuto_check_map
    GFC_SET ALC1 |=1
    
}

QUEST_PROGRESS p200_alice 4
PVV 201
AUTO_SAVE
