HKDS	n RT #<%>

IF 'GFC[OOP0]<4' {
    <LOAD>
    // もぐもぐ
    #SND_LOAD ev_mountain
    MSG	n_60 
    

    MSG	mb_61 
    PIC_HIDE_ALL	 
    
    WAIT 10
    LP_DEACTIVATE Effector_snd_robo
    PIC_FILL #0 DARK
    PIC_FADEIN	#0 45
    WAIT 60

    HKDS	mb C  @CLB 

    STOP_BGM	240 0
    LOAD_BGM BGM_piano_no_kakera
    SND mount_eat_taco
    MTL SND ping
    MTL PIC_FLASH	&9 0 6 4 ff:#EBEBEB
    MSG	mb_62 


    MSG	mb_63 I


    HKDS	mb C  @CLB WIDE
    REPLACE_BGM 30 50 0

    SND mount_eat_taco_jingle1 
    PIC_FLASH #9 0 6 24 ff:#EBEBEB
    TL 15 PIC_FLASH #9 0 6 34 88:#EBEBEB
    PIC_RADIATION #10 ff:#EBEBEB
    TL 50 PIC_FADEOUT #10
    MSG	mb_64 IA

    DOTL
    SND mount_eat_taco_jingle2
    MSG	mb_65 


    MSG	mb_66 

    MTL SND mount_eat_taco_tsukuten
    MTL PIC_FLASH	#10 0 6 14 ff:#EBEBEB
    MTL PIC_FLASH	#10 20 6 54 aa:#EBEBEB
    MSG	mb_67 
    WAIT 15
    PIC_FADEOUT #0 70

    HALF_BGM	1
    WAIT 55
    DEFINENDEF _use_noeljuice=0
    HKDS	mb   CLT '#<'$_from'>' 
    HKDS	 n    
    
TALKER	n R   


    IF $_use_noeljuice {
    // 生地の中にノエルジュースまたは毒水を使っている場合
        MSG	mb_68 
    
        PIC   n a_2/a0L2R3__F2__f2__m1__b2_u0    
        PIC_MP	n SWT|BLS

        MSG	n_69 
        PIC_HIDE_ALL	


        MSG	mb_70 
    } ELSE {
        PIC   n a_1/a22__F1__f1__m1__b1__u1    
    PIC_MP	n SWT2

        // 使ってない場合
        MSG	n_71 
        PIC_HIDE_ALL	 
        HKDS	n R  #<%> 
        

        MSG	mb_72 
        WAIT 25

        MSG	mb_73 
    }

    // ========================
    // タコス納品

    HKDS	mb C  @CLB WIDE
HKDS	n R  #<%> 
    
    WAIT 20
    PIC_FILL #0 DARK
    TL 15  PIC_FLASH	&9 0 6 4 aa:#EBEBEB
    TL 35  PIC_FLASH	&9 0 6 4 aa:#EBEBEB
    TL 68  PIC_FLASH	&9 0 6 40 aa:#EBEBEB
    DENY_SKIP
    SND mount_taco_curiosity
    DENY_EVENTHANDLE
    TL 90 ALLOW_EVENTHANDLE
    STOP_BGM 10 0
    MSG	mb_10 AI
    
    WAIT 40

    HKDS	mb   CLT '#<'$_from'>' 
    
    DOTL
    PIC_FADEOUT #0 100
    WAIT 92
    REPLACE_BGM 40 120 1
    HALF_BGM	0
    MSG	mb_11 


    MSG	n_12 


    MSG	mb_13 

    SND get_item
    REMITEM_NOANNOUNCE precious_ooparts 1 0
    GETITEM precious_ooparts 1 2

    MSG	mb_14 
    MSG	mb_14_2 


    MSG	n_15 

    WAIT 20

    MSG	n_16 T



    GFC_SET_MX OOP0 4
    QUEST_PROGRESS ooparts03 2
    LP_ACTIVATE Effector_snd_robo


} ELSE {
    <LOAD>
    MSG	mb_14_2 
    IF 'GFC[OOP0]<5' {

        WAIT 20

        MSG	n_16  T
    }
    
    MSG	mb_30 

}
