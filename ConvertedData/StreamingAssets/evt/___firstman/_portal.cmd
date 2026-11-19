@___firstman/__header
TALKER	n L  
TALKER	fh R   
 

IF 'GFC[FHM0]==0 && GFC[FHM1]==0' {
    CHANGE_EVENT	___firstman/t00
}

IF 'GFC[FHM0]==0 && GFC[FHM1]==1' {
    CHANGE_EVENT	___firstman/t01
}

_en_key=Assigned_sub_firstman_npc

GREETING	L 20
WAIT 20
IF 'GFC[FHM0]>=1' {
    CHANGE_EVENT2 ___firstman/_check_treasurehunt_finish
    IFSTR $_treasurehunt_finish_pic ISNOT '' {
        CHANGE_EVENT2 ___firstman/t_finish_treasurehunt
    }
}
<LOAD>


LABEL _AGAIN

SELECTARRAY_CLEAR
SELECTARRAY	 &&Select_fishing_tutorial _FISHTUTO 
SELECTARRAY	 &&Select_nothanks SKIP C
SELECT -1 
// ========================
LABEL _FISHTUTO

CHANGE_EVENT2	___firstman/_fishing_tutorial
#MS_ % '>>[Ev_first -30,0] ? @L >+[-40,0 :60] '
WAIT 60

SEEK_END

// ========================
LABEL SKIP
//<BREAK>
#MS_ % '##'
HALF_BGM 0
