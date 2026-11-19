// 1: ノエルの発言ネーム
// 2: 尻時間

DEFINENDEF 1=
DEFINENDEF 2=170

PE ZOOM2 1
WAIT 50

#MS_ % '#; @R ^ -G >>[Ev_window 10,0] P[kabesiri_out_0] w70 P[kabesiri_out_1] w'$2

WAIT_MOVE

SND garage_sneaking_pong
IFSTR $1 ISNOT '' {
    HKDS	n RT #<%>  
    MSG $1 C
}
#MS_ % '## P[kabesiri_out_2] _ +G <<[0.025,0.05 :4:40] F snd[pr_down] P[kabesiri_out_3]'

TL 30 #NO_DECLINE_AREA_CAMERA
TL 110 MSG_HIDE	  

WAIT_MOVE
@_VO_SPOT ev_hit_ground Noel

WAIT 50
ALLOW_SKIP
WAIT_BUTTON

