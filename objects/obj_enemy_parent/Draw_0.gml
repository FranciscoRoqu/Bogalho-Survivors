// Desenha o sprite com propriedades estendidas (escala, rotação, transparência)  
draw_sprite_ext(sprite_index, image_index, x, y, facing, 1, 0, c_white, image_alpha);  

// Exibe barra de vida/energia na interface (ex: HUD do jogador)  
show_healthbar();  

// Verifica pressionamento da tecla CTRL para debug/desenvolvimento  
if keyboard_check(vk_control)  
    // Desenha caminho calculado (linhas vermelhas para visualização de pathfinding)  
    draw_path(path, x, y, true);  