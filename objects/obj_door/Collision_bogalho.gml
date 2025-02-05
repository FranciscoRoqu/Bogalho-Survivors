/// @description Collision with the player
if (bogalho.player_controlled == true) {
	var current_room = global.rooms[global.current_room_index]
	var next_room = undefined
	
    show_debug_message("Collision start");

    var next_room_index = -1;

    show_debug_message("Path found: " + string(bogalho.path));

    // Clear the grid and log the state
    mp_grid_clear_all(global.grid);
    show_debug_message("Grid cleared.");
    // Attempt to calculate a path and log the outcome
    var path_result = mp_grid_path(global.grid, bogalho.path, bogalho.x, bogalho.y, x, y, true);
    if (!path_result) {
        show_debug_message("Pathfinding failed! Start: " + string(bogalho.x) + ", " + string(bogalho.y) + "; End: " + string(x) + ", " + string(y));
        exit;
    } else {
        show_debug_message("Pathfinding successful.");
    }

    // Handle direction and log the result
    switch (_direction) {
        case "left":
            global._offset_x -= 768;
            next_room_index = global.rooms[global.current_room_index].left;
            break;
        case "right":
            global._offset_x += 768;
            next_room_index = global.rooms[global.current_room_index].right;
            break;
        case "top":
            global._offset_y -= 432;
            next_room_index = global.rooms[global.current_room_index].top;
            break;
        case "bottom":
            global._offset_y += 432;
            next_room_index = global.rooms[global.current_room_index].bottom;
            break;
    }

    global.current_room_index = next_room_index;
	next_room = global.rooms[global.current_room_index]
    show_debug_message("Transitioning to room " + string(global.current_room_index));

    bogalho.player_controlled = false;

    // Find the opposite door and log its properties
    var opposite_door_direction = get_opposite_door(_direction);
    var opposite_door = undefined;
    for (var i = 0; i < array_length(global.rooms[global.current_room_index].doors); i++) {
        var door = global.rooms[global.current_room_index].doors[i];
        if (door.direction == opposite_door_direction) {
            opposite_door = door;
            break;
        }
    }

    if (is_undefined(opposite_door)) {
        show_debug_message("Opposite door not found!");
        exit;
    } else {
        show_debug_message("Opposite door found. Position: " + string(opposite_door.position[0]) + ", " + string(opposite_door.position[1]));
    }
	var final_coords = opposite_door.position
    // Adjust opposite door position slightly based on direction
    switch (_direction) {
        case "top":
            final_coords[1] -= 30;
            break;
        case "bottom":
            final_coords[1] += 30;
            break;
        case "left":
            final_coords[0] -= 30;
            break;
        case "right":
            final_coords[0] += 30;
            break;
    }
    
    // Add the door position to the player's path
    path_add_point(bogalho.path, final_coords[0], final_coords[1], 100);
    show_debug_message("Path point added to opposite door.");

    // Debug global room structure
    show_debug_message("Debugging room properties:");
    var properties = variable_struct_get_names(global.rooms[global.current_room_index]);
    for (var i = 0; i < array_length(properties); i++) {
        var property = properties[i];
        var value = variable_struct_get(global.rooms[global.current_room_index], property);
        if (is_array(value)) {
            show_debug_message(property + " (array):");
            for (var j = 0; j < array_length(value); j++) {
                var sub_item = value[j];
                if (is_struct(sub_item)) {
                    var sub_properties = variable_struct_get_names(sub_item);
                    for (var k = 0; k < array_length(sub_properties); k++) {
                        var sub_property = sub_properties[k];
                        var sub_value = variable_struct_get(sub_item, sub_property);
                        show_debug_message("  " + sub_property + ": " + string(sub_value));
                    }
                } else {
                    show_debug_message("  " + string(sub_item));
                }
            }
        } else {
            show_debug_message(property + ": " + string(value));
        }
    }
	var distance_to_next_roomX = current_room.offsets[0] - next_room.offsets[0]
	var distance_to_next_roomY = current_room.offsets[1] - next_room.offsets[1]
	var distances = [distance_to_next_roomX, distance_to_next_roomY]
	show_debug_message(distances)
	with(bogalho)
	{
		pathing = true
		path_start(path, move_speed, path_action_stop, false)
	}
    show_debug_message("Collision end");
	begin_transition = !begin_transition
	    switch (_direction) {
        case "top":
            final_coords[1] += 30;
            break;
        case "bottom":
            final_coords[1] -= 30;
            break;
        case "left":
            final_coords[0] += 30;
            break;
        case "right":
            final_coords[0] -= 30;
            break;
    }
} else {
    exit;
}
