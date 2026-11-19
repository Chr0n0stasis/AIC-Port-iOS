DEFINENDEF _insert_in_costume_change=
PIC_HIDE_ALL	T 

DOTL
HIDE_BLURSC
PE ZOOM2 -1
WAIT 20
__cloth_changed=1
#MS_ % '## w15 P[walk] >>[Ev_backyard_door 20,0 :100] P[stand]'
WAIT 30
TL 20 LP_ACTIVATE_TO_CHIP Ev_backyard_door
HALF_BGM	1

PIC_FILL	#9 DARK 
PIC_FADEIN  #9 50
WAIT 60
CLEAR_DROP_ITEMS

ENGINE_NNEA Barten FIX_POS
SND cloth_dojo_off
IFSTR $_insert_in_costume_change ISNOT '' {
    HKDS	n   CCLCB @C TT
    TL 50 MSG $_insert_in_costume_change T
}
WAIT 200
DOTL

#< % >
IF $_costume'==0' {
    PR_OUTFIT BUNNY
} ELSIF $_costume'==1' {
    PR_OUTFIT BUNNYREV
}

__mgm_bun_active=1
LP_DEACTIVATE   ExitD_bar
HIDE_LAYER table_4ascend
HIDE_LAYER front_light
#CMDRELOAD	IMMEDIATE IMMEDIATE_LOAD 

STOP_BGM	120 0


