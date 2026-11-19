DEF_CURMAP _curmap
IFSTR $_curmap IS city_scl_ground
    SEEK_END

#SND_LOAD ev_club
PIC_FILL #9 DARK
<LOAD>
QUEST_FINISH p106_grazia_goto_club H

#MS_ % 'ptc[00_alma_goto_ground] >>[Ev_106_00.b 30,0] ## @L >+[-30,0 :60] P[stand_ev~] '

CITYCASTER_LOAD 0
WAIT 4
PIC_FADEOUT	#9 40

#< mobq >
#MOBG_ANIM_SHOW_CANE

#MS '>+[300,0] @R P[walk] >+[230,0 :130] P[stand]' 
#MS_ alma '>+[200,0] @R w80 P[walk] >+[320,0 :250] P[stand]' 

HKDS	mb LT #<mobq>
TALKER_REPLACE	mb '' talk_mob_w9

WAIT 78

MSG	mb_00 

TALKER	n R  
PIC   n a_3/a0__F1__f3__m5__b2_u0     
PIC_MP	n AWK 



MSG	n_01 
HKDS	mb L '='


MSG	mb_01 

PIC_HIDE_ALL	 



WAIT 25

#MS 'w25 P[walk] >+[820,0 :320] P[stand]' 
#WAIT_MOVE_TARGET alma

WAIT_MOVE
#MS_ alma 'P[walk] >+[120,0 :80] P[stand_nocane]' 
#WAIT_MOVE_TARGET 

HKDS	l RB @CR
HKDS	n LB @CL

SND cloth_off
PIC #8 scl_106/s106_00
PIC_MOVE2	#8 C C-15 C C+30 30 ZSIN

PIC_FADEIN #8 30

TL 40 MSG	n_03 CBF

MSG	l_02 

DOTL



MSG	l_04 


MSG	n_05 


MSG	l_06 

WAIT 15
SF_SET TBOX_106_boxes_table_Treasure_mg_watershard 0
REMOVEMAGIC WATERSHARD

DENY_SKIP
INIT_MAP_MATERIAL city_scl_ground 3
PIC_FADEOUT #8 50
PIC_MOVE	#8 C C+155 60 ZPOW
PIC_FILL #9 DARK
PIC_FADEIN #9 110


#MS_ alma 'P[walk] >+[140,0 :110] '
#MS_ % 'w30 @R w15 >+[100,0 :80] ptc![00_alma_goto_ground]'


WAIT 125

PIC_FADEOUT #8 0

GFC_SET IXA1 8

SCN_MANUAL_BGM_REPLACE ''
WAIT_FN MAP_TRANSFER
NEL_MAP_TRANSFER city_scl_ground R !!
// ========================
CHANGE_EVENT	106/01_ground_ensyu
