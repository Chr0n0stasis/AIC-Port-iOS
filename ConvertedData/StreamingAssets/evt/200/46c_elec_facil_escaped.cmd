DEFINENDEF 1=
_evname=$1

#< % >

#MS '>+[90,0 <<0.08] P[stand_weak]'
WAIT 10


TALKER	n L

// 脱出した
PIC   n a_1/a22__F1__f1__m1__b3__u0    
MSG	n_00 

PIC   n a_3/a2__F1__f3__m1__b4_u0    
LOAD_BGM BGM_mountain NormalMountain
IF 'SkillHas[evade_jump]' {
    MSG	n_01 

} ELSE {
    MSG n_01_no_metaevade_0
    IF 'quest_progress_f[p200_alice_mine1]>=1' {
        MSG n_02_no_metaevade_0
        GOTO _MINE1_PROGRESS
    }
}


IF 'quest_progress_f[p200_alice_mine1]>=1' {
    // 第一坑道を見つけてる
    MSG	n_02 
    LABEL _MINE1_PROGRESS
    QUEST_PROGRESS p200_alice_mine1 2

} ELSE {
// 見つけてない
    PIC   n a_2/a0L1R3__F2__f2__m1__b4_u2    
    PIC_MP n TTT
    MSG	n_10 

    IF 'quest_progress_f[p200_alice_mine1]==0' {
        
        MSG	n_11 
    } ELSE {
        // そもそも酒場で話を聞いてない
        MSG	n_20 
    }
}


QUEST_FINISH p200_elec_facil

#VANISH
REPLACE_BGM	20 100 
AUTO_SAVE
