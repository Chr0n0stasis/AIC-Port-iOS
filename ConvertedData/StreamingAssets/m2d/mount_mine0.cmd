// %DARK_ACTIVATE
_qp=~quest_progress_f[p200_alice]
IF $_qp'==16' {
    /* ___ quest16 ___ */
    {
        load_once = {
            #VANISH
            QUEST_PROGRESS p200_alice 17 H
        }
    }
}

_qp=~quest_progress_f[p200_alice_mine1] 
IF $_qp'>=0&&'$_qp'<=2' {
    /* ___ quest2 ___ */
    {
        load_once = {
            #VANISH
            QUEST_PROGRESS p200_alice_mine1 3
        }
    }
}
