// 杖を買いたい
<LOAD_EMOJI>


#MS_ % 'q w130 @L P[stand_ev~=0]'

@___city_forge/father_comment ___city_forge/t_buy00*ff_00  $_focusto

#MS_ % 'q w30 @R P[stand_ev~=0]'


MSG	fd_01 


MSG	fd_02 


MSG	fd_03 


MSG	fd_04 


// バイト募集の張り紙。おじさん構文というか絵文字で覆い尽くされている。
WAIT 20

#MS_ % 'q >>[Ev_board.b 40,0 <<0.06] P[stand_ev~=0]'

WAIT 40

TX_BOARD ___city_forge/board_recruit*board_recruit FRAMED_PAPER
WAIT 50

HKDS	n    

TALKER	n R  

#MS_ % '@R ! >+[20,0 :50] ? P[stand_ev~=0]'

PIC   n a_3/a0__F1__f3__m1__b4_u0    
PIC_MP  n   SWT|QUE
MSG	n_05 
PIC_HIDE_ALL	 


CHANGE_EVENT2	___city_forge/t_buy01
