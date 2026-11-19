// 1: flags
// 2: 失敗放尿なら1
// 3: playvo
// 4: _flags
DEFINENDEF 1=''
DEFINENDEF 2=0
DEFINENDEF 3=1
DEFINENDEF 4=
_playvo=$3
_omorashi_flags=$4
IFSTR $1 ISNOT '' {
    1='|'$1
}  
UIP_EVENT_SETFADE  cuts_peeremove PROG0|PROG1$1 1 1
UIP_SYNC_CUTIN 320,-520,1.76  -270 300 1.6 T 40

IF $2 {
    // 失敗
    IFSTR $_omorashi_flags IS '' {
        _omorashi_flags=FPBCN
    }
    PR_OMORASHI $_omorashi_flags
    SND pee_long
    UIP_PTCST ui_excrete_juice_hokahoka '_delay=10.2;_count=30;_saf=150;'

    
} ELSE {
    // 成功
    IFSTR $_omorashi_flags IS '' {
        _omorashi_flags=J
    }
    SND pee_bench_glass

    PR_OMORASHI $_omorashi_flags PEE 1
    

}
IF $_playvo  PR_VOICE split_manual Noel
UIP_PTCST ui_excrete_juice_splash '_fail='$2



PR_CURE 0 0 0 0 0 200
PIC_FLASH	&9 1 8 34 99:#E9E9BD
UIP_PTCST ui_sinv
UIP_PTCST ui_hs


HKDS	n LB @C TT
// UIGM RELEASE_TAB_CACHE STAT
