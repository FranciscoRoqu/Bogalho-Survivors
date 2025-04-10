switch(state) {  
    default:  
        // --- Controle Principal ---  
        // Só processa inputs se NÃO estiver em transição de cena/estado  
        if (!is_transitioning) {  
            reset_variables();             // Reinicia variáveis de movimento/input  
              
            // Lógica ativa apenas se jogador estiver vivo  
            if (state != states.DEAD) {  
                aim_weapon();              // Controla direção da mira/armas  
                get_input();               // Captura inputs do teclado/joystick  
                movement();                // Calcula movimento baseado nas direções  
                check_fire();              // Verifica condições de disparo  
                pick_weapon();             // Permite trocar de arma coletável  
            }  

            // --- Atualização de Estado ---  
            // Altera para MOVIMENTO se houver direção ativa (e jogador vivo)  
            if ((leftrightmovement != 0 || updownmovement != 0) && state != states.DEAD) {  
                state = states.MOVE;       // Ativa estado de movimento  
            } else {  
                state = states.IDLE;       // Volta para estado inativo  
            }  

            anim();  // Atualiza animações mesmo em transição/pausa  
        }  
        break;  

    // --- Estado MORTO ---  
    case states.DEAD:  
        sprite_index = sprite_player_dead;  // Define sprite fixo de morte (ex: corpo caído)  
        break;  
}  

// --- Reset de Transição ---  
// Garante sincronização com sistema global de transições  
if (is_transitioning && !global.is_transitioning) {  
    is_transitioning = false;  // Libera controle do jogador  
    can_move = true;           // Restaura movimentação normal  
}  