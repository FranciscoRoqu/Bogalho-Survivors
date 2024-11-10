event_inherited()
// alert = está a perseguir o jogador?
alert = false
// alert_dis = distância a que o jogador pode estar antes de começar a perseguir
alert_dis = 160
// attack_dis = distância do jogador para começar a atacar
attack_dis = 18
state = states.IDLE
//Variáveis para permitir que os tempos de atualização do 
//percurso dos inimigos seja espalhado ao longo de 1 segundo
calc_path_delay = 30
calc_path_timer = irandom(60)

// Adicionar o recurso para um caminho
path = path_add()