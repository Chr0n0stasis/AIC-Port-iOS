

MSG mb_00
_cur_gq_level_v=~$_cur_gq_level+1
MSG mb_01 X[$_cur_gq_level_v]

IF $_cur_gq_level'>=1&&GFC[GLD_MAX_RANK]<1' {
    GFC_SET_MX GLD_MAX_RANK 1
    GETITEM_BOX oc_slot 1 0
    WAIT_FN ITEMDESC
    WAIT 20
} 

IF $_cur_gq_level'>=2&&GFC[GLD_MAX_RANK]<2' {
    GFC_SET_MX GLD_MAX_RANK 2
    IF 'SkillHas[smash]' {
        GETITEM_BOX lunchbox 1 0
    } ELSE {
        GETSKILL smash
    }
    WAIT_FN ITEMDESC
    WAIT 20
} 
IF $_cur_gq_level'>=3&&GFC[GLD_MAX_RANK]<3' {
    GFC_SET_MX GLD_MAX_RANK 3
    GETITEM_BOX enhancer_slot 1 0
    WAIT_FN ITEMDESC
    WAIT 20
} 
IF $_cur_gq_level'>=4&&GFC[GLD_MAX_RANK]<4' {
    GFC_SET_MX GLD_MAX_RANK 3
    GETITEM_BOX enhancer_slot 1 0
    WAIT_FN ITEMDESC
    WAIT 20
}
WAIT 25

IF $_cur_gq_level'<4' {
    MSG mb_02 
} ELSE {
    MSG mb_03
}