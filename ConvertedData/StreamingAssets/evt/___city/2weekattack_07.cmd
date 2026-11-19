


DENY_SKIP
DOTL
#< % >
#PTCST ui_snd_1 '_cue=heartbeat_fast_loop' 
SND wk2_flashback_return
PIC_FILL &11 DARK
PIC_FADEIN	&11 70
IFDEF _album_categ {
    STOP_BGM	160 
}


TL 10  PIC_FLASH	&7 5 0 35 77:#ff0000
TL 25  PIC_FLASH	&8 5 0 35 44:#ff0000
TL 49  PIC_FLASH	&9 5 0 35 77:#ff0000
TL 79  PIC_FLASH	&6 5 0 15 44:#ff0000
TL 92  PIC_FLASH	&5 10 0 45 77:#ff0000
WAIT 140
CLEARTL


HKDS	n B #<%> TT

SHOW_LETTERBOX_A
PIC_HIDE_ALL '' 1
PIC_FILL &11 DARK
IFDEF _album_categ {
    SEEK_END
}
PIC_FADEOUT	&11 20


#MS 'P[stand_hardbreathe=6] @R'
#PTCST ev_q_handshake '_1=400;_2=400;_3=20' 
PE HP_REDUCE 1
PE BURST 1 0.5
PE ENEMY_OVERDRIVE_APPEAR 1 0.4

TL 19  PIC_FLASH	&9 5 0 35 77:#000000
TL 32  PIC_FLASH	&6 5 0 15 44:#000000
TL 55  PIC_FLASH	&5 10 0 45 77:#000000
TL 30 ALLOW_SKIP
WAIT 25
MSG	n_15 

CLEARTL
MSG_HIDE 
WAIT 30
DENY_SKIP
#MS 'P[dmg_breathe]'
PIC_FLASH	#7 10 4 15 80:#ff0000
WAIT 10

#PTCST_REMOVE ui_snd_1
TALKER_REPLACE	n '=' ''
// PE ZOOM2 -1
PE HP_REDUCE -1
PE BURST -1 
PE ENEMY_OVERDRIVE_APPEAR -1
HALF_BGM 1

PIC_FILL	#1 DARK
PIC_FILL	#0 ff:#ff0000
PIC_MOVEA	#1 15 SCARY

TL 45 PIC_FLASH	#7 0 10 12 67:#ff0000
TL 45 PIC_MOVEA	#1 12 SCARY2
TL 92 PIC_FLASH	#7 0 10 12 67:#ff0000
TL 92 PIC_MOVEA	#1 30 SCARY

TL 130 PIC_FLASH	#7 10 2 35 67:#ff0000
TL 130 PIC_MOVEA	#1 55 SCARY
// 嘔吐

DENY_EVENTHANDLE 
TL 120 ALLOW_EVENTHANDLE
TL 120 ALLOW_SKIP
SND wk2_reverse 
HKDS	n B @C WIDE_TT 
PE BGM_LOWER 1

MSG	n_16 I

CLEARTL 
PIC_FINE #1
PIC_HIDE #0
// 嘔吐
MSG_HIDE
WAIT 35

TALKER_REPLACE	n '=' ' '

IF $_alma_exists {
    // アルマがいる場合
    TALKER_REPLACE	l  
    
    _msg=l_17
    _tk=l

} ELSE {

    _msg=mb1_18
    _tk=mb1
    // いない場合
    TALKER_REPLACE	mb1 '' talk_mob_w8 
}

HKDS	$_tk L @LOUT   

MSG	$_msg

MSG_HIDE
WAIT 5
DOTL

SCN_MANUAL_BGM_REPLACE
INIT_MAP_MATERIAL_EV_FLUSHABLE school_in_health 1
WAIT_FN MAP_TRANSFER 
NEL_MAP_TRANSFER school_in_health L !Ev_bed0
HALF_BGM 0
PE BURST -1 
PE BGM_LOWER -1 
PE ZOOM2 1
<LOAD>

WAIT 10
PIC_FADEOUT #1 80
#< % >
#MS 'q P[stand_weak~] >>[Ev_primula 50,0] @L'
#MS_ primula 'P[stand_nobag] @R'


HKDS	n '' '' '' 
WAIT 50

TALKER	p L
TALKER	n R
PIC   n a_3/a1__F1__f3__m2__b2_u1    
PIC_MP	n BLS 
PIC   p p/a11__F2__f2__m1__b1_u0    
IF '!(PVV==105&&GFC[IXA1]<4)' {


    // 保健室
    MSG	n_19 

    PIC   p p/a12__F1__m2__b2_u1    
    MSG	p_20 
    PIC   p p/a31__F1__f1__m1__b3_u0    
    MSG	p_21


    PIC   n a_3/a2__F1__f3__m2__b1_u1    
    MSG	n_21 
    PIC_HIDE_ALL T

    PIC_FILL &11 DARK
    PIC_FADEIN	&11 60
    WAIT 70
    PE ZOOM2 -1 60

    #MS_ primula 'P[chair] @RT'
    PIC_FADEOUT	&11 70
    WAIT 45
    #AUTO_BGM_REPLACE 0
    
} ELSE {
    // イクシャ初回

    // イクシャの初見医務室イベント 105/health_primula_t00 をまだ見ていない場合
    MSG	n_100 

    PIC   p p/a12__F2__f2__m1__b2_u1    
    PIC_MP	p HOT 
    
    MSG	p_101 
PIC   p p/a11__F2__f2__m1__b1_u1    
PIC_MP p QUE

    MSG	p_102 

PIC   n a_1/a00L1R1__F1__f1__m1__b3__u1    
    PIC_MP	n BLS
    MSG	n_102 

PIC   p p/a31__F1__m2__b3_u0    
    MSG	p_103 

    PIC   p p/a31__F1__f1__m1__b3_u0    
    MSG	p_21


    PIC   n a_3/a2__F1__f3__m2__b1_u1    
    MSG	n_21 

    PIC   n a_2/a0L1R3__F2__f2__m1__b3_u2    
    PIC_MP n SWT

    // p_21, n_21
    MSG	n_104 
    PIC   p p/a11__F2__f2__m3__b1_u0    

    MSG	p_105 

    PIC_HIDE_ALL T
    MSG_HIDE
    PE ZOOM2 60
    // 105/health_primula_t00 *p_06 に合流
    CHANGE_EVENT2	105/health_primula_t00 2
    
    // イクシャの初見医務室イベント 105/health_primula_t00 をまだ見ていない場合

}
