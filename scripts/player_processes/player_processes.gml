function reset_variables()
{
	move_speed=2.75
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
	if aim_dir > 90 and aim_dir < 270
		facing = -1
	else
		facing = 1
	move_and_collide(leftrightmovement * move_speed, updownmovement * move_speed, obj_solid, 4, undefined, undefined, max_speed, max_speed)
}

function anim(){
	switch(state){
		case states.IDLE:
			sprite_index = sprite_player_idle
			break
		case states.MOVE:
			sprite_index = sprite_player_move
			break
		case states.DEAD:
			sprite_index = sprite_player_dead
			break
	}
}

function aim_weapon()
{
	aim_dir = point_direction(x, y, mouse_x, mouse_y)
	if(current_weapon != noone){
		current_weapon.image_angle = aim_dir
	}
}

function check_fire(){
	if mouse_check_button(mb_left) and current_weapon != noone{ 
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

function pick_weapon(){
	if keyboard_check_pressed(ord("E")){
		// Player coordinates
		var player_x = obj_player.x
		var player_y = obj_player.y
	
		var inst_count = instance_number(obj_weapon_parent) // Number of objects from the same type as obj_weapon_parent
	
		for (var i = 0; i < inst_count; i++) {
			// Encontra a i-ésima instância que é filho de obj_weapon_parent
			var inst = instance_find(obj_weapon_parent, i) 
			if current_weapon != inst
			{
				// Verify if the mouse is hovering a weapon
				if (point_in_rectangle(mouse_x, mouse_y, inst.bbox_left, inst.bbox_top, inst.bbox_right, inst.bbox_bottom)) 
				{
				    // Verify the distance between the player and the weapon
				    var distance = point_distance(player_x, player_y, inst.x, inst.y)
				    if (distance <= 100) // 100 is the maximum allowed distance to pick up a weapon
					{ 
				        // Add the touched weapon to the current weapon variable
						if (current_weapon != noone)
						{
							var new_weapon = instance_create_layer(current_weapon.x, current_weapon.y, "Instances", current_weapon.object_index)
							var original_weapon = current_weapon
							with (original_weapon) 
							{
								instance_destroy()
							}
						}
				        
						current_weapon = inst
						alarm[0] = -1
						can_fire = true
					}
			        break // Stop the loop after finding the first instance
			    }
			}
	}	
}

	if (keyboard_check_pressed(vk_space)) {
		// Verify if the player has a weapon equipped
		if (current_weapon != noone) {
		    // Create a new instance of the current weapon
			var new_weapon = instance_create_layer(current_weapon.x, current_weapon.y, "Instances", current_weapon.object_index)

		    // Hold original weapon
		    var original_weapon = current_weapon
		
		    // Remove the equipped weapon reference
		    current_weapon = noone
			
		    // Delete the  original instance
		    with (original_weapon) {
		        instance_destroy()
		    }
		}
	}
}