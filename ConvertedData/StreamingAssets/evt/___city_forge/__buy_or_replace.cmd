// $1: bgm reload
DEFINENDEF 1=0
_bgm_rep=$1
IF $_bgm_rep {
    LOAD_BGM	BGM_title grazia
}

_forge_result=$_result

WAIT 10
SND city_forge_replace
#< smith >
#PTCST_PREFIX _nosnd 1 


#MS_ % '## >>[ExitD_forge.b -60,0]'
WAIT 350

_result=0
IFSTR $_forge_result IS 'BUY' {
    FORGE_BUY_CANE $_cane $_cane_grade 0
}
IFSTR $_forge_result IS 'REPLACE' {
    FORGE_REPLACE_CANE $_cane $_cane_grade $prev_cane $prev_cane_grade 0
}
    


PIC_FADEOUT #9 50

#MS_ % ' >+[100,0 :120]'

IF $_bgm_rep {
    TL 20 REPLACE_BGM	100     
} ELSE {
    TL 20 START_BGM	100 
}

IF $_result {
    WAIT 40
    GETITEM_BOX 'cane_'$_cane 1 $_cane_grade
    WAIT_FN ITEMDESC
}

#PTCST_PREFIX _nosnd 0

GFB_SET FITTING 0
ALLOW_FASTTRAVEL
FORGE_TESTFIRE_INIT

prev_cane!
prev_cane_grade!

IF $_cane_grade'>=4&&GFB[FORGE_GET_HOLDER]==0' {
    CHANGE_EVENT2 ___city_forge/t_prize_holder
}

WAIT_MOVE
DOTL
