// 1 quest_name 
// 2 level
_qname=$1
_qlevel=$2

IF 'GFC[FHM0]>0' {
    IF 'GFC[TRS0]&8==0' {
        WAIT 80
        PIC   n a_3/a0__F1__f3__m1__b4_uo  
        PIC_MP	n QUE 
        MSG n_100
        GFC_SET TRS0 |=8
    } ELSE {
        WAIT_BUTTON
    }
    QUEST_PROGRESS $_qname $_qlevel

} ELSE {
    // ファーストに会ってない
    WAIT 80
    PIC   n a_3/a0__F1__f3__m1__b4_uo  
    PIC_MP	n QUE 
    IF 'PVV<200' {
        MSG __treasurehunt/000_5*n_00
        MSG __treasurehunt/000_5*n_01
        MSG __treasurehunt/000_5*n_02
    } ELSE {
        DEFINE_WHOLEMAP _wm
        IFSTR $_wm IS 'mount' {
            MSG n_110
        } ELSE {
            MSG n_120
        }
    }
    QUEST_PROGRESS $_qname $_qlevel
}
PIC_HIDE_ALL	 

