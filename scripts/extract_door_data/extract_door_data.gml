// Extract door positions from a room layout
function extract_doors(room_data) {
    var doors = [];
    for (var i = 0; i < array_length(room_data); i++) {
        if (room_data[i][0] == obj_door) {
            var door_direction = room_data[i][5]; // 6th element is the direction
            array_push(doors, door_direction);
        }
    }
	show_debug_message(doors)
    return doors; // Return an array of door directions
}
/// get_opposite_door(door_direction)
/// @param door_direction: The direction of the door
/// @return The opposite door direction
function get_opposite_door(door_direction) {
    switch (door_direction) {
        case "top": return "bottom";
        case "bottom": return "top";
        case "left": return "right";
        case "right": return "left";
        default: return ""; // Return empty if the direction is invalid
    }
}
// Check if a room has a matching opposite door
function has_opposite_door(room_data, target_door) {
    var doors = extract_doors(room_data); 
    var opposite_door = get_opposite_door(target_door); // Get the opposite direction
    
    // Loop through the doors in the room and check if any match the opposite direction
    for (var i = 0; i < array_length(doors); i++) {
        if (doors[i] == opposite_door) {
            return true; // Found a matching door
        }
    }
    
    return false; // No matching door found
}