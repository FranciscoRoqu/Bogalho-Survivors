/// @description Controla comportamentos visuais específicos de cada estado (animações e timers)  
switch(state){  
    case states.IDLE:  
        if random(10) == 1                   // Se ocorrer 1 em 10 chances por frame  
            sprite_index = sprite_idle_special // Alterna para animação especial de inatividade  
    break;  
      
    case states.DEAD:  
        image_index = image_number - 1       // Define último frame da animação de morte  
        image_speed = 0                      // Congela animação (sem atualização automática)  
        alarm[0] = game_get_speed(gamespeed_fps) * 2  // Configura alarme para 2 segundos (baseado no FPS do jogo)  
    break;  
}  