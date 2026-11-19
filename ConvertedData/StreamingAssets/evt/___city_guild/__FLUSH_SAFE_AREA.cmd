// 1: pre area
// 2: new area
// 3: newArea is safe (1/0)
_new_is_safe=$3
IFSTR $2 IS city {
    // to 街
    IF '(GFC[GLD0]&3)==2' {
        // ギルドの依頼を進行中である
        IF 'guildquest_progressing[city]' {
            GFC_SET GLD0 |=4
        }
    } 
} ELSIFSTR $1 IS city {
    // 外に出る
    IF '!'$_new_is_safe'&&(GFC[GLD0]&4)!=0' {
        // ギルドの依頼を進行中である
        GQ_FLUSH_ITEMCOLLECT city
        GFC_SET GLD0 &=11
    } 
}