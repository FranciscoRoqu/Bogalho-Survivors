switch(state){
	default:
		if player_controlled == true
		{
			reset_variables()
			if state != states.DEAD
			{
				aim_weapon()
				get_input()
				movement()
				check_fire()
				pick_weapon()
			}
			if leftrightmovement != 0 or updownmovement != 0 and state != states.DEAD{
				state = states.MOVE
			}
			else{
				state = states.IDLE
			}
			anim()
		}
		else
		{
			mask_index = -1
			state = states.MOVE
			if path_index != -1
			{
				var next_x = path_get_x(path, path_position + 0.01)
				var next_y = path_get_y(path, path_position + 0.01)
				
				var _direction = point_direction(x, y, next_x, next_y)
					aim_dir = _direction
					if(current_weapon != noone){
						current_weapon.image_angle = aim_dir
					}
				if _direction <= 90 or _direction >= 270
				{
					facing = 1
				}
				else
				{
					facing = -1
				}
			}
			if path_position == 1
			{
				player_controlled = true
				mp_grid_add_instances(global.grid, obj_solid, false)
			}
		}	
		break;
	case states.DEAD:
		sprite_index = sprite_player_dead
		break;
}