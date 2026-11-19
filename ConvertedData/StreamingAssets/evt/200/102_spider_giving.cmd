<LOAD_DWARF>
GREETING	R 20
#MS_ alice '_ = _ +G ? P[stand_ev] @#[%::70]'

TALKER_REPLACE	a  Mob 
WAIT 20
TALKER	a L  
TALKER	n R
PIC   a p3/a0L2R1__F1__e3__u2    
PIC   n a_1/a22__F1__f1__m1__b1__u0    

SELECT 4 _LABEL 
&&Select_watching _WATCH
&&Select_giving _GIVE
&&Select_pinch _PINCH
&&Select_abort _CANCEL C

PIC_HIDE_ALL	 

GOTO $_LABEL
// ========================================================
// MARK : Pinch
// ========================================================
LABEL _PINCH
GFC_SET ALM1 +=1
ACHIVE p210_alice_hoppe_pinch

WAIT_MOVE
#MS_ % '>+[-35,0 << 0.08] P[interact]' 
WAIT 15

PIC %7 mountain210_alice/alice_giving_twist 
PIC_FADEIN	%7 10
PIC_MOVE2	%7 C C-30 C C 30 ZSIN
WAIT 15
SND hit_grab
PIC_MOVEA	%7 18 SCARY
PIC_FLASH	&10 0 4 6 0x55aaaaaa
WAIT 8

HKDS	a LB @CLT TT

IF 'GFC[ALC3]&3==0' {
    MSG	a_00 A

} ELSIF 'GFC[ALC3]&3==1' {
    MSG	a_10 A
} ELSE {
    MSG	a_20 A
}
#MS_ alice '= ! P[walk] >+[-40,0 <<0.11] ?'
IF 'GFC[ALC3]&3>1' {
    #MS_ alice 'P[crying]'
} ELSE {
    #MS_ alice 'P[beware]'
}
WAIT 10
PIC_HIDE_ALL	 
WAIT 32
HKDS	a    



PIC   n a_3/a0__F1__f3__m8__b1_u2    
IF 'GFC[ALC3]&3==0' {
    PIC   a p2/a1L2R1__F1__e5__ua    
    PIC_MP a BLS|SWT
    WAIT 20
    MSG	a_01 

    MSG	n_02 T

    GFC_SET ALC3 ~(GFC[ALC3]&12)|1
} ELSIF 'GFC[ALC3]&3==1' {
    PIC   a p2/a1L2R1__F1__e8__uaa    
    PIC_MP a BLS|SWT2
    WAIT 20



    MSG	a_11 


    MSG	n_12 T

    GFC_SET ALC3 ~(GFC[ALC3]&12)|2
} ELSE {

    PIC   a p1/a0L3R3__F1__e6__ue    
    PIC_MP a BLS
    WAIT 13
    PIC_MOVEA	a 14 SCARY
    
    WAIT 30

    MSG	a_21 


    PIC   n a_1/a22__F1__f1__m1__b3__u0    
    PIC_MP n SWT
    MSG	n_22 T


}
PIC_HIDE_ALL	 
#MS_ % '! >+[25,0 << 0.06] ? P[stand_ev]' 


SEEK_END

// ========================================================
// MARK : Give
// ========================================================
LABEL _GIVE
UIGM CHOOSE_ITEM '' _result
IFSTR $_result IS '' 
    SEEK_END

GFC_SET ALM1 +=1
WAIT 25

IFSTR $_result IS 'precious_errorchip' {
    CHANGE_EVENT	200/95_spider_give_device
    
} ELSIF 'ItemIs['$_result'][@FROMENEMY]' {
    PIC   n a_1/a00L1R1__F1__f1__m1__b1__u1    
    PIC   a p1/a0L1R3__F1__e7__uia    
    MSG	n_50 C
    MSG_HOLD
    WAIT 30
    PIC_MOVEA	a 12 SCARY
    MSG	a_61 
    // わかるよ、あなたはエルフだから…魔族を殺すんだよね。
    PIC   a p2/a1L1R1__F1__e7__u1    
    PIC_MP a TTT

    MSG	a_62
    PIC   n a_3/a0__F1__f3__m1__b4_u0    
    PIC_MP n SWT
    MSG	n_63 T
    PIC_HIDE_ALL	 
    
} ELSIFSTR $_result IS 'precious_noel_cloth' {
  // ノエルの服を渡す
ACHIVE p210_alice_give_clothes
    START_BLURSC_TO_BEHIND
    SHOW_BLURSC 
    WAIT 25
    PIC %7 mountain210_alice/alice_giving_clothes
    PIC_FADEIN	%7 20
    PIC_MOVE2	%7 C C-30 C C 50 ZSIN
    
    WAIT 40
    HKDS	n RB @CRR  TT
    HKDS	a LB @CLL  TT
    
    MSG	n_80 


    MSG	a_81 


    MSG	a_82 


    MSG	n_83 T


    // 頷く
    PIC_MP2 %7 a2 DEP
    MSG	a_84 


    // 首を振る
    MSG	a_85 


    MSG	n_86 T

    HKDS	n '=' '='
    WAIT 30
    PIC_MP2 %7 n2 BLS

    MSG	n_87 T

    PIC_FILL %10 DARK
    PIC_FADEIN	%10 55
    WAIT 60
    PIC_FADEOUT %10 60
    HIDE_BLURSC 1
    PIC_HIDE %7 1
    WAIT 50

} ELSIFSTR $_result IS 'precious_noel_shorts' {

ACHIVE p210_alice_give_pantsu
    START_BLURSC_TO_BEHIND
    SHOW_BLURSC 
    WAIT 25
    PIC #7 mountain210_alice/alice_giving_pantsu
    PIC_FADEIN	#7 20
    PIC_MOVE2	#7 C C-30 C C 50 ZSIN
    
    WAIT 40
    HKDS	n RB @CRR  TT
    HKDS	a LB @CLL  TT

    // 下着を渡す
    MSG	n_90 


    // これはあなたの下着?
    MSG	a_91 


    HKDS	n '=' '=' 
    MSG	n_92 


    MSG	a_93 


    HKDS	n '=' '=' TT
    // ……えるふは、下着を着なくて平気なの?
    MSG	n_94 

    WAIT 20
    HIDE_BLURSC
    PIC_FADEOUT #7 45
    WAIT 40


} ELSIF 'ItemIs['$_result'][@FROMNOEL]' {
    // ジュース関連
ACHIVE p210_alice_give_juice
    PIC   n a_1/a00L1R1__F1__f1__m1__b2__u1    
    PIC_MP n BLS
    PIC   a p3/a0L2R2__F1__e2__ua2    
    TL 20 PIC_MVA a 14 SCARY
    MSG	n_50 


    MSG	a_51 

DOTL
PIC   a p2/a1L1R1__F1__e2__uaa    
PIC_MP a DEP|SWT
    MSG	a_52 A


PIC   n a_2/a0L2R3__F2__f2__m1__b5_u2    
    MSG	n_53 T


PIC   n a_3/a1__F1__f3__m1__b3_uo    
PIC_MP n SWT2|BLS
    MSG	n_55 T

} ELSIF 'ItemIs['$_result'][@FOOD]||ItemIs['$_result'][@FISH]||ItemIs['$_result'][@FRUIT]' {
    PIC   n a_1/a00L1R3__F1__f1__m1__b1__uo    
   PIC   a p3/a0L1R2__F1__e3__u1    
      // 魚、ごはん
MSG	n_110 
PIC   a p3/a0L1R2__F1__e3__u2    

MSG	a_111 
PIC   a p3/a0L1R2__F1__e6__u1    
MSG	a_111_2 

PIC   a p2/a1L1R1__F1__e2__u1    
TL 13 PIC_MOVEA a 14 SCARY
PIC_MP a BLS

MSG	a_112 
PIC   n a_3/a0__F1__f3__m1__b3_u0    
PIC_MP n SMK

MSG	n_113 

DOTL
    
} ELSE {
    PIC   n a_1/a22__F1__f1__m1__b1__u1    
    PIC   a p1/a0L3R1__F1__e1__ui3    
    MSG	n_100 


    PIC   a p1/a0L3R2__F1__e2__u2    
    PIC_MP a TTT
    MSG	a_101 
    PIC   n a_1/a22__F1__f1__m1__b1__u0    

    MSG	n_102 
    PIC   a p1/a0L1R2__F1__e2__u1    
    PIC_MP a SWT

    MSG	a_103 

PIC   n a_3/a0__F1__f3__m1__b4_u0    
PIC_MP n QUE
    MSG	n_104 T


}
SEEK_END
// ========================================================
// MARK : Watch
// ========================================================
LABEL _WATCH
GFC_SET ALM1 +=1
WAIT 15

START_BLURSC_TO_BEHIND
SHOW_BLURSC 
PIC #6 mountain210_alice/alice_watch_bg 
PIC_MOVE2 #6 0,150 0,-110 304 ZSIN
PIC_FADEIN #6 40 
WAIT 20
IF 'GFC[ALC1]&1==0' {
    PIC #7 mountain210_alice/alice_watch0 
} ELSE {
    PIC #7 mountain210_alice/alice_watch1
}
PIC_MOVE2 #7 P-150,200 -100,-380 284 ZSIN
PIC_FADEIN #7 50

WAIT_BUTTON 320
PIC_FINE #6
PIC_FINE #7
WAIT_BUTTON

CHANGE_EVENT	200/103_spider_waiting_prepare 60 1


// ========================================================
// MARK : 
// ========================================================
