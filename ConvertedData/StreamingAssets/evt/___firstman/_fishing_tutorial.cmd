_pond_key=mount_house
// _en_key にNNEA の名前をいれておく

_mv_pond=FisMain-$_pond_key 
IF 0 {
    LABEL AGAIN
}
PIC_HIDE_ALL	 
PIC_FILL #9 DARK
PIC_FADEIN	#9 55

WAIT 60
FISBGM_STATE OFFLINE 1 
#NO_DECLINE_AREA_CAMERA

#MS_ Firstman  '@L P[stand]'
#MS_ $_mv_pond '## #;'
#MS_ % '>>[Ev_first 50,0] @L ! >+[30,0 :70] P[stand_ev~] ?'
#< Firstman >
FISHPOND $_pond_key FINE_CANE_APPEARANCE 1
IF 0 {
    FISHPOND $_pond_key CACHE_SET_FISH eel
} ELSIF 'GFC[MOB9]==0' {
    GFC_SET MOB9 1
    FISHPOND $_pond_key CACHE_SET_FISH sardine
} ELSIF 'GFC[MOB9]==1' {
    GFC_SET MOB9 2
    FISHPOND $_pond_key CACHE_SET_FISH herring
}  ELSIF 'GFC[MOB9]==2' {
    GFC_SET MOB9 0
    FISHPOND $_pond_key CACHE_SET_FISH flounder
}
PIC_FADEOUT	#9 50
WAIT 35

FISHPOND $_pond_key LUREINIT




DENY_SKIP
WAIT 45
ALLOW_SKIP
#DECLINE_AREA_CAMERA
#MS_ % '= ## P[stand_ev~]'
IFSTR $_cought_fish ISNOT '' {
    CHANGE_EVENT2 ___firstman/t_fish_turorial
    SELECT 2
    &&Select_watch_again AGAIN 
    &&Select_nothanks _NOTHANKS

}
LABEL _NOTHANKS

PIC_HIDE_ALL	 

PIC_FILL #9 DARK
PIC_FADEIN	#9 55

WAIT 60
PIC_FADEOUT	#9 60
FISBGM_STATE OFFLINE 1 
FISHPOND $_pond_key CACHE_SET_FISH 
// FISHPOND $_pond_key FINE_CANE_APPEARANCE 0


// #MS '## #; >+[-30,0] P[walk~] >+['$_movelast',0:80] '
// PIC_FADEOUT	#9 50
// WAIT 50
