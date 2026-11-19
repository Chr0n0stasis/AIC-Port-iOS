// _mobtype

BENCH_UIPIC_SLIDE 0
IFNDEF _mobtype {
    DEF_MOBTYPE _mobtype
    IFSTR $_mobtype IS '' {
        IF nightingale_here {
            _mobtype='_other'
        }
    }
}


IFSTR $_mobtype IS 'alma' {
    IF $_on_sitdown'&&(GFC[MST_NPC0]&1)!=0' {
        SEEK_END
    }
    GFC_SET MST_NPC0 |=1
    // 
    
    
} ELSE {

    IF $_on_sitdown {
        @_bench_check_sf_level 1 'cure_ep_'$_mobtype
        IF '!'$_result {
            SEEK_END
        }
    }
}


_bench_auto_decline=1 // 他のベンチイベントに接続しない


SHOW_BLURSC

TALKER	nb2  C   
HKDS	nb2  LB 

<LOAD>
PIC   nb2 a_epbench/a00__F1__f1m2__e1__ua2    
PIC_MOVEA	nb2 -1 HANDSHAKE

@_VO_SPOT_R breath_e 20 80 Noel

// 興奮度が高い状態で街のベンチに座ったときのイベント
MSG	nb2_00 


MSG	nb2_01 T


PIC   nb2 a_epbench/a00__F1__f1m1__e2__u1    
PIC_MOVEA	nb2 3 SHAKE
CLEARTL
@_bench_ev_masturb_noel
MSG	nb2_02 T


MSG	nb2_03 T


PIC   nb2 a_epbench/a00__F1__f1m2__e1__ua2    
PIC_MOVEA	nb2 -1 HANDSHAKE
MSG	nb2_04 T


MSG	nb2_05 T


IFSTR $_mobtype IS 'alma' {
    CHANGE_EVENT	_bench_cure_ep_alma
    
} ELSIFSTR $_mobtype IS 'city' {
        <LOAD>
    
        HKDS	mb1 RT @ROUT TT 
        TALKER_REPLACE	mb1 '' talk_mob_w0
        // 分岐1a:街中 ==========================
        MSG	mb1_10 

    IF '!noel_torned' {
        <LOAD>
        
        CLEARTL
        // 服がまともな状態
        TL 40 MSG_SKIP 
        PIC   nb2 a_epbench/a00__F2__f2m1__e1__u1    I
        PIC_MP	nb2 EXQ 
        PIC_MOVEA	nb2 15 SCARY
        DENY_EVENTHANDLE
        
        MSG	nb2_11 AI
        ALLOW_EVENTHANDLE
    
PIC   nb2 a_epbench/a00__F2__f2m1__e3__ua2    
        MSG	nb2_12 I

WAIT 30

PIC   nb2 a_epbench/a00__F1__f1m1__e3__ua1    
PIC_MOVEA	nb2 3 SHAKE

        MSG	nb2_13 T


        MSG	nb2_14 T


        MSG	nb2_15 T

    } ELSE {
        <LOAD>
        // + さらに服が破れてる場合の差分 ==========================
#SND_LOAD ev_city

        CLEARTL
        PIC   nb2 a_epbench/a00__F2__f2m1__e2__ua1    
        PIC_MOVEA	nb2 -1 HANDSHAKE
                MSG	nb2_20 
        WAIT 20

        @_PIIN

        PIC   nb2 a_epbench/a00__F2__f2m1__e1__u1    I
        PIC_MP	nb2 EXQ 
        PIC_MOVEA	nb2 15 SCARY

        MSG	nb2_21 

        WAIT 20

        SND pee_zattou

        HKDS	mb2 LB @LBOUT TT 
        TALKER_REPLACE	mb2 '' talk_mob_w3
        HKDS	mb5 CRB @ROUT TT 
        HKDS	mb4  RT @RTOUT TT 
        HKDS	mb3 CCRCT @ROUT TT 
        TALKER_REPLACE	mb5 '' talk_mob_m2
        TALKER_REPLACE	mb4 '' talk_mob_m0
        TALKER_REPLACE	mb3 '' talk_mob_w9

        // 喧騒
        MSG	mb2_22 CF

        WAIT 25

        MSG	mb3_23 CF

        WAIT 25

        MSG	mb4_24 CF

        WAIT 25

        MSG	mb5_25 CF

        WAIT 160

        MSG_HIDE
        WAIT 30

        MSG	nb2_26 I
        PIC   nb2 a_epbench/a00__F1__f1m1__e3__ua1    I
        PIC_MOVEA	nb2 15 SCARY

        WAIT 30
        PIC   nb2 a_epbench/a00__F1__f1m1__e3__u2    
        PIC_MOVEA	nb2 4 SHAKE


        MSG	nb2_27 T

        MSG	nb2_28 T

    }
    
} ELSE {

        <LOAD>
        CLEARTL
        PIC   nb2 a_epbench/a00__F2__f2m1__e3__ua2    I
        PIC_MOVEA	nb2 15 SCARY


        // モブが喋りかけてこないようなキャラクターの場合の汎用分岐 ==========================
        MSG	nb2_100  TI

        WAIT 30
        PIC   nb2 a_epbench/a00__F1__f1m1__e2__u2    
        PIC_MOVEA	nb2 -1 HANDSHAKE
        MSG	nb2_101  T


        MSG	nb2_102 T

        WAIT 30
        PIC   nb2 a_epbench/a00__F1__f1m1__e3__u1    
        PIC_MOVEA	nb2 4 SHAKE
        MSG	nb2_103 T
}
