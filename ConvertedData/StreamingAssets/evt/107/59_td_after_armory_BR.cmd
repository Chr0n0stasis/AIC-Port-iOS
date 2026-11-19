DEFINENDEF 1=_
_LP=$1
#< % 

TALKER	n L   
PIC   n a_3/a0__F1__f3__m1__b4_u0    

IFSTR $_LP CONTAINS 'BR' {
    #MS 'F >>['$_LP' -70,0 <<0.07] >+[-120,0 <<0.07] P[stand_ev~] '
} ELSIFSTR $_LP CONTAINS 'BL' {
    #MS 'F >>['$_LP' 70,0 <<0.07] >+[120,0 <<0.07] P[stand_ev~] '
} ELSE {
    #MS 'F'
}

MSG n_00
PIC   n a_1/a22__F1__f1__m1__b2__u0    
PIC_MP n TTT
MSG n_01

DOTL
PIC_HIDE_ALL	 
DENY_SKIP

WAIT_MOVE

IFSTR $_LP IS '_' {
    IF 'm2d_current_y<36' {

        PR_KEY_SIMULATE B 
        WAIT 50
        #MS 'F'
        WAIT_MOVE
    }

}
