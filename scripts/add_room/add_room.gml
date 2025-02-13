function add_room(parent_room, direction_to_parent, new_room_id, new_room_layout, offset_x, offset_y) {
	var pos = [0,0]
	var parent_id = undefined
    // Calculate new position based on direction
    var new_position = pos;
	if(!is_undefined(parent_room))
	{
		parent_id = parent_room.id
		pos = parent_room.absolute_position;
	}
	switch (direction_to_parent) {
	    case "top":    new_position = [pos[0], pos[1] - 1]; break;
	    case "bottom": new_position = [pos[0], pos[1] + 1]; break;
	    case "left":   new_position = [pos[0] - 1, pos[1]]; break;
	    case "right":  new_position = [pos[0] + 1, pos[1]]; break;
	}
    // Check if position is already occupied
    if (ds_map_exists(global.rooms_by_position, string(new_position))) {
		parent_room = find_all_connections(parent_room,pos)
		show_debug_message("This position is occupied: " + string(new_position))
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
    // Link the new room to the parent
    switch (direction_to_parent) {
        case "top":    
			new_room.bottom = parent_room.id; 
		break;
        case "bottom": 
			new_room.top = parent_room.id; 
		break;
        case "left":   
			new_room.right = parent_room.id; 
		break;
        case "right":  
			new_room.left = parent_room.id; 
		break;
    }
    // Add the new room to global storage
    array_push(global.rooms, new_room);
    ds_map_set(global.rooms_by_position, string(new_position), new_room_id);


    return new_room;
}
