DENY_SKIP

 PIC_FILL &6 DARK
PIC_FADEIN	&6 60
WAIT 70
_total_time=170
_t=0
_t_vo=~5+rand[10]
_t_kuchu=~10+rand[20]
_t_flash=~10+rand[20]
SND insect_rape2
PIC_FILL #6 DARK
PIC_FADEOUT	&6 20
DOTL
LABEL _REP0
{
    IF $_t'>='$_t_vo {
        _t_vo=~$_t_vo+11+rand[20]
        PR_VOICE laying_s
    }
    IF $_t'>='$_t_kuchu {
        _t_kuchu=~$_t_kuchu+5+rand[10]
        SND absorb_guchu
    }
    IF $_t'>='$_t_flash {
        _t_flash=~$_t_flash+10+rand[45]
        IF 'rand[100]<60&&sensitive_level==0' {
            UIP_CUTIN_LAYEGG 0 0 1 0
            PIC_FLASH	&9 0 1 ~15+rand[20] 88:#FF5786
            PIC_FLASH	&10 0 1 ~35+rand[45] 30:#000000
            PIC_FLASH	&11 0 1 12 30:#000000
        } ELSE {
            PIC_FLASH	&9 0 1 ~3+rand[33] 55:#FF5786
        }

    }

}
IF $_t'<'$_total_time {
    _t=~$_t+3;
    WAIT 3
    GOTO _REP0
}
WAIT 15


PIC_FADEOUT	#6 90