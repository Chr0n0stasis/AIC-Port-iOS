

GREETING L 50
#MS_ Firstman '## w30 P[wait~] @L'


WAIT 70
<LOAD>
WAIT 30

PIC   fh P0/a0L1R1__F1__m1    
PIC   n a_3/a0__F1__f3__m1__b1_uo    
PIC_MP	n QUE  


MSG	n_00 


PIC   fh P0/a0L1R2__F2__m1    
MSG	fh_01 V 
PIC_HIDE_ALL	 

#MS_ firstrod 'w20 ##'
TL 20 
WAIT 40
PE ZOOM2 60 

HKDS	n RT #<%>
#MS_ % 'w35 @L ! >+[10,0 :45] ? P[stand_ev~]'

MSG	n_02 
HKDS	n       
DOTL 
SELECTARRAY_CLEAR
IF 'ItemAddable[fishrod]==0' {
    SELECTARRAY  &&Select_getit GETIT S
    SELECTARRAY  &&Select_getit_enough GETIT_ENOUGH
} ELSE {
    SELECTARRAY  &&Select_getit GETIT
}

SELECTARRAY  &&Select_abort ABORT C
SELECT -1

//================================================
LABEL ABORT
// 受け取らない
WAIT 15
#MS_ % '= ## ! @R >+[-50,0:35] ? P[guard]'
PIC   n a_2/a0L1R3__F2__f2__m1__b1_u2    
PIC   fh P0/a0L1R1__F1__m1    

MSG	n_10 

PIC   fh P0/a0L1R1__F1__m1_3    
MSG	fh_11 V

SEEK_END
//================================================
LABEL GETIT_ENOUGH
// 受け取るが荷物がいっぱい
WAIT 15
#MS_ % '=  ## ! @R >+[-30,0:40] ? P[guard]'
PIC   fh P0/a0L1R1__F1__m1    

PIC   n a_1/a00L1R3__F1__f1__m1__b2__uo    
PIC_MP n SWT2
MSG	n_20 

PIC   fh P1/a0L1R1__F2__m2    
MSG	fh_21 V

PIC   n a_2/a0L1R3__F2__f2__m1__b5_u2    
PIC_MP n QUE

MSG	n_22  T

SEEK_END

//================================================
LABEL GETIT
WAIT 15

#MS_ % '= >+[-20,0 :25] @BL P[collect] ## w50'
WAIT_MOVE
GETITEM fishrod 1
#MS_ firstrod 'PTC[get_drop_item]'
#VANISH firstrod

#MS_ % 'w25 P[crouch2stand~]:40 @R >+[30,0 :45] P[stand_ev~]'
WAIT 45
FISBGM fis1 1 350

PIC   fh P0/a0L2R1__F1__m1_2    
PIC   n a_3/a2__F1__f3__m1__b4_uo    
MSG	fh_50 V


PIC   n a_1/a22__F1__f1__m1__b1__u0    

MSG	n_51  T

PIC   n a_2/a0L1R3__F2__f2__m1__b4_u2    
PIC_MP n SWT

MSG	n_52 

PIC   fh P1/a0L1R1__F2__m4    
MSG	fh_53 V

PIC   n a_3/a0__F1__f3__m1__b4_u0    
PIC_MP n QUE
MSG	n_54 T



GFC_SET FHM1 0
GFC_SET_MX FHM0 1
GFB_SET FISHING_ENABLED 1


SELECT 2
&&Select_fishing_tutorial _FISHTUTO 
&&Select_no_fishing_tutorial _DOIT C

// ========================
LABEL _DOIT
PIC   n a_3/a2__F1__f3__m8__b1_u0    
PIC_MP n KIR
MSG	n_60 

PIC   fh P1/a0L1R1__F2__m3    
PIC_MP fh TTT
// お手本を見ない
MSG	fh_61 V


GOTO _ENDIF
// ========================
LABEL _FISHTUTO
PIC_HIDE_ALL	 
GFC_SET MOV9 0
PE ZOOM2 -1
CHANGE_EVENT2	___firstman/_fishing_tutorial

#MS_ % '>>[Ev_first -50,0]'

// ========================
LABEL _ENDIF
PIC_HIDE_ALL	 

#CMDRELOAD	IMMEDIATE IMMEDIATE_LOAD

#MS_ % '## #; ? @L >>[Ev_FishChair.b 60,0 <<0.08] '

WAIT_MOVE

