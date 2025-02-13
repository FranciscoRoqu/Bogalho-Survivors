switch(state){
	case states.IDLE:
		calc_entity_movement()
		check_for_player()
		if path_index != -1 
			state = states.MOVE
		enemy_anim()

	break;
	case states.MOVE:
		calc_entity_movement()
		check_for_player()
		check_facing()
		if path_index == -1 
			state = states.IDLE
		enemy_anim()

	break;
	case states.KNOCKBACK:
		calc_knockback_movement()
		check_for_player()
		enemy_anim()
	break;
	case states.ATTACK:
		calc_entity_movement()
		check_for_player()
		damage_entity(obj_player,self,damage,0)
		enemy_anim()
	break;
	case states.DEAD:
		calc_entity_movement()
		enemy_anim()
		if(beginDisappear)
		{
			image_alpha -= 0.005
			if(image_alpha <= 0)
			{
				instance_destroy(self,true)
			}
		}
	break;
}