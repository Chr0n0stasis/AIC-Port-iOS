
_played_2w=0
SF_EVT_SET
// GOTO MOFU2
PIC   n a_1/a22__F1__f1__m1__b1__u0    
PIC   p p/a11__F1__m2__b2_u0    
MSG	p_01 


MSG	p_02 

PIC   n a_2/a0L1R3__F2__f2__m1__b5_uo    
MSG	n_03 

PIC   n a_2/a0L1R3__F2__f2__m1__b5_u3    
MSG	n_04 

PIC   n a_1/a22__F1__f1__m6__b1_u0    
MSG	n_05 


PIC   n a_1/a00L1R1__F1__f1__m4__b1_ua    
MSG	n_06 

STOP_BGM 340 

PIC   p p/a11__F2__f2__m1__b1_u1    
MSG	p_07 

TL 50 PIC   n a_1/a22__F1__f1__m1__b1__u0    
PIC   p p/a12__F2__f2__m3__b1_u1    
MSG	p_08 




MSG	p_09


PIC   p p/a12__F2__f2__m1__b2_u0    
MSG	p_11 

PIC   p p/a11__F1__m2__b2_u0    
MSG	p_12 
DOTL

PIC   n a_3/a0__F1__f3__m1__b3_u0    
MSG	n_13 


MSG	n_14 


PIC   n a_2/a0L1R3__F2__f2__m1__b3_uo    
PIC_MP n SWT2
MSG	n_15 


IF '!GFB[CITY_2WEEKATTACK]' {
    _played_2w=1
    <LOAD>
    PIC_HIDE_ALL	'' 1
    PIC_FILL	#0 DARK
    WAIT 20

    HKDS	n C #<%> MONOLOGUE
    TALKER_REPLACE n '=' ''
    // 防衛戦前に二週間前の回想を見ていない場合、ここで回想を挟む
    #SND_LOAD ev_2weekattack
    MSG	n_20 

    MSG	n_20_2 C
    MSG_HOLD
    WAIT 20
    
    TL 1 PIC_FILL	#0 DARK
    @___Other/trauma -1 '' '' '' 0
    DOTL 
    WAIT 120
    WAIT_BUTTON 
    MSG_HIDE

    WAIT 30
    _album_categ=1
    TALKER_REPLACE	n
    ___2weekattack=1
    #CMDRELOAD	IMMEDIATE IMMEDIATE_LOAD 
    WAIT 3
    CHANGE_EVENT2 ___city/2weekattack_00 2
    ALLOW_SKIP
    //GFB_SET CITY_2WEEKATTACK 1
     PIC_FADEOUT	#0 20
    #MS_ % '## P[stand_weak]'
    #MS_ primula '@#[%::40]'
    #PTCST ev_q_handshake '_1=400;_2=400;_3=20' 
    PE HP_REDUCE 1
    PE BURST 1 0.5
    PE ENEMY_OVERDRIVE_APPEAR 1 0.4
    
    HKDS	n CLT #<%> TT
    HKDS	p CCRCT #<primula>
    
    
    PIC_HIDE_ALL '' 1
    PIC_FILL	&1 DARK
    PIC_FADEOUT	&1 50

    WAIT 120

    TALKER_REPLACE	n

    // （回想。
    MSG	n_21


    MSG	p_21 
    #< % >

    #PTCST_REMOVE ui_snd_1
    TL 30 PIC_FILL	#0 DARK
    TL 30 PIC_FADEIN #0 150
    MSG	n_22 
    DOTL
    PE HP_REDUCE 120
    PE BURST 120 0.5
    PE ENEMY_OVERDRIVE_APPEAR 120 0.4
    PE HP_REDUCE -1
    PE BURST -1
    PE ENEMY_OVERDRIVE_APPEAR -1
    HKDS	n CLT @LB TT
    _npos=CCLCT
    MSG	n_23 
HKDS	p CCRCB @R TT

} ELSE {
    <LOAD>
    STOP_BGM 1 
    PIC_HIDE_ALL	'' 1
    PIC_FILL	#0 DARK
    WAIT 5
    START_FRONT_IMAGE_ON_MSG
    PIC_PE	&15 ENEMY_OVERDRIVE_APPEAR|ff:#ffffff
    PIC_FADEIN &15 1
    PIC_FLASH	#20 0 1 18 0xffBBA0A0
    PIC #7 still_2weekattack/5
    PIC_MV #7 0 -632
    PIC_MOVEA	#7 -1 HANDSHAKE
    WAIT 20
    PIC_FILL &20 ff:#C91515
    PIC_FADEIN	&20 20
    WAIT 25
    PIC_HIDE_ALL	'#' 1
    PIC_FILL	#0 DARK
    PIC_FADEOUT	&20 60
    

    WAIT 90
// ========================
    TL 190 PIC_FADEOUT &15 120
    HKDS	n CCLCB @LB TT
    _npos=CCLCB
    
    MSG	n_30
HKDS	p CCRCT @R TT
}
LOAD_BGM BGM_degree45
WAIT 38
<LOAD>
MSG	p_40 

 HKDS	n $_npos @LB TT

DOTL
TL 15 SND foot_bare
MSG	n_41 

TL 50 REPLACE_BGM	5 80
STOP_FRONT_IMAGE_ON_MSG


MSG	n_42 


MSG	p_43 
HKDS	p '=' '=' 
MSG	p_43_2 


MSG	p_44 


MSG	p_45 

DOTL

MSG	p_46 


MSG	p_47 


MSG	p_48 


MSG	p_49 


MSG	p_50 


MSG	n_51 
STOP_BGM 200
WAIT 25

IF 0 {
    LABEL MOFU
    PIC_FILL	#0 DARK

}
LOAD_BGM BGM_primula

HKDS	n    
HKDS	p


#MS_ % '= >>[Ev_primula -25,0] P[stand_weak] @R '
#MS_ primula 'P[chair] @L'


PIC_FADEOUT #0 100
WAIT 75
#MS_ % '= ! P[walk] >+[-10,0 :20] P[stand_ev~] ? @R'
WAIT 10

// ========================
//もふ
PIC   n a_2/a0L2R3__F2__f2__m1__b2_uo    
PIC_MP n SWT|BLS
MSG	n_60

PIC   p p/a11__F1__f1__m1__b1_u1    
PIC_MP p QUE
MSG	p_61
PIC   n a_1/a22__F1__f1__m6__b1_u1    
PIC_MP n SWT2
MSG	n_62 

PIC   p p/a12__F1__f1__m1__b2_u0    
PIC_MP p TTT
HALF_BGM	 1

REPLACE_BGM 20 120
MSG	p_63 

PIC   n a_3/a1__F1__f3__m5__b2_u0    
PIC_MOVEA	n 14 SCARY
PIC_MP n BLS|EXC I

// 合流
MSG	n_64 I

MSG_HOLD
SELECTARRAY_CLEAR
SELECTARRAY &&Select_mofu MOFU 
SELECTARRAY &&Select_not_mofu NOT_MOFU C  
SELECT_FOCUS 0
SELECT -1 _res

MSG_HIDE
IFSTR $_res IS 'NOT_MOFU' {
    LOAD_BGM BGM_school
    REPLACE_BGM 200 200 1
    _reshow_picture=1
    IF $_played_2w {
        GFB_SET CITY_2WEEKATTACK 1
    }
    SEEK_END
}
PIC_HIDE_ALL	''

PIC_FILL	#0 DARK
PIC_FADEIN #0 50
WAIT 55

IF 0 {
    LABEL MOFU2
    PIC_HIDE_ALL	'' 1
    
    PIC_FILL	#0 DARK

}
CHANGE_EVENT2	105/health_primula_mofumofu


IF $_played_2w {
    // 二週間前回想を再生していた場合
    HKDS	n CLT #<%>
    
    MSG	n_65 T
    GFB_SET CITY_2WEEKATTACK 1
} ELSE {
    WAIT 10
}

REPLACE_BGM 50 60 1


HKDS	n
HKDS	p 


