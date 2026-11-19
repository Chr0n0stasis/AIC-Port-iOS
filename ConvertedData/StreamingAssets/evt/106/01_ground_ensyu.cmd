LOAD_BGM	BGM_tyousa_dbd_file_no3 
HKDS	l    
HKDS	n
GFC_SET ALM1 0
PR_CURE 1 1 1 1 1

_x=70
@106/_put_citycaster


WAIT 30
PIC_FADEOUT #9 110
WAIT 25
REPLACE_BGM	10 140 1


HKDS	mb0 RT  #<$_mvh_e> TT
TALKER_REPLACE	mb0 Mob talk_mob_w3

HKDS	mb1 CCLT  #<$_mvh_f> TT
TALKER_REPLACE	mb1 Mob talk_mob_w8 

HKDS	bs RT #<boss>
TALKER_REPLACE	bs instructor talk_mob_w2

ALLOW_SKIP 
MSG	mb0_00 CBF
WAIT 100
MSG_HIDE	
WAIT 30 

MSG	mb1_01 CBF
WAIT 100
MSG_HIDE	
WAIT 30  



#MS_ citycaster_sub_l '##'

MSG	bs_00 

WAIT 40

<LOAD>
#MS_ % '## P[stand_ev]'
@___city_forge/get_first_cane 
DEFINE_NOEL_CANE _cane
IF noel_cane_itemdrop 
    GOTO _NO_BERMIT_CANE

IFSTR $_cane ISNOT 'bermit' {
    LABEL _NO_BERMIT_CANE
    // 杖を換装していない
    MSG	bs_01 

    TALKER	n L  
    PIC   n a_3/a2__F1__f3__m1__b1_uo    
    PIC_MP	n SWT2


    MSG	n_02 


    MSG	bs_03 

    PIC   n a_1/a00L1R1__F1__f1__m1__b3__u0    
    PIC_MP	n SWT 

    MSG	n_04 


    MSG	bs_05 
    PIC_HIDE_ALL	 
    WAIT 30
    TALKER	l R   
    
    PIC   l l1/a0L3R1__F1__m1__b2_u1    


    MSG	l_06 

    PIC_HIDE_ALL	 
    WAIT 20
#MS_ citycaster_sub_i '##'
    PE ZOOM2 60
    WAIT 50
    TALKER	l ROUT   
    TALKER	i L   
    TALKER	n R   
    

    PIC   i i/a00L3R1__F1__f1__m1__b3_u0    
    MSG	i_07 

PIC   n a_1/a00L1R1__F1__f1__m1__b2__u1    
    MSG	n_08 
@_PIIN
PIC   n a_3/a0__F1__f3__m5__b2_u0    
PIC_MP n EXQ
    MSG	n_09

PIC   i i/a00L5R4__F2__f2__m1__b5_u3    
PIC_MP i KIR
    MSG	i_09 

PIC_HIDE_ALL	 
WAIT 40
#MS_ citycaster_sub_l '##'
HKDS	bs CCRB '='

    MSG	bs_10 

PIC   i i/a00L1R5__F1__f1__m1__b5_u4    
PIC_MP i SMK
    MSG	i_11 

} ELSE {

    // 杖を換装した // ============
    PE ZOOM2 60
    MSG	bs_12 

TALKER	n L   


PIC   n a_2/a0L1R3__F2__f2__m1__b5_u0    
    MSG	n_13 


    MSG	bs_14 

TALKER	n CLL
TALKER	i LL  

PIC   i i/a00L3R1__F1__f1__m5__b0_u3   
@_TSUKKOMI i

    MSG	i_15 IA

PIC_HIDE_ALL	 
WAIT 20
#MS_ citycaster_sub_i '##'
WAIT 30
TALKER	n R  
TALKER	i L   
@_PIIN
PIC   n a_3/a0__F1__f3__m5__b2_u0    I
PIC_MP n EXQ
 


    MSG	n_16 


PIC   i i/a00L5R4__F2__f2__m1__b5_u3    
PIC_MP i KIR
    MSG	i_09 
PIC_HIDE_ALL	 
WAIT 40
#MS_ citycaster_sub_l '##'
HKDS	bs CCRB '='



    MSG	bs_18 

}
// ============
// 合流
PIC_HIDE_ALL	 
WAIT 30

PE ZOOM2 -1

HKDS	bs CCRT '='
#MS_ citycaster_sub_l '##'
MSG	bs_19 

// ========================

PIC_FILL #9 DARK
PIC_FADEIN #9 50

WAIT 60

IFSTR $_cane ISNOT 'bermit' {
    GFC_SET ALM1 |=8
    ITEMMNG_PUSH_BYTES
    FORCE_REPLACE_NOEL_CANE bermit 0
    GETITEM_NOANNOUNCE  cane_bermit 1 0
}
CHANGE_EVENT 106/02_learn_watershard
