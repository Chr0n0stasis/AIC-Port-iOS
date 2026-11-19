// 途中を省略してここまで来た人向け アリスとの会話
<LOAD_DWARF>

#< alice >

TALKER	n L   
TALKER_REPLACE	a  Mob 

HKDS	a #<alice>  #<alice> ONELINE
_dx=~lp_foc_x[Ev_qa200_12_jump1]
_dx0=~lp_foc_x[Ev_qa200_12_jump0]
_ax=~m2d_current_x
_mvx0=~($_dx0-$_ax)*28-40
_mvx=~($_dx-$_dx0)*28-54


#MS_ alice 'q ! P[sink2fear] >+[20,0 :15] >+[30,0 :40] ? P[crouch2stand] @R'
#MS_ alice 'P[run] >+['$_mvx0',0 <<0.14] <<[0.056,0 a0h36r20] P[jump] j[>>120:24:24] F P[run] >+['$_mvx',0 <<0.16] @L P[jump] w5 <<[-0.05,0 a20h20r20] j[>>140:30:30] P[fall] F'
#MS_ alice 'P[crouch] w4 <<[0.076,0 a5h50r10]  @R P[rolejump] j[>>160:38:38] F'
#MS_ alice 'P[crouch] w4 <<[-0.026,0 a5h20r10]  @L P[jump] j[>>160:38:38] P[fall] F'
#MS_ alice '@L P[walk] >>[Ev_qa200_12_end.Lb 4,0 <<0.09] P[stand2crouch]'
MSG a_01 L[180]C
MSG_HOLD

#< QA200_PUPPY >
ENEMY_ADD_TICKET NT_PUNCH2_200_12_ATTACK Breakable_mount_cannonroad_200 200/31_escape12aft 130 Ev_qa200_12_cover
