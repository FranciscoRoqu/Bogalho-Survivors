/// @function entity_take_damage(target, damage, source, [apply_knockback], [knockback_power], [knockback_duration])
/// @param {instance} target        The instance receiving damage
/// @param {real}     damage        Amount of damage to apply
/// @param {instance} source        Source of the damage (for direction)
/// @param {bool}     apply_knockback Whether to apply knockback (default: true)
/// @param {real}     knockback_power Knockback force (default: 4)
/// @param {real}     knockback_duration Knockback duration (default: 15)

function entity_take_damage(_target, _damage, _source, _apply_knockback=true, _knockback_power=4, _knockback_duration=15) {
    if !instance_exists(_target) return false;
    
    // Apply damage
    if variable_instance_exists(_target, "hit_points") 
	{
        _target.hit_points -= _damage;
        
        // Universal damage event
        if _target.object_index == bogalho {
            event_user(0); // Player damage event
        } else {
            event_user(1); // Enemy damage event
        }
    }
    
    // Apply optional knockback
    if _apply_knockback && variable_instance_exists(_target, "knockback_direction") {
        var dir = point_direction(_source.x, _source.y, _target.x, _target.y);
        
        _target.knockback_force = _knockback_power;
        _target.knockback_direction = dir;
        _target.knockback_duration = _knockback_duration;
        
        // Enter staggered state if exists
        if variable_instance_exists(_target, "state") {
            _target.state = enemy_state.staggered;
        }
    }
    
    // Visual feedback
    if variable_instance_exists(_target, "image_blend") {
        _target.image_blend = merge_color(_target.image_blend, c_red, 0.7);
        _target.alarm[1] = 8; // Reset color
    }
    
    // Death check
    if _target.hit_points <= 0 {
        if variable_instance_exists(_target, "state") {
            _target.state = enemy_state.dead
        }
    }
    
    return true;
}

function show_healthbar(){
    // Só desenha se vida estiver entre 1% e 99%
    if hit_points != hit_points_max and hit_points > 0
        draw_healthbar(
            x-20, y-20,          // Posição inicial (canto inferior esquerdo)
            x+20, y-15,          // Posição final (canto inferior direito)
            hit_points/hit_points_max*100,  // Percentagem de vida
            $0003300,            // Cor da borda (preto)
            $3232FF,             // Cor de fundo (azul claro)
            $00B200,             // Cor de preenchimento (verde)
            0,                   // Espessura da borda
            true, true           // Mostrar borda e preenchimento
        )
}