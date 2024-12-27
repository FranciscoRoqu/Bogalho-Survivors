/// @description
switch(state){
	case states.IDLE:
		if random(10) == 1
			sprite_index = sprite_idle_special
	break;
	case states.DEAD:
		image_index = image_number - 1
		image_speed = 0
		alarm[0] = game_get_speed(gamespeed_fps) * 2
	break;
}