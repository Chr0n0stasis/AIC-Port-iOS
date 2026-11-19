// PIC_MP2 %6 $_manpu_n ... が可能
<NOLOAD>
__noel_active=~drawer_shown[%6]
IF $1'<0' {
    IF $__noel_active {
        PIC_MOVE2 %6 C-380 C-120 L-40 C-120  20 ZSIN
        PIC_FADEOUT %6 15
        MSG_LEFT_DEFAULT 0.3
    }
    SEEK_END
}
<LOAD>
START_MANPU_FRONT_ON_W
MSG_LEFT_DEFAULT 0.1
PIC %6 'mgm_bun_noel/nl__'$1 
IF $__noel_active'==0' {
    PIC_MOVE2 %6 L-40 C-120 C-380 C-120 20 ZSIN
}
PIC_FADEIN %6 15
IF $1'>=20' {
    _manpu_n=noel2
} ELSIF $1'>=10' {
    _manpu_n=noel1
} ELSE {
    _manpu_n=noel0
}
HKDS	n CLT '>%6'


