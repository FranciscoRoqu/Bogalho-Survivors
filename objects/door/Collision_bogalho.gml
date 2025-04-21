/// @description Verifica e inicia transições entre salas quando o jogador interage com uma porta, incluindo controle de cooldown  
if (global.transition_cooldown <= 0) { // Impede transições rápidas em sequência  
    var target_room = get_target_room(global.current_room_x, global.current_room_y, door_dir); // Calcula coordenadas da nova sala com base na direção  
    
    if (room_exists_at(target_room.x, target_room.y)) { // Valida se a sala de destino existe no layout gerado  
        transition_to_room(target_room.x, target_room.y, door_dir); // Inicia animação e reposicionamento da câmera/jogador  
        global.transition_cooldown = room_speed * 0.5; // Define intervalo mínimo entre transições (0.5 segundos)  
    }  
}  