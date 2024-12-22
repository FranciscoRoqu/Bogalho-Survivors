/// @description Geração de salas
// Você pode escrever seu código neste editor

global.room_layouts = [
    [
         [obj_solid, 0.0, 0.0, 48.000008, 1.0],
         [obj_solid, 0.0, 416.0, 48.000004, 1.0],
         [obj_solid, 0.0, 0.0, 1.0, 11.0],
         [obj_solid, 752.0, 0.0, 1.0, 27.0],
         [obj_devGun, 272.0, 256.0, 1.0, 1.0],
         [obj_solid, 0.0, 256.0, 1.0, 11.0],
         [obj_door, 8.0, 216.0, 1.0, 5.0, "left"],
         [obj_enemy_2, 688.0, 111.0, 1.0, 1.0],
         [obj_enemy_6, 541.0, 69.0, 1.0, 1.0],
         [obj_enemy_ironwarden, 552.0, 138.0, 1.0, 1.0]
    ]
];

// Sala inicial
global.current_room_index = 0;

// Define o tamanho da câmera e sua view
view_enabled = true;
view_set_visible(0, true);
view_set_wport(0, 640); // Largura da câmera
view_set_hport(0, 480); // Altura da câmera