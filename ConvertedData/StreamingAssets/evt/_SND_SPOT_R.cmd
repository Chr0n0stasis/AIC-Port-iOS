//1 cue_name family
//2 repeat count
//3 interval
IFNDEF 3
    3=30
IFNDEF 2
    2=1

__wait=0
// ========================
LABEL _REP
TL $__wait SND	$1

2=~$2-1

IF $2'>0' {
    __wait=~$__wait+$3
    GOTO _REP
}
// ========================
