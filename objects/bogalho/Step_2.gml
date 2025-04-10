// --- Gestão da Arma Equipada ---  
if(current_weapon != noone){  
    current_weapon.depth = depth - 1       // Configura profundidade padrão (atrás do jogador)  
    
    // Posiciona arma relativamente ao jogador usando ângulo de mira  
    current_weapon.x = x + lengthdir_x(current_weapon.weapon_dis, aim_dir)  // X: cálculo trigonométrico  
    current_weapon.y = y + lengthdir_y(current_weapon.weapon_dis, aim_dir)  // Y: cálculo trigonométrico  
    
    // Ajusta camada de renderização conforme direção da mira  
    if(aim_dir > 0 and aim_dir < 180)  
        current_weapon.depth = depth + 1  // Arma à frente do jogador se mirando para direita  
     
    // Controla flip vertical para efeito de orientação  
    if aim_dir > 90 and aim_dir < 270  
        current_weapon.image_yscale = -1   // Inverte sprite se mirando para baixo/trás  
    else  
        current_weapon.image_yscale = 1   // Orientação padrão se mirando para cima/frente  
    
    // Suaviza transições de posicionamento  
    current_weapon.weapon_dis = lerp(  
        current_weapon.weapon_dis,  
        current_weapon.weapon_dis_persistent,  
        0.1  // Interpolação linear: 10% de aproximação por frame  
    )  
}  