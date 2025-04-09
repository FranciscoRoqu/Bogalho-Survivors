/// @description Carregar templates
global.room_templates = room_templates();

// Build the starting room at (0, 0)
var start_layout = global.room_templates.initial_room;
build_room_at(start_layout, 0, 0);

// Build the top neighbor at (0, -1)
var top_layout = global.room_templates.next_room;
build_room_at(top_layout, 0, -1);

// Spawn player in center of start room
var player_x = WORLD_CENTER_X + ROOM_WIDTH / 2;
var player_y = WORLD_CENTER_Y + ROOM_HEIGHT / 2;
instance_create_layer(player_x, player_y, "Player", bogalho);