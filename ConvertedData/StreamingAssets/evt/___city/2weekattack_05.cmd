UIP_EVENT_SETFADE 
PE BGM_LOWER 80 0.5




HKDS	n LB @B  


PIC_FILL	#0 DARK

PIC_FLASH	%9 0 14 40 ff:#000000

UIP_EVENT_SETFADE cuts_in_stomach !NORMAL

TL 30 #SNDINTV '' insect_rape 170 

WAIT 60

MSG	n_00 T

DOTL

// 熱湯
UIP_PTCST ui_in_stomach_splash // じゅ〜
TALKER_REPLACE	n '=' '' 

PIC_FLASH	%9 8 15 50  77:#C27474
#SNDINTV '' absorb_licked 70 24


UIP_EVENT_SETFADE cuts_in_stomach !PROG0
UIP_PTCST ui_in_stomach_1
// PIC_MOVEA #1 50 SIN_V

@_VO_SPOT mouth_fin Noel

MSG	n_01 T

SND bite_splash
PIC_FLASH	%9 3 5 20  ff:#C27474
UIP_PTCST ui_sinv

@_VO_SPOT_R mouth 7 38 Noel

MSG	n_02 AI

WAIT 15
PIC_FLASH	%9 1 2 40  aa:#000000
UIP_EVENT_SETFADE cuts_in_stomach !PROG1
UIP_PTCST ui_sinhv
#SNDINTV '' heartbeat 70 24
CLEARTL
WAIT 30

MSG	n_03 T


WAIT 15
UIP_PTCST ui_in_stomach_splash // じゅ〜
TL 35 UIP_PTCST ui_in_stomach_splash // じゅ〜
UIP_EVENT_SETFADE cuts_in_stomach !PROG0
PIC_FLASH	%9 3 5 20   ab:#C27474
PIC_FLASH	%10 40 205 500   55:#C27474
@_VO_SPOT mouth_fin Noel
UIP_PTCST ui_sinhv
MSG	n_04 A

DOTL

PIC_FADEOUT %10 20
UIP_PTCST ui_in_stomach_splash // じゅ〜
TL 22 UIP_PTCST ui_in_stomach_splash // じゅ〜
PIC_FLASH	%9 3 5 50  ff:#C27474
TL 22 PIC_FLASH	%9 3 5 50  ff:#C27474

// PIC_MOVEA #1 70 SIN_V2
@_VO_SPOT_R laying_s 8 40 Noel
UIP_PTCST ui_sinhv

MSG	n_05 T

WAIT 15

UIP_PTCST ui_in_stomach_splash // じゅ〜
#SNDINTV '' absorb_eat_stomach_low 75 
#CLEARSND '' insect_rape  
#CLEARSND '' absorb_licked  
#SNDINTV '' absorb_licked 38 24
UIP_EVENT_SETFADE cuts_in_stomach !PROG0|PROG1
UIP_PTCST ui_sinh
PIC_FLASH	%9 3 5 50  ff:#C27474
@_VO_SPOT mouth_fin Noel
MSG	n_06 AI

@_VO_SPOT_R mouthl 8 40 Noel
PIC_FLASH	%9 1 2 30  aa:#000000
UIP_PTCST ui_sinhv
MSG	n_07 TI

PIC_FLASH	%9 1 2 14  66:#000000
UIP_PTCST ui_sinv
MSG	n_08 TI

UIP_PTCST ui_in_stomach_splash // じゅ〜

PIC_FLASH	%9 15 30 84  bb:#000000
PIC_FLASH	%10 3 5 33  aa:#C27474
UIP_PTCST ui_sinhv
// PIC_MOVEA #1 30 SCARY
// TL 25 PIC_MOVEA #1 70 SIN_V2

UIP_EVENT_SETFADE cuts_in_stomach !PROG2
MSG	n_09 TI

DOTL 
WAIT 19

UIP_PTCST ui_in_stomach_splash // じゅ〜
SND absorb_eat_stomach

PIC_FLASH	%9 3 5 50  ff:#C27474
UIP_PTCST ui_hs
MSG	n_10 TI

WAIT 25

PIC_FLASH	%9 1 2 14  66:#000000
TL 14 PIC_FLASH	%10 3 5 50  ff:#C27474
UIP_PTCST ui_sinv
// PIC_MOVEA #1 140 SIN_V
DOTL

SND absorb_eat_stomach
UIP_EVENT_SETFADE cuts_in_stomach !PROG0|PROG1

UIP_PTCST_REMOVE ui_in_stomach_1
UIP_PTCST ui_in_stomach_2
CLEARTL
@_VO_SPOT_R sxx_mouth 20 75 Noel 
MSG	n_11 TI

WAIT 30
SND absorb_eat_stomach
PIC_FLASH	%9 1 2 30  66:#000000
UIP_PTCST ui_sinhv
// PIC_MOVEA #1 60 SIN_V

UIP_EVENT_SETFADE cuts_in_stomach !PROG0|PROG2
MSG	n_12 TI

WAIT 20
PIC_FLASH	%9 1 2 30  36:#000000
// PIC_MOVEA #1 140 SIN_V

MSG	n_13 TI

WAIT 30

UIP_PTCST ui_in_stomach_splash // じゅ〜
SND absorb_eat_stomach
PIC_FLASH	%9 3 5 90  77:#C27474
PIC_FLASH	%10 1 2 80  66:#000000
UIP_EVENT_SETFADE cuts_in_stomach !PROG0|PROG1
CLEARTL
WAIT 8
MSG	n_14 TI

WAIT 30
SND absorb_eat_stomach
PIC_FLASH	%9 1 2 50  66:#000000

UIP_EVENT_SETFADE cuts_in_stomach !PROG0|PROG2
UIP_PTCST ui_hs
WAIT 8
// TL 40 PIC_FADEOUT #1 120
MSG	n_15 T

DOTL
WAIT 20
WAIT_BUTTON	 
CLEARTL
#CLEARSND
UIP_PTCST_REMOVE ui_in_stomach_2