GREETING	R -10
WAIT 10
SELECT 2 
&&Select_back BACK
&&Select_continue_sneaking CT C

LABEL CT
#MS_ % 'P[walk~] >+[35,0 :40] P[stand~]'
WAIT 40

SEEK_END

// ========================================================
// MARK : 帰宅
// ========================================================
LABEL BACK

#MS_ % 'P[walk~] >+[-15,0 :80]'
WAIT 10
PIC_FILL	#9 DARK
PIC_FADEIN	#9 60

INIT_MAP_MATERIAL school_garage_right 1
PE ZOOM2 -1
WAIT 80

WAIT_FN MAP_TRANSFER
NEL_MAP_TRANSFER school_garage_right R !Ev_elevator
PIC_FADEOUT	#9 80


#MS_ % '@L >+[-60,0 ] P[walk~] >+[-105,0 :75] P[stand~]'
WAIT_MOVE
