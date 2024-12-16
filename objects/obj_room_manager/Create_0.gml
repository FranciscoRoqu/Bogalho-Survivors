/// @description Geração de salas
// Você pode escrever seu código neste editor

global.room_layouts = [
    [
        [obj_solid, 0, 0],  // Posição inicial (0, 0) de uma parede
		[obj_solid, 0, 0],
		[obj_solid, 0, 753],
		[obj_solid, 1350, 0],
		[obj_door, 16, 16, "left"],
		[obj_devGun, 272, 256]
    ]
];

// Sala inicial
global.current_room_index = 0;

// Define o tamanho da câmera e sua view
view_enabled = true;
view_set_visible(0, true);
view_set_wport(0, 640); // Largura da câmera
view_set_hport(0, 480); // Altura da câmera