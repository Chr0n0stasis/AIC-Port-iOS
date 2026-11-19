// メモリーチップを拾った

#< sneaker_1 >

#MS_ % 'P[beware~]'
#MS '## >>[Sneaker_btm_blocker.b 50,0] @L P[walk_light] >+[-130,0 :120] @R P[stand_light] w10'
IF 'GFC[TIG0]==2&&(GFC[TIG1]&3)<2' {

HKDS	mb0 CRT #<sneaker_1>
TALKER_REPLACE	mb0  Army talk_mob_m0

    MSG mb0_00
    WAIT_MOVE
    WAIT 60

    #MS_ % '##'
    WAIT 15
    TALKER	n L   
    PIC   n a_2/a0L1R3__F2__f2__m1__b5_u2    
    PIC_MP	n SMK

    MSG n_02
    GFC_SET TIG1 ~(GFC[TIG1]&12)+2
} ELSE {
    WAIT_MOVE
}
