BENCH_UIPIC_SLIDE 0
IFNDEF _on_sitdown
    _on_sitdown=0
IF $_on_sitdown {
    IFNDEF _calced_bench_sf_level {
        IF '(GFC[MST_NPC0]&2)!=0' {
            SEEK_END
        }
    }
}

GFC_SET MST_NPC0 |=2

SHOW_BLURSC

TALKER	nb2  C   
HKDS	nb2  LB 

<LOAD>
PIC   nb2 a_epbench/a00__F1__f1m1__e3__u1    
PIC_MOVEA	nb2 -1 HANDSHAKE

@_VO_SPOT_R breath_e 20 80 Noel


PIC   nb2 a_epbench/a00__F1__f1m1__e2__u2    

MSG	nb2_00 T

WAIT 20
PIC   nb2 a_epbench/a00__F1__f1m2__e1__ua2    
MSG	nb2_01 T

CLEARTL