
PIC   p p/a11__F1__m2__b2_u0    
PIC   n a_1/a22__F1__f1__m1__b2__u1    
// 先生に「先生は罪人か？」と聞く
IF 'SfEvt[105/health_primula_t_primula_is_villain]'  {
    STOP_BGM 200
    GOTO _TALK2
}

PIC_MP p QUE

MSG	p_00 
PIC   n a_1/a22__F1__f1__m1__b2__u0    

MSG	n_01 
MSG_HOLD

SELECT 2
&&Select_listen_execute _TALK
&&Select_stop_sitdown _SKIP

LABEL _SKIP
MSG_HIDE
GOTO SEEK_END
//================================================
LABEL _TALK
STOP_BGM 200
MSG_HIDE
WAIT 20
LABEL _TALK2
SF_EVT_SET
LOAD_BGM BGM_primula_suspicion

PIC   n a_2/a0L1R3__F2__f2__m1__b3_u0    
MSG	n_10 


TL 70 REPLACE_BGM	30 5 

PIC   p p/a12__F2__f2__m1__b1_u0    
MSG	p_11 

PIC   n a_2/a0L1R3__F2__f2__m1__b4_u2    
MSG	n_12 
PIC   p p/a12__F2__f2__m3__b1_u1    

MSG	p_13 

PIC   p p/a11__F1__f1__m1__b2_u0    
PIC_MP p HOT
MSG	p_14 

PIC   n a_3/a0__F1__f3__m1__b1_u2    
MSG	n_15 
PIC   p p/a11__F1__m2__b2_u0    

MSG	p_16 
PIC   p p/a11__F2__f2__m2__b1_u1    

MSG	p_17 

PIC   n a_3/a1__F1__f3__m1__b3_u0    
MSG	n_18 
DOTL
#< primula >
rx=~m2d_current_x
#< % >
px=~m2d_current_x
PE ZOOM2 200
PE MAGIC_DEVICE_ACTIVATE 240 0.5

#MS_ primula '## w20 P[bench2stand~] w40 !'
IF $px'<'$rx {

    #MS_ primula '@L P[walk_nobag~] >+[-25,0 :40] >+[-10,0 :40] '
    #MS_ % '! w92 P[walk] >+[-35,0:70] P[stand_ev~]?'
} ELSE {
    #MS_ primula '@R P[walk_nobag~] >+[25,0 :40] >+[10,0 :40] '
    #MS_ % '! w92 P[walk] >+[35,0:70] P[stand_ev~]?'
}
#MS_ primula 'P[stand_nobag~] ?'
PIC   p p/a11__F2__f2__dk1_u0    
TL 20 PIC   n a_1/a22__F1__f1__m1__b1__u1    

MSG	p_19 

STOP_BGM 200
DOTL
PIC_HIDE_ALL	 
LOAD_BGM BGM_light
HKDS	p T #<primula> TT

WAIT 50
MTL MSG_SKIPHOLD

MSG	p_20 


SELECT 2
&&Select_scary SCARY
&&Select_not_scary NOT_SCARY C
// ================================================

LABEL SCARY
MSG_HIDE
WAIT_MOVE
HKDS	p    

WAIT 40
PIC   n a_1/a00L1R3__F1__f1__m1__b2__u1    
PIC_MP n SWT
PIC   p p/a11__F1__m2__dk1_ua    
// A==
MSG	p_100 

PIC   n a_1/a22__F1__f1__m1__b3__u1    
PIC_MP n SWT2
MSG	n_101 

PE MAGIC_DEVICE_ACTIVATE -1 240
PIC   p p/a11__F2__f2__m1__b2_u1    
MSG	p_102 

PIC   p p/a31__F1__f1__m1__b2_u0    
MSG	p_103 

GOTO _C
// ================================================
LABEL NOT_SCARY
MSG_HIDE
WAIT_MOVE
HKDS	p    
WAIT 40
// B==
PIC   n a_3/a0__F1__f3__m1__b1_uo    
PIC   p p/a11__F1__m2__dk2_u1    
MSG	n_150 

PIC   p p/a11__F1__m2__dk1_ua    
MSG	p_151 

PIC   n a_1/a22__F1__f1__m1__b2__u1    
PIC_MP n SWT2
MSG	n_152 

PIC   p p/a12__F2__f2__m1__b1_u1    
MSG	p_153 
PIC   p p/a11__F2__f2__m3__b1_u0    
MSG	p_153_2 

PIC   n a_2/a0L1R3__F2__f2__m1__b4_u2    
PIC_MP n SMK|SWT
MSG	n_154 
PE MAGIC_DEVICE_ACTIVATE -1 240

PIC   p p/a31__F1__f1__m1__b2_u1    
MSG	p_155 
// ================================================

LABEL _C
TL 25 PIC   n a_1/a00L1R1__F1__f1__m1__b1__uo    

REPLACE_BGM	200 200 0
// C===

MSG	p_200 

DOTL
PIC   n a_3/a1__F1__f3__m1__b3_uo    
MSG	n_201 

PIC   p p/a11__F1__f1__m1__b2_u0    
MSG	p_202 

PIC   n a_2/a0L1R3__F2__f2__m1__b4_u2    
MSG	n_203 

PIC   p p/a11__F2__f2__m3__b1_u0    
MSG	p_204 

PIC   n a_3/a0__F1__f3__m8__b1_u3    
PIC_MP n BLS|SWT
MSG	n_205 




MSG_HOLD
SELECTARRAY_CLEAR
SELECTARRAY &&Select_mofu MOFU 
SELECTARRAY &&Select_not_mofu NOT_MOFU C  
SELECT_FOCUS 0
SELECT -1 _res

MSG_HIDE
IFSTR $_res IS 'NOT_MOFU' {
    STOP_BGM 200 1
}
PIC_HIDE_ALL	''

PIC_FILL	#0 DARK
PIC_FADEIN #0 90
WAIT 100
#CMDRELOAD	IMMEDIATE IMMEDIATE_LOAD 
WAIT 2

IFSTR $_res IS 'NOT_MOFU' {
    _reshow_picture=1

    LOAD_BGM BGM_school
    REPLACE_BGM 200 200 1
    PIC_FADEOUT #0 90
    GREETING	@ 15
    WAIT 70

    SEEK_END
}


IF 0 {
    LABEL MOFU2
    PIC_HIDE_ALL	'' 1
    
    PIC_FILL	#0 DARK

}
CHANGE_EVENT2	105/health_primula_mofumofu 1

WAIT 10
REPLACE_BGM 50 60 1


HKDS	n
HKDS	p 


