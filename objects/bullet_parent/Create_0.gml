/// @description Finaliza o ciclo de vida da bala e inicia efeito de explosão  
function bullet_die()  
{  
    speed = 0;                   // Congela movimento imediatamente (velocidade = 0)  
    instance_change(  
        bullet_explosion,        // Substitui por objeto de explosão  
        false                    // Não executa eventos do novo objeto automaticamente  
    );  
}  