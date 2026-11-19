TALKER	n R  
TALKER	w L   
 

__bgm=BGM_town4
_flag=~quest_progress_f[subquest_mount_cocktail]
PIC   n a_1/a00L1R1__F1__f1__m1__b1__u0    
IF $_flag'>=4' {
    LOAD_BGM $__bgm
    STOP_BGM 300 0
    GOTO TALK
}
#SND_LOAD ev_mountain

IF $_flag'<2' {
    
    IF 'SfEvt[___city/bar_w_t_bar]' {    
        PIC   w w/a0L3R1__F1__f1__m2__b2__u5    
        PIC_MP w HOT
        // C:1回目正解する(ヴァーロスの好みを聞いている。
        MSG	w_00 
        PIC   w w/a0L1R3__F2__f2__m1__e2__u2    
        MSG	w_01 
    } ELSE {
        PIC   w w/a0L3R1__F1__f1__m2__b2__u5    
        PIC_MP w HOT
        // C2:1回目正解する(ヴァーロスの好みを聞いていない。
        MSG	w_10
    }

} ELSE {
    PIC   w w/a0L1R1__F2__f2__m1__e4__u1    
    PIC_MP w HOT
    // C3:2回目以降正解する
    MSG	w_20

}
// E C1-3から合流
PIC   w w/a0L2R3__F1__f1__m1__e3__u2    
TL 25 SND glass_ice_karan
TL 20 PIC_MOVEA	w 15 SHAKE
LOAD_BGM $__bgm

MSG	w_100 


@_PIIN
PIC   n a_3/a0__F1__f3__m5__b2_u0    
PIC_MP n QUE
PIC_MOVEA	n 2 HOP
MSG	n_101 I

TUTO_MSG	___city/bar_w_t_cocktail_wrong*actihol_06 -1000
TUTO_TEMP_FRONT 1
PIC   w w/a0L1R1__F2__f2__m1__e1__u3    
MSG	w_102 

PIC   n a_1/a22__F1__f1__m1__b3__u0    
PIC_MP n SMK

MSG	n_103 T

MSG	n_104 

MSG_HIDE
WAIT 30
HALF_BGM 1
PIC_HIDE_ALL	'' 1
PIC_FILL #0 DARK
TL 18 SND gokkun
TL 15 PIC_FLASH	#9 1 10 9 ff:#888888
TL 15 PIC_MOVEA #9 8 SCARY2
TL 25 PIC_MOVEA #0 24 SCARY

HKDS	n C @CCR   

//お酒を飲む 
MSG	n_105  A

PE ZOOM2 1
#< %  
#MS 'P[stand_weak~]'

DOTL
WAIT 40
PE CONFUSED_CAMERA 1 0.2
PIC_FADEOUT #0 90
HALF_BGM 0

WAIT 40


PIC   w w/a0L1R1__F2__f2__m1__e3__u2    
PIC_MP w LAG
PIC   n a_2/a0L1R3__F2__f1__m2__b1_u1    
PIC_MP n BLS|BSM

MSG	w_106 

HKDS	n   
PIC   n a_2/a0L1R3__F2__f1__m2__b1_u2  
PIC_MP n BLS|BSM

MSG	n_107 T

TUTO_REMOVE

PIC   w w/a0L1R1__F1__f1__m1__e2__u2    
PIC_MP w ONP
MSG	w_108 

PIC_HIDE_ALL	 
WAIT 20

// かんぱい
#MS_ walross '## #;'
HKDS	w CCL @CL
PIC_FILL #0 DARK
TL 20 PIC_FLASH	#9 1 6 30 ff:#888888
SND bar_cheers

MSG	w_109 

WAIT 20
SND gokkun_3
WAIT 120
PIC_FILL #0 DARK 
PIC_FO #0 90
WAIT 70

STOP_BGM 300 0
PIC   w w/a0L3R3__F2__f2__m1__e3__u3    
PIC_MP w ONP2
PIC   n a_3/a1__F1__f3__m2__b2_u1    
PIC_MP n BLS
HKDS	 w 

MSG	w_110 


TL 30 PIC   n a_1/a22__F1__f1__m1__b1__u0    
TL 30 PIC_MP n BLS

LABEL TALK
REPLACE_BGM	200 200  0
PE CONFUSED_CAMERA -1 300


// TALK
PIC   w w/a0L1R1__F3__f3__m1__e1__u2    
MSG	w_111 
PIC   w w/a0L1R1__F1__f1__m1__e1__u1    
MSG	w_111_2

PIC   n a_3/a0__F1__f3__m1__b3_u0    

MSG	n_112 

PIC   w w/a0L3R1__F1__f1__m2__b2__u3    

MSG	w_113 

PIC   w w/a0L2R3__F2__f2__m1__e4__u3    
MSG	w_114 

PIC   n a_1/a00L1R1__F1__f1__m1__b2__uo    
PIC_MP n QUE

MSG	n_115 

PIC   w w/a0L1R1__F2__f2__m1__e1__u1    
MSG	w_116 

PIC   w w/a0L2R1__F3__f3__m1__e1__u1    
PIC_MP w TTT
MSG	w_117 

PIC   n a_1/a22__F1__f1__m1__b1__u0    
MSG	n_118 

PIC   w w/a0L1R3__F1__f1__m1__e3__u3    
MSG	w_119 

    

PIC   n a_1/a22__F1__f1__m1__b3__u0    
PIC_MP n HOT
MSG	n_120 

STOP_BGM 300 0
PIC   w w/a0L1R3__F1__f1__m1__e1__u6    
MSG	w_121 

PIC   n a_2/a0L1R3__F2__f2__m1__b2_uo
MTL PIC   n a_2/a0L1R3__F2__f2__m1__b4_u2    
MTL PIC_MP	n BLS
MTL PIC_MOVEA	n 10 SCARY
MTL SND cloth_gosogoso
MSG	n_122 

PIC   w w/a0L2R1__F2__f2__m1__e4__u2    
PIC_MP w ONP
MSG	w_123 

@_TSUKKOMI
REPLACE_BGM	150 120 0

#MS_ % '##'
PIC   n a_3/a1__F1__f3__m5__b1_u0    
PIC_MP n BLS|SWTB
MSG	n_124 I

PE ZOOM2 -1 90
IF $_flag'<4' {
    SHOW_QUEST_PROGRESS 1
    QUEST_FINISH subquest_mount_cocktail
}
