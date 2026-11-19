

#< ostrea >
TALKER s L
TALKER n R

IF 'GFC[OST1]==0' {
    IFDEF 1 {
        IF 'Exist_mover['$1']' {
            #VANISH $1
        }
    }
    #LIGHT 89:#ffffff 80 50

    GREETING	R 50
    WAIT 15
    
    LOAD_BGM	BGM_hunter_minarai 
     STOP_BGM	190 0


    IF 'GFC[WLR1]==0' {
        TALKER_REPLACE	s beastman 
    }
    // オストレアと遭遇
    PIC   s s/a0L3R3__F1__f1__m2__b2__u3  
    PIC   n a_3/a2__F1__f3__m1__b2_uo    
    PIC_MOVEA	s -1 SCARY
    PIC_MP	s DEP

    MSG	s_00 A

   PIC   n a_3/a2__F1__f3__m1__b2_u3    
    PIC_MP	n QUE|SWT2
    
    REPLACE_BGM 30 0 0
    MSG	n_01 


#MS_ ostrea '@R P[stand]'
    // ついにステレオタイプなおばけまで〜
    PIC   s s/a0L2R2__F1__f1__m2__b1__u2   I 
    PIC_MP s EXQ
    PIC_MOVEA	s 1 HOP
    
    MSG s12_8a*s_03



    IF 'GFC[WLR1]==0' {
        PIC   s s/a0L2R2__F1__f1__m1__e1__u2    
        MSG	s_02 

        PIC   s s/a0L1R2__F2__f2__m1__e1__u4    
        PIC_MP s QUE
        // まだ名乗られてない場合
        MSG	s_03 
        PIC   s s/a0L1R1__F1__f1__m1__e1__u2    
        TALKER_REPLACE	s 

        MSG	s_04 
        PIC   n a_1/a22__F1__f1__m1__b2__u1  
        MTL   PIC   n a_3/a0__F1__f3__m5__b2_u0    
        MTL PIC_MP n SWB

        MSG	n_05 
    } ELSE {
        PIC   s s/a0L1R3__F2__f2__m1__e1__u3    
        MSG	s_03_2
        
        PIC   n a_1/a22__F1__f1__m1__b2__u1    
        MTL   PIC   n a_3/a0__F1__f3__m5__b2_u0    
        MTL PIC_MP n SWB
        MTL PIC_MOVEA n 1 HOP
        MSG	n_05_2

    }



    PIC   n a_3/a2__F1__f3__m1__b1_uo    
    // 合流
    MSG	n_06 

    PIC   s s/a0L3R2__F1__f1__m1__e3__u1    
    PIC_MP s HOT
    MSG	s_07 

    PIC_HIDE_ALL	 
    WAIT 20

    #< ostrea >
    #MS '@L'
    #MS_ Cannon_0_Mv0 'w20 ##'
    #CALL2 bright trigger_a
    #< ostrea >
    HKDS	s RT   '#<ostrea>'
    WAIT 40

    MSG	s_09 
    WAIT 15
    #MS_ % '##'
    HKDS	s  
    WAIT 15

    PIC   n a_3/a2__F1__f3__m1__b1_u2    
    PIC   s s/a0L1R3__F1__f1__m1__e3__u3    
    PIC_MP s SMK
    MSG	s_10 

PIC   n a_1/a00L1R3__F1__f1__m1__b3__u0    
PIC_MP n HOT

    MSG	n_11 

    PIC   s s/a0L2R1__F1__f1__m1__e1__u2    
    PIC_MP s LIG
    MSG	s_12 
    @_PIIN
    
    PIC   n a_2/a0L1R3__F2__m6__b2_u0    
    PIC_MOVEA n 2 JUMP
    PIC_MP n EXQ

    MSG	n_13 

    PIC   s s/a0L1R2__F1__f1__m1__e2__u1    

    MSG	s_14 


    MSG	s_15 
PIC   n a_3/a2__F1__f3__m1__b4_uo    
PIC_MP n TTT
    MSG	n_16 
    PIC   s s/a0L1R3__F2__f2__m1__e1__u3    

    MSG	s_17 


    PIC_HIDE_ALL	 
    #MS_ '% >+[-40,0 :40]'
    WAIT_MOVE
    WAIT 20


    GFC_SET_MX OST0 1
    GFC_SET OST1 1
REPLACE_BGM	70 90
} ELSE {
    GREETING	@ 10
    #MS_ ostrea '@#[%::60]'
    WAIT 15
    IF 'GFC[OST1]==1' {
        PIC   n a_2/a0L1R1__F2__f2__m1__b5_u2    
        PIC_MP n SWT
        PIC   s s/a0L1R1__F1__f1__m1__e1__u3    

        MSG	n_30 
        PIC   s s/a0L1R2__F1__f1__m1__e2__u1    
        
        MSG	s_31 
        PIC   s s/a0L3R1__F1__f1__m1__e1__u2    
        MSG	s_32 
    } ELSE {
        CHANGE_EVENT	200/43_ostrea_cannon_broken 1
        
    }
}

