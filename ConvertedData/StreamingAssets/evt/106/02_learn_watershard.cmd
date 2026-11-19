
PIC_FILL #9 DARK
DENY_PR_CANE_SWITCH 1
#MS_ % '>>[Treasure_mg_watershard.b 60,0] P[walk] ## #; >+[-40,0 :55] P[stand~]'

#MS_ citycaster_7 '>>[#<dev2> 80,0] @L P[walk] >+[-65,0:55] P[stand_cane2] w180 P[walk] >+[400,0 :280]'
#MS_ dev2 'w55 w120 >+[0,200] w220 >+[10,-200]'
#MS_ staff '>+[100,0] @L P[walk] >+[-100,0:80] P[stand] w125 P[walk] @R >+[210,0 :180] P[stand] w50 @L P[walk] >+[-210,0:170] P[stand]'
#MS_ staff 'w120 @R  P[walk] >+[80,0 :70] P[stand] w70 @L P[walk] >+[-80,0:70] P[stand]'
#MS_ staff 'w180 @R  P[walk] >+[30,0 :50] P[stand] w70 @L P[walk] >+[-30,0:50] P[stand]'

#MS_ citycaster_11 'w320 >>[#<dev1> 440,0] @L P[walk] >+[-425,0:280] P[stand_cane2] w180 P[walk] @R >+[490,0 :320]'
#MS_ dev1 'w320 w280 w120 >+[0,200] w110 >+[0,-200]'
#MS_ citycaster_0 'w560 >>[#<dev0> 460,0] @L P[walk] >+[-445,0 :320] P[stand_cane2] w180 P[walk] @R >+[490,0 :345]'
#MS_ dev0 'w560 w320 w120 >+[0,200] w170 >+[0,-200]'
#MS_ citycaster_4 'w840 >>[#<dev2> 460,0] @L P[walk] >+[-445,0 :320] P[stand_cane2] '

WAIT 2
PIC_FADEOUT #9 50

#WAIT_MOVE_TARGET %

WAIT_MOVE
#WAIT_MOVE_TARGET


#CALL2 Treasure_mg_watershard CHECK

WAIT 30
TALKER	n L   
HKDS	n    
PIC   n a_3/a2__F1__f3__m1__b2_u3    
MSG n_00
PIC_HIDE_ALL	 



PIC_FILL #9 DARK
PIC_FADEIN #9 80
#MS_ % 'P[walk] >+[100,0 :80] P[stand]'

INIT_MAP_MATERIAL city_scl_ground 1
GFC_SET_MX IXA1 9
WAIT 80
SCN_MANUAL_BGM_REPLACE BGM_tyousa_dbd_file_no3 
WAIT_FN MAP_TRANSFER
NEL_MAP_TRANSFER city_scl_ground R !!


CHANGE_EVENT 106/03_ensyu

