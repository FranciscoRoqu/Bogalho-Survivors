// Coordenadas do jogador
var player_x = obj_player.x; // Supondo que "obj_player" é o objeto do jogador
var player_y = obj_player.y;

var inst_count = instance_number(obj_weapon_parent); // Número de instâncias do tipo obj_weapon_parent (incluindo filhos)

for (var i = 0; i < inst_count; i++) {
    // Encontra a i-ésima instância que é filho de obj_weapon_parent
    var inst = instance_find(obj_weapon_parent, i); 

    // Verifica se o mouse está sobre a instância
    if (point_in_rectangle(mouse_x, mouse_y, inst.bbox_left, inst.bbox_top, inst.bbox_right, inst.bbox_bottom)) {
        // Verifica a distância do jogador para a arma
        var distance = point_distance(player_x, player_y, inst.x, inst.y);
        if (distance <= 100) { // 100 é a distância máxima permitida para apanhar a arma
            // Atribui a instância tocada à variável current_weapon
            current_weapon = inst;

            show_debug_message("Arma apanhada: " + string(inst.object_index));
        } else {
            show_debug_message("Muito longe para apanhar a arma: " + string(inst.object_index));
        }

        break; // Interrompe o loop após encontrar a primeira instância tocada
    }
}
