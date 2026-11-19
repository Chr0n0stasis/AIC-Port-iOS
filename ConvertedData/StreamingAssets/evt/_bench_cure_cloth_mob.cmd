BENCH_UIPIC_SLIDE 0
IFNDEF 1 
    1=0
_on_sitdown=$1 // ベンチに座った時点での強制実行なら 1
SHOW_BLURSC

TALKER	nb2  C   

HKDS	nb2  LB 


DEF_MOBTYPE _mobtype

IFSTR $_mobtype IS 'alma' {
    IF $_on_sitdown'&&(GFC[CLT_NPC0]&1)!=0' {
        BENCH_CMD_EXECUTE cure_cloth
        SEEK_END
    }
    GFC_SET CLT_NPC0 |=1
    // 
    // 
    CHANGE_EVENT	_bench_cure_cloth_alma
    

    
} 
IF $_on_sitdown {
    @_bench_check_sf_level 1
    IF '!'$_result {
        BENCH_CMD_EXECUTE cure_cloth
        SEEK_END
    }
}

<LOAD>

#SND_LOAD ev_city

SND pee_zattou
HKDS	mb1 RT @ROUT 
TALKER_REPLACE	mb1 '' talk_mob_w0

WAIT 25

PIC   nb2 a_epbench/a00__F1__f1m2__e1__u2    
PIC_MOVEA	nb2 -1 HANDSHAKE
// 街に服ビリ状態で入った時
MSG	nb2_00 T


MSG	nb2_01 T

IFSTR $_mobtype IS '_other' {
   GOTO _NO_TALK_WITH_MOB
}



MSG	mb1_02 


        TL 40 MSG_SKIP 
        DENY_EVENTHANDLE
PIC   nb2 a_epbench/a00__F2__f2m1__e1__u1    I
PIC_MP	nb2 EXQ 
PIC_MOVEA	nb2 15 SCARY
MSG	nb2_03 AI


        ALLOW_EVENTHANDLE
        PIC   nb2 a_epbench/a00__F2__f2m1__e3__ua2    I
PIC_MOVEA	nb2 3 SHAKE
MSG	nb2_04 I


MSG	mb1_05 

PIC   nb2 a_epbench/a00__F2__f2m1__e4__ua2    
MSG	nb2_06 

TL 10 SND foot_normal_fading
WAIT 70


IF 0 {
    LABEL _NO_TALK_WITH_MOB
    MSG_SKIP
    WAIT 40
}

DOTL
PIC   nb2 a_epbench/a00__F1__f1m1__e3__ua1    
MSG	nb2_07 


MSG	nb2_08 T



@_bench_cure_cloth_darken 0
