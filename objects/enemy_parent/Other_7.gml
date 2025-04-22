  switch(state){        
    case enemy_state.dead:  
        image_index = image_number - 1       // Define último frame da animação de morte  
        image_speed = 0                      // Congela animação (sem atualização automática)  
        alarm[1] = game_get_speed(gamespeed_fps) * 2  // Configura alarme para 2 segundos (baseado no FPS do jogo)  
    break;  
}  