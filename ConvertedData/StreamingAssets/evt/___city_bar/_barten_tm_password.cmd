SF_EVT_SET
// 貯蔵庫のパスワードは？
PIC   bt P0/a0L2R2__F1__e2    
PIC_MP bt QUE
MSG	bt_00 

PIC   bt P0/a0L1R4__F2__e2    
MSG	bt_01 R[bt_01_b]
// 別ワードがログに出力

TUTO_MSG Tuto_backlog
TUTO_TEMP_FRONT
TUTO_POS C T

WAIT 24
