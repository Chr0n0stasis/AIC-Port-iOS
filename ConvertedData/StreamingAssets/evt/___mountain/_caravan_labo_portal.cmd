DEFINENDEF 1=MOB4
_mkey=$1
_from=$2


HKDS	mb CLT '#<'$2'>' // 右
HKDS	n R  #<%> 
GREETING	R 30
TALKER_REPLACE	mb laboman  talk_mob_m0

#MS_ $_from '@#[%::60]'
WAIT 20

_evt=

IF 'GFC[OOP0]>=4' {
    _evt=___mountain/_caravan_labo_t_ooparts4
} ELSIF 'GFC[OOP0]==3' {
    _evt=___mountain/_caravan_labo_t_ooparts2
}

IFSTR $_evt IS '' {
    _evt=___mountain/_caravan_labo_t00
}

CHANGE_EVENT2	$_evt

IF 'GFC[OOP0]==2&&ItemHas[precious_ooparts]>0' {
    WAIT 25
    MTL MSG_SKIPHOLD
    MSG ___mountain/_caravan_labo_t_ooparts2*n_00 T
    SELECT 2 
    &&Select_send_ooparts _SEND_OOPARTS
    &&Select_stop_sitdown _END C

    LABEL _SEND_OOPARTS
    CHANGE_EVENT2	___mountain/_caravan_labo_t_ooparts2
} ELSIF 'GFC[OOP0]==3' {
    MSG_HOLD
    SELECT 2 
    &&Select_send_taco _SEND_TACO
    &&Select_stop_sitdown _END C
    LABEL _SEND_TACO // ================================================
    MSG_HIDE
    HIDE_LETTERBOX_A
    HIDE_STATUS
    _result=0
    // QUEST_REMOVE ooparts03 1
    // QUEST_PROGRESS ooparts03 0 H
    UI_ITEMCONFIRM_FOR_QUEST ooparts03 _send_dish_key
    <NOLOAD>
    SHOW_LETTERBOX_A
    IF $_result {
        _use_noeljuice=~DishIngredientHas[$_send_dish_key][mtr_noel_milk]
        _use_noeljuice=~$_use_noeljuice+DishIngredientHas[$_send_dish_key][mtr_elf_milk]
        _use_noeljuice=~$_use_noeljuice+DishIngredientHas[$_send_dish_key][mtr_noel_juice0]
        CHANGE_EVENT2	___mountain/_caravan_labo_t_ooparts4

    }
}

LABEL _END

MSG_HIDE
