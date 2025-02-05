if(current_weapon != noone){
	current_weapon.depth = depth - 1

	current_weapon.x = x + lengthdir_x(current_weapon.weapon_dis,aim_dir)
	current_weapon.y = y + lengthdir_y(current_weapon.weapon_dis,aim_dir)
	
	if(aim_dir > 0 and aim_dir < 180)
		current_weapon.depth = depth + 1
	 
	if aim_dir > 90 and aim_dir < 270
		current_weapon.image_yscale = -1
	else
		current_weapon.image_yscale = 1
	
	current_weapon.weapon_dis = lerp(current_weapon.weapon_dis, current_weapon.weapon_dis_persistent, 0.1)
}