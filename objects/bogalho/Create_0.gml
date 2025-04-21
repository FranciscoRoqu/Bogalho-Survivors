/// @description
event_inherited(); 

// --- Configuração inicial de estados e movimento ---  
state = states.IDLE;             // Estado inicial: inativo/em repouso  
move_speed = 2.75;               // Velocidade base de movimento (unidades por segundo)  
max_speed = move_speed;          // Define velocidade máxima igual à base  
facing = 1;                      // Direção inicial do sprite (1=direita, -1=esquerda)  

// --- Flags de direção e ação ---  
up = 0; down = 0; left = 0; right = 0;  // Controle de direção (0=desativado)  
aim_dir = 0;                     // Ângulo atual de mira (0° = direita padrão)  

// --- Controles de estado e autoria ---  
can_fire = false;                // Bloqueia ações de ataque inicialmente  
is_transitioning = false;        // Indica se está em transição entre estados/cenas  
is_ai_controlled = false;        // Desativa controle automático por IA  

// --- Temporizadores e aleatoriedade ---  
alarm[0] = 20;                   // Temporizador genérico (20 frames até disparar)  
random_num = ceil(random(1000000)); // Gera número aleatório entre 1-1.000.000  
if random_num == 1 {  
    state = states.DEAD;          // 0.0001% de chance de morte imediata
}  