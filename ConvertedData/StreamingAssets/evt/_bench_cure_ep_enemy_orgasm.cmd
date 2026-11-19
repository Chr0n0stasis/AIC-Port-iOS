IFNDEF 1
    1=0
_on_sitdown=$1 // ベンチに座った時点での強制実行なら 1

DEF_MOBTYPE _mobtype
IFSTR $_mobtype IS '' {
    IF nightingale_here {
        _mobtype=_other
    }
}

IFSTR $_mobtype ISNOT '' {
    CHANGE_EVENT _bench_cure_ep_mob
}

IF $_on_sitdown {
    IF '!SerHas[SHAMED_EP]||sensitive_level>0' {
        SEEK_END
    }
    @_bench_check_sf_level 0
    IF '!'$_result {
        SEEK_END
    }
}

BENCH_UIPIC_SLIDE
_bench_auto_decline=1 // 他のベンチイベントに接続しない
DENY_SKIP
TL 60 ALLOW_SKIP
MSG b00 K[L]
DOTL
CHANGE_EVENT2 _bench_cure_ep_base $_on_sitdown  _bench_cure_ep_enemy_orgasm_success _bench_cure_ep_enemy_orgasm_failure