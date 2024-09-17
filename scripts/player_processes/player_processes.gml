function reset_variables()
{
	move_speed=1.5
	up=0
	down=0
	left=0
	right=0
	updownmovement=0
	leftrightmovement=0
}

function get_input(){
	if keyboard_check(ord("W")) or keyboard_check(vk_up) == true
	{
		up = 1
	}
	if keyboard_check(ord("A")) or keyboard_check(vk_left) == true
	{
		left = 1
	}
	if keyboard_check(ord("S")) or keyboard_check(vk_down) == true
	{
		down = 1
	}
	if keyboard_check(ord("D")) or keyboard_check(vk_right) == true
	{
		right = 1
	}
}

function movement(){
	updownmovement = down - up
	leftrightmovement = right - left
	if(updownmovement != 0 and leftrightmovement != 0)
	{
		move_speed = move_speed - .5
	}
	if aim_dir > 90 and aim_dir < 270
		facing = -1
	else
		facing = 1
	move_and_collide(leftrightmovement * move_speed, updownmovement * move_speed, obj_solid)
}

function anim(){
	switch(state){
		case states.IDLE:
			sprite_index = sprite_player_idle
			break;
		case states.MOVE:
			sprite_index = sprite_player_move
			break;
		case states.DEAD:
			sprite_index = sprite_player_dead
			break;
	}
}

function aim_weapon()
{
	aim_dir = point_direction(x, y, mouse_x, mouse_y)
	current_weapon.image_angle = aim_dir
}

function check_fire(){
	if mouse_check_button(mb_left){
		if can_fire{
			can_fire = false
			alarm[0] = current_weapon.fire_rate
						
			var _dir = point_direction(x, y, mouse_x, mouse_y)
			current_weapon.weapon_dis = 10
			var _inst = instance_create_layer(x,y, "Bullet", current_weapon.weapon_bullet)
			with(_inst){
				speed = self.bullet_speed
				direction = _dir
				image_angle = _dir
				owner_id = other
			}
		}
	}
}
