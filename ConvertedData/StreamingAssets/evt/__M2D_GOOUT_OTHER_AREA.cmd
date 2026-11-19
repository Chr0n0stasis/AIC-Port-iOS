// このイベントは Tranfer イベント内において
// 一番はじめに実行される。
// 外出を許可しない場合は _result=1 を与える。
// 現在のWHOLEKEY は $1 
__cur_wm=$1
__dep_wm=$2
IFSTR $__dep_wm ISNOT 'house' {
    IFSTR $__cur_wm IS 'house' {
        IF '5<=PVV && PVV<100' {
            _result=0
            CHANGE_EVENT2	s01_1c
        }
        GOTO PVV0
    }
    IF 'PVV<100' {
        _result=0
        CHANGE_EVENT2	s01_1c
    }
    LABEL PVV0
}
IFSTR $__cur_wm IS 'forest' {
    IFSTR $__dep_wm IS 'city' {
        IF 'PVV<105' {
            _result=0
            IF 'PVV==104&&GFC[IXA1]>0' {
               CHANGE_EVENT2 m2d_forest_2city
            }
            SEEK_END
        } ELSE {
            IF 'wplmode' {
            _result=0
                SEEK_END
            }
        }
    }
}

IFSTR $__cur_wm IS 'city' {
    IFSTR $__dep_wm IS 'mount' {
        IF 'PVV<200' {
            _result=0
            CHANGE_EVENT2 107/_stop_goto_mount_before_pvv115 n_00
            SEEK_END
        }
    }
}
