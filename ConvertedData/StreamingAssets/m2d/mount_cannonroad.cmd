##USE_EVENT_VARCON## 
DEFINENDEF _200_31_aft_alma=0
IF $_200_31_aft_alma {

    /* ___ alma ___ */
    {

        %PXL sub_l
        %PHY
        %SIZE 12 68
        %POSE stand
        %SP_SHIFT 0 12.5
        %PT Ev_qa200_12_end.Lb 30,0
        talk = 200/32_escape12aft_alma
    }
} ELSIF 'quest_progress_f[p200_alice]<13' {
    /* ___ alma ___ */
    {

        %PXL_LOAD sub_l
        
    }
}
