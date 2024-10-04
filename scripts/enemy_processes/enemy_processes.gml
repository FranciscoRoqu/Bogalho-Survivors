function enemy_anim(){
	switch(state){
		case states.IDLE:
			sprite_index = sprite_idle
			break;
		case states.MOVE:
			sprite_index = sprite_walk
			break;
		case states.ATTACK:
			sprite_index = sprite_attack
		break;
		case states.KNOCKBACK:
			sprite_index = sprite_hurt
		break;
		case states.DEAD:
			sprite_index = sprite_dead
		break;
	}
	
	depth = -bbox_bottom
	// Atualizar posição anterior
	xp = x
	yp = y
}

function check_for_player(){
	var _dis = distance_to_object(obj_player)
	//Começar a atacar? Ou continuar a perseguir (se estiver dentro da distância definida)
	if ((_dis <= alert_dis) or alert) and _dis > attack_dis
	{
		// O inimigo está alerta
		alert = true
		if calc_path_timer-- <= 0{
			//Recomeçar temporizador
			calc_path_timer = calc_path_delay
			
			// Encontrar um caminho até ao jogador
			var _found_player = mp_grid_path(global.grid, path, x, y, obj_player.x, obj_player.y, choose(0,1))
			
			// Começar a perseguir o jogador
			if _found_player{
				path_start(path, move_speed, path_action_stop, false)
			}
		}
	}
	else{
		// O inimigo está próximo o suficiente para atacar
		
		if _dis <= attack_dis{
			path_end()
		}
	}
}

function check_facing(){
	
		var _facing = sign(x - xp)
		if _facing != 0 facing = _facing
}

function calc_entity_movement(){
	// Mover o inimigo
	
	// Aplicar movimento
	x += hsp
	y += vsp
	
	hsp *= global.drag
	vsp *= global.drag
	
	check_if_stopped()
}

function calc_knockback_movement(){
	
	//aplicar movimento
	x += hsp
	y += vsp
	
	//Desacelerar
	hsp *= 0.91
	vsp *= 0.91
	
	check_if_stopped()
	knockback_time--
	if knockback_time <= 0 state = states.IDLE
}


function collision(){
	var _tx = x
	var _ty = y
	
	x = xprevious
	y = yprevious
	
	var _disx = abs(_tx - x)
	var _disy = abs(_ty - y)
	
	repeat(_disx){
		if !place_meeting(x + sign(_tx - x), y, obj_solid){
			x+= sign(_tx - x)
		}
	}
	repeat(_disy){
		if !place_meeting(x, y + sign(_ty - y), obj_solid){
			y+= sign(_ty - y)
		}
	}
}