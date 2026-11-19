_phase=~GFC[PVV106_SNEAKING_FAILURE]
IFDEF 1
    _phase=$1

#SND_LOAD ev_club
#SND_LOAD ev_city



SHOW_BLURSC
HIDE_STATUS
#< % >

WAIT 25
HKDS	mb RT @CRT
HKDS	n LT @CL
TALKER_REPLACE	mb Army talk_mob_m0
ALLOW_SKIP
LOAD_BGM	BGM_A_suspicion 
TL 25 REPLACE_BGM	30 0 0


IF $_phase'==0' {

    PIC &4 city_sneaking/aware_0 S
    PIC_MOVE2	&4 C C-50 C C+20   30 ZSIN    
    PIC_FADEIN	&4 40
    
    WAIT 15
    
    MSG	mb_05 


    //何か確認する


    MSG	n_07 


    MSG	mb_08 


    MSG	n_09 

    @___Tigrina/106iyapan_skip $_phase 0
    IF $_skip_result GOTO __SKIP

    WAIT 30

    PIC &4 city_sneaking/aware_1 S
    PIC_FADEIN	&4 30
    PIC_MOVEA	&4 70 SHAKE
    SND cloth_gosogoso1
    

    MSG	mb_10 


    MSG	n_11  T

    WAIT 30


    MSG	mb_12 


    MSG	n_13 


    WAIT 60
    PIC &5 city_sneaking/aware_breast__0 S
    PIC_FADEIN	&5 30
    PIC_MOVE2	&5 0 -40 0 0 25 ZSIN    
    PIC_MOVEA	&5 15 SCARY
    TL 40 PIC_FADEOUT	&4 50
    TL 30 PIC_MOVEA	&5 105 DANCE
    TL 180 PIC_MOVEA	&5 60 DANCE
    SND cloth_gosogoso1



    MSG	n_15 


    MSG	mb_14 

    DOTL
    WAIT 130


    MSG	mb_16 

    PIC &5 city_sneaking/aware_breast__1 S
    PIC_FADEIN	&5 20
    PIC_MOVEA	&5 15 SCARY
    PIC_MP2	&5 noel EXQ '' 140
    

    MSG	n_17 AI


    MSG	mb_18 


    MSG	n_19 


    MSG	mb_20 


    MSG	n_21 

    WAIT 70
    SND cloth_huton
    PIC_FADEOUT	&5 0 
    PIC_FILL	&9 DARK
    PIC_FADEOUT	&9 50
    UIP_EVENT_SETFADE cuts_iyapan 0 1 1
    PR_BREATH breath_e
    HKDS	n '=' @CLT TT
    HKDS	mb RB @RBOUT TT   
    
    

    WAIT 80


    MSG	n_22 
    WAIT 30

    MSG	mb_23 


    MSG	n_24 

    WAIT 40

    PIC_FILL	&9 DARK
    PIC_FADEOUT	&9 50
    UIP_EVENT_SETFADE cuts_iyapan !PROG0
    WAIT 80
    
    MSG	mb_25 


    MSG	n_26  T
    WAIT 20
    WAIT_BUTTON	

    HKDS	mb '=' '='
    MSG	mb_27 


    MSG	n_28 

} ELSIF $_phase'==1' { 
    PIC &4 city_sneaking/aware_0 S
    PIC_MOVE2	&4 C C-50 C C+20   30 ZSIN    
    PIC_FADEIN	&4 40
    
    WAIT 15
    
    MSG	mb_100 

    MSG	n_100 

    MSG	mb_101 
    MSG	n_101 


    MSG	mb_102 


    MSG	n_103 

    @___Tigrina/106iyapan_skip $_phase 0
    IF $_skip_result GOTO __SKIP

    HKDS	n '=' '=' TT
    HKDS	mb '=' '=' TT   
    WAIT 60
    PIC &5 city_sneaking/aware_breast__0 S
    PIC_FADEIN	&5 30
    PIC_MOVE2	&5 0 -40 0 0 25 ZSIN    
    PIC_MOVEA	&5 15 SCARY
    TL 40 PIC_FADEOUT	&4 50
    TL 30 PIC_MOVEA	&5 105 DANCE
    TL 160 PIC_MOVEA	&5 60 DANCE
    SND cloth_gosogoso1


    //乳揉まれカットイン
    MSG	n_105 


    MSG	mb_106 


    MSG	n_107 


    DOTL
    //もう一回揉まれ
    WAIT 50
    DOTL
    PIC &5 city_sneaking/aware_breast__2 S
    PIC_FADEIN	&5 12
    PIC_MOVEA	&5 20 SCARY
    SND cloth_gosogoso0
    MSG	n_108 


    HKDS	mb '=' '='　   
    MSG	mb_109 


    MSG	mb_110 
    LABEL _N111

    PIC &5 city_sneaking/aware_breast__0 S
    PIC_FADEIN	&5 12
    PIC_MOVEA	&5 80 SHAKE
    
    MTL PIC &5 city_sneaking/aware_breast__2 S
    MTL PIC_FADEIN	&5 20
    MTL PIC_MOVEA	&5 20 SCARY
    MSG	n_111 


    WAIT 60
    PIC &5 city_sneaking/aware_breast__0 S
    PIC_FADEIN	&5 35
    MSG	mb_112 


    MSG	n_113 
    
    TL 15 PIC_FADEOUT	&5 50


    //たくし上げカットイン
    WAIT 70
    DOTL
    SND cloth_huton
    PIC_FADEOUT	&5 0 
    PIC_FILL	&9 DARK
    PIC_FADEOUT	&9 50
    UIP_EVENT_SETFADE cuts_iyapan !PROG1 1 1
    PR_BREATH breath_e
    HKDS	n '=' @CLT TT
    HKDS	mb RB @RBOUT TT   

    MSG	mb_114 


    MSG	n_115 

    WAIT 30
    WAIT_BUTTON
    PIC_FILL	&9 DARK
    PIC_FADEOUT	&9 50
    UIP_EVENT_SETFADE cuts_iyapan !PROG1|PROG0 1 1
    WAIT 30
    HKDS	n '=' @TT '='

    MSG	n_116  T

    WAIT_BUTTON

    MSG	n_117 


    MSG	mb_118 


    WAIT_BUTTON

    //じろじろ見られてるっぽいカットインか何か
    MSG	n_119 


    HKDS	mb '=' '=' 
    MSG	mb_120 


    MSG	n_121 

    HKDS	mb '=' '=' TT 

    MSG	mb_122 


    WAIT 85

    PIC &5 city_sneaking/aware_hip S
    PIC_FADEIN	&5 45
    SND cloth_gosogoso0
    PIC_MOVEA	&5 70 SIN_H
    TL 95 PIC_MOVEA	&5 70 SIN_H

    MSG	n_123 I


    MSG	mb_124

    WAIT 30
    DOTL
    SND cloth_gosogoso0
    PIC_MOVEA &5 SCARY 20
    TL 30 PIC_MOVEA	&5 40 SIN_H
    PIC_FADEIN	&5 5
    TL 95 PIC_MOVEA	&5 70 SIN_H

    //お尻側カットイン
    MSG	n_124 

    MSG	mb_125 


    SND cloth_gosogoso0
    PIC_MOVEA	&5 30 SIN_H
    TL 45 PIC_MOVEA	&5 40 SIN_H
    WAIT 40

    MSG	mb_126 

    DOTL

    WAIT 55
    HKDS	n '=' @C '='
    PIC_FADEOUT	&5 0
    PIC_FILL	&9 DARK
    PIC_FADEOUT	&9 50
    UIP_EVENT_SETFADE cuts_iyapan !PROG1|PROG0|SMASH 1 1

    MSG	n_127 T

    WAIT 40

    MSG	mb_128 
} ELSE {
    HKDS	n '=' '=' TT
    PIC &4 city_sneaking/aware_1 S
    PIC_MOVE2	&4 C C-50 C C+20   30 ZSIN    
    PIC_FADEIN	&4 40
    
    WAIT 15

    MSG	mb_200 


    MSG	n_201 


    MSG	mb_202 


    MSG	n_203 


    MSG	mb_204 


    MSG	n_205 

    @___Tigrina/106iyapan_skip $_phase 
    IF $_skip_result GOTO __SKIP


    // HKDS	mb '=' '=' TT   
    WAIT 60
    PIC &5 city_sneaking/aware_breast__2 S
    PIC_FADEIN	&5 30
    PIC_MOVE2	&5 0 -40 0 0 25 ZSIN    
    PIC_MOVEA	&5 15 SCARY
    TL 40 PIC_FADEOUT	&4 50
    TL 30 PIC_MOVEA	&5 105 DANCE
    TL 160 PIC_MOVEA	&5 60 DANCE
    SND cloth_gosogoso1


    //胸もみ
    MSG	n_206 


    MSG	mb_207 

    DOTL
    WAIT 30

    PIC &5 city_sneaking/aware_breast__1 S
    PIC_FADEIN	&5 15
    PIC_MOVEA	&5 25 SIN_H
    TL 50 PIC_MOVEA	&5 25 SIN_H
    TL 110 PIC_MOVEA	&5 45 SIN_H
    SND cloth_gosogoso1

    MSG	n_208 


    MSG	mb_209 


    MSG	n_210 
    DOTL
    WAIT 60
    PIC &5 city_sneaking/aware_breast__0 S
    PIC_FADEIN	&5 15
    MSG	mb_211 


    MSG	n_212 

    WAIT 70
    DOTL
    SND cloth_huton
    PIC_FADEOUT	&5 0 
    PIC_FILL	&9 DARK
    PIC_FADEOUT	&9 50
    UIP_EVENT_SETFADE cuts_iyapan !PROG2 1 1
    PR_BREATH breath_e
    HKDS	n '=' @CLT TT
    HKDS	mb RB @RBOUT 

    WAIT_BUTTON

    MSG	mb_213 


    MSG	n_214  T


    MSG	mb_215 

    WAIT 60

    DOTL
    PR_BREATH 
    @_SND_SPOT_R kuchu 10 40
    PIC_FILL	&9 DARK
    PIC_FADEOUT	&9 50
    UIP_EVENT_SETFADE cuts_iyapan !PROG2|PROG0 1 1
    //パンツさわり
    MSG	n_216 



    MSG	mb_217 


    MSG	n_218 

    WAIT 30

    HKDS	mb '=' '=' TT
    MSG	mb_219 


    MSG	n_220 


    MSG	n_221 


    MSG	mb_222 

    WAIT 30
    CLEARTL
    @_SND_SPOT_R kuchul 14 30
    PIC_FILL	&9 DARK
    PIC_FADEOUT	&9 50
    UIP_EVENT_SETFADE cuts_iyapan !PROG2|PROG0|SMASH 1 1

    //パンツいじり加速
    MSG	n_223 


    MSG	mb_224 

    CLEARTL
    @_SND_SPOT_R kuchul 14 30
    PIC_FILL	&9 DARK
    PIC_FADEOUT	&9 50
    UIP_EVENT_SETFADE cuts_iyapan !PROG2|PROG0|SMASH|PROG1 1 1

    MSG	n_225 

    WAIT_BUTTON

    WAIT 30

    CLEARTL
    PIC_FILL	&9 DARK
    PIC_FADEOUT	&9 50
    UIP_EVENT_SETFADE cuts_iyapan !PROG2|SMASH 1 1
    PR_BREATH breath_e
    WAIT 30

    MSG	mb_226 


    MSG	n_227 

    WAIT 50
    HKDS	mb '=' '=' 

    MSG	mb_228 


    WAIT 30

    PIC &5 city_sneaking/aware_hip S
    PIC_FADEIN	&5 45
    SND cloth_gosogoso0
    PIC_MOVEA	&5 50 SIN_H
    TL 95 PIC_MOVEA	&5 50 SIN_H


    MSG	n_229
    MSG	mb_230
    PIC_FADEOUT	&5 140
}

STOP_BGM	100 


WAIT 30
IF 0 {
    LABEL __SKIP
    PIC_HIDE_ALL	 
    STOP_BGM	100 
}
DOTL
HKDS	n 
