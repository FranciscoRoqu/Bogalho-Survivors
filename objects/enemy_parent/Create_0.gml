event_inherited();
enum enemy_state {
    inactive,   // Before player enters room
    active,     // Actively attacking/pursuing
    staggered,  // Brief pause after being hit
	dead		//
}

knockback_force = 0;
knockback_direction = 0;
knockback_duration = 0;
current_speed = move_speed;
state = enemy_state.active;

repath_interval = 30;  // Time between path recalculations (in frames)
repath_timer = repath_interval;

beginDisappear = false;           // Flag para iniciar efeito de desaparecimento (morte/despawn)  
path = path_add();                // Cria recurso de caminho para movimentação controlada  