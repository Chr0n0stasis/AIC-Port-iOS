<NOLOAD>
IF '!MagicHas[PR_BURST]&&wplmode' {
    _result=0
    GREETING	 L 40
    <LOAD>
    TALKER	n L  
    PIC   n a_1/a22__F1__f1__m1__b2__u1    
    PIC_MP n TTT
    
    MSG n_00
    WAIT_MOVE
}
