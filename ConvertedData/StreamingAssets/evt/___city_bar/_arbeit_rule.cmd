TALKER	bt R   


#MS_ Barten '##'
IF $1'==0' {
    PIC   bt P0/a0L2R1__F1__e2    
    MSG	bt_200 
PIC   bt P0/a0L1R4__F2__e3    

    MSG	bt_201 

PIC   bt P0/a0L1R3__F1__e1    
    MSG	bt_202 

PIC_HIDE_ALL	 
#MS_ bun_receipt '##'
    WAIT 40
    HKDS	bt   CLT #<Barten>
    MSG	bt_203 

} ELSIF $1'==1' {
    // お触りについて
    PIC   bt P0/a0L1R3__F2__e2    
MSG	bt_250 


@___city_bar/_arbeit_noel_hkds 12
PIC_MP2 %6 $_manpu_n DEP|BLS

MSG	n_251 
PIC   bt P0/a0L1R2__F1__e3    

MSG	bt_252 
PIC   bt P0/a0L1R4__F1__e1    
MSG	bt_253 

} ELSE {
// 休憩について
PIC   bt P0/a0L1R1__F1__e1    
MSG	bt_300 

PIC   bt P0/a0L2R3__F1__e3    
MSG	bt_301 


@___city_bar/_arbeit_noel_hkds 2
MSG	n_302 

PIC   bt P0/a0L1R4__F2__e3    
MSG	bt_303 R[bt_303_b]


@___city_bar/_arbeit_noel_hkds 4
PIC_MP2 %6 $_manpu_n QUE
MSG	n_304 

}

#MS_ Barten '##'
HKDS	bt    
