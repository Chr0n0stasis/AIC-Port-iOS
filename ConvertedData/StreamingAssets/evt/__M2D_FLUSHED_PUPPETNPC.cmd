// _battle なら 1
IFNDEF 1
    _is_battle=1
ELSE 
    _is_battle=$1


IF $_is_battle {
        
    IF '(GFC[PUP2]&1)>0&& GFC[PUP_KILL]%2==0' {
        // 移動木偶 アイテムを購入 またはペナルティ緩和
        IF 'GFC[PUP_BUYR]>0' {
            IF 'GFC[PUP_BUYR]<=4  && ( (GFC[PUP2]&2)>0 || rand[100]<40 )' {
                GFC_SET PUP_BUYR ~GFC[PUP_BUYR]-1
            }
        } ELSE {
            IF '( (GFC[PUP2]&2)>0 )' {
                GFC_SET PUP0 ~GFC[PUP0]+1
            }
        }
        GFC_SET PUP2 ~GFC[PUP2]&12
    } ELSIF 'GFC[PUP_BUYR]>0&& GFC[PUP_BUYR]<4 &&rand[100]<15 ' {
        GFC_SET PUP_BUYR ~GFC[PUP_BUYR]-1
    }


    IF 'GFC[DFMT]>0&&rand[100]>=70' {
        GFC_SET   DFMT -=(rand[3]+1)
    }
    IF 'rand[100]>=60' {
        GFC_SET MST_NPC0 0
        GFC_SET CLT_NPC0 0
    }
    IF 'GFC[BRTU]>=8' {
        STOREFLUSH BarUnder    
    }
    GFC_SET GLD0 &=14
}
IF 'GFC[NIG0]==2' {
    GFC_SET_MX NIG1 15
}
IF '(GFC[COF2]&3)==3' {
    IF 'GFC[COF0]%2==1' GFC_SET COF0 +=1
    GFC_SET COF2 ~GFC[COF2]&12
}
GFC_SET TLD_N2 0
GFC_SET DJO0 &=14
GFC_SET RON2 0

MGM_FISH_FEED_FLUSH
// GFC_SET  TLD_N2 GFC[TLD_N2]&9

