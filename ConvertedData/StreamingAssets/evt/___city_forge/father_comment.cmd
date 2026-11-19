// 1:comment 
// 2:backcamera target
DEFINENDEF 1=
DEFINENDEF 2=%

MSG_PREFIX ff '<s3>' 
HKDS	ff LT #<smith> TT
TALKER_REPLACE	ff Blacksmith talk_mob_m1
DENY_SKIP
TL 20 STOP_BGM 120

IFDEF _focusto {
    #< $_focusto
    #TTT_TEMP_HIDE
}


#< smith >
#TTT_TEMP_HIDE
#PTCST_PREFIX _nosnd 0
#MS '## W20 P[sit_awake]'

WAIT 100
DOTL

IFSTR $1 ISNOT '' {
    ALLOW_SKIP
    MSG $1
    WAIT 40
    DENY_SKIP
    START_BGM 80

} ELSE {
    WAIT 130
    DENY_SKIP
    TL 50 START_BGM 80
}

#MS 'P[sit_awake2hammer]'
ALLOW_SKIP
#MS_ $2 '##'
WAIT 30

DOTL 
