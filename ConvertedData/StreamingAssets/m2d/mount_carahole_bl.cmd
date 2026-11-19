_do_bright=1
IF 'PVV<215' {
    
    IF 'GFC[OST1]<=2&&quest_progress_f[p200_elec_facil]<4' {
        /* ___ ostrea ___ */
        {   

            %SIZE 12 68
            %PXL sub_s
            %SP_SHIFT 0 9
            %PT Ev_ostrea
            IF 'GFC[OST1]==0' {
                %POSE confuse
                %LIGHT 13:#ffffff 10
                _do_bright=0
            } ELSE {
                %POSE stand
            }
            %PHY
            %AIM R
            talk = 200/42_ostrea_cannon ostrea_cover
        }
        IF 'GFC[OST1]==0' {
            %DEFINE_ON_POINT Ev_ostrea_cover
            /* ___ ostrea_cover ___ */
            {

                stand = {
                    #CALL ostrea talk
                }
            }
            %DEFINE_ON_POINT 
        }
        %DEFINE_ON_POINT Ev_LT
        /* ___ Ev_LT ___ */
        {
            %LIGHT 10:#ffffff 100
        }
        %DEFINE_ON_POINT 

    }
}


/* ___ bright ___ */
{
    trigger_a = {
        #< Cannon_0_Mv0 >
        #LIGHT 45:#ffffff 340 50
        IF '!SF[M2D_LP_BRK_Breakable_carahole_bl_ostrea1]' {
            #< Breakable_carahole_bl_ostrea1-hit >
            #LIGHT 45:#ffffff 340 50
        }
    }   
    IF $_do_bright {
        load_once = {
            #CALL bright trigger_a
        }
    }
}
