
TALKER	n L   
PIC   n a_1/a00L1R1__F1__f1__m1__b1__uo    
PIC_MP	n QUE 

MSG	n_00  


SELECTARRAY_CLEAR
IF 'sensitive_level>0' {
    SELECTARRAY &&Select_find_nightingale FIND S
    SELECTARRAY &&Select_callback_nightingale CALLBACK  
    _foc_default=1
} ELSE {
    SELECTARRAY &&Select_find_nightingale FIND 
    SELECTARRAY &&Select_callback_nightingale CALLBACK  S
    _foc_default=0
}
SELECTARRAY &&Cancel CANCEL C
SELECT_FOCUS $_foc_default
SELECT -1 _result

PIC_HIDE_ALL	 
IFSTR $_result IS 'CANCEL' {
    SEEK_END
}

GFC_SET NIG0 3
GFC_SET NIG1 0
STOREFLUSH Night 1
STOREADD Night mtr_elf_egg 3 3
IFSTR $_result IS 'FIND' {
    @___Other/fatal cuts_nightingale_0_0 1 1 ___Nightingale/quest00_bag_endfatal
    CHANGE_EVENT2	___Nightingale/quest00_2    
    SEEK_END
} 

#MS_ % '>>[ #<Nightingale> :70 ]'
WAIT 10
PIC_FILL	#10 DARK
PIC_FADEIN	#10 60
WAIT 70

// 以下、健全モードの場合のシーンスキップ

HKDS	n RT @ROUT
HKDS	t CL @LBOUT

MSG	n_01 

TL 25 MSG_SKIP
MSG	t_02 I

CLEARTL
@_TSUKKOMI
MSG	t_03 I


MSG	n_03 


MSG	t_04 


MSG	n_05 


MSG	t_06 


@___Nightingale/quest00_bag_endfatal

#MS  '@#[%::50]'


HKDS	n
HKDS	t 

PIC_FADEOUT	#10 55
WAIT 70