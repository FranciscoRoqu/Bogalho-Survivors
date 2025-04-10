switch(state) {
    default:
        // Only process controls if NOT transitioning
        if (!is_transitioning) {
            reset_variables();
            
            // Handle player input if alive
            if (state != states.DEAD) {
                aim_weapon();
                get_input();
                movement();
                check_fire();
                pick_weapon();
            }

            // Update movement state
            if ((leftrightmovement != 0 || updownmovement != 0) && state != states.DEAD) {
                state = states.MOVE;
            } else {
                state = states.IDLE;
            }

            // Always update animations
            anim();
        }
        break;

    case states.DEAD:
        sprite_index = sprite_player_dead;
        break;
}

// Emergency transition reset
if (is_transitioning && !global.is_transitioning) {
    is_transitioning = false;
    can_move = true;
}