// 1: この話し手
// 2: MOBxフラグ



DEFINENDEF 2=MOB1
DEFINENDEF 1=
_gfcm=$2
_mv=$1
GREETING	L 30
TALKER	n L    
HKDS	mb RT  #<$1> 
TALKER_REPLACE	mb '' talk_mob_w10
HKDS	n CLT #<%>


// 獣人の職員

IF 'GFC['$_gfcm']&1==0' {
    GFC_SET $_gfcm |=1
    MSG	mb_00 
DENY_SKIP
    #MS_ Noel 'snd[cloth_off] P[interact~] w30 ptcT[puzz_box_activate_once] w50 P[stand_ev~] '
    WAIT 75

    // 杖をかざす
    MTL MSG_SKIPHOLD

    MSG	n_01
} ELSE {
    MTL MSG_SKIPHOLD
    MSG	mb_00 
    WAIT 20
}

SELECTARRAY_CLEAR
SELECT_POS CCB
DEFINE_NOEL_CANE _cur_cane _cur_cane_grade
IF '(GFC[BERMIT_RPL_CANE]&8)!=0' {
    SELECTARRAY &&Select_replace_cane_back _REPLACE_RETURN_BACK
} ELSE {
    IF 'ItemHas[cane_bermit][0]==0' {
        SELECTARRAY &&Select_about_cane _REPLACE_ASK
    }
}
SELECTARRAY &&Select_nothanks _END C

SELECT -1

LABEL _END
SEEK_END
// ========================
LABEL _REPLACE_ASK
ALLOW_SKIP
MSG_HIDE
// 杖の換装
<LOAD>
@___city_forge/get_first_cane

IF 'GFC['$_gfcm']&2==0' {
    GFC_SET $_gfcm |=2
    MSG	n_02 


    MSG	mb_03 
    DENY_SKIP
    WAIT 60

    MSG	mb_04 
} ELSE {
    DENY_SKIP
    WAIT 30
}
MTL MSG_SKIPHOLD
MSG	mb_05 



ALLOW_SKIP
SELECTARRAY_CLEAR
SELECT_POS CCB
SELECT_CLMS 2
SELECTARRAY &&Select_wanna_test _WANNA_TEST
SELECTARRAY &&Select_abort _END C
SELECTARRAY &&Select_replace_cane _REPL_EXECUTE

SELECT -1


LABEL _WANNA_TEST
// 試し撃ちとかできない？

PIC   n a_1/a22__F1__f1__m4__b1_ua    
PIC_MP n SWT
HKDS	n  
HKDS	mb CCRCT  #<$_mv>  


MSG_HIDE
MSG	n_10 

MSG	mb_11 


MSG	mb_12 


PIC   n a_3/a0__F1__f3__m1__b4_u0    
MSG	n_13 



GOTO _FORGE_ACCESS


// ========================
LABEL _REPL_EXECUTE
// 換装する
MSG	mb_20 



#MS_ Noel '>+[20,0 :40] snd[cloth_off] P[interact~] '
DEFINE_FORGE_BUY_TARGET _fg_cane _fg_grade
IFSTR $_fg_cane IS $_cur_cane {
    IF $_fg_grade'=='$_cur_cane_grade {
        
        IF 'ItemHas[cane_'$_fg_cane']['$_fg_grade']<=1' {
        #MS_ Noel 'w55 ! >+[-20,0 :40] ? @R P[stand_ev~]'

            // 換装しようとした杖がバイトのテスター品だった
            WAIT 40
            MSG	mb_21 
            WAIT 40

            MSG	mb_22 
            SEEK_END

        }
    }
}
GFC_SET BERMIT_RPL_CANE |=8
DENY_SKIP
WAIT 15
PIC_FILL	#9 DARK 
PIC_FADEIN #9 60
WAIT 100 
#MS_ Noel '= ! >+[-60,0 :40] ? @R P[stand_ev~]'

FORGE_REPLACE_CANE bermit 0 $_cur_cane $_cur_cane_grade 0
PIC_FADEOUT #9 60

WAIT 40
GETITEM_BOX 'cane_bermit' 1 0
WAIT_FN ITEMDESC
SEEK_END

// ========================
// 換装した後、やっぱり戻したいと言う
// mb_11をもう一度言った後
LABEL _REPLACE_RETURN_BACK
ALLOW_SKIP
MSG_HIDE
MSG	mb_11
MSG	mb_30 


MSG	n_31 

LABEL _FORGE_ACCESS
IF '(GFC['$_gfcm']&8)==0&&quest_progress[city_forge_access]==-1&&(visitted[city_in_forge]==0||(GFC[FORGE0]&2)==0)' {
    MSG_HIDE
    PIC_HIDE_ALL	 
    
    GFC_SET $_gfcm |=8
    WAIT 20
    #MS_ Noel '? >+[-80,0 :100] ? @L P[stand_ev~]'
    HKDS	n CT #<%>
    WAIT 20

    MSG	n_14 
    IF 'visitted[city_in_forge]==0' {
        QUEST_PROGRESS city_forge_access 0
    }
}
