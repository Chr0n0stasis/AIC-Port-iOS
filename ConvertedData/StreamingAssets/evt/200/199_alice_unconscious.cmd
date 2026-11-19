#< % >
#SND_UNLOAD
#SND_LOAD ev_mountain
IF 0 {
    GOTO _DEBUG_STILL 

}
START_GMAIN
START_GHANDLE
<NOLOAD>
STOP_LETTERBOX
_199_alice_recast=0

IF 'SF[M2D_LP_BRK_Breakable_210last]' {
    WAIT 15
    GOTO _V
} ELSE {
    WAIT 80 
}
_pr_x=~m2d_current_x
_lr=~lp_mapr[$1]+1.25
IF $_pr_x'>='$_lr {
    LP_ACTIVATE Breakable_210last
    SEEK_END
    // ========================
}
LABEL _V
#VANISH $1
#MS_ % 'F'
DENY_SKIP
STOP_GHANDLE
#< % > 
#PTCST 'ev_199_alice_unconscious_needle'
SND ev_210_hit_stab
DEACTIVATE_PUTTED_MAGIC

STOP_BGM 40 1
WAIT 11
START_LETTERBOX
PIC_FILL #0 DARK
WAIT 5
PIC_FLASH	#9  0 9 1 ff:#c32028
TL 15 PIC_FLASH	#9  0 9 1 ff:#c32028
TL 15 PIC_MVA #9 30 SCARY

HKDS	n CL #<%>

IF '!Exist_mover[alice]' {
    _199_alice_recast=1
    #CMDRELOAD	 IMMEDIATE  IMMEDIATE_LOAD
    WAIT 2
}


MSG n_00 CF
WAIT 80
<NOLOAD>
#MS_ % 'q >>['$1'.R 20,0 ] #; P[sleep] @L'
PE ZOOM2 1
PIC_FADEOUT #0 90
#MS_ alice '>>[Ev_200hidden] w20'

TL 40 MSG n_01 CF
TL 180 MSG n_02 CF
WAIT 120

#MS_ alice '= P[walk] >>[#<%> 30,0 <<0.07] P[guard]'
LABEL _DEBUG_STILL
<LOAD>
WAIT 280
DENY_SKIP
WAIT_MOVE


HKDS	kuromaku ROUT @RBOUT
MSG kuromaku_03 CF
CLEARTL
MSG_HIDE 1
SND ev_210_tobecontinued_chorus
PIC_PE #6 ENEMY_OVERDRIVE_APPEAR|cc:#ffffff
PIC_FADEIN #6 180

PIC_FLASH	#9  0 9 40 ff:#ffffff
TL 60 PIC_FLASH	#9  20 1 90 55:#ffffff
PIC_B #0 mountain210_alice/alice_unconscious0
PIC #1 mountain210_alice/alice_unconscious1
PIC_MOVE #0 0 580 
PIC_MOVE #0 D D-1020 230 ZSIN
PIC_MOVE #1 D D-920 230 ZSIN
PIC_MVA #0 240 HANDSHAKE
PIC_MVA #1 240 HANDSHAKE


WAIT 240
DOTL
PIC_HIDE_ALL '' 1
PIC_FILL #0 DARK

GFC_SET OST1 0

// 体験版処理　================================================
IF 'nel_trial' {
    WALKCOUNT 99
    SND ev_210_tobecontinued_attack
    TITLECALL Telop_Trial_end200 64
    TITLECALL_SETTING 0 0 0 0 0 1
    TITLE_POS_SHIFT 0 20
    WALKCOUNT 99

    WAIT 70
    ALLOW_SKIP
    WAIT_BUTTON
    TITLECALL_SETTING 0 0 100 '' 1
    TITLECALL_HIDE 
    DENY_SKIP
    INIT_MAP_MATERIAL mount_spider_entrance 1
    SCN_MANUAL_BGM_REPLACE ''
    WAIT 130

    QUEST_REMOVE p200_alice_goback
    QUEST_FINISH p200_alice H
    IF 'quest_progress_f[p200_elec_facil]>=2' {
        QUEST_FINISH p200_elec_facil H
    } ELSE {
        QUEST_REMOVE p200_elec_facil
    }
    GFC_SET ALC1 0
    PVV 215 
    FLUSH_SUMMONER
    
    WAIT_FN MAP_TRANSFER
    NEL_MAP_TRANSFER house_noelroom L "!Ev_bench"
    #< % >
    PR_CANE_RETURNBACK 0
    #MS 'P[bench=3]'

    PE ZOOM2 -1
    PIC_FADEOUT #0 80
    WAIT 140
    QUEST_REMOVE p999_trial_finished 1
    QUEST_REMOVE p200_alice_veryfirst
    QUEST_PROGRESS p999_trial_finished 0

    IF 'GFC[BRTU]>=8' {
        QUEST_REMOVE subquest_new_item_baru 1
        QUEST_PROGRESS subquest_new_item_baru 0 H
    }
    AUTO_SAVE
}
