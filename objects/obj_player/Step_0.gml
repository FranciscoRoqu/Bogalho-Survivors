switch(state){
	default:
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
		pick_weapon()
	break;
}