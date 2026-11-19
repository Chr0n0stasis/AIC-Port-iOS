// 窓から侵入

PIC_FILL   	#9 DARK 

#< $1 >
#MS '## #;'
#MS_ % '>>[Ev_RR]'
WAIT 5
<LOAD>
#SND_LOAD ev_club
#DECLINE_AREA_CAMERA 2
PIC_FADEOUT	#9 80
IF 'GFC[TIG0]<=1' {
    DENY_SKIP
}

CHANGE_EVENT2	___Tigrina/106sneak_kabesiri ___Tigrina/106sneak_00*n_00 170


DOTL
IF 'GFC[TIG0]<=1' {

    #MS_ % '@L P[wakeup_b]: @R P[stand_weak]'

    WAIT 20
    HKDS	
    TALKER	n L      

    PIC   n a_3/a1__F1__f3__m2__b2_u1    
    PIC_MP	n BLS|BSM 

    MSG n_01
    PIC_HIDE_ALL	T
    WAIT 20
    PE ZOOM2 60
    PE ZOOM2 -1
    WAIT 30
    #MS_ % '## P[walk~] >+[50,0 :80] P[stand~]'

    WAIT_MOVE
    WAIT 10

    GFC_SET_MX	TIG0 2 
    GFC_SET TIG1 0
    AUTO_SAVE

} ELSE {
    PE ZOOM2 60
    PE ZOOM2 -1
    #MS_ % '@L P[wakeup_b]: @R '
    #MS_ % '## P[walk~] >+[50,0 :60] P[stand~]'
    WAIT_MOVE

}