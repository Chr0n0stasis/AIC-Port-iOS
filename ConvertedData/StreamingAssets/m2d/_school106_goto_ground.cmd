// _pt 

_i=0
%DEFINE_ON_POINT   
LABEL _LOOP_GROUND
/* ___ mob$_i ___ */
IF $_i'==0' {
    %MOBG	woman_elf_thin_student stand
    %PT Ev_106_00 -447 4 1
} ELSIF $_i'==1' {
    %MOBG	woman_elf_thin_student_9 stand
    %PT Ev_106_00 -687 4 1
} ELSIF $_i'==2' {
    %MOBG	woman_elf_student_6 stand
    %PT Ev_106_00 -600 4 1
} ELSIF $_i'==3' {
    %MOBG	woman_elf_thin_student_sister_2 stand
    %PT Ev_106_00 -747 4 1
} ELSIF $_i'==4' {
    %MOBG	woman_elf_student_1 stand
    %PT Ev_106_00 -857 4 1
} ELSIF $_i'==5' {
    %MOBG	woman_elf_thin_student_sister_3 stand
    %PT Ev_106_00 -930 4 1
}
%MOBG_ATLAS_WH 200 220
load_once = {
    #< THIS >
    #MOBG_ANIM_SHOW_CANE
    _spd=~0.06+rand[100]/10000*3
    #MS '>+[300,0] P[walk] @R >+[ 1800,0 <<'$_spd']'
}


_i=~$_i+1
IF $_i'<6' {
    GOTO _LOOP_GROUND
}

/* ___ mobq ___ */
%MOBG	woman_elf_student_10 stand
%PT Ev_106_00 -600 4 1
%MOBG_ATLAS_WH 340 240

/* ___ alma ___ */
%SIZE 12 68
%PT Ev_106_00 -650 0 1
%PXL sub_l
%POSE stand
%SP_SHIFT 0 3.5
%AIM R

load_once = 106/00_alma_goto_ground
