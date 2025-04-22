/// @description Processa colisão e aplica dano se o alvo ainda estiver vivo  
if other.hit_points > 0{  
    bullet_die()                     // Destrói o projétil após impacto válido  
    damage_entity(  
        other,                      // Entidade afetada (ex: inimigo/jogador)  
        owner_id,                   // ID do responsável pelo dano (ex: jogador ou torre)  
        damage,                     // Quantidade de dano numérico  
        knockback_time              // Duração do efeito de recuo (em frames)  
    )  
}  