// ノエルが危険な状態
MSG	ro_00 

MSG_HOLD
SELECT 2
&&Select_cure_by_rounin CURE
&&Select_nothanks NOTHANKS C


// ========================================================================
//受けない
LABEL NOTHANKS
MSG	ro_10 


_result=0
SEEK_END

// ========================================================================
LABEL CURE
//受ける
MSG_HIDE
_result=1
PIC_FILL #9 DARK
PIC_FADEIN #9 50
WAIT 90
ROUNIN PROGRESS_TIPS_TSUNAGI  

HKDS	ro  CCLCB '=' 

CHANGE_EVENT2 ___Rounin/t_tsunagi
HKDS	ro  CCRT '=' 
WAIT 50
BENCH_CMD_EXECUTE_O cure_hp_simple '' 1
PR_CURE 0 -1 1 0 2 0
PIC_FADEOUT #9 70
WAIT 50
MSG	ro_01 


