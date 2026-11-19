_skip_result=0
SELECTARRAY_CLEAR
_skip_sel_default=-2
IF 'sensitive_level>=2' {
    _skip_sel_default=1
    SELECTARRAY &&Select_osioki_progress_sensitive 0 S
    SELECTARRAY &&Select_osioki_skip 1 C
} ELSIF 'sensitive_level>=1' {
    _skip_sel_default=-1
    SELECTARRAY &&Select_osioki_progress 0
    SELECTARRAY &&Select_osioki_skip 1 C
} ELSIF $1'>=3' {
    _skip_sel_default=1
    SELECTARRAY &&Select_osioki_progress 0
    SELECTARRAY &&Select_osioki_skip 1 C
} ELSE {
    SEEK_END
}

SELECT_FOCUS $_skip_sel_default
SELECT_POS CB
SELECT -1 _skip_result
IF $_skip_result {

}

