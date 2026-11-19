PIC_HIDE_ALL	 
// 釣りミニゲーム
// 1:pond_key
// 2:Lp
// 3:aim
IFNDEF 1
    DEF_CURMAP 1 
IFNDEF 2
    2=Ev_FishChair
IFNDEF 3
    3=R
_movelast=-60
_pond_key=$1
IFSTR $3 IS L
    _movelast=60

#< % > 
_mv_pond=FisMain-$_pond_key 
PIC_FILL #9 DARK
PIC_FADEIN	#9 55
#MS '>>['$2'.b :60 ]'

WAIT 60
#NO_DECLINE_AREA_CAMERA
#MS 'q >>['$2'.b] @'$3
#MS_ $_mv_pond '## #;'
FISHPOND $_pond_key FINE_CANE_APPEARANCE 1
PIC_FADEOUT	#9 50

WAIT 30
IF 0 {
    LABEL _TRYAGAIN
    // #MS 'P[interact]'
}
FISHPOND $_pond_key LUREINIT
IFSTR $_pond_key IS 'mount_house' {
    IFSTR $_fish_mgm_activated ISNOT '' {
        // ミニゲームが開始された
        IFSTR $_cought_fish IS '' {
            // 魚が釣れなかった
            
            GFC_SET MOB8 +=1
            IF 'GFC[MOB8]==2&&total_mgm_fis_success<10&& GFC[MOB18]==0' {
                _tryagain=0
                GFC_SET MOB18 1
                // 連続失敗
                CHANGE_EVENT2	___firstman/t_fishing_need_listen
                
            }
        } ELSE {
            GFC_SET MOB8 0
        }
    }
}

IF $_tryagain {
    GOTO _TRYAGAIN
}
DENY_SKIP
WAIT 15
ALLOW_SKIP
PIC_FILL #9 DARK
PIC_FADEIN	#9 55

WAIT 60
FISHPOND $_pond_key FINE_CANE_APPEARANCE 0
#DECLINE_AREA_CAMERA


#MS '## #; >+[-30,0] P[walk~] >+['$_movelast',0:80] '
PIC_FADEOUT	#9 50
WAIT 50
