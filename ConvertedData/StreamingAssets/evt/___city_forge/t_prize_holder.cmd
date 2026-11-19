DEFINENDEF 1=0
#MS_ % 'w40 P[stand_ev]'
IF 'quest_progress_f[city_forge_030]>=0'
    QUEST_FINISH  city_forge_030 

IF $1'==0' {

WAIT 30
// レベル5まで育てた報酬
MSG	fd_00 

} ELSE {
WAIT 15

    // ver0.30対応 (レベル5まで育てた杖を持って鍛冶屋に行ったとき)
    MSG	fd_00_2
}


MSG	fd_01 

TL 20 #MS_ % '= P[stand_ev=0] @L'
@___city_forge/father_comment ___city_forge/t_prize_holder*ff_02  $_focusto

DOTL
TL 20 #MS_ % 'P[stand_ev=0] @R'


MSG	fd_03 

GETITEM_BOX workbench_holder_cane 1 0
WAIT_FN ITEMDESC
PIC_HIDE_ALL	 

WAIT 25
DOTL
GFB_SET FORGE_GET_HOLDER 1
