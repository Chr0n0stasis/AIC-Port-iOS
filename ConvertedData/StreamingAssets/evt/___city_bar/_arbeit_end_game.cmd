// 1  おもらし前なら1
// 2　total_eat
DEFINENDEF 1=0
DEFINENDEF 2=0
_go_toilet=$1
_total_eat=$2
SND minigame_quit
DENY_SKIP
MGM_BUN_DEACTIVATE_GAME_PREPARE
#< Barten > 
#MS '## P[bar_wash2stand~]'
#MS_ % 'w25 @#[Barten] P[stand]  '
TL 25 ALLOW_SKIP
HKDS	bt CRT #<Barten> 

IF '!'$_go_toilet {
    MSG bt_00
} ELSE {
    // おトイレ

    MTL MSG_SKIP
    MSG bt_10


    @___city_bar/_arbeit_noel_hkds 15

    PIC_MP2 %6 $_manpu_n BLS|BSM
     
    MSG n_11
    @___city_bar/_arbeit_noel_hkds -1
    TL 10 PIC_MOVEA	%6 14 SCARY
    
    CHANGE_EVENT2 ___city_bar/_arbeit_restroom 2
    PIC_HIDE_ALL	%&#T 1
    PIC_FILL &9 DARK
    GOTO _RESULT

}

WAIT 10
DOTL
PIC_FILL &9 DARK
PIC_FI &9 50
WAIT 60

LABEL _RESULT
DOTL
<LOAD>
DENY_SKIP
MGM_BUN_DEACTIVATE_GAME
WAIT 2
ALLOW_SKIP
WAIT 60
PIC_B	#8 bg/bg_bar_backyard '' bgcolor
PIC_FO &9 50
_mgm_bun=1

CHANGE_EVENT    ___city_bar/_arbeit_result 0
