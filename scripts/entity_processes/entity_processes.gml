/// @description Aplica dano a uma entidade e calcula efeitos de recuo
/// @param {real} _tid    ID da entidade alvo
/// @param {real} _sid    ID da entidade origem (causadora do dano)
/// @param {real} _damage Quantidade de dano a aplicar
/// @param {real} _time   Duração do efeito de recuo (em frames)
function damage_entity(_tid, _sid, _damage, _time){
    with(_tid){
        hit_points -= _damage  // Reduz pontos de vida do alvo
        
        var _dead = is_dead()  // Verifica se entidade morreu
        path_end()             // Interrompe qualquer movimento ativo
        
        // Define força do recuo conforme estado de vida
        var _dis = _dead ? 5 : 3  // Recuo maior se morto (5 vs 3 pixels)
        
        // Calcula direção do recuo (ângulo entre origem e alvo)
        var _dir = point_direction(_sid.x, _sid.y, x, y)
        hsp += lengthdir_x(_dis, _dir)  // Aplica componente horizontal
        vsp += lengthdir_y(_dis, _dir)  // Aplica componente vertical
        
        // Configura temporizadores e estados
        calc_path_delay = _time  // Intervalo para recalcular caminho
        alert = true             // Mantém inimigo em estado de alerta
        knockback_time = _time   // Duração total do efeito de recuo
        
        // Aplica estado de recuo apenas se alvo não for jogador
        if !_dead && _tid != bogalho {
            state = states.KNOCKBACK
        }
        return _dead  // Retorna se entidade foi morta
    }
}

/// @description Verifica e atualiza estado de morte da entidade
function is_dead(){    
    if state != states.DEAD{
        if hit_points <= 0{
            state = states.DEAD    // Ativa estado de morte
            hit_points = 0         // Garante vida não negativa
            image_index = 0        // Reinicia animação de morte
            return true
        }
    } 
    return false  // Mantém estado atual se já estiver morto
}

/// @description Para movimento suave quando velocidade é insignificante
function check_if_stopped(){
    // Limiar de paragem: 0.1 pixels/frame
    if abs(hsp) < 0.1 hsp = 0  // Reset velocidade horizontal
    if abs(vsp) < 0.1 vsp = 0  // Reset velocidade vertical
}

/// @description Renderiza barra de vida sobre a entidade
function show_healthbar(){
    // Só desenha se vida estiver entre 1% e 99%
    if hit_points != hit_points_max and hit_points > 0
        draw_healthbar(
            x-20, y-20,          // Posição inicial (canto inferior esquerdo)
            x+20, y-15,          // Posição final (canto inferior direito)
            hit_points/hit_points_max*100,  // Percentagem de vida
            $0003300,            // Cor da borda (preto)
            $3232FF,             // Cor de fundo (azul claro)
            $00B200,             // Cor de preenchimento (verde)
            0,                   // Espessura da borda
            true, true           // Mostrar borda e preenchimento
        )
}