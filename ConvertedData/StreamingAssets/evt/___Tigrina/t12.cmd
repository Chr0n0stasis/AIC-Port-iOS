// ガレージ戦闘敗北
MSG_PREFIX	so <tigrina>

#< % >
#MS '## #; >>[Ev_tig.b 200,0] @L'
#MS_ tigrina '>>[Ev_tig 40,10] @R'
WAIT 60
_phase=~GFC[TIG2]
IFDEF 1 {
    IF $1'>=0' 
        _phase=$1
}
    
@__M2D_GAMEOVER_WAKEUP_WAIT
WAIT 35
TALKER	so L   
TALKER	n R
ALLOW_SKIP

PIC   n a_3/a1__F1__f3__m2__b2_u1    
PIC_MP	n SMK 
PIC   so so2/a0L1R2__F2__f2__m1__e2_u3    
PIC_MP	so SWT 


IF $_phase'<=1' {
    _target_script=school_in_garage_l1
    GFC_SET TIG2 2
    MSG	n_00 


    MSG	so_01 

    PIC   n a_1/a00L1R1__F1__f1__m1__b3__u1    
    PIC_MP n SWT2
    MSG	n_02 


    PIC   so so1/a0L2R3__F1__f1__m4__e1_u1    
    PIC_MP so ONP
    MSG	so_03 


} ELSIF $_phase'==2' {
    _target_script=school_in_garage_l2
    GFC_SET TIG2 3
    MSG	n_100 


    MSG	so_101 

    PIC   n a_1/a00L1R1__F1__f1__m1__b3__u1    
    PIC_MP n SWT2|BLS

    MSG	n_102 

    PIC   so so1/a0L1R2__F1__f1__m5__u1    
    
    MSG	so_103 

    PIC   n a_3/a2__F1__f3__m3__b1_u0    
    PIC_MP n SWT

    MSG	n_104 

} ELSE {
     // 3度目
    // お互い気まずい顔
    MSG	so_200 


    MSG	n_201 
PIC   so so1/a0L2R3__F1__f1__m5__u1    
    MSG	so_202

PIC   n a_1/a00L1R1__F1__f1__m1__b3__u1    
PIC_MP n SWT2
    MSG	n_203 
    PIC   so so2/a0L4R2__F2__f2__m1__e2_u2    
    PIC_MP so SMK
    MSG	so_204

PIC   n a_2/a0L1R2__F2__f2__m2__b1_u0    
PIC_MP n BSM
    MSG	n_205

PIC   so so1/a0L3R3__F1__f1__m1__e2_u2    
    MSG	so_206 

PIC   so so1/a0L2R4__F1__f1__m8__b1_u1    
PIC_MOVEA	so 2 JUMP

    MSG	so_206_2

PIC   n a_3/a0__F1__f3__m1__b1_u2    
PIC_MP n QUE
    MSG	n_207 

    
    GFC_SET TIG2 4
PIC   so so1/a0L2R1__F1__f1__m4__e1_ua2    
    PIC_MP so PLE
PIC_MOVEA	so 90 SHAKE
    MSG so_208
    
    PIC   n a_1/a22__F1__f1__m1__b3__uo    
PIC_MP n SWT2
    MSG	n_209

    WAIT 25

        #MS_ tigrina 'P[walk] >+[70,0 :60] P[stand]'
    CHANGE_EVENT	___Tigrina/t13 1
    

}

PR_CURE 1 1
SMNCREATOR TARGET_SCRIPT $_target_script
SUMMONER_TYPE SmnC_garage NO_REVERT
SUMMONER_ACTIVATE SmnC_garage
