switch(state){
	default:
		if current_weapon == noone{
			current_weapon = instance_create_layer(x,y, "Instances", obj_start_weapon)
		}
		reset_variables()
		if state != states.DEAD{
			aim_weapon()
			get_input()
			movement()
			check_fire()
		}
		if leftrightmovement != 0 or updownmovement != 0 and state != states.DEAD{
			state = states.MOVE
		}
		else{
			state = states.IDLE
		}
		anim()
	break;
}