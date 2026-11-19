// イクシャ救出後 撃破

START_LETTERBOX

TALKER	i L
PIC_TERM_ENABLE i _beto 1

#< citycaster_sub_i >
CITYCASTER_AI idle
TALKER	n R
PIC_FILL	%9 DARK
PIC_FADEIN	%9 60
WAIT 62
#< % >
SUMMONER_RESCUE_REPOSIT
#MS '>>[Summon_mount_cave_honey0.b 50,0] @L P[stand_ev]'
#MS_ citycaster_sub_i 'q K TS[1] >>[Summon_mount_cave_honey0.b 4,0] @R'

PIC_FADEOUT %9 60
STOP_BGM 220 1
#MS_ citycaster_sub_i  'P[crouch]'
WAIT 45

PIC   i i/a00L5R5__F2__f2__m3__b1_u1    
PIC_MP i BLS|SWT

PIC   n a_1/a22__F1__f1__m1__b2__uo    
PIC_MP n SWT

MSG	i_00 

MSG	n_01 

PIC   i i/a00L5R3__F1__f1__m4__b2_u2    
PIC_MP i BLS|BSM

@_TSUKKOMI
MSG	i_02 I


CHANGE_EVENT2	200/22b_ixia_rescue_02




MSG	i_03 I

PIC   n a_3/a0__F1__f3__m1__b4_u4    
PIC_MP n SWT2

MSG	n_04  I

PIC   i i/a00L5R3__F1__f1__m1__b3_u5    

PIC_MP i BLS|SWT
PIC_MOVEA	i 2 JUMP


MSG	i_05 

PIC_HIDE_ALL	%&#T or empty 1 to immediate

LOAD_BGM BGM_mountain NormalMountain
// STOP_BGM 200 1
#< % >
IF $is_left {
    #MS_ ixia '. #~ _ P[stand2fly] ? -G @L >>[Ev_qa200_8.R 45,70 <<0.12]` >>[Ev_qa200_8.L -50,20 <<0.12]` P[fly2stand]'
    #MS 'w20 P[stand_awake] w110 @L P[stand_ev]'
} ELSE {
    #MS_ ixia '. #~ _ P[stand2fly] ? -G @R >+[240,0 <<0.14] <<[ 0.13,0 h40r30] j[>>70 :20:0] F >+[390,0 <<0.15] P[fly2stand]'
    #MS 'w20 P[stand_awake] w110 @R P[stand_ev]'

}
PE ZOOM2 70
PE ZOOM2 -1


WAIT 150

TALKER	n L

PIC   n a_1/a22__F1__f1__m3__b1_u0    
PIC_MP n DEP
TL 50 REPLACE_BGM 120 190
MSG	n_06 

GFC_SET IXA1 |=9
#VANISH ixia

is_left!
DOTL

