IF 'SfBreakable[Breakable_cannonroad_pb0]|| PVV>=210 || !Exist_mover[Breakable_cannonroad_pb1-hit] || quest_progress[p200_alice]!=20' 
    SEEK_END

TALKER	n L   

<LOAD>

#MS_ Cannon_0_Mv0 '##'
#MS_ % 'F w20 @R ! >>[Ev_cannonL.b -10,0 <<0.05]  @R P[stand_ev~] ?'
DENY_SKIP
WAIT 120

IF 'GFC[OST1]>=2' {

    // レクチャー済み
// オストレアのイベントクリアしてる場合
PIC   n a_3/a2__F1__f3__m1__b4_uo    
MSG	n_00 T


} ELSE {
    PIC   n a_3/a0__F1__f3__m1__b2_u3    
// オービタルで無理やりきた場合
MSG	n_01 T



}

HKDS	n LB   #<%>

PIC_HIDE_ALL	
WAIT 30
#MS_ Breakable_cannonroad_pb1-hit '##'
WAIT 60

// 合流
MSG	n_02 T

WAIT 60
#MS_ Cannon_0_Mv0 '##'
WAIT 120
HKDS	n    


PIC   n a_2/a0L3R1__F2__f2__m1__b5_uo    
MSG	n_03 T
