switch(state){
    // Estado INATIVO: aguarda deteção do jogador
    case states.IDLE:
        calc_entity_movement()          // Atualiza movimento padrão da entidade
        check_for_player()              // Verifica proximidade do jogador
        if path_index != -1             // Se existir caminho definido (path_index != -1)
            state = states.MOVE         // Transita para estado MOVIMENTO
        enemy_anim()                    // Atualiza animação conforme estado
    break;

    // Estado MOVIMENTO: segue caminho definido
    case states.MOVE:
        calc_entity_movement()          // Executa movimento ao longo do caminho
        check_for_player()              // Mantém verificação contínua do jogador
        check_facing()                  // Verifica/Ajusta direção do sprite conforme movimento
        if path_index == -1             // Se caminho concluído (path_index == -1)
            state = states.IDLE         // Retorna para estado INATIVO
        enemy_anim()                    // Atualiza animação conforme movimento
    break;

    // Estado RECUO: movimento de retrocesso por impacto
    case states.KNOCKBACK:
        calc_knockback_movement()       // Calcula movimento de recuo (força externa)
        check_for_player()              // Monitoriza proximidade do jogador
        enemy_anim()                    // Atualiza animação de recuo
    break;

    // Estado ATAQUE: executa ação ofensiva
    case states.ATTACK:
        calc_entity_movement()          // Mantém movimento durante o ataque
        check_for_player()              // Verifica se jogador permanece em alcance
        damage_entity(bogalho,self,damage,0)  // Aplica dano à entidade 'bogalho' (ex: jogador)
        enemy_anim()                    // Executa animação de ataque
    break;

    // Estado MORTO: processo de desativação
    case states.DEAD:
        calc_entity_movement()          // Último movimento residual (ex: queda)
        enemy_anim()                    // Executa animação de morte
        if(beginDisappear)              // Flag de desaparecimento ativada
        {
            image_alpha -= 0.005        // Reduz opacidade gradualmente (efeito de desaparecer)
            if(image_alpha <= 0)        // Quando totalmente transparente
            {
                instance_destroy(self,true)  // Remove a instância permanentemente
            }
        }
    break;
}