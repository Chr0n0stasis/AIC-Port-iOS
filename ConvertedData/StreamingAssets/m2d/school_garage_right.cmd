##USE_EVENT_VARCON## 
IF 'GFC[TIG0]==1&&quest_progress[p106_tigrina_armory]==1' {
    _tigrina__t01=1
}
IF 'GFC[TIG0]==2' {
    _tigrina__t01=2
}
IFDEF _tigrina__t01 {
    /* ___ tigrina ___ */
    {

        %SIZE 12 68
        %SP_SHIFT 0 10.5
        %PXL sub_so
        %PT Ev_L 145,0
        %POSE stand
        %PHY
        %AIM L
        talk = ___Tigrina/106sneak__init 1
        load_once = {
            IF '(GFC[TIG0])==2' {
                IF 'ItemHas[precious_memorychip]>0' {
                    CHANGE_EVENT	___Tigrina/106sneak__return_success 1

                } ELSIF '(GFC[TIG2]&12)==4' {
                    GFC_SET TIG2 12
                    CHANGE_EVENT	___Tigrina/106sneak__return_t01
                } ELSIF '(GFC[TIG2]&3)==1' {
                    GFC_SET TIG2 |=3
                    CHANGE_EVENT	___Tigrina/106sneak__return_t00
                } 

            } 
        }
    }
    /* ___ cam_elevator ___ */
    {
        
        %PT Ev_elevator
        trigger_a = {
            
        }
    }
}