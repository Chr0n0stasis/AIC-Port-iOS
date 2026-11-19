SF_EVT_SET
//HKDS	person_key position(ex.L|CR) 追従先 %など hkds_type(ex:WIDE) 

PIC   bt P0/a0L2R2__F1__e2    
// 襲撃はなぜ起きたと思う？
MSG	bt_00 


@___city_bar/_arbeit_noel_hkds 2
MSG	n_01 

PIC   bt P0/a0L2R3__F2__e1    
MSG	bt_02 

@___city_bar/_arbeit_noel_hkds 4
PIC_MP2 %6 $_manpu_n TTT

MSG	n_03 

PIC   bt P0/a0L1R4__F1__e1    
MSG	bt_04 

@___city_bar/_arbeit_noel_hkds 2

MSG	n_05 

PIC   bt P0/a0L1R1__F3__e2    
MSG	bt_06 


@___city_bar/_arbeit_noel_hkds 16
PIC_MP2 %6 $_manpu_n SWT2
MSG	n_07 

