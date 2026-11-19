DOTL 
_mapto=$1

_goaim=$2
_result=1
@___city/_warp 1
IF $_result==0 {
    SEEK_END
}
#< % >
PR_KEY_SIMULATE	R 0 
PR_KEY_SIMULATE	L 0 
WAIT 20
#MS_ % 'P[stand_ev~]'
START_LETTERBOX


SELECTARRAY_CLEAR
SELECTARRAY &&Select_back_to_guild GUILD 
SELECTARRAY &&Cancel CANCEL C
SELECT_FOCUS	0
SELECT -1


LABEL GUILD

#MS_ % 'q'
CHANGE_EVENT2 ___city/_warp_zx_execute 

LABEL CANCEL

