v=~quest_progress[p200_elec_facil]
HKDS	dev  CCLCT #<facility_console>
TALKER_REPLACE	dev Mob talk_cane

IF $v'==0 || '$v'==1' {
    CHANGE_EVENT	200/45_elec_facil_recover 0
    
} ELSIF $v'==2' {
    CHANGE_EVENT	200/45_elec_facil_recover 1
    
} ELSIF $v'==3' {
    
    CHANGE_EVENT	200/45b_elec_facil_alert 1
    
}
