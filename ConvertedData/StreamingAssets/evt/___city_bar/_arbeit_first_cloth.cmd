DEFINENDEF 1=0

MSG_LEFT_DEFAULT 0.3
MSG_RIGHT_DEFAULT 0.05

TALKER	bt R   
PIC   bt P0/a0L1R2__F1__e1    
IF $1'==0' {
    // 通常

@___city_bar/_arbeit_noel_hkds 3
PIC_MP2 %6 $_manpu_n BLS
    MSG	n_00 

PIC   bt P0/a0L1R4__F1__e2    
MSG	bt_01 

@___city_bar/_arbeit_noel_hkds 16
PIC_MP2 %6 $_manpu_n QUE

MSG	n_02 

PIC   bt P0/a0L2R2__F2__e1    
MSG	bt_03 


} ELSE {
    // 最初に逆バニー服を着る
    @___city_bar/_arbeit_noel_hkds 21
    PIC_MP2 %6 $_manpu_n BLS|BSM
    MSG	n_50 A

PIC   bt P0/a0L2R2__F2__e1    
    MTL MSG_SKIP
    MSG	bt_51 


    @___city_bar/_arbeit_noel_hkds 15
    @_TSUKKOMI
    MSG	n_52 AI

PIC   bt P0/a0L4R1__F3__e2    
    MSG	bt_53 


    MSG	bt_54 
    @___city_bar/_arbeit_noel_hkds 14
    PIC_MP2 %6 $_manpu_n BLS|SWT

    MSG	n_55 


}
