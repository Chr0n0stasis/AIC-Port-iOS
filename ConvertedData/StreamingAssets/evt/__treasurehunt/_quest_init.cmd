
PIC_HIDE_ALL	 
HKDS	n    


TALKER	n L   
IF '(GFC[TRS0]&2)==0' {
    
    IF '(GFC[TRS0]&1)>0&&quest_progress_f[subquest_treasurehunt_000]>=0' {
        
        // 街の宝探しを既にやっている
        WAIT 30
        PIC   n a_1/a22__F1__f1__m3__b1_u0    
        PIC_MP n SMK
        MSG	___mountain/_caravan_church_treasure_t00*n_06 
        GFC_SET TRS0 |=2

    } ELSE {
        WAIT 30
        PIC   n a_3/a0__F1__f3__m1__b4_uo    
        PIC_MP	n QUE 
        
        // やってない
        MSG	___mountain/_caravan_church_treasure_t00*n_06_2 

    }
}
PIC_HIDE_ALL	 
