DEFINENDEF 1=
_CANCELCMD=$1

// <BREAK>

IFSTR $_CANCELCMD IS 'IXIA' {
    TALKER	i R 
    TALKER	 n L    
    
    
    PIC   i i/a00L1R2__F1__f1__m1__b1_u3    
    PIC_MP	i QUE  
    PIC   n a_3/a2__F1__f3__m1__b1_u0    

    
    MSG  i_00
    PIC   n a_3/a2__F1__f3__m1__b1_uo    
    PIC_MP n TTT
    MSG  n_01
    PIC   i i/a00L3R3__F1__f1__m1__b5_u2    
    PIC_MOVEA	i 1 JUMP 

    MSG i_02
} ELSIFSTR $_CANCELCMD IS 'ALMA' {
    TALKER	l R
    TALKER	 n L    

    PIC   l l1/a0L2R1__F1__m1__b5_ua    
    PIC_MP l TTT
    PIC   n a_1/a22__F1__f1__m1__b1__u0    
 // 普通 アルマ
    MSG	l_10  
PIC   n a_2/a0L2R3__F2__f2__m1__b5_u0    
PIC_MP n SWT2
PIC_MOVEA n 7 SHAKE

    MSG	n_11 

} ELSIFSTR $_CANCELCMD IS 'PRIMULA' {

    TALKER p L
    TALKER	 n R
    PIC   p p/a11__F1__m2__b2_u0    
    // プリムラ配置 汎用
    PIC   n a_1/a22__F1__f1__m1__b1__u0    

    MSG	p_30 

    PIC   n a_2/a0L1R3__F2__f2__m1__b5_u2    
    MSG	n_31 


} ELSIFSTR $_CANCELCMD IS 'TIGRINA' {
    // 普通 ティグリナ
    
    TALKER so L
    TALKER	 n R
    PIC   so so1/a0L4R2__F1__f1__m8__b1_u1    
    PIC_MP so KIR
    TL 20 PIC_MOVEA	so 20 SCARY
    
    PIC   n a_1/a22__F1__f1__m1__b1__u0    
    MSG	so_40 

DOTL
    PIC   n a_3/a0__F1__f3__m1__b4_u5    
    MSG	n_41  T


} ELSIFSTR $_CANCELCMD IS 'NO_CC' {
    TALKER so L
    TALKER	 n R
    PIC   so so2/a0L1R1__F2__f2__m1__e1_u2    
    // 特殊状況: 誰も人員を配置しない
    PIC   n a_2/a0L2R1__F2__f2__m1__b5_u2    
    PIC_MP n SWT
    MSG	so_200 

} ELSIFSTR $_CANCELCMD IS 'IXIA_CANNON' {

    TALKER	i L
    TALKER	 n R    
    PIC   i i/a00L1R1__F1__f1__m1__b5_u4    
    PIC_MP i SMK
    PIC   n a_1/a22__F1__f1__m1__b1__u0    

    // 特殊状況: イクシャを砲兵に置いた
    MSG	i_210 

    PIC   n a_3/a0__F1__f3__m1__b4_u0    
    PIC_MP n TTT


    MSG	n_211 
    PIC   i i/a00L5R3__F2__f2__m3__b1_u0    
    @_TSUKKOMI i
    PIC_MOVEA	i  1 JUMP
    

    MSG	i_212  I

} ELSIFSTR $_CANCELCMD IS 'ALMA_HEALER' {
    LABEL _ALMA_HEALER
    TALKER	l L
    TALKER	 n R
    PIC   l l1/a0L3R2__F1__m1__b5_u1    
    PIC_MP l SMK
    // 特殊状況: アルマを救護兵に置いた
    PIC   n a_3/a2__F1__f3__m1__b1_u0    
    MSG	l_222 

    PIC   n a_1/a00L1R1__F1__f1__m1__b2__u1    

    MSG	n_223 

    PIC   l l1/a0L3R1__F1__m1__b8_u1        
    MSG	l_224 
    PIC   n a_2/a0L1R3__F2__f2__m1__b5_u0    
    PIC_MP n QUE

    MSG	n_225 

    PIC   l l1/a0L2R2__F1__m1__b3_u2    
    PIC_MOVEA	l  3 SHAKE

    MSG	l_226 

    IFSTR $_CANCELCMD IS 'ALMA_HEALER_I' {
        TALKER	 l CLL
        TALKER	 i LL
        PIC   i i/a00L1R2__F1__f1__m1__b3_u2    
        PIC_MP i PLE
        MSG	i_227 


        PIC   n a_3/a2__F1__f3__m8__b1_u2    
        PIC_MP n SWT
        MSG	n_228  T
        
    }

} ELSIFSTR $_CANCELCMD IS 'ALMA_HEALER_I' {
    GOTO _ALMA_HEALER
}
