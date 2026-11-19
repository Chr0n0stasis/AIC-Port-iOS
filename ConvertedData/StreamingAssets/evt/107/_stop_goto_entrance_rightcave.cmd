// 1: call from LP
<LOAD>

START_LETTERBOX

DEFINENDEF 1=

_called_lp=$1
IF 'PVV==107' {

    _result=0
    TALKER	n L   
    IFSTR $_called_lp ISNOT '' {
        #MS_ % '>>['$_called_lp'.Lb -40,0 <<0.08] @R P[stand_ev~]'
    }

    PIC   n a_1/a22__F1__f1__m1__b2__uo    
    MSG n_00

    PIC   n a_3/a2__F1__f3__m1__b1_uo    
    MSG n_01

    PIC_HIDE n

    DENY_SKIP
    WAIT_MOVE

}
