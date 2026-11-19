//粗相をしてしまう
DENY_SKIP
HALF_BGM 1
_mgm_bun=1
MGM_BUN_DEACTIVATE_GAME_PREPARE
MGM_BUN_GAME_PAUSE
HKDS	n CB #<Noel>
PE ZOOM2 1
#MS_ % '##'

WAIT 20

MSG	n_00 T

MSG	n_01 T


_actihol=1
_omorashi_flags=PFSCBM
ALLOW_SKIP
EPSITU &&Log_bun_failed_omorashi
EPSITU_FLUSH
PE ZOOM2 40
TL 20 PE ZOOM2 -1
CHANGE_EVENT ___city/_omorashi bar

