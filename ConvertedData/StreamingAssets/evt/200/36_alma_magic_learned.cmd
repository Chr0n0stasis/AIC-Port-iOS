// フラワリーサークル習得イベント
GFC_SET ALM1 |=8
START_LETTERBOX

TALKER	n L   
TALKER	l R   
LOAD_BGM BGM_heiwa_no_hanmokku

#MS_ % 'w40 P[stand_ev~] @R'
#MS_ man_bst_cow_farmer_1 '@L w80 P[walk~] >>[#<alma> 170,0 <<0.02] P[stand~]'
 
PIC   l l1/a0L2R1__F1__m1__b4_u2    
PIC   n a_2/a0L1R1__F2__f2__m1__b5_u0    
// フラワリーサークル登録
MSG	l_00 
MSG	n_00 

IF '!MagicAssignedSecond[FLOWERYCIRCLE]' 
    GOTO _lbl_150

PIC   l l1/a0L2R2__F1__m1__b1_ua    
PIC_MP	l QUE 

MTL MSG_SKIPHOLD
MSG	l_11 
SELECT_POS CCB

SELECT 2
&&Select_tellme2 _TELL
&&Select_nothanks _NOTHANKS C

// ========================
LABEL _TELL

PIC   n a_3/a2__F1__f3__m1__b4_uo    
// YES
MSG	n_20 



MAGIC_SEL_QUARTER
PIC   l l1/a0L1R3__F1__m1__b4_ua2    
MSG	l_21 

PIC   l l1/a0L2R3__F1__m1__b3_u2    
MSG	l_22 
PIC_HIDE_ALL	 

DENY_SKIP
#MS_ alma '!@L P[walk] >+[40,0 :70] P[stand]'
TUTO_MSG	'<key FLOWERYCIRCLE/> &&Mag_title_flowerycircle' 
TUTO_POS C T
PR_CURE 0 1

#< % >
PR_NO_KILL_MAGIC_ON_MS
STOP_LETTERBOX
LABEL RE
#NO_DECLINE_AREA_CAMERA

ALLOW_EVENTHANDLE_KEY X
WAIT_PR_EXPLODE_MAGIC '' R
IF '!MagicCount[FLOWERYCIRCLE]' {
    WAIT 100
    PR_CURE 0 1
    GOTO RE
}

WAIT 60
#DECLINE_AREA_CAMERA
ALLOW_EVENTHANDLE_KEY
WAIT 30
#MS_SOFT_ % '= w20 P[stand_ev~] @R'

TUTO_REMOVE
START_LETTERBOX
ALLOW_SKIP

IF 'NoelLockonPower>=0.5' {
    WAIT 60
    // 唱える・普通
    PIC   n a_2/a0L3R1__F2__f2__m1__b5_u0    
    PIC   l l1/a0L2R2__F1__m1__b3_ua2    
    PIC_MP l PLE2
    MSG	l_31 

    PIC   n a_1/a00L1R1__F1__f1__m1__b1__u3    
    MSG	n_32 


    // => n_43へ
    GOTO _n43
}
    WAIT 40

// 唱えたがロックオン性能が悪い杖で唱えて範囲がバカ狭い場合
PIC   n a_3/a2__F1__f3__m1__b4_u2    
PIC_MP n SWT
PIC   l l1/a0L2R1__F1__m1__b2_u1    
PIC_MP l TTT
MSG	n_41 
PIC   l l1/a0L2R2__F1__m1__b8_ua    
PIC_MP l SWT2

MSG	l_42 

PIC   n a_1/a00L1R1__F1__f1__m1__b2__u1    
MSG	n_42 

LABEL _n43
PIC   n a_1/a00L1R3__F1__f1__m1__b1__u3    
MSG	n_43 

PIC   l l1/a0L3R2__F1__m1__b3_u2    
PIC_MP l KIR
MSG	l_44 
PIC_HIDE_ALL	 
WAIT 30
HKDS	mb RT #<man_bst_cow_farmer_1>

#MS_ man_bst_cow_farmer_1 '= ##'
#MS_ alma 'w30 @R'
WAIT 20
TALKER_REPLACE	mb Mob  talk_mob_w7b

// 牧場主の獣人が話しかけてくる
TL 70 REPLACE_BGM 130 130

MSG	mb_50 

PIC   n a_2/a0L2R3__F2__f2__m1__b5_u2    
PIC_MP n SWT2

MSG	n_51 
PIC_HIDE_ALL	 


DOTL

MSG	mb_52 

HKDS	 n CCLCT  #<%>


MSG	n_52 
SEEK_END

// ========================
LABEL _NOTHANKS

// 使い方→NO 
PIC   n a_3/a2__F1__f3__m8__b1_u1    
PIC_MP n KIR
MSG	n_100 

LABEL _l_101
PIC   l l1/a0L3R2__F1__m1__b3_ua2    
PIC_MP l PLE
MSG	l_101 
#MS_ man_bst_cow_farmer_1 '. P[stand~]'

GOTO REBGM
// ========================
LABEL _lbl_150
//既に二列目に色々置いているために
//フラワリーサークルが一列目に来ている場合...
PIC   l l1/a0L2R1__F1__m1__b1_u1    
MSG	l_150 
PIC   l l1/a0L2R2__F1__m1__b6_ua    
PIC_MP l EXC

MSG	l_151 


MSG	l_152 

PIC   n a_1/a22__F1__f1__m4__b1_ua    
MSG	n_153 
GOTO _l_101

// l_101へ

LABEL REBGM
REPLACE_BGM 130 130
