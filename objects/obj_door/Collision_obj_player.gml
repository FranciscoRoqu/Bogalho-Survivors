/// @description Colisão com o jogador
// Você pode escrever seu código neste editor
// Verifica a direção da porta usada
var _direction = "right"; // Direção da porta
var _offset_x = 0;
var _offset_y = 0;

// Define o offset com base na direção
switch (_direction) {
    case "top":
        _offset_y = -432; // Gera acima
        break;
    case "bottom":
        _offset_y = 432; // Gera abaixo
        break;
    case "left":
        _offset_x = -768; // Gera à esquerda
        break;
    case "right":
        _offset_x = 768; // Gera à direita
        break;
}

// Calcula a nova posição da câmera
var camera = view_camera[0];
var new_camera_x = _offset_x; // Posição X da nova sala
var new_camera_y = _offset_y; // Posição Y da nova sala

// Atualiza a posição da câmera
camera_set_view_pos(camera, new_camera_x, new_camera_y);


// Seleciona o próximo layout de forma aleatória
var next_room_index = irandom(array_length(global.room_layouts) - 1);
var next_room_layout = global.room_layouts[next_room_index];

// Gera a nova sala
room_gen(next_room_layout, _offset_x, _offset_y);

