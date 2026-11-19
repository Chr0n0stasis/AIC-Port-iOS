IFDEF _calced_bench_sf_level {
    _result=1
    SEEK_END
}

_calced_bench_sf_level=1

// 1: SF を加算する場合 true
// 2: SF key
IFNDEF 1
    1=1

IFNDEF 2 {
    DEFINE_NEXT_EV _nextev
    _sf_evt_key=EV_$_nextev
} ELSE {
    _sf_evt_key=$2
}
_v=~SF[$_sf_evt_key]
_result=1
IF $_v'>0' {
    IF $_v'>4' 
        _v=4

    IF 'rand[1000]>=(1000/(0.5+'$_v'))' {
        _result=0
    }
}

IF $_result'&&'$1 {
    SF_SET $_sf_evt_key '+=1'
}