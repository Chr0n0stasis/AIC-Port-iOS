WAIT 20
// GOTO _FLASHBACK


TALKER i R
TALKER n L
TALKER_REPLACE i Unknown
LOAD_BGM BGM_ixia

DENY_SKIP
HKDS i TT #<ixia> WIDE_TT
#MS_ % '@R  P[stand_ev] '

DENY_EVENTHANDLE
TL 130 ALLOW_EVENTHANDLE
TL 80 STOP_BGM 180 0
TL 80 #MS '>>[Ev_ixia.b] ## w20 @L ! P[stand2fly] >+[-40,0 :50] >+[-370,0 :85] >>[Ev_wpl200.Lb 70,0 <<0.12] >+[-20,0 :30] ? @L P[fly2stand] >+[-20,0 :50]'
TL 80 PE ZOOM2 40
TL 120 #MS_ % '@R >>[ Ev_wpl200.Lb -32,0 ] '
TL 310 #MS_ % '! P[walk] >+[-20,0 :50] ? w8 @R P[stand_ev]'

MSG s01_ixia_2a_00*i_00

WAIT_MOVE

ALLOW_SKIP
HKDS i 
REPLACE_BGM 0 100 0
WAIT 20

TALKER_REPLACE i 
PIC   i i/a00L1R2__F1__f1__m1__b5_u1    
PIC_MP i 
PIC   n a_1/a22__F1__f1__m1__b1__uo    


MSG	i_01 

PIC   n a_3/a0__F1__f3__m5__b2_u4    
PIC_MP n SWT2
MSG	n_02 
PIC   n a_1/a22__F1__f1__m1__b2__u1    
PIC_MP n TTT
MSG	n_02_2 

PIC   i i/a00L1R1__F2__f2__m1__b3_u2    
PIC_MP i QUE
MSG	i_03 

@_TSUKKOMI
PIC   i i/a00L1R3__F1__f1__m1__b1_u1    
PIC_MP i EXC
PIC   n a_2/a0L2R3__F2__f2__m1__b5_u0    
PIC_MP n AWK
MSG	i_04  I


PIC   n a_3/a2__F1__f3__m1__b1_uo    

MSG	n_05 


PIC   i i/a00L1R5__F1__f1__m1__b3_ua    
MSG	i_06 C

MSG_HOLD
WAIT 40
PIC   n a_1/a22__F1__f1__m1__b1__u0    
PIC_MP n SWT

MSG	n_07 


PIC_HIDE_ALL	


WAIT 30

#< >
#SND_LOAD ev_city_td
#MS 'P[appeal]'

HKDS i RT #<ixia> 
MSG	i_08 

STOP_BGM 230 0
#MS 'P[stand2fly] ! @R >+[40,0 :50] >>[Ev_ixia.b 240,0 << 0.14] P[stand]'
#MS_ % 'w65 ## w18 P[walk] >+[45,0 :70] P[stand_ev~] @R '

WAIT 75
PIC   n a_2/a0L1R3__F2__m6__b2_u1    
PIC_MP n EXQ
MSG	n_10 

PIC   n a_1/a22__F1__f1__m3__b1_u0    
PIC_MP n DEP
MSG	n_10_1 

DOTL 

PIC   n a_3/a0__F1__f3__m1__b4_u5    
MSG	n_11 


LABEL _FLASHBACK
PVV_ABSOLUTE 107
SND memoryback
PIC_FILL &9 0xffDCDCDC
PIC_FADEIN &9 20
INIT_MAP_MATERIAL school_in_armory_mtgroom 1
SCN_MANUAL_BGM_REPLACE ''
WAIT 25
PE SEPIA 1
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

PVV_ABSOLUTE 201
SND memoryback
PIC_FILL &9 0xffDCDCDC
PIC_FADEIN &9 20
INIT_MAP_MATERIAL mount_wpl_end 1
SCN_MANUAL_BGM_REPLACE ''



WAIT 25
WAIT_FN MAP_TRANSFER
NEL_MAP_TRANSFER mount_wpl_end L !!
#MS_ % '>>[Ev_wpl200.Lb -8,0] @R P[stand_ev] '

WAIT 2
TITLECALL_HIDE 1
PVV_ABSOLUTE 200
PIC_FADEOUT &9 80
PE SEPIA -70
ALLOW_SKIP
LOAD_BGM BGM_mountain NormalMountain
WAIT 120
TALKER	n L   


PIC   n a_3/a2__F1__f3__m1__b4_u2    
PIC_MP n TTT
MSG	n_12 

PIC   n a_1/a00L1R1__F1__f1__m1__b2__uo    
MSG	n_13 
PIC_HIDE_ALL	 
#MS_ % 'P[walk~] >+[60,0 :40]'

REPLACE_BGM 180
GFC_SET ALM0 1
// PVV_ABSOLUTE 201
NIGHTINGALE_SET mount_entrance_grazia

WAIT_MOVE

STOREFLUSH Night
PR_ASSIGN_REVERT_POSITION
AUTO_SAVE
