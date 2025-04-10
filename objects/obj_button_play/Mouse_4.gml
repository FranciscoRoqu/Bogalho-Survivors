/// @description Inicializa transição para a sala de jogo principal  
event_inherited();         // Herda e executa primeiro o evento do objeto pai (ex: pré-carregamento)  
room_goto(rm_game);        // Transição para a sala 'rm_game' (sala principal do jogo)  