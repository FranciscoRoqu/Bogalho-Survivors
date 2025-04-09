/// @description Collision with the player

if(collided == false and bogalho.player_controlled == true)
{
	// Selects the next layout randomly
	var next_room_index = irandom_range(1, array_length(global.room_layouts) - 1);
	var next_room_layout = global.room_layouts[next_room_index];
	
	// Defines offset based on direction
	switch (_direction) {
	    case "top":
	        global._offset_y = global._offset_y - 432; // Top
	        break;
	    case "bottom":
	        global._offset_y = global._offset_y + 432; // Bottom
	        break;
	    case "left":
	        global._offset_x = global._offset_x - 768; // Left
	        break;
	    case "right":
	        global._offset_x = global._offset_x + 768; // Right
	        break;
	}
	
	// Creates the new room
	room_gen(next_room_layout, global._offset_x, global._offset_y, _direction);
	collided = true
	
	bogalho.path = path_add()
	mp_grid_clear_all(global.grid)
	
	bogalho.mp_path = mp_grid_path(global.grid, bogalho.path, bogalho.x, bogalho.y, x, y, true)

	switch(_direction)
	{
		case "left":
			path_add_point(bogalho.path, bogalho.x, global.opposite_door.y, 100)
			path_add_point(bogalho.path, global.opposite_door.x - 25, global.opposite_door.y, 100);
		break;
		case "right":
			path_add_point(bogalho.path, bogalho.x, global.opposite_door.y, 100)
			path_add_point(bogalho.path, global.opposite_door.x + 25, global.opposite_door.y, 100);
		break;
		case "top":
			path_add_point(bogalho.path, global.opposite_door.x, bogalho.y, 100)
			path_add_point(bogalho.path, global.opposite_door.x, global.opposite_door.y - 25, 100);
		break;
		case "bottom":
			path_add_point(bogalho.path, global.opposite_door.x, bogalho.y, 100)
			path_add_point(bogalho.path, global.opposite_door.x, global.opposite_door.y + 30, 100);
		break;
	}
	bogalho.player_controlled = false;
}
else
{
	exit;
}