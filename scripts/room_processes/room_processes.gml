	// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações
/// @desc Generate the room inside the game room
/// @param {array} layout  Array of data from the room layouts
/// @param {any*} offset_x  Offset in the x axis
/// @param {any*} offset_y  Offset in the y axis
function room_gen(layout, offset_x, offset_y)
{
	for (var i = 0; i < array_length(layout); i++) 
	{
        var obj = layout[i][0]; // Object
        var _x = layout[i][1] + offset_x; // X position
        var _y = layout[i][2] + offset_y; // Y position

		show_debug_message("Placing " + string(layout[i][0]) + " at the position: " + string(layout[i][1] + offset_x) + ", " + string(layout[i][2] + offset_y))
        // If it's a door, define a direction
        if (is_array(layout[i]) && array_length(layout[i]) > 6) 
		{
            var _direction = layout[i][6]; // "top", "bottom", etc.
            var inst = instance_create_layer(_x, _y, "MapLayout", obj);
            inst._direction = _direction;
			inst.image_xscale = layout[i][3];
			inst.image_yscale = layout[i][4];
			inst.image_angle = layout[i][5];
		}
		// If it's not a door
		else 
		{
			var inst = instance_create_layer(_x, _y, "MapLayout", obj);
			inst.image_xscale = layout[i][3];
			inst.image_yscale = layout[i][4];
			inst.image_angle = layout[i][5];
		}
	}
}


/**
 * Add the new room to the global arrays
 * @function add_room(parent_room, direction_to_parent, new_room_id, new_room_layout, offset_x, offset_y)
 * @param {struct} [parent_room]  Parent room's struct
 * @param {string} [direction_to_parent]  Direction to the chosen parent room
 * @param {any*} new_room_id  Id of the new room
 * @param {array} new_room_layout  Layout of the new room
 * @param {any*} offset_x  Offset in the x axis
 * @param {any*} offset_y  Offset in the y axis
 * @returns {struct, undefined} New room struct
 */
function add_room(parent_room, direction_to_parent, new_room_id, new_room_layout, offset_x, offset_y) {
	// Default position
	var pos = [0,0]
	// The id of the parent room
	var parent_id = undefined
    // Calculate new position based on direction
    var new_position = pos;
	if(!is_undefined(parent_room))
	{
		// Define the new parent id and absolute position
		parent_id = parent_room.id
		pos = parent_room.absolute_position;
	}
	switch (direction_to_parent) {
		// Calculate the new absolute position depending on the direction to the parent
	    case "top":    new_position = [pos[0], pos[1] - 1]; break;
	    case "bottom": new_position = [pos[0], pos[1] + 1]; break;
	    case "left":   new_position = [pos[0] - 1, pos[1]]; break;
	    case "right":  new_position = [pos[0] + 1, pos[1]]; break;
	}
    // Check if position is already occupied
    if (ds_map_exists(global.rooms_by_position, string(new_position))) {
		show_debug_message("This position is occupied: " + string(new_position))
		// If the position is occupied return undefined an try again
		return undefined
    }
    // Create the new room
    var new_room = {
        id: new_room_id,
        top: undefined,
        bottom: undefined,
        left: undefined,
        right: undefined,
        parent: parent_id,
        absolute_position: new_position,
		doors: extract_doors(new_room_layout, [offset_x,offset_y]),
		offsets: [offset_x, offset_y]
    };
    // Add the new room to global storage
    array_push(global.rooms, new_room);
    ds_map_set(global.rooms_by_position, string(new_position), new_room_id);


    return new_room;
}
/// @desc  Extract the doors from a room
/// @param {array} room_data  Data of the room
/// @param {any} offsets  Array of offsets
/// @returns {array<struct>}  Doors in the room
function extract_doors(room_data, offsets) {
    var doors = [];
    for (var i = 0; i < array_length(room_data); i++) {
        if (room_data[i][0] == obj_door) {
			var door = 
			{
				direction: undefined,
				position: []
			}
            door.direction = room_data[i][6]; // 6th element is the direction
			if(!is_undefined(offsets))
			{
				door.position = [room_data[i][1] + offsets[0], room_data[i][2] + offsets[1]] // Calculate the door's position
			}
			array_push(doors, door);
        }
    }
    return doors; // Return an array of door directions
}
/// @desc Return the opposite direction 
/// @param {string} door_direction  The direction of the door
/// @returns {string} Opposite direction
function get_opposite_door(door_direction) {
	// Return the opposite direction
    switch (door_direction) {
        case "top": return "bottom";
        case "bottom": return "top";
        case "left": return "right";
        case "right": return "left";
        default: return ""; // Return empty if the direction is invalid
    }
}
/// @desc Check if a room has a matching opposite door
/// @param {array} room_data Room layout
/// @param {string} target_door Direction of the door
/// @returns {bool} Has opposite door
function has_opposite_door(room_data, target_door) {
    var doors = extract_doors(room_data); 	// Get all the doors in a room
    var opposite_door = get_opposite_door(target_door); // Get the opposite direction
    
    // Loop through the doors in the room and check if any match the opposite direction
    for (var i = 0; i < array_length(doors); i++) {
        if (doors[i].direction == opposite_door) {
            return true; // Found a matching door
        }
    }
    
    return false; // No matching door found
}
/// @deprecated
function get_complete_directions(roomId, previousId)
{
	// Get the selected room
	var _room = global.room_hierarchy[roomId];
	var completeDirections = [];
	if(!is_undefined(previousId))
	{
		if(_room.right != -1 and _room.right != previousId)
		{
			array_push(completeDirections, {id: _room.right, direction: "right"})
		}
		if(_room.left != -1 and _room.left != previousId)
		{
			array_push(completeDirections, {id: _room.left, direction: "left"})
		}
		if(_room.top != -1 and _room.top != previousId)
		{
			array_push(completeDirections, {id: _room.top, direction: "top"})
		}
		if(_room.bottom != -1 and _room.bottom != previousId)
		{
			array_push(completeDirections, {id: _room.bottom, direction: "bottom"})
		}
	}
	else
	{
		if(_room.right != -1)
		{
			array_push(completeDirections, {id: _room.right, direction: "right"})
		}
		if(_room.left != -1)
		{
			array_push(completeDirections, {id: _room.left, direction: "left"})
		}
		if(_room.top != -1)
		{
			array_push(completeDirections, {id: _room.top, direction: "top"})
		}
		if(_room.bottom != -1)
		{
			array_push(completeDirections, {id: _room.bottom, direction: "bottom"})
		}
	}
	show_debug_message("Room " + string(roomId) + ": " + string(completeDirections))
	return completeDirections
}

/**
 * Loop through all rooms and find all connections
 */
function find_all_connections()
{
	// Loop through all rooms
	for(var i = 0; i < global.room_id_counter; i++)
	{
		// Define the current room
		var room_to_check = global.rooms[i]
		// Get the absolute position of the current checked room
		var absolute_position = room_to_check.absolute_position
		// If the checked room is not undefined
		if(!is_undefined(room_to_check))
		{
			// Set the default values
			var found_room = undefined;
			var directions = [
			    ["top",    0, -1],
			    ["bottom", 0,  1],
			    ["left",  -1,  0],
			    ["right",  1,  0]
			];
			// Loop through all directions
			for(var j = 0; j < array_length(directions); j++)
			{
				var _direction = directions[j][0]; // Current direction
				var new_position = [
					absolute_position[0] + directions[j][1],
					absolute_position[1] + directions[j][2]
				];
				var adjacent_key = string(new_position)
				if(ds_map_exists(global.rooms_by_position, adjacent_key))
				{
					var adjacent_room_id = ds_map_find_value(global.rooms_by_position, adjacent_key)
					switch(_direction)
					{
						case "top":
							if(room_to_check.top == undefined)
							{
								room_to_check.top = adjacent_room_id;
							}
						break;
						case "bottom":
							if(room_to_check.bottom == undefined)
							{
								room_to_check.bottom = adjacent_room_id
							}
						break;
						case "left":
							if(room_to_check.left == undefined)
							{
								room_to_check.left = adjacent_room_id
							}
						break;
						case "right":
							if(room_to_check.right == undefined)
							{
								room_to_check.right = adjacent_room_id
							}
						break;
					}
				}
			}
		}
	}
}

/**
 * Destroy a door if it doesn't have a connected room
 * @param {string} _direction Direction to check
 * @param {struct} door A struct with the door's data 
 * @returns {id.instance} Description
 */
function destroy_door(_direction, door){
	var door_inst = undefined
	if(door.direction == _direction)
	{
		door_inst = instance_position(door.position[0], door.position[1], obj_door)
	}
	if(!is_undefined(door_inst))
	{
		instance_destroy(door_inst, false)
		var inverted_door = instance_position(door.position[0], door.position[1], obj_inverted_door)
		if(!is_undefined(inverted_door))
		{
			instance_destroy(inverted_door, false)
		}
	}
	return door_inst
}