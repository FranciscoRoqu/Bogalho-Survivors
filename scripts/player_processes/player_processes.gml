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
		// Coordenadas do jogador
		var player_x = obj_player.x;
		var player_y = obj_player.y;
	
		var inst_count = instance_number(obj_weapon_parent); // Número de instâncias do tipo obj_weapon_parent (incluindo filhos)
	
		for (var i = 0; i < inst_count; i++) {
			// Encontra a i-ésima instância que é filho de obj_weapon_parent
			var inst = instance_find(obj_weapon_parent, i); 
			if current_weapon != inst{
				// Verifica se o mouse está sobre a instância
				if (point_in_rectangle(mouse_x, mouse_y, inst.bbox_left, inst.bbox_top, inst.bbox_right, inst.bbox_bottom)) {
				    // Verifica a distância do jogador para a arma
				    var distance = point_distance(player_x, player_y, inst.x, inst.y);
				    if (distance <= 100) { // 100 é a distância máxima permitida para apanhar a arma
				        // Atribui a instância tocada à variável current_weapon
						if current_weapon != noone{
							var new_weapon = instance_create_layer(obj_player.x, obj_player.y, "Instances", current_weapon.object_index);
							var original_weapon = current_weapon;
							show_debug_message("Arma largada e instância original destruída: " + string(original_weapon.object_index));
							with (original_weapon) {
								instance_destroy();
							}
						}
				        
						current_weapon = inst;
						
				        show_debug_message("Arma apanhada: " + string(inst.object_index));
				    } else {
				        show_debug_message("Muito longe para apanhar a arma: " + string(inst.object_index));
					}
			
			        break; // Interrompe o loop após encontrar a primeira instância tocada
			    }
			}
	}	
}

	if (keyboard_check_pressed(vk_space)) {
		// Verifica se o jogador tem uma arma equipada
		if (current_weapon != noone) {
		    // Cria uma nova instância da arma (referenciada por current_weapon) na posição do jogador
		    var new_weapon = instance_create_layer(obj_player.x, obj_player.y, "Instances", current_weapon.object_index);
		
		    // Guarda a instância original antes de apagar
		    var original_weapon = current_weapon;
		
		    // Remove a referência da arma equipada
		    current_weapon = noone;
			
			show_debug_message("Arma largada e instância original destruída: " + string(original_weapon.object_index));
		    // Apaga a instância original
		    with (original_weapon) {
		        instance_destroy();
		    }
		}
	}
}