switch(state){
	default:
		reset_variables()
		if state != states.DEAD and player_controlled == true
		{
			aim_weapon()
			get_input()
			movement()
			check_fire()
			pick_weapon()
		}
		if path_index != -1
		{
			var next_x = path_get_x(path, path_position + 0.01)
			var next_y = path_get_y(path, path_position + 0.01)
			
			var _direction = point_direction(x, y, next_x, next_y)
			if _direction <= 90 or _direction >= 270
			{
				facing = 1
			}
			else
			{
				facing = -1
			}
		}
		if player_controlled == false and path_position == 1
		{
			player_controlled = true
			mask_index = sprite_player_idle
		}
		if leftrightmovement != 0 or updownmovement != 0 and state != states.DEAD{
			state = states.MOVE
		}
		else{
			state = states.IDLE
		}
		anim()
	break;
	case states.DEAD:
		instance_destroy()
}