GREETING	L 20
#MS_ $1 '@#[%::40]'

HKDS	mb CRT #<$1>
HKDS	n LT #<%>  
TALKER_REPLACE	mb Army  talk_mob_w1 

 

WAIT 20

IF 'GFC[MOB0]==0' {
    GFC_SET MOB0 1

    MSG mb_00
    MSG n_00
    MSG mb_01
} ELSE {

    MSG mb_02
    
}
