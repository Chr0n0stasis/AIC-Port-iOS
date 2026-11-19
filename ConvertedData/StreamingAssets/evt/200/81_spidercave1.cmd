// アリスに気付く
IF 'PVV>=210' {
    #VANISH
    SEEK_END
}
IF 'PVV<210' {
    IF '(GFC[ALC1]&8)!=0' {
        #VANISH
        SEEK_END
    }
}
DEFINENDEF 1=Ev_alice
IFSTR $1 IS Ev_alice {
    #MS_ % '@L ! >>[Ev_alice.Rb -24,0 <<0.03] ? P[stand_ev~] @L '
} ELSE {
    GREETING	R 32
}
<LOAD_DWARF>
TALKER	a L
TALKER	n R   
TALKER_REPLACE	a  Mob 
IF 'ItemHas[precious_magicdevice200]>0' {
    CHANGE_EVENT	200/82_spidercave2
    SEEK_END
}
IF 'GFC[ALC3]&1==1' {
    // 既に話した
    PIC   a p3/a0L2R2__F1__e3__ua2    
    PIC   n a_2/a0L1R1__F2__f2__m1__b1_u2    
    TL 11 PIC_MOVEA	a 2 JUMP
    DOTL
    MSG a_20 A
    PIC   n a_1/a22__F1__f1__m3__b1_u0    
    PIC_MP n QUE
    MSG n_21


} ELSE {

    PE ZOOM2 60
    <LOAD>
    #MS_ alice '##'
    WAIT 20
    HKDS	a CLT #<alice>


    MSG a_01


    PIC_HIDE_ALL	 
    WAIT 40

    #MS_ alice 'P[crying]'
    HKDS	a 

    WAIT 25

    PIC   a p2/a1L1R1__F1__e2__u2    
    PIC_FINE a
    PIC_MOVE2 a P P-230 D D 80 ZSIN
    PIC_FADEIN a 60


    MSG a_04
    TALKER	a L

    WAIT 24
    #MS_ % '## P[interact]'


    WAIT 12
    PIC   n a_3/a0__F1__f3__m1__b4_uo    

    MSG n_06
    PIC   n a_2/a0L1R1__F2__f2__m1__b1_uo    
    PIC_MP	n SWT  


    MSG n_07
    PIC_HIDE_ALL	
    #MS_ alice '##'
    WAIT 20
    @_PIIN
    WAIT 20
    #MS_ alice ' @R ! P[feared_stop]  >+[-80,0 :60] ?'

    PIC   a p3/a0L2R2__F1__e2__ua2    
    PIC_MP a QUE|BLS
    MSG a_07 A
    MSG a_08

    PIC   n a_2/a0L1R1__F2__f2__m1__b1_u2    
    MSG n_08

    // -----
    // アリスは首を振り、床を指さす。端末はノエルの背後に落ちていた。
    // -----
    PIC   a p2/a1L2R1__F1__e2__u1    
    PIC_MP a SWT2
    //やぁ……！ あ、うしろ、うしろ見て！
    MSG	a_09 

    PIC_HIDE_ALL	 
    WAIT 20
    @_PIIN
    #MS_ alice '## P[ev_yubisasi]'

    HKDS	a RT #<alice>

    MSG	a_10 

    WAIT 40

    #MS_ % 'P[guard] ##'


    //アリス、指差し後退り。
    PIC   n a_3/a0__F1__f3__m1__b1_u2    
    MSG	n_10 

    PIC_HIDE_ALL	 
    GFC_SET ALC3 1
    #CMDRELOAD	IMMEDIATE IMMEDIATE_LOAD

    WAIT 30
    #MS_ drop_magicdevice  '##'

    WAIT 45

    HKDS	n LT #<%> 


    MSG	n_11  T


    MSG	n_12 
    HKDS	a
    // あるから、あるからぁ!
    PIC   a p1/a0L3R1__F1__e8__uia    
    PIC_MP a SWT2|BLS
    MSG	a_12 A



}
