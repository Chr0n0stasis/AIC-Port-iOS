%DEFINE_ON_POINT books..Ev_book_0  
%SHADOW 40
%TALK_TARGET_TTT 
%DOD_CM_BEHIND_TOP


%DEFINE_ON_POINT books..Ev_book_10
/* ___ Ev_book_10 ___ */
{
    %CHECK_DESC EV_access_hvn_book_orthodoxy
    check = ___city_hvn/_book_portal ___city_hvn/book_orthodoxy*b00
}



%DEFINE_ON_POINT books..Ev_book_8
/* ___ Ev_book_8 ___ */
{
    %CHECK_DESC EV_access_hvn_book_cooking
    check = {
        CHANGE_EVENT2	 ___city_hvn/_book_portal ___city_hvn/book_cooking*b00
        WAIT 20
        TALKER	n L   
        PIC   n a_3/a0__F1__f3__m1__b3_u0    
        PIC_MP	n SWT|BSM
        MSG ___city_hvn/book_cooking*n_00 T
        
    }
}



%DEFINE_ON_POINT books..Ev_book_9
/* ___ Ev_book_9 ___ */
{
    %CHECK_DESC EV_access_hvn_book_elfbody
    check = ___city_hvn/_book_portal ___city_hvn/book_elfbody*b00
}



%DEFINE_ON_POINT books..Ev_book_6
/* ___ Ev_book_6 ___ */
{
    %CHECK_DESC EV_access_hvn_book_uv
    check = ___city_hvn/_book_portal ___city_hvn/book_uv*b00
}



%DEFINE_ON_POINT books..Ev_book_3
/* ___ Ev_book_3 ___ */
{
    %CHECK_DESC EV_access_hvn_book_demon
    check = ___city_hvn/_book_portal ___city_hvn/book_demon*b00
}




%DEFINE_ON_POINT books..Ev_book_4
/* ___ Ev_book_4 ___ */
{
    %CHECK_DESC EV_access_hvn_book_cane
    check = ___city_hvn/_book_portal ___city_hvn/book_cane*b00
}



%DEFINE_ON_POINT books..Ev_book_5
/* ___ Ev_book_5 ___ */
{
    %CHECK_DESC EV_access_hvn_book_abyss
    check = ___city_hvn/_book_portal ___city_hvn/book_abyss*b00
}







%DEFINE_ON_POINT books..Ev_book_0

/* ___ Ev_book_0 ___ */
{
    %CHECK_DESC EV_access_hvn_book_urasima
    check = ___city_hvn/_book_portal ___city_hvn/book_urasima*b00
}

%DEFINE_ON_POINT 



/* ___ mob00 ___ */
{
    
    %SIZE 12 68
    // %SP_SHIFT 0 3.5
    %MOBG	woman_elf_oneesan_hakui_1 stand
    %MOVE WALKAROUND_LR '' 0.2
    %PT Ev_RR 5,4
    %AIM L
    talk = ___city_hvn/library_elf_00 mob00 MOB0
}
