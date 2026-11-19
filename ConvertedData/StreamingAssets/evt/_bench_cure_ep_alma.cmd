// 駅でアルマがいる場合の特殊な分岐 ==========================
HKDS	l R @RBOUT  
IF 'GFC[ALM0]==0' {

    MSG	l_00 
} ELSE {

    MSG	l_01 
}




// ======
PIC   nb2 a_epbench/a00__F2__f2m1__e2__ua1    
PIC_MOVEA	nb2 -1 HANDSHAKE
MSG	nb2_02 


// 服の状態で分岐
// 服が平常 ================
IF '!noel_torned' {

    MSG	l_03 
} ELSE {
    // 服ビリ
    MSG	l_04 

}

CLEARTL
@_PIIN

PIC   nb2 a_epbench/a00__F2__f2m1__e1__u1    I
PIC_MP	nb2 EXQ 
PIC_MOVEA	nb2 15 SCARY
MSG nb2_10 IA

MSG l_11 

WAIT 30

PIC   nb2 a_epbench/a00__F1__f1m1__e3__ua1    
PIC_MOVEA	nb2 3 SHAKE

MSG nb2_12 T
