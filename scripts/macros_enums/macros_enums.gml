// ========================================================
//                    CONFIGURAÇÕES GLOBAIS
// ========================================================

/// Dimensões padrão da viewport/câmara
#macro ROOM_WIDTH 768          // Largura padrão das salas do jogo (em pixels)
#macro ROOM_HEIGHT 432         // Altura padrão das salas do jogo (em pixels)

/// Centro do mundo para sistemas de posicionamento global
#macro WORLD_CENTER_X 3840     // Coordenada X central do mundo (para reset de câmera)
#macro WORLD_CENTER_Y 2160     // Coordenada Y central do mundo 

/// Tamanho base dos tiles (unidade de medida do grid)
#macro Ts 16                   // Tamanho de tile em pixels (16x16)

// ========================================================
//                   SISTEMA DE ESTADOS
// ========================================================

/// Estados possíveis para entidades (inimigos/jogador)
enum states{
    IDLE,     // Estado inativo/em repouso
    MOVE,     // Em movimento para alvo específico
    ATTACK,   // Executando ação ofensiva
    DEAD,     // Morto/aguardando desaparecimento
    KNOCKBACK // Em recuo por dano recebido
}

// ========================================================
//                   TIPOS DE DANO
// ========================================================

/// Categorias de dano para sistema de resistências/efeitos
enum damages{
    RADIANT,    
    PHYSICAL    
}

// ========================================================
//                   VISUAIS DE DANO
// ========================================================

/// Mapeamento de efeitos visuais para tipos de dano
global.damages_sprites = [
    sprite_the_power_of_the_sun,  
    sprite_physical               
]