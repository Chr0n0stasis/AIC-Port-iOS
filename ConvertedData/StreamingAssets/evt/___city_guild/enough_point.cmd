HKDS	n L  #<%> 

IF '!GFB[GUILD_HEAR_POINT]' {
    // GFB_SET GUILD_HEAR_POINT 1

    MSG	n_00 


    MSG	mb_01 


    MSG	n_02 


    MSG	mb_03 


    MSG	n_04 


    MSG	mb_05 


    MSG	n_06 


    MSG	mb_07 


    MSG	n_08 T

} ELSE {

    //再び話しかける

    MSG	n_21 


    MSG	mb_22 


    MSG	n_23 

HALF_BGM	1

PIC_FILL #8 DARK
PIC_FADEIN #8 50 
WAIT 60

HKDS	mb CLT '=' WIDE

    MSG	mb_24 

WAIT 40

HKDS	mb RT '=' 

    // 同一人物
    MSG	mb_25
    
    WAIT 15
    TL 20 HALF_BGM	0
    PIC_FADEOUT #8 70 

    WAIT 50


    HKDS	mb CCRT '=' 
    DOTL
    MSG	mb_26 



    MSG	n_28 

}
MSG_HIDE
WAIT 10
