// 喋れないときは 1
DEFINENDEF 1=0
__no_talk=$1
DEFINENDEF _total_eat=0
_tflag=
IF $__no_talk {
    _tflag='S'
}
SELECTARRAY_CLEAR
SELECT_FOCUS_RANDOM_TALK barten

_evt_header=___city_bar/_barten_tm_
_cockquest_flag=~quest_progress_f[subquest_mount_cocktail]
IF $_cockquest_flag'>=1' {
    _already=~SfEvt[___city_bar/_barten_tm_not_takeout]
    SELECTARRAY &&Select_talk_more_not_takeout 'not_takeout' $_tflag $_already
    IF $_cockquest_flag'>=4' {
        _already=~SfEvt[___city_bar/_barten_tm_about_walross]
        SELECTARRAY &&Select_talk_more_about_walross 'about_walross' $_tflag $_already
    }
}

_already=~SfEvt[___city_bar/_barten_tm_about_td]
SELECTARRAY &&Select_talk_more_about_td 'about_td' $_tflag $_already
IF $_already'&&GFC[BRTU]>=8' {
    _already=~SfEvt[___city_bar/_barten_tm_about_td2]
    SELECTARRAY &&Select_talk_more_about_td2 'about_td2' $_tflag $_already
}

IF 'GFC[BRTU]>=8' { // 貯蔵庫を見た
    _already=~SfEvt[___city_bar/_barten_tm_you_are_monster]
    SELECTARRAY &&Select_talk_more_you_are_monster 'you_are_monster' $_tflag $_already

} ELSE {
    _already=~SfEvt[___city_bar/_barten_tm_password]
    SELECTARRAY &&Select_talk_more_password 'password' $_tflag $_already
}
IF 'GFC[FHM0]>0' {
    _already=~SfEvt[___city_bar/_barten_tm_mount_friend]
    SELECTARRAY &&Select_talk_more_mount_friend 'mount_friend' $_tflag $_already
}
// IF $_cockquest_flag'>=4' {
//     _already=~SfEvt[___city_bar/_barten_tm_not_takeout]
//     SELECTARRAY &&Select_talk_more_not_takeout 'not_takeout' $_tflag $_already
// }

IF $_total_eat'>0' {
    _already=~SfEvt[___city_bar/_barten_tm_about_food]
    SELECTARRAY &&Select_talk_more_about_food 'about_food' $_tflag $_already
}

    
IF '!'$__no_talk {
    SELECT_POS CCB
     SELECTARRAY &&Select_back_to_takeout &&Select_back_to_takeout C
     SELECTARRAY &&Select_retry_arbeit_talking &&Select_retry_arbeit_talking C
     SELECTARRAY &&Select_quit_arbeit_talking &&Select_quit_arbeit_talking C
} ELSE {
    SELECTARRAY &&Cancel &&Cancel C
}

SELECT -1 _result
