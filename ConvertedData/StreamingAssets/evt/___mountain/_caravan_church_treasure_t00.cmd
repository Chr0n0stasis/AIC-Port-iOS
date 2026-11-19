GREETING	@ 15
#MS_ $1 '@#[%::60]'

HKDS	mb RT '#<'$1'>' 
HKDS	n LT  '#<%>' 

TALKER_REPLACE	mb Mob talk_mob_w5

IF 'quest_progress_f[subquest_treasurehunt_001]==-1' {
    WAIT 20
    MSG	mb_00 


MSG	n_01 


MSG	mb_02 


MSG	n_03 


PIC_SWIN treasurehunt/treasurehunt_001__0

MSG	mb_04 


MSG	n_05 

CHANGE_EVENT2 __treasurehunt/_quest_init




QUEST_PROGRESS subquest_treasurehunt_001 0  

} ELSE {
    // 2度目話す
    PIC_SWIN treasurehunt/treasurehunt_001__0
    WAIT 25
    MSG	mb_20 

}
