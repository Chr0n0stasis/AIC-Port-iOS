_cnct=1
DEF_CURMAP _map
ROUNIN DEFINE_BATTLE_ACTIVE _battle_occured
IF 'GFC[RON0]==0&&!'$_battle_occured {
    MSG ro_00
    _cnct=0
} ELSE {
    IFSTR $_map IS 'house_center' {
        MSG ro_100
    } ELSIFSTR $_map IS 'mount_caravan_in_bar' {
        MSG ro_101
    } ELSIFSTR $_map IS 'city_in_bar' {
        MSG ro_102
    } ELSIF $_battle_occured {
         MSG ro_19
    } ELSIF 'GFC[RON0]==1' {
        MSG ro_02
        _cnct=0
    } ELSE {
        _r=~rand[4]+10
        MSG 'ro_'$_r
        _cnct=0
    }
}
