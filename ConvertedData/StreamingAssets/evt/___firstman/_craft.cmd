GREETING	L -10

IF 'ItemHas[Recipe_fishrod]==0' {
    CHANGE_EVENT2	___firstman/t_craft0
    
    // GETITEM fishrod 1 0
    // GETITEM mtr_fishpond_feed 5 0


    GETITEM Recipe_fishrod 1 0
    GETITEM Recipe_mtr_fishpond_feed 1 0
}   
////////////////
WAIT 5
<LOAD>
WAIT 10
ALCHEMY_FISH alchemy_cutin/f_laevi
