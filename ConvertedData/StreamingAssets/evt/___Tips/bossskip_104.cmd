
_bossskip=1

SCN_MANUAL_BGM_REPLACE ''
INIT_MAP_MATERIAL forest_nusi_coroseum 1
WAIT 2
WAIT_FN MAP_TRANSFER

NEL_MAP_TRANSFER forest_nusi_coroseum L !Ev_near_ixia


WAIT 5

#MS_ % '>>[Ev_pvv104_ixia.b -120,0] @L P[stand_ev=4]'
#MS_ ixia '>>[Ev_pvv104_ixia.b -40,0] @L P[weak]'

DENY_SKIP
SUMMONER_TYPE forest_nusi_coroseum NO_EFFECT NO_BORDER
SUMMONER_PROTECT_MANAPLANT  forest_nusi_coroseum
TL 15 PIC_FADEOUT #9 40
CHANGE_EVENT s13_4a
