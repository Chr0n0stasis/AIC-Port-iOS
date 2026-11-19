// evt/___Sample/Adder.cmd
VALOTIZE 0
_sample_a=~-10--14
TALKER	n  L  
PIC   n a_3/a2__F1__f3__m1__b4_uo    

HKDS	n RT '' TT

MTL MSG_SKIPHOLD
MSG n_<<<EOM
Let\'s do math.
EOM;

// '
　DEFINENDEF v1=10
NUMCOUNTER 0 999 $v1
    v1=$_result

MTL MSG_SKIPHOLD
MSG n_<<<EOM
the content of v1 is <C1>$v1 <C0>.
what is the next <C1>v2<C0>?
EOM;

DEFINENDEF v2=3
NUMCOUNTER 0 999 $v2
v2=$_result
HKDS	n '' '' ''

    _add=~$v1+$v2
MSG n_<<<EOM
'$v1' = $v1 。
\$v2 = $v2 。
The added result is $_add。
EOM;