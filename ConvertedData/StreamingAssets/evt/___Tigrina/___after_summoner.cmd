// ガレージのバトル終了イベント
// _BAREA が定義されてます
IFNDEF _BAREA
    _BAREA=_
<NOLOAD>
STOP_LETTERBOX
WAIT 45
START_LETTERBOX
PIC_FILL	#9 DARK
PIC_FADEIN	#9 40
WAIT 50
SMNCREATOR POP_DANGER_LEVEL
MIST_CLEAR
@___Tigrina/_gameover_after 0

#MS_ % '>>[#<tigrina>] >+[-50,0] @R ## #;'
PIC_FADEOUT	#9 45

CHANGE_EVENT	___Tigrina/___portal
