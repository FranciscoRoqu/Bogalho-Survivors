/// @description Colisão com o jogador
collided = true

// Seleciona o próximo layout de forma aleatória
var next_room_index = irandom(array_length(global.room_layouts) - 1);
var next_room_layout = global.room_layouts[next_room_index];
//_direction = global.room_layouts[next_room_index][4][5]; // Direção da porta

// Define o offset com base na direção
switch (_direction) {
    case "top":
        _offset_y = _offset_y - 432; // Gera acima
        break;
    case "bottom":
        _offset_y = _offset_y + 432; // Gera abaixo
        break;
    case "left":
        _offset_x = _offset_x - 768; // Gera à esquerda
        break;
    case "right":
        _offset_x = _offset_x + 768; // Gera à direita
        break;
}


// Gera a nova sala
room_gen(next_room_layout, _offset_x, _offset_y);

