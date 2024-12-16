/// @description Geração de salas
// Você pode escrever seu código neste editor

global.room_layouts = [
    [
        [obj_solid, 0, 0],  // Posição inicial (0, 0) de uma parede
        [obj_enemy_6, 64, 64], // Um inimigo na posição (64, 64)
        [obj_door, 320, 0, "right"] // Uma porta no topo
    ],
    [
        [obj_solid, 0, 0],
        [obj_enemy_2, 128, 128],
        [obj_door, 320, 480, "bottom"]
    ]
];

// Sala inicial
global.current_room_index = 0;

// Define o tamanho da câmera e sua view
view_enabled = true;
view_set_visible(0, true);
view_set_wport(0, 640); // Largura da câmera
view_set_hport(0, 480); // Altura da câmera

// Define a posição inicial da câmera
var camera = view_camera[0];
camera_set_view_pos(camera, 0, 0); // Início na posição (0, 0)

