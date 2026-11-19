DEFINENDEF 1=40
// $2 102から #6#7 を削除
PIC_FILL #10 DARK
PIC_FADEIN #10 $1
WAIT $1

IF $2 {
    PIC_HIDE #6 1
    PIC_HIDE #7 1
}
HIDE_BLURSC 1
TALKER	n L    
TALKER	a R   

#MS_ alice 'q ##' 
#MS_ % 'q P[crouch~] >>[Ev_alice -60,0] @R'
PIC_FADEOUT #10 60
IF 'GFC[ALC1]&1==0' {
    // not spark
    CHANGE_EVENT 200/104_spider_waiting
} ELSE {
    CHANGE_EVENT 200/105_shinebooster
}
