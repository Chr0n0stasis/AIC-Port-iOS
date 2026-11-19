// 1:bath enable
// 2:toilet enable
// 3:background path
VALOTIZE 1
#SND_LOAD ev_restroom
TALKER nb R
IF $1==$2 {
    _top_type=TOP_BT
} ELSIF $1 {
    _top_type=TOP_B
} ELSE {
    _top_type=TOP_T
}
IFNDEF __restroom_oshigama
    __restroom_oshigama=-1

IFNDEF 3
    _bgpath=
ELSE 
    _bgpath=$3

DEF_CURMAP __map

// 初期処理
START_LETTERBOX
HALF_BGM	1
#< % >
HKDS	nb L @R
HKDS	n L @R

// <BREAK>
<NOLOAD>
_lt=60
IFSTR $_bgpath IS '' {
    SHOW_BLURSC
    _lt=30
} ELSE {
    <LOAD>
    @___Other/still $_bgpath
    PIC_TFADE	#1 DOOR_OPEN
    PIC_FADEIN	#0 30
}
UI_FRONTLOG 1
<LOAD>
WAIT $_lt

#MS_ % '='
SND cloth_off

_first_command=
__super_pee=0


IF $__restroom_oshigama'!=0' {
    __img_h1=toilet_action2/h1
    IF 'noel_wetten' {
        __img_h1=toilet_action2/h1d
    }
    IF 'sensitive_level>=2' {
        PIC %0 toilet_action2/h0 h
        PIC_MOVE2 %0  P,P-140 -14,28 40 ZSIN
        PIC_FADEIN %0 50
        TL 50 PIC_MOVEA	%0 2 SHAKE
        TL 50 SND prko_s

        WAIT_BUTTON 70 
        SND cloth_off_1
        DOTL
        TL 60 PIC_MOVEA	%0 95 DANCE
        WAIT_BUTTON 150 
        DOTL
        PIC_FADEOUT %0 60

    } ELSIF '!SerHas[NEAR_PEE]' {
        IF '!noel_torned' {
            PIC %0 toilet_action2/h0 h
        } ELSE {
            PIC %0 toilet_action2/h0b h

        }
        PIC_MOVE2 %0  P,P-40 274,78 40 ZSIN
        PIC_FADEIN %0 50
        TL 50 PIC_MOVEA	%0 15 SHAKE
        TL 50 SND prko_s

        WAIT_BUTTON 70 
        SND cloth_off_1
        DOTL
        TL 20 PIC_MOVE	%0  D+0,D+40 50 ZSINV
        TL 20 PIC_FADEOUT %0 50
        WAIT 10 

        PIC %1 $__img_h1 h
        PIC_MOVE2 %1  P,P+250 0,130 80 ZSIN2
        PIC_FADEIN %1 50
        TL 80 PIC_MOVE	%1  D+0,D-320 130 ZPOW

        WAIT_BUTTON 150 
        DOTL
        PIC_FADEOUT %1 60


    } ELSE {
        // 強制おし
        PIC %1 $__img_h1 h
        PIC_MOVE2 %1  P,P+60 0,130 30 ZSIN2
        PIC_FADEIN %1 10
        PIC_MOVEA	%1 20 SCARY
        HKDS	nb B @TT TT
        MSG ___House/_restroom_oshigama_in_success*nb_01
        PIC_FADEOUT %1 25
        WAIT 20
        _first_command=pee

        IF $__restroom_oshigama'==2'
            __super_pee=2
        ELSE 
            __super_pee=1
    }

}
HKDS	nb L @R ''
PIC %2 toilet_action/toilet
PIC_MOVE2 %2  P,P+160 140,0 55 ZSIN
PIC_FADEIN %2 30

@___House/_restroom_picture_def
PIC_MOVE2 nb  P,P+160 140,0 55 ZSIN
PIC_FADEIN nb 30

IFSTR $_first_command ISNOT '' {
    BENCH_CMD_EXECUTE_O $_first_command
    _result=$_first_command
    _first_command=
    _result_cmd=1
    GOTO COMMAND_EXECUTED
}
IF $__restroom_oshigama'==0' {
    // トイレ前でおもらししちゃった
    #MS_ % 'P[stand_ev~~]'
   CHANGE_EVENT2 ___House/_restroom_oshigama_in_failure
    WAIT 20

}

// ======================== REPEAT

WAIT 40
IF 0 {
    LABEL FAST_TOILET_REVERT
    DOTL
    PIC %2 toilet_action/toilet
    PIC_MOVE2 %2  P,P+160 140,0 40 ZSIN
    PIC_FADEIN %2 44

    @___House/_restroom_picture_def
    PIC_MOVE2 nb  P,P+160 140,0 40 ZSIN
    PIC_FADEIN nb 44

    IF $__super_pee'==0' WAIT 20
}
IF 0 {
    LABEL FAST_TOILET_POS_REVERT
    PIC_MOVE %2  C+140,C+0 60 ZSIN
    PIC_MOVE nb  C+140,C+0  60 ZSIN
    IF $__super_pee'==0' WAIT 20
}
IF 0 {
    LABEL FAST_TOILET_PIC_REVERT
    @___House/_restroom_picture_def
    WAIT 20
}
LABEL MENU_TOP
IF $__super_pee'>=1' {
    #MS_ % 'P[stand_ev~~]'
    PIC   nb a_toilet/a0__F1__m2__ua    
    PIC_MP nb BLS|SWT|HOT
    IF $__super_pee'>=2' {
        WAIT 20
        CHANGE_EVENT2 ___House/_restroom_oshigama_in_success
    }
    WAIT 20
}

__super_pee=0
DOTL

ALLOW_SKIP
_result=0

@___House/_restroom_deactivate_check 0
UI_RESTROOM_MENU $_top_type
LABEL COMMAND_EXECUTED


IFSTR $_result IS '0' {
    // quit
    GOTO QUIT
}

IFSTR $_result STARTS 'pee' {
    // _result_cmd: 何かを出すことができたら 1 以上
    IF 'SENSITIVE' {
        PIC_FADEOUT	nb 20
        PIC_FADEOUT	%2 20

        
        __fadetime=20
        __waittime=180
        IF 'sensitive_level>=2' {
            WAIT 15
            PIC &0 toilet_action2/h2 h
            __super_pee=0
        } ELSIF $__super_pee {
            PIC_FADEOUT	nb 0
            PIC_FADEOUT	%2 0
            WAIT 15
            IF $_result_cmd'!=0' SND restroom_pee_power
            __fadetime=10
            PIC &0 toilet_action2/h3 h
            __waittime=260
        } ELSE {
            WAIT 15
            IF $_result_cmd'!=0' SND restroom_pee
            PIC &0 toilet_action2/h2 h
        }
        PIC_MOVE2 &0  P,P-30 C,C $__fadetime ZSIN
        IF $__super_pee {
            PIC_MOVEA &0 10 SCARY
            TL 5 PIC_FLASH	&9  1 5 20 66:#F3D382
            TL 55 PIC_FLASH	&9  1 5 20 66:#F3D382
            TL 50 PIC_MOVEA &0 10 SCARY
        } ELSE 
            PIC_FADEIN &0 $__fadetime
        WAIT_BUTTON $__waittime
        IF $_result_cmd'!=0' {
            SND restroom_flush
            TL 30 PR_VOICE after_pee
        }
        DOTL
        PIC_FADEOUT &0 40
        
        GOTO FAST_TOILET_REVERT
    } ELSE {
        __fadetime=40
        
        IF $__super_pee {
            __fadetime=15
            PIC   nb a_toilet/a0__F1__m6_u1    
        } ELSIF 'noel_torned' {
           PIC   nb a_toilet/a0B__F1__m3__u2    
           PIC_MP	nb BLS
        } ELSE {
            PIC   nb a_toilet/a0__F1__m3__u1    
        }
        PIC_MV	nb D+180,D $__fadetime ZSIN
        PIC_MV	%2 D+180,D $__fadetime ZSIN
        WAIT 15

        PIC &0 toilet_action2/h3_bg
        PIC_MOVE &0 C-220,0 0
        PIC_FADEIN &0 25
        PIC &1 toilet_action2/h3_noel h
        PIC_MOVE &1 C-220,0 0
        PIC_FADEIN &1 25
        IF $_result_cmd'!=0' {
            __pee_img=toilet_action2/h3_pee
            __snd_name=restroom_pee
            __fadetime=20
            __waittime=140
            IF $__super_pee'==0' {
                WAIT 30
            } ELSE {
                __snd_name=restroom_pee_power
                __fadetime=5
                __pee_img=toilet_action2/h3_pee_power
                __waittime=230
                TL 21 PIC_MOVEA &1 25 SCARY
                TL 21 PIC_MOVEA &3 25 SCARY
                TL 21 PIC_FLASH	&9  1 5 20 66:#F3D382
                
                TL 70 PIC_MOVEA &1 18 SCARY
                TL 70 PIC_MOVEA &3 18 SCARY
                TL 75 PIC_FLASH	&9  1 5 20 66:#F3D382
                
            }
            TL 20 SND $__snd_name
            TL 20 PIC &3 $__pee_img h
            TL 20 PIC_MOVE &3 C-220,0 0
            TL 20 PIC_FADEIN &3 $__fadetime
            TL 140 PIC_FADEOUT &3 20
            WAIT_BUTTON 140
            DOTL
            SND restroom_flush
            TL 20 PR_VOICE after_pee
            WAIT_BUTTON
        } ELSE {
            WAIT_BUTTON
        }
        PIC_FADEOUT &0 20
        PIC_FADEOUT &1 20
        @___House/_restroom_picture_def
        GOTO FAST_TOILET_POS_REVERT
    }
}
IFSTR $_result STARTS 'shower' {
    PIC_MV	nb D-60,D 40 ZSIN
    PIC_MV	%2 D-50,D 40 ZSIN
    PIC_FADEOUT	nb 30
    PIC_FADEOUT	%2 30
    SND cloth_off_0
    WAIT 30
    TL 15 SND restroom_shower
    _scroll_time=240
    IF 'SENSITIVE' {
        PIC %0 toilet_action2/bath_sensitive h
    } ELSE {
        _scroll_time=400
        PIC %0 toilet_action2/bath_no_sensitive h
    }
    PIC_MOVE2 %0 P,C+360 C, C-320, $_scroll_time ZLINE
    PIC_FADEIN %0 35
    WAIT_BUTTON	$_scroll_time
    PIC_FINE %0 
    WAIT_BUTTON	-1
    PIC_MOVE %0 D,D-140, 60 ZLINE
    
    PIC_FADEOUT %0 60
    WAIT 35
    PIC_CLEAR_TERM_CACHE nb
    IFSTR $__map IS 'house_hall' {
        // PIC_HIDE_ALL	T 1 を忘れずに呼ぶこと
        IF 'GFB[PVV100_BATH]==0 && PVV>=100 && !SENSITIVE' {
        // HIDDEN_WHOLE_SCREEN 0
            CHANGE_EVENT	s10_3a
        }
    }
    GOTO FAST_TOILET_REVERT


}
IFSTR $_result IS 'restroom_cure_egged' {
    // 排卵
    _with_tool=0
    IF 'ItemHas[precious_egg_remover]&&sensitive_level==0' {
        WAIT 5
        SELECT 3 
        &&Bench_Cmd_restroom_cure_egged_no_tool  _EGG_WITHOUT_TOOL
        &&Bench_Cmd_restroom_cure_egged_tool _EGG_WITH_TOOL
        &&Cancel MENU_TOP C 
        // 道具使用 ==============
        LABEL _EGG_WITH_TOOL
        _with_tool=1
        PIC_FADEOUT	nb 40
        PIC_FADEOUT	%2 40
        CHANGE_EVENT2 _bench_cure_egged_00 0 1
        IF $_egg_canceled {
            GOTO _EGG_AFTER_CANCELED
        }   
        GOTO _EGG_AFTER
    }
    // 道具不使用 ==============
    LABEL _EGG_WITHOUT_TOOL
    PIC_MV	nb D+80,D 70 ZLINE
    PIC_MV	%2 D+80,D 70 ZLINE
    TL 30 PIC_FADEOUT	nb 40
    TL 30 PIC_FADEOUT	%2 40
    CHANGE_EVENT2 ___House/_restroom_cure_egg

    LABEL _EGG_AFTER
    BENCH_CMD_EXECUTE_O restroom_cure_egged
    PIC_CLEAR_TERM_CACHE nb
    LABEL _EGG_AFTER_CANCELED
    PIC_MV	nb D-80,D 70 ZSIN
    PIC_MV	%2 D-80,D 70 ZSIN
    PIC_FADEIN_SOFT	nb 40 1 
    PIC_FADEIN_SOFT	%2 40 1


    IF 'noel_torned' {
        PIC   nb a_toilet/a0B__F1__m4__ua2    
    } ELSE {
        PIC   nb a_toilet/a0__F1__m4__ua2    
    }
    PIC_MP nb SWT|BLS
    IF $_with_tool {
        WAIT 45
        ALLOW_SKIP
        GOTO MENU_TOP

    }
    WAIT 60
    PIC_MOVEA	nb 12 SCARY
    ALLOW_SKIP
    MSG n_lay_egg00
    WAIT 20
    GOTO MENU_TOP
}

GOTO MENU_TOP


LABEL         QUIT
// ========================================================
// MARK : 終了処理
// ========================================================

DOTL
DENY_SKIP
@___House/_restroom_deactivate_check 1
IF $_rslt'==0' {
    GOTO FAST_TOILET_PIC_REVERT
}
// HIDDEN_WHOLE_SCREEN 0

#MS_ % '='
PIC_HIDE_ALL	 
IFSTR $_bgpath IS ''
    HIDE_BLURSC
PIC_MOVE2 nb  P+420,P D,D 40 ZSIN
PIC_MOVE2 %2  P+420,P D,D 40 ZSIN
SEEK_END
