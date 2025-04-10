/// @description Atualiza animações do inimigo conforme seu estado atual
function enemy_anim(){
    switch(state){
        case states.IDLE:
            sprite_index = sprite_idle  // Animação de repouso/inatividade
            break;
        case states.MOVE:
            sprite_index = sprite_walk  // Animação de movimento
            break;
        case states.ATTACK:
            sprite_index = sprite_attack  // Animação de ataque
        break;
        case states.KNOCKBACK:
            sprite_index = sprite_hurt  // Animação de dano/recuo
        break;
        case states.DEAD:
            sprite_index = sprite_dead  // Animação de morte
        break;
    }
    
    depth = -bbox_bottom  // Define profundidade com base na posição Y (evita sobreposições)
    xp = x  // Guarda posição X anterior para cálculos de direção
    yp = y  // Guarda posição Y anterior
}

/// @description Verifica deteção e perseguição ao jogador
function check_for_player(){
    var _dis = distance_to_object(bogalho)  // Distância atual ao jogador
    
    // Lógica de perseguição (dentro do raio de alerta mas fora de alcance de ataque)
    if ((_dis <= alert_dis) or alert) and _dis > attack_dis
    {
        state = states.MOVE  // Muda para estado de movimento
        alert = true  // Ativa modo de alerta permanente
        
        // Temporizador para otimizar cálculos de pathfinding
        if calc_path_timer-- <= 0{
            calc_path_timer = calc_path_delay  // Reinicia contagem
            
            // Calcula novo caminho usando grid de navegação
            var _found_player = mp_grid_path(global.grid, path, x, y, bogalho.x, bogalho.y, choose(0,1))
            
            if _found_player{
                path_start(path, move_speed, path_action_stop, false)  // Inicia movimento pelo caminho
            }
        }
    }
    else{
        // Lógica de ataque quando dentro do alcance
        if _dis <= attack_dis{
            path_end()  // Interrompe pathfinding
            state = states.ATTACK  // Muda para estado de ataque
            
            // Ataque corpo-a-corpo se não tiver arma equipada
            if(current_weapon == noone){
                damage_entity(bogalho, self, damage, knockback_time)  // Aplica dano direto
            }
        }
    }
}

/// @description Atualiza direção do sprite conforme movimento
function check_facing(){
    var _facing = sign(x - xp)  // Calcula direção (-1: esquerda, 1: direita)
    if _facing != 0 facing = _facing  // Atualiza apenas se houver movimento
}

/// @description Calcula movimento normal da entidade
function calc_entity_movement(){
    // Aplica velocidade horizontal/vertical
    x += hsp
    y += vsp
    
    // Reduz velocidade gradualmente (arrasto global)
    hsp *= global.drag
    vsp *= global.drag
    
    check_if_stopped()  // Verifica paragem completa
}

/// @description Calcula movimento de recuo (knockback)
function calc_knockback_movement(){
    // Aplica velocidade específica para recuo
    x += hsp
    y += vsp
    
    // Desaceleração mais acentuada que movimento normal
    hsp *= 0.91
    vsp *= 0.91
    
    check_if_stopped()  // Verifica paragem
    knockback_time--  // Reduz duração do knockback
    if knockback_time <= 0 state = states.IDLE  // Retorna ao estado normal
}

/// @description Processa colisões com objetos sólidos
function collision(){
    var _tx = x  // Guarda posição-alvo X
    var _ty = y  // Guarda posição-alvo Y
    
    // Reseta para posição anterior sem colisão
    x = xprevious
    y = yprevious
    
    // Calcula distâncias percorridas
    var _disx = abs(_tx - x)
    var _disy = abs(_ty - y)
    
    // Resolução horizontal de colisões
    repeat(_disx){
        if !place_meeting(x + sign(_tx - x), y, obj_solid){
            x+= sign(_tx - x)  // Move-se pixel a pixel até colidir
        }
    }
    
    // Resolução vertical de colisões
    repeat(_disy){
        if !place_meeting(x, y + sign(_ty - y), obj_solid){
            y+= sign(_ty - y)
        }
    }
}