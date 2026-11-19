// げきは　

DENY_SKIP
PIC_FILL &11 DARK
PIC_FADEIN	&11 80
WAIT 120
UIP_SETFADE 
UIP_EVENT_SETFADE 0

PE SND_VOLUME_REDUCE 1
TL 40 SND wk2_hit_arrow_fromout

TL 55 PIC_FLASH &15 10 0 30 44:#ffffff
TL 70 SND wk2_hit_arrow_fromout
TL 78 SND wk2_hit_arrow_fromout
TL 115 SND wk2_hit_arrow_fromout
TL 130 SND wk2_hit_arrow_fromout
TL 152 SND wk2_hit_arrow_fromout

TL 168 SND wk2_grawl_far
TL 140 PIC_FLASH &15 4 0 20 33:#ffffff
TL 166 PIC_FLASH &15 10 0 50 33:#ffffff


TL 192 SND wk2_hit_arrow_fromout
TL 204 SND wk2_hit_arrow_fromout
TL 210 SND wk2_hit_arrow_fromout
TL 222 SND wk2_hit_arrow_fromout
TL 231 SND wk2_hit_arrow_fromout
TL 239 SND wk2_hit_arrow_fromout


TL 180 PIC_FADEOUT	&11 80

TL 180 PIC_FILL #11 DARK

WAIT 280

ALLOW_SKIP




HKDS	mb0 LT @LOUT    TT 
TALKER_REPLACE	mb0 'Mob' '' 



MSG	mb0_15 CB

WAIT 25
HKDS	mb5 CLB @LOUT     TT
TALKER_REPLACE	mb5 '' ''
MSG	mb5_16 CB

WAIT 35

HKDS	l R @ROUT     TT
TALKER_REPLACE	l 'Mob'  ''
MSG	l_17 B

DOTL

WAIT 80
PE BGM_WATER -1 30
PE BGM_LOWER -1 30

PE SND_VOLUME_REDUCE -1

PIC_HIDE_ALL '' I
PIC_B #0 bg/2weekattack
PIC_FILL #11 DARK
PIC_FADEOUT	#11 80
PIC_FILL	#1 77:#000000

TALKER_REPLACE	n 
WAIT 120
HIDE_LETTERBOX_A

PIC   #6 still_2weekattack/7 
PIC_MOVE2 #6 0,280 0,20 700 ZSIN
PIC_MOVEA	#6 -1 HANDSHAKE

IF 'sensitive_level>0' {
    PIC_FLASH #10 0 2 40 DARK
} ELSE {
    PIC_FADEIN #6 90
}

HKDS	n RB @L TT 

MSG	n_18 
MSG_HIDE	  
WAIT 50


TALKER_REPLACE	n '=' ' '

HKDS	mb4 LT @LOUT     TT
TALKER_REPLACE	mb4 '' ''
HKDS	mb6 RT @ROUT     TT
TALKER_REPLACE	mb6 '' ''
MSG	mb4_19 CB
WAIT 30
MSG	mb6_20 B

HKDS	l RBOUT @RTOUT     TT

WAIT 65
IF 'sensitive_level>0' {
   TL 40 PIC_FILL #7 77:#520E0E
   TL 40 PIC_FADEIN #7 200
    HKDS	n LT @L TT 

} ELSE {
    PIC   #7 still_2weekattack/8
    PIC_FADEIN #7 110
    PIC_MOVEA	#7 -1 HANDSHAKE
    HKDS	n RB @CRT TT 
}


MSG_HIDE	  

// 最後のアルマの文章は表示されない。ログに記載されるのみ。強調表示もされない。
MSG	l_hidden_21 CB


MSG	n_22 

WAIT 30

