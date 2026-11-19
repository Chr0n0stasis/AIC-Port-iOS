MSG	mb_00 


MSG	mb_01 


MSG	mb_02 

MSG_HOLD

SELECT	2 
&&Select_guild_register REGISTER
&&Select_nothanks NOTHANKYOU
// ========================

LABEL NOTHANKYOU
_result=0
MSG	mb_03 


MSG	mb_04 

SEEK_END

// ========================
LABEL REGISTER
MSG_HIDE	  
#MS_ Noel 'snd[cloth_off] P[interact~] w70 ptcT[puzz_box_activate_once] w70 P[stand_ev~] '

WAIT 70
_result=1


MSG	mb_05 


MSG	mb_06 


MSG	mb_07 

GETITEM_BOX precious_guild_card 1 0
WAIT_FN ITEMDESC

WAIT 40

MSG mb_08

CHANGE_EVENT2	___city_guild/descryption


