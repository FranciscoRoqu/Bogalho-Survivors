/// @description
global.current_room_x = 0; // Posição X inicial no grid (coluna central)
global.current_room_y = 0; // Posição Y inicial no grid (linha central)
global.current_room_enemies = ds_list_create()
global.show_minimap = true; // Toggle with key if needed
MINIMAP_CELL_SIZE = 8;      // Size of each room dot
MINIMAP_PADDING = 8;        // Offset from screen edge
MINIMAP_COLOR = c_white;    // Normal rooms
CURRENT_ROOM_COLOR = c_red; // Player's current room
global.grid_width = 10;
global.grid_height = 10;