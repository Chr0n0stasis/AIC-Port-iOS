GREETING	L 20


DEFINENDEF 1=
_mkey=$1



WAIT 20
HKDS	mb CRT '#<'$2'>' // 右
HKDS	n  LT #<%> 
TALKER_REPLACE	mb Mob  talk_mob_w11

#MS_ $2 '@#[%::60]'


IF $_mkey'==0' {

    // ちゃらそうなお姉さん

    MSG	mb_00 


    MSG	mb_01 


    MSG	mb_02 


    MSG	n_03 


    MSG	mb_04 I

    TALKER	n   L
    
HKDS	n    

PIC   n a_3/a2__F1__f3__m5__b1_u0    
PIC_MP	n SWT2|BLS

    MSG	n_05 

} ELSE {
    MSG	mb_10

}
