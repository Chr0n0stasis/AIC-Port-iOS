// 1: gameover なら 1
IFNDEF 1 {
    MSG_PREFIX	so <tigrina>
    1=0
    TALKER	so L   
    TALKER	n R   
}
_from_gameover=$1
PR_CURE 1 1

// 合流 ================================================
PIC   so so2/a0L3R2__F2__f2__m1__e3_ui1    
MTL PIC   so so1/a0L1R2__F1__f1__m1__e3_u2    
MTL PIC   so so1/a0L2R1__F1__f1__m1__e1_ui    
MTL PIC   so so2/a0L1R1__F2__f2__m2__e1_u0    
MSG	so_00  S

PIC   n a_1/a00L1R1__F1__f1__m1__b1__u1    
MSG	n_01 

PIC   so so1/a0L2R1__F1__f1__m4__e1_ua3    
PIC_MP	so SWT2 

MSG	so_02 


TL 40 STOP_BGM	70 
PIC   n a_2/a0L2R3__F2__m6__b2_u0    
MSG	n_03 

DOTL


PIC   so so1/a0L1R1__F1__f1__m1__e1_ua    


WAIT 120

TL 30 START_BGM 100
PIC   so so2/a0L4R2__F2__f2__m7__e1_ua    
PIC_MP so SWT2

MSG	so_04 

DOTL
PIC   n a_3/a0__F1__f3__m1__b1_uo    
MSG	n_05 

PIC   so so1/a0L3R4__F1__f1__m1__e3_u1    
MSG	so_06 

PIC   so so1/a0L2R3__F1__f1__m1__e2_ua3    
MTL PIC   so so2/a0L3R1__F2__f2__m2__e1_ui1    
MTL PIC_MP so PLE
MTL PIC   so so2/a0L4R2__F2__f2__m4__e1_ua3    
MSG	so_07 

PIC   n a_3/a2__F1__f3__m1__b3_u0    
PIC_MP n SWT

MSG	n_08 

@_PIIN
PIC   so so1/a0L3R3__F1__f1__m4__e1_ua2    
PIC_MOVEA	so 2  JUMP

MSG	so_09 

MTL PIC   so so2/a0L2R1__F2__f2__m2__e2_ua2    
MSG	so_09_2 S

PIC   n a_1/a22__F1__f1__m3__b1_ua    
PIC_MP n DEP
MSG	n_10 

PIC   so so2/a0L4R2__F2__f2__m1__e3_u0    
MSG	so_11 

PIC   so so1/a0L1R2__F1__f1__m1__e2_u2    
PIC_MP so SWT
MSG	so_12 

IFNDEF _album_categ {
    IF 'ItemHas[recipe_collection]' {
        #< tigrina >
        #PHY 1
        
        PIC   so so1/a0L2R1__F1__f1__m1__e1_ua    
        // 錬金術図鑑を持っている場合
        TL 30 PIC   n a_3/a0__F1__f3__m1__b4_uo    
        MSG	so_13 
        DOTL
        PIC   so so2/a0L3R1__F2__f2__m1__e3_ui1    
        MSG	so_13_2 
        IF $_from_gameover {
            #MS_ tigrina 'P[walk] ! >+[60,0 :50] P[stand] w100 P[walk] >+[-130,0 :150] P[stand] ?'
                
        } ELSE {
            #MS_ tigrina 'P[walk] ! >+[-60,0 :50] P[stand] w100 P[walk] >+[60,0 :90] P[stand] ?'

        }
        #MS_ % 'w60 P[stand_ev~]'
        PIC_HIDE_ALL	 
        

        WAIT 190
        GFB_SET FG_ENEMY 1
        PIC   n a_1/a22__F1__f1__m1__b1__u0    
        PIC   so so1/a0L2R2__F1__f1__m4__e1_ua3    
        PIC_MP so PLE
        MSG	so_14 
        MSG	so_15 
    }
    IF 'PVV>=106' {
        // QUEST_PROGRESS p999_trial_finished 0
        QUEST_REMOVE p106_grazia_goto_club 1

    }
}


// 錬金術図鑑を持っている場合ここまで
PIC   so so2/a0L1R2__F2__f2__m1__e1_u0    
MSG	so_16 

PIC_HIDE_ALL	%&#T


GFC_SET_MX TIG1 2
GFC_SET TIG2 0

IFNDEF _album_categ {
    @106/tigrina_after_flag
    AUTO_SAVE
}

