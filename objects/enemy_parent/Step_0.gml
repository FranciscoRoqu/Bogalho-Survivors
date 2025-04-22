switch(state){
	case enemy_state.inactive:
		sprite_index = sprite_idle
		break;
	case enemy_state.active:
		sprite_index = sprite_walk
	    // Handle pathfinding timer
	    if (repath_timer <= 0) {
	        // Clear old path and calculate new one
	        path_clear_points(path);
	        
	        // Offset target to prevent path staleness
	        var target_x = bogalho.x + random_range(-16, 16);
	        var target_y = bogalho.y + random_range(-16, 16);
	        
	        // Calculate new path
	        if mp_grid_path(global.grid, path, x, y, target_x, target_y, true) {
	            path_start(path, move_speed, path_action_restart, true);
	            repath_timer = repath_interval;  // Reset timer
	            show_debug_message("Path recalculated!");
	        } else {
	            // Fallback to direct movement
	            move_towards_point(target_x, target_y, move_speed);
	            repath_timer = 15;  // Retry sooner if path failed
	        }
	    } else {
	        repath_timer--;  // Decrement timer
	    }
	    
	    update_facing();
	break;
	case enemy_state.staggered:
		path_end()
	    if knockback_duration > 0 {
	        // Apply knockback velocity
	        var kb_speed = knockback_force * (knockback_duration / 15);
	        hspeed = lengthdir_x(kb_speed, knockback_direction);
	        vspeed = lengthdir_y(kb_speed, knockback_direction);
	        
	        // Maintain facing direction
	        update_facing();
			collision();
	        
	        knockback_duration--;
	    }
	    else {
	        // Return to normal state
	        state = enemy_state.active;
	        current_speed = move_speed;
	        repath_timer = 0; // Force path refresh
	    }
	break;
	case enemy_state.dead:
	sprite_index = sprite_dead
	path_end()
	
}