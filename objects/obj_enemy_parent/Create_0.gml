event_inherited(); // Herda comportamento do objeto pai

/// @description Inicializa variáveis de controle para IA de inimigo (perseguição, ataque e pathfinding)  
alert = false;                    // Determina se o inimigo está perseguindo o jogador  
alert_dis = 160;                  // Distância mínima para iniciar perseguição (em pixels)  
attack_dis = 18;                  // Distância para iniciar ataque corpo-a-corpo  
state = states.IDLE;              // Estado inicial: parado/inativo  

// Controle de otimização para atualização de pathfinding  
calc_path_delay = 30;             // Intervalo entre recalculos de caminho (em frames)  
calc_path_timer = irandom(60);    // Aleatoriza tempo inicial para evitar updates simultâneos  

beginDisappear = false;           // Flag para iniciar efeito de desaparecimento (morte/despawn)  
path = path_add();                // Cria recurso de caminho para movimentação controlada  