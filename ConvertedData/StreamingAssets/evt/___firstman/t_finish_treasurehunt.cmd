
TALKER	n LL   
TALKER	fh RR
HKDS	n CLB
HKDS	fh CRB
   
PIC   fh P0/a0L1R1__F1__m1    
IFNDEF _treasurehunt_finish_pic {
    @___firstman/__header
    _treasurehunt_finish_pic=treasurehunt2/treasurehunt_000__5
}

PIC_SWIN  $_treasurehunt_finish_pic
PIC_MV %W X Y+100 30 ZSIN

IF 'GFC[TRS1]==0' {
    PIC   n a_1/a22__F1__f1__m1__b1__u1    
    MSG	n_00 

PIC   fh P0/a0L1R1__F1__m1_3    
MSG	fh_01 V


PIC   n a_3/a0__F1__f3__m1__b1_uo    
PIC_MOVEA	n 1 JUMP
@_PIIN
PIC_MP n EXC



MSG	n_02 I

PIC   fh P0/a0L1R2__F2__m2    
MSG	fh_03 V

    @___firstman/t_finish_treasurehunt_give
PIC   n a_1/a00L1R1__F1__f1__m1__b1__u1    
PIC   fh P0/a0L2R1__F1__m1    

MSG	n_50 

PIC   fh P0/a0L1R1__F1__m1    
MSG	fh_51 V

PIC   n a_2/a0L2R3__F2__f2__m1__b5_u2    
PIC_MP n TTT

MSG	n_52 



} ELSIF 'GFC[TRS1]==1' {
    PIC   n a_2/a0L1R3__F2__f2__m1__b5_uo    
    MSG	n_100 

PIC   fh P0/a0L1R1__F1__m1_2    
MSG	fh_101 V

PIC   n a_1/a22__F1__f1__m1__b2__u1    
MSG	n_102 

PIC   fh P0/a0L2R1__F1__m1_3    
MSG	fh_103 V

PIC   n a_3/a1__F1__f3__m1__b4_uo    
PIC_MP n QUE
MSG	n_104 T

PIC   fh P0/a0L1R2__F2__m2    
MSG	fh_105 V

    @___firstman/t_finish_treasurehunt_give
PIC   fh P0/a0L2R1__F1__m1    
PIC   n a_1/a22__F1__f1__m1__b2__u1    
PIC_MP n TTT
MSG	n_151 


} ELSIF 'GFC[TRS1]==2' {
    
PIC   n a_1/a00L1R3__F1__f1__m1__b2__u1    
    MSG	n_200 

PIC   fh P0/a0L1R1__F1__m1_3    
    MSG	fh_201 V

PIC   n a_2/a0L1R3__F2__f2__m1__b5_u2    
    MSG	n_202 

PIC   fh P0/a0L1R1__F2__m2    
    MSG	fh_203 V

PIC   n a_3/a0__F1__f3__m1__b1_uo    
PIC_MP n QUE
    MSG	n_204 

    @___firstman/t_finish_treasurehunt_give
    PIC   fh P0/a0L1R1__F1__m1_2    
    PIC   n a_3/a0__F1__f3__m1__b4_u0    
    MSG	fh_250 V

PIC   n a_1/a22__F1__f1__m1__b2__uo    
PIC_MP n HOT
    MSG	n_251 T

}

IFDEF _treasure_quest {

    // QUEST_FINISH $_treasure_quest
    SHOW_QUEST_PROGRESS 
}
