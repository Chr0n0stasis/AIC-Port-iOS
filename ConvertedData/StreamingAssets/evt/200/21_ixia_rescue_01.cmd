#VANISH
IF '(GFC[IXA1]&8)!=0' {
    SEEK_END
}

#< % >

_lpx=~lp_foc_x[Summon_mount_cave_honey0]
_prx=~m2d_current_x
#MS_ citycaster_sub_i '##'
IF $_lpx'>'$_prx {
    // 左から
    GFC_SET IXA2 1
    #MS 'P[run] >>[Summon_mount_cave_honey0.Lb 40,0 <<0.12] P[guard] '
    TALKER	n L
    
} ELSE {
    GFC_SET IXA2 2
    #MS 'P[run] >>[Summon_mount_cave_honey0.Rb -40,0 <<0.12] P[guard] '
    TALKER	n R
    
}
HKDS	i CRT #<citycaster_sub_i> 

MSG i_00


PIC   n a_3/a2__F1__f3__m1__b2_u3    
PIC_MP n SWT2
MSG n_01

SUMMONER_ACTIVATE mount_cave_honey0
#MS  '##'
#< citycaster_sub_i >  

CITYCASTER_HP_CURE_ON_WAKEUP 200
