/// @description Collision with the player

if(collided == false)
{
	// Selects the next layout randomly
	var next_room_index = irandom_range(1, array_length(global.room_layouts) - 1);
	var next_room_layout = global.room_layouts[next_room_index];
	
	// Defines offset based on direction
	switch (_direction) {
	    case "top":
	        _offset_y = _offset_y - 432; // Top
	        break;
	    case "bottom":
	        _offset_y = _offset_y + 432; // Bottom
	        break;
	    case "left":
	        _offset_x = _offset_x - 768; // Left
	        break;
	    case "right":
	        _offset_x = _offset_x + 768; // Right
	        break;
	}
	
	// Creates the new room
	room_gen(next_room_layout, _offset_x, _offset_y, _direction);
	collided = true
	
	obj_player.path = path_add()
	mp_grid_clear_all(global.grid)
	
	obj_player.mp_path = mp_grid_path(global.grid, obj_player.path, obj_player.x, obj_player.y, x, y, true)
	path_add_point(obj_player.path, obj_player.x, global.opposite_door.y, 100)
	path_add_point(obj_player.path, global.opposite_door.x + 25, global.opposite_door.y, 100)
}



