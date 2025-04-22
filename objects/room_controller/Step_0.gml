/// @description Decrementa o cooldown de transição a cada frame e garante que não fique negativo
global.transition_cooldown -= 1; // Reduz o cooldown a cada frame
if (global.transition_cooldown < 0) global.transition_cooldown = 0; // Garante que não seja menor que 0

if(global.showInfo)
	global.show_minimap = false
else
	global.show_minimap = true
	
instance_place_list(x, y, enemy_parent, global.current_room_enemies, false);
for(var i = 0; i < array_length(global.current_room_enemies); i++) {
    with(global.current_room_enemies[i]) {
        state = enemy_state.active; 
    }
}