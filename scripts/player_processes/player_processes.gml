/// @description Reinicia variáveis de movimento para valores padrão
function reset_variables()
{
    move_speed=2.75  // Velocidade base de movimento
    up=0             // Reset movimento para cima
    down=0           // Reset movimento para baixo
    left=0           // Reset movimento para esquerda
    right=0          // Reset movimento para direita
    updownmovement=0 // Eixo vertical neutralizado
    leftrightmovement=0 // Eixo horizontal neutralizado
}

/// @description Captura entrada do teclado para movimento WASD/setas
function get_input(){
    // Verifica teclas de movimento vertical
    if keyboard_check(ord("W")) or keyboard_check(vk_up) == true
    {
        up = 1  // Ativa movimento para cima
    }
    if keyboard_check(ord("S")) or keyboard_check(vk_down) == true
    {
        down = 1  // Ativa movimento para baixo
    }

    // Verifica teclas de movimento horizontal
    if keyboard_check(ord("A")) or keyboard_check(vk_left) == true
    {
        left = 1  // Ativa movimento para esquerda
    }
    if keyboard_check(ord("D")) or keyboard_check(vk_right) == true
    {
        right = 1  // Ativa movimento para direita
    }
}

/// @description Calcula e aplica movimento com deteção de colisões
function movement(){
    updownmovement = down - up  // Combina inputs verticais (-1, 0, 1)
    leftrightmovement = right - left  // Combina inputs horizontais
    
    // Inverte direção do sprite quando mirando para trás
    if aim_dir > 90 and aim_dir < 270
        facing = -1  // Esquerda
    else
        facing = 1   // Direita

    // Aplica movimento com física simplificada
    move_and_collide(
        leftrightmovement * move_speed,  // Força horizontal
        updownmovement * move_speed,     // Força vertical
        obj_solid,                       // Objeto de colisão
        4,                               // Precisão de deteção (pixels)
        undefined, undefined,            // Parâmetros não utilizados
        max_speed, max_speed             // Limites de velocidade
    )
}

/// @description Atualiza animações conforme estado do jogador
function anim(){
    switch(state){
        case states.IDLE:
            sprite_index = sprite_player_idle  // Animação parado
            break
        case states.MOVE:
            sprite_index = sprite_player_move  // Animação movimento
            break
        case states.DEAD:
            sprite_index = sprite_player_dead  // Animação morte
            break
    }
}

/// @description Calcula direção da mira com base na posição do rato
function aim_weapon()
{
    aim_dir = point_direction(x, y, mouse_x, mouse_y)  // Ângulo em graus
    
    // Rotaciona arma equipada para seguir mira
    if(current_weapon != noone){
        current_weapon.image_angle = aim_dir  // Alinha rotação da arma
    }
}

/// @description Verifica condições de disparo e cria projéteis
function check_fire(){
    if mouse_check_button(mb_left) and current_weapon != noone{ 
        if can_fire{
            can_fire = false  // Ativa cooldown
            alarm[0] = current_weapon.fire_rate  // Define intervalo entre disparos
                        
            var _dir = point_direction(x, y, mouse_x, mouse_y)  // Direção do tiro
            current_weapon.weapon_dis = current_weapon.animation_knockback  // Distância inicial da arma
            
            // Cria instância do projétil
            var _inst = instance_create_layer(x,y, "Bullet", current_weapon.weapon_bullet)
            with(_inst){
                speed = self.bullet_speed  // Velocidade definida pela arma
                direction = _dir           // Direção do mouse
                image_angle = _dir         // Rotação do sprite
                owner_id = other           // ID do jogador para evitar auto-dano
            }
        }
    }
}

/// @description Gestão de equipamento de armas (E para recolher, Espaço para largar)
function pick_weapon(){
    // --- Sistema de Recolha ---
    if keyboard_check_pressed(ord("E")){
        var player_x = bogalho.x  // Posição X atual do jogador
        var player_y = bogalho.y  // Posição Y atual do jogador
    
        // Procura armas próximas
        var inst_count = instance_number(obj_weapon_parent)
        for (var i = 0; i < inst_count; i++) {
            var inst = instance_find(obj_weapon_parent, i) 
            if current_weapon != inst  // Evita deteção da arma atual
            {
                // Verifica se mouse está sobre a arma
                if (point_in_rectangle(mouse_x, mouse_y, 
                    inst.bbox_left, inst.bbox_top, 
                    inst.bbox_right, inst.bbox_right)) 
                {
                    // Verifica distância permitida para recolha
                    var distance = point_distance(player_x, player_y, inst.x, inst.y)
                    if (distance <= 100)  // Raio de 100 pixels
                    { 
                        // Troca arma atual pela nova
                        if (current_weapon != noone)
                        {
                            // Cria cópia da arma antiga no chão
                            var new_weapon = instance_create_layer(
                                current_weapon.x, 
                                current_weapon.y, 
                                "Instances", 
                                current_weapon.object_index
                            )
                            // Remove arma antiga
                            with (current_weapon) { instance_destroy() }
                        }
                        
                        current_weapon = inst  // Equipa nova arma
                        alarm[0] = -1          // Reset cooldown
                        can_fire = true        // Permite disparo imediato
                        break  // Interrompe busca após encontrar
                    }
                }
            }
        }   
    }

    // --- Sistema de Largar Arma ---
    if (keyboard_check_pressed(vk_space)) {
        if (current_weapon != noone) {
            // Cria cópia da arma atual no chão
            var new_weapon = instance_create_layer(
                current_weapon.x, 
                current_weapon.y, 
                "Instances", 
                current_weapon.object_index
            )
            
            // Remove referência da arma equipada
            var original_weapon = current_weapon
            current_weapon = noone  // Fica desarmado
            
            // Destrói instância equipada
            with (original_weapon) { instance_destroy() }
        }
    }
}