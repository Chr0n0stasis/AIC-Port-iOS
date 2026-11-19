DEFINENDEF 1=0
_result=0

IF $1'==0' {
    IF 'PVV<=104' {
        _result=1
        SEEK_END
    }

    IF 'PVV==105' {
        IF 'GFC[IXA1]<4' {
            @105/scl_hall_stop_go_other_area
            _result=0 
            SEEK_END
        } ELSE {
            _result=1
            SEEK_END
        }
    }
    IF '(PVV==106 && ((GFC[TIG0]>=3&&GFC[TIG1]>=2 ) || GFC[TIG0]>=4) ) || PVV>=107' {
        
            _result=1
            SEEK_END
    }
}

TALKER	n R   
IF $1'==1' {
    GREETING	R 10
    #<
    #MS '@#[%::40]'
    
    WAIT 15
    TALKER	l L   
    PIC   n a_1/a22__F1__f1__m1__b1__u3    

    PIC   l l1/a0L2R1__F1__m1__b2_ua    
    MSG l_00

PIC   n a_1/a00L1R1__F1__f1__m1__b1__u1    
    MSG n_01


    PIC   l l1/a0L2R2__F1__m1__b3_ua2    
    PIC_MP	l HEA 
    
    MSG l_02

PIC   n a_3/a0__F1__f3__m1__b4_uo    
    MSG n_03
    PIC_HIDE_ALL	 
    
    WAIT 20
    #MS_ % '>+[40,0 :65] P[stand_ev~]'
} ELSE {

    GREETING	R -15
}
HKDS	n CRT #<%>  

MSG n_04

MSG n_05

IF '!(GFC[TIG0]>=3&&GFC[TIG1]>=2)' {
    QUEST_PROGRESS p106_grazia_goto_club 1
}
WAIT_MOVE
