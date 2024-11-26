/// @description
switch(state){
	case states.IDLE:
		if random(10) == 1
			show_debug_message("Special")
			sprite_index = sprite_idle_special
	case states.DEAD:
		show_debug_message("Morto")
		image_index = image_number - 1
		image_speed = 0
		alarm[0] = 10
	break;
}