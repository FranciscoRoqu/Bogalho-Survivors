switch(state){
	default:
		reset_variables()
		if state != states.DEAD{
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
	break;
	case states.DEAD:
		instance_destroy()
}