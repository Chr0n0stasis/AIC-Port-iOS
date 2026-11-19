_bossskip=1
DENY_SKIP 
PR_CURE 1 1 1 1 1 1
INIT_MAP_MATERIAL mount_spider_coroseum 1
WAIT 2
_107_first=1
WAIT_FN MAP_TRANSFER

NEL_MAP_TRANSFER mount_spider_coroseum L !ExitL_toground
WAIT 2

ENGINE Alice200 RELEASE
GFC_SET ALC1 0
@200/qa23_load
CHANGE_EVENT 200/90_spider_after
