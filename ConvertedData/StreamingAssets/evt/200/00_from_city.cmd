PIC_FILL &9 DARK
GFC_SET WLR_G 0

HKDS	n LT #<%>
START_LETTERBOX
<LOAD>
#MS_ % '= >>[WarpTo 110,0] #; @R >+[60,0 :150] w40 P[stand_ev~] w10'
WAIT 3
PIC_FADEOUT &9 55
TALKER_REPLACE	n 
WAIT 20
MSG	n_00 

WAIT_MOVE
HKDS	n   
TALKER	n L   
#SND_LOAD ev_city_td
 
IF 'quest_progress[p200_alice_veryfirst]==0&&PVV==200' {
    // 028からのアップグレード
    QUEST_PROGRESS p200_alice_veryfirst 1 H
    
    LABEL _FLASHBACK
    PVV_ABSOLUTE 107
    SND memoryback
    PIC_FILL &9 0xffDCDCDC
    PIC_FADEIN &9 20
    INIT_MAP_MATERIAL school_in_armory_mtgroom 1
    SCN_MANUAL_BGM_REPLACE ''
    WAIT 25
    PE SEPIA 1
    PE ZOOM2 1
    wpl_hachan=1
    WAIT_FN MAP_TRANSFER
    NEL_MAP_TRANSFER school_in_armory_mtgroom L !!
    DENY_SKIP

    TITLECALL_HIDE 1
    WAIT 8

    LP_DEACTIVATE Effector_sound
    CHANGE_EVENT2  107/61_mtgroom_preload
    

    #MS_ % '>>[ExitD_armory_mtg.Lb 0,0] @L >+[-100,0 :110]  P[stand_ev~]'
    #MS_ alice '## #; @L P[stand_ev_3=3] w35 P[stand2pet] @BL w30 ## '
    WAIT 18

    PIC_HIDE_ALL	T 1
    PIC_FADEOUT &9 80
    wpl_hachan!
    WAIT 100
    #MS_ alice  'P[crouch2beware_turnback]   @R '

    WAIT 60

    PVV_ABSOLUTE 200
    SND memoryback
    PIC_FILL &9 0xffDCDCDC
    PIC_FADEIN &9 20
    INIT_MAP_MATERIAL city_entrance_rightcave 1
    SCN_MANUAL_BGM_REPLACE ''



    WAIT 25
    WAIT_FN MAP_TRANSFER
    NEL_MAP_TRANSFER city_entrance_rightcave L !!
    #MS_ % '>>[WarpTo.b 170,0] @R #; P[stand_ev=7] '
    WAIT 2
    TITLECALL_HIDE 1
    PVV_ABSOLUTE 200
    PIC_FADEOUT &9 80
    PE ZOOM2 -1
    PE SEPIA -70
    ALLOW_SKIP
    WAIT 120
}
    
PIC   n a_1/a22__F1__f1__m1__b2__uo    
MSG	n_01 

PIC   n a_3/a2__F1__f3__m1__b1_uo    

MSG	n_02 
PIC_HIDE_ALL	 

QUEST_REMOVE p200_alice_veryfirst 1 
QUEST_REMOVE p200_alice 1 
WAIT 3
QUEST_PROGRESS p200_alice_veryfirst 1 X
GFC_SET ALM1 0
