/// @description Geração de salas
// Você pode escrever seu código neste editor

global.room_layouts = [
    [
         [obj_solid, 0.0, 0.0, 48.000004, 2.3125],
         [obj_solid, 0.0, 32.0, 1.75, 25.0],
         [obj_solid, 12.0, 404.0, 47.250004, 1.75],
         [obj_solid, 740.0, 32.0, 2.0, 24.0],
         [obj_door, 384.0, 26.0, 1.666667, 1.703448, "top"],
         [obj_door, 27.0, 212.0, 0.13000005, 1.551724, "left"],
         [inverted_door, 27.0, 220.0, 0.13333334, 1.551724],
         [obj_map_limit, 16.00003, 16.0, 15.333334, 6.25],
         [obj_blank, 0.0, 0.0, 48.0, 1.0],
         [obj_blank, 752.0, 16.0, 1.0, 26.0],
         [obj_blank, 0.0, 416.0, 47.0, 1.0],
         [obj_blank, 0.0, 16.0, 1.0, 25.0]
    ]
];

// Sala inicial
global.current_room_index = 0;