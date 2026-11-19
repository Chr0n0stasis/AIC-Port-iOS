
#SND_LOAD ev_city

SND pee_zattou
HKDS	mb1 RT @ROUT TT 
TALKER_REPLACE	mb1 '' talk_mob_w0
HKDS	mb2 CCRCT @RBOUT TT 
TALKER_REPLACE	mb2 '' talk_mob_m0

PIC   nb2 a_epbench/a00__F1__f1m1__e1__u1    


// 喧騒
MSG	mb1_00  CF

        WAIT 25


MSG	mb2_01  CF 

WAIT 140
MSG_HIDE
WAIT 20

HKDS	l  R @ROUT   

MSG	nb2_02 T
WAIT 35

// 呼び方が変わる前の場合が存在するので2種類
IF 'GFC[ALM0]>0' {
    MSG	l_03 
} ELSE {

    MSG	l_04 
}


PIC   nb2 a_epbench/a00__F2__f2m1__e3__ua2    
PIC_MOVEA	nb2 2 SHAKE

MSG	nb2_05 


MSG	l_06 

PIC   nb2 a_epbench/a00__F2__f2m1__e4__u4    
MSG	nb2_07 

PIC   nb2 a_epbench/a00__F1__f1m1__e3__u2    
MSG	nb2_08//

@_bench_cure_cloth_darken 0