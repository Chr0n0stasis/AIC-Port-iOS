_prog=~quest_progress_f[subquest_mount_cocktail]
IF $_prog'>=4' {
    CHANGE_EVENT ___city/bar_w_t_cocktail_correct
}
PIC   n a_1/a22__F1__f1__m1__b1__u1    
PIC   w w/a0L2R1__F2__f2__my__e4__u6    
MSG	n_00 


PIC   w w/a0L3R1__F1__f1__m1__e3__u4    
PIC_MP w SMK
MSG	w_01 


PIC   n a_2/a0L1R3__F2__f2__m1__b1_u0    
MSG	n_02 

IF $_prog'>=0&&'$_prog'<4&&ItemCount[@COCKTAIL]>0' {
    MSG_HOLD
    SELECT 2
    &&Select_send_cocktail _SEND
    &&Select_nothanks _END C
    LABEL _SEND

    PIC_HIDE_ALL	
    UIGM CHOOSE_ITEM @COCKTAIL _result 0
    MSG_HIDE

    IFSTR $_result IS '' {
        WAIT 20
        SEEK_END
    } 
    DEFINE_ITEM_RECIPE $_result _recipe
    IFSTR $_recipe IS '' {
        WAIT 20
        SEEK_END
    } 
    // 選択した
    WAIT 10

    REMITEM $_result 1 -1 Alert_item_reduced_walross
    IFSTR $_recipe IS 'gintonic' {
        SF_EVT_SET
        CHANGE_EVENT2 ___city/bar_w_t_cocktail_correct
        GOTO _END
    } ELSE {
        CHANGE_EVENT ___city/bar_w_t_cocktail_wrong
    }

}

PIC   w w/a0L1R1__F1__f1__m2__b2__u6    
PIC_MP w HOT
MSG	w_03 
PIC   n a_1/a00L1R1__F1__f1__m1__b2__u1    
MSG	n_04 

PIC   w w/a0L1R1__F3__f3__m1__e1__u1    
MSG	w_05 


PIC   w w/a0L1R3__F1__f1__m2__b1__u2    
MSG	w_06 

PIC   n a_3/a0__F1__f3__m1__b1_u2    
PIC_MOVEA	n 1 HOP

MSG	n_07 

PIC   w w/a0L2R1__F2__f2__m1__e4__u2    
MSG	w_08 

PIC   n a_3/a1__F1__f3__m1__b4_u5    
PIC_MP n SWT|QUE
MSG	n_09 

IF '!SfEvt[___city/bar_w_t_bar]' {
    PIC   w w/a0L3R1__F3__f3__m1__e1__u1    
    PIC_MP w QUE

    MSG	w_10 
}

PIC   w w/a0L1R3__F1__f1__m1__e3__u2    
MSG	w_11 

PIC   n a_3/a1__F1__f3__m1__b3_u0    
PIC_MP n TTT
MSG	n_12 T

PIC   n a_2/a0L1R3__F2__f2__m1__b1_u2    
MSG	n_13 

PIC   w w/a0L1R1__F2__f2__my__e1__u6    
MSG	w_14 

IF $_prog'==-1' {
    SHOW_QUEST_PROGRESS 1
    QUEST_PROGRESS subquest_mount_cocktail  0
}
LABEL _END
MSG_HIDE
