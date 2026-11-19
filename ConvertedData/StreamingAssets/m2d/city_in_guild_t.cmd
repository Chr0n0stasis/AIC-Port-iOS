

%DEFINE_ON_POINT Ev..Ev_pot_L
  
/* ___ alchemy_pot ___ */
{

    %CHECK_DESC EV_access_alchemy
    check = ___city_guild/_portal_alchemy_guild
}

%DEFINE_ON_POINT Ev_workbench

/* ___ alchemy_workbench ___ */
{
    %CHECK_DESC EV_access_workbench
    check = ___Laevi/alchemy_workbench
    IF '!GFB[ALCHEMY_RECIPE]' {
        %SET_ENABLE check 0
    }

}


%DEFINE_ON_POINT   




/* ___ woman_elf_pocha_1 ___ */
{
    %SIZE 12 78
    %MOBG	woman_elf_pocha_1 stand colvari_1
    %PT	Ev_pot_R.b -20 0
    %AIM R
}

%TARGET_MAP _city_in_guild_kitchen
%DEFINE_ON_POINT 
{
    /* ___ woman_bst_cook_1 ___ */
    %SIZE 12 78
    %MOBG	woman_bst_cook_1 stand colvari_1
    %PT Ev_pot_BL 0 4
    %AIM RL
    %MOVE WALKAROUND_LR '' 0.6 0.04
}
