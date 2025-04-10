/// @description Finaliza o comportamento da bala e inicia efeitos de destruição  
bullet_die();  // Executa a lógica de término do projétil (ex: explosão/desaparecimento)  

/**  
Linha por linha:  
1. bullet_die() - Função personalizada que:  
   - Para movimento (speed = 0)  
   - Troca sprite para animação de explosão  
   - Inicia timer para autodestruição  
   - Emite partículas/efeitos visuais  
   - Reproduz SFX de impacto/explosão  
**/  