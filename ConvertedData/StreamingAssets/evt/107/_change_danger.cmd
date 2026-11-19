DEFINENDEF 1=0 
// 1.IMMEDIATE
IF 'PVV==107' {
        // TD
    IF '(GFC[IXA1]&8)==8' {
        _do_not_change_night=1
        DANGER 0
        DANGER_MANUAL 1 $1
    } ELSIF '(GFC[IXA1]&4)==4' {
        _do_not_change_night=1
        DANGER 0
        DANGER_MANUAL 0.5 $1
    }
}
