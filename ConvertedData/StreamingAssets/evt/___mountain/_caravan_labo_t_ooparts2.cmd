HKDS	n RT  #<%> 
IF 'GFC[OOP0]<=2' {
    <LOAD>
    #SND_LOAD ev_mountain    
        // （考古学者の通常の会話のあと。
    MSG	n_01 


    MSG	mb_02 


    PIC_FILL #9 DARK
    PIC_FADEIN #9 40
    WAIT 50
    REMITEM precious_ooparts 1 -1 Alert_item_reduced_ooparts
    SND put_ooparts
    WAIT 20
    MSG	mb_03 


    MSG	n_04 

    MSG	mb_05 
    WAIT 40
    PIC_FADEOUT #9 40
    WAIT 60

    MSG	mb_06 


    MSG	mb_07 


    MSG	n_08 


    MSG	mb_09 


    MSG	n_10 


    MSG	mb_11 


    MSG	n_12 


    MSG	mb_13 


    MSG	n_14 


    MSG	mb_15 


    MSG	n_16 T

    GFC_SET OOP0 3
    QUEST_PROGRESS ooparts03 0
    TOUCHITEM Recipe_taco
} ELSE {
    <LOAD>
    MSG mb_30
//第一の人に会ってない場合
    IF '!GFB[FISHING_ENABLED]' {
        
    MSG	n_31


    MSG	mb_32
    }



}
