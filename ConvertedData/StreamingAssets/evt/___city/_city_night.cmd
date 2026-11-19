// 1: immediate
DEFINENDEF 1=0

IF 'PVV==107' {

    IF '(GFC[IXA1]&8)==8' {
        DANGER_MANUAL 1 $1
    } ELSIF '(GFC[IXA1]&4)==4' {
        DANGER_MANUAL 0.5 $1
    } ELSE {
        DANGER_MANUAL 0 $1
    }
} ELSE {
    DANGER_MANUAL 0 $1
}
