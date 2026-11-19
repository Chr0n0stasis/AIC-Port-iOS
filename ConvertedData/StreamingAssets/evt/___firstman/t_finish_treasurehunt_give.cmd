HALF_BGM 1
PIC_HIDE_ALL	 
WAIT 10
PIC_FILL #9 DARK
PIC_FADEIN #9 65
WAIT 80
#MS_ ev_first 'snd[firstman_hikidasi]'
WAIT 220

#MS_ ev_first 'snd![firstman_hikidasi]'

PIC_FADEOUT #9 DARK
PIC_FADEOUT #9 80
WAIT 70

IF 'GFC[TRS1]==0' {
    GETITEM_BOX workbench_holder_itemreel
} ELSIF 'GFC[TRS1]==1' {
    GETITEM_BOX workbench_holder_bomb
}

HKDS	n   
HKDS	fh    
TALKER	n L   

TALKER	fh R   
IFDEF _treasure_quest {

    QUEST_FINISH $_treasure_quest
}
 
FISBGM_FINE_QUEST
WAIT_FN ITEMDESC
GFC_SET TRS1 +=1
HALF_BGM	0

WAIT 25
