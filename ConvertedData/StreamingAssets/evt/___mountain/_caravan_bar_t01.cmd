MSG_PREFIX mb '<m fadein>'
GREETING	R 40
// ファーレン古株の獣人。顔が広そうだ。

DEFINENDEF 1=
_mkey=$1


WAIT 20
HKDS	mb LT '#<'$2'>' // 右
HKDS	n CRT  #<%> 
TALKER_REPLACE	mb Mob  talk_mob_m0


IF 'quest_progress_f[p200_alice_mine1]<0' {
    <LOAD>
    #SND_LOAD ev_mountain
    MSG	mb_00 


    MSG	n_00 


    MSG	mb_01 
    WAIT 10
    #MS_ $2 '##'
    HKDS	mb LB '=' // 右
    PE ZOOM2 40
    WAIT 30
    MSG	mb_01_2


    MSG	n_02 

    HALF_BGM	1
    PIC_FILL #8 DARK
    PIC_FADEIN #8 50 
    #MS_ % '>+[-10,0 :60]'
    WAIT 60
    SND mount_bar_put_drink
    WAIT 120
    #MS_ % '= ! >+[10,0 :60] P[stand_ev~] @L ?'
    TL 20 HALF_BGM	0
    PE ZOOM2 1
    PE ZOOM2 -1
    PIC_FADEOUT #8 70 
    #MS_ $2 '#~'
    HKDS	mb LT '=' // 右
    WAIT 40

    MSG	mb_03 


    MSG	mb_04 


    MSG	n_05 


    MSG	mb_06
    WAIT 30
    MSG	mb_06_2
    MSG n_06 


    MSG	mb_07 


    MSG	mb_08 

    MSG	mb_08_2 

MSG	mb_11 
    MSG	n_10 

    QUEST_PROGRESS p200_alice_mine1 0
} ELSE {
    <LOAD>
    MSG	mb_08_2 
MSG	mb_09 




}
