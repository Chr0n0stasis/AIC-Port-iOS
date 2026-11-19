// 成功

// 1, 1..帰還実行

SNEAKINGMG STOPNPC
DEFINENDEF 1=0
_depmap=school_in_garage
_success=1

#< % >
DENY_SKIP
IF $1'==0' {
    PIC_FILL	#9 DARK
    PIC_FADEIN	#9 60
    PR_KEY_SIMULATE L
    WAIT 80
    PR_KEY_SIMULATE L 0
    WAIT 40
    STOP_GMAIN

    IF 'GFC[TIG0]!=2' GOTO FAIL

    HKDS	n R @ROUT
    ALLOW_SKIP
    
    IF 'ItemHas[precious_memorychip]==0' {
        MSG n_00
        _depmap=school_garage_right
        _success=0
    } ELSE {
        HKDS	mb CLT @L
        TALKER_REPLACE	mb Army talk_mob_w3
        
        MSG mb_100
        MSG n_101
        MSG mb_102
        WAIT 60
    }
} ELSE {
    PIC_FILL	#9 DARK
    PIC_FADEIN	#9 60
    WAIT 120
    LABEL FAIL
    IF 'GFC[TIG0]!=2' {
        _depmap=school_garage_right
        _success=0
    }
}
START_GMAIN
INIT_MAP_MATERIAL $_depmap 1
HIDE_BLURSC 1
WAIT_FN MAP_TRANSFER
NEL_MAP_TRANSFER $_depmap R !Ev_L
#CMDRELOAD	IMMEDIATE IMMEDIATE_LOAD

WAIT 2
#< % >
PIC_FADEOUT	#9 80

HKDS	n    


IF $_success {
    IF 'GFC[TIG0]<3' {
        GFC_SET TIG0 3
        GFC_SET TIG1 0 
        GFC_SET TIG2 0 
    }
    IF 'ItemHas[precious_memorychip]>0' {
        REMITEM precious_memorychip 99 -1 Alert_item_reduced_memorychip_success  
    }
    // #CALL Ev_smnc_center load_once

} ELSE {
    #MS '@R >+[80,0 :120]'
    WAIT_MOVE
}

