randomize()
global.room_templates = room_templates();

var all_keys = variable_struct_get_names(global.room_templates);
var num_rooms = 6;
var directions = [
    ["top",    0, -1],
    ["bottom", 0,  1],
    ["left",  -1,  0],
    ["right",  1,  0]
];

var reverse_dir_map = ds_map_create();
ds_map_add(reverse_dir_map, "top", "bottom");
ds_map_add(reverse_dir_map, "bottom", "top");
ds_map_add(reverse_dir_map, "left", "right");
ds_map_add(reverse_dir_map, "right", "left");


var room_positions = ds_map_create();
ds_map_add(room_positions, "0,0", true);

var open_positions = ds_list_create();
ds_list_add(open_positions, [0, 0]);

build_room_at(global.room_templates.initial_room, 0, 0);

var rooms_built = 0;
while (rooms_built < num_rooms && ds_list_size(open_positions) > 0) {
    var index = irandom(ds_list_size(open_positions) - 1);
    var from_pos = open_positions[| index];
    var from_x = from_pos[0];
    var from_y = from_pos[1];

    var shuffled = array_shuffle(directions);

    for (var d = 0; d < array_length(shuffled); d++) {
        var dir = shuffled[d][0];
        var dx = shuffled[d][1];
        var dy = shuffled[d][2];
        var nx = from_x + dx;
        var ny = from_y + dy;
        var key = string(nx) + "," + string(ny);

        if (!ds_map_exists(room_positions, key)) {
            var valid_layouts = [];

			for (var i = 0; i < array_length(all_keys); i++) {
			    var layout_name = all_keys[i];
			    if (layout_name == "initial_room") continue;
			
			    var layout = variable_struct_get(global.room_templates, layout_name);
				var opposite = ds_map_find_value(reverse_dir_map, dir);
				if (layout_has_door(layout, opposite)) {
				    array_push(valid_layouts, layout);
				}
			}

            if (array_length(valid_layouts) > 0) {
                var random_index = irandom(array_length(valid_layouts) - 1);
				var chosen_layout = valid_layouts[random_index];
                build_room_at(chosen_layout, nx, ny);
                ds_map_add(room_positions, key, true);
                ds_list_add(open_positions, [nx, ny]);
                rooms_built += 1;
                break;
            }
        }
    }
}

// Spawn player in center of start room
var player_x = WORLD_CENTER_X + ROOM_WIDTH / 2;
var player_y = WORLD_CENTER_Y + ROOM_HEIGHT / 2;
instance_create_layer(player_x, player_y, "Player", bogalho);
