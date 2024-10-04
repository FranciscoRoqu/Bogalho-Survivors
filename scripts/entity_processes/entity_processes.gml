function damage_entity(_tid, _sid, _damage, _time){
	///@arg tid		real		target_id
	///@arg sid		real		source_id
	///@arg damage  real		Quantidade de dano que o projétil deve dar
	///@arg	time	real		Tempo que o inimigo deve ser arrastado para trás
	
	with(_tid){
		hit_points -= _damage
		
		var _dead = is_dead()
		path_end()
		if _dead 
			var _dis = 5
		else
			var _dis = 3
		var _dir = point_direction(_sid.x, _sid.y, x, y)
		hsp += lengthdir_x(_dis, _dir)
		vsp += lengthdir_y(_dis, _dir)
		
		calc_path_delay = _time
		alert = true
		knockback_time = _time
		if !_dead state = states.KNOCKBACK
		return _dead
	}
}
// Verificar se o inimigo está morto
function is_dead(){
	
	if state != states.DEAD{
		if hit_points <= 0{
			state = states.DEAD
			hit_points = 0
			image_index = 0
			
			return true
		}
	} else return true
}

function check_if_stopped(){
	// Verificar se o valor das velocidades são próximos o suficiente de 0 
	// e defini-los como 0 se for verdade
	
	if abs(hsp) < 0.1 {
		hsp = 0
	}
	if abs(vsp) < 0.1 {
		vsp = 0
	}
}

function show_healthbar(){
	// Mostrar a barra de vida do inimigo
	
	//if hit_points != hit_points_max and hit_points > 0
		draw_healthbar(x-20, y-20, x+20, y-15, hit_points/hit_points_max*100, $0003300, $3232FF, $00B200, 0, true, true)
}