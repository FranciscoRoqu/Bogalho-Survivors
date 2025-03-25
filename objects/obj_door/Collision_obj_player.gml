/// @description Collision with the player

if(collided == false and obj_player.player_controlled == true)
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
	
	obj_player.path = path_add()
	mp_grid_clear_all(global.grid)
	
	obj_player.mp_path = mp_grid_path(global.grid, obj_player.path, obj_player.x, obj_player.y, x, y, true)

	switch(_direction)
	{
		case "left":
			path_add_point(obj_player.path, obj_player.x, global.opposite_door.y, 100)
			path_add_point(obj_player.path, global.opposite_door.x - 25, global.opposite_door.y, 100);
		break;
		case "right":
			path_add_point(obj_player.path, obj_player.x, global.opposite_door.y, 100)
			path_add_point(obj_player.path, global.opposite_door.x + 25, global.opposite_door.y, 100);
		break;
		case "top":
			path_add_point(obj_player.path, global.opposite_door.x, obj_player.y, 100)
			path_add_point(obj_player.path, global.opposite_door.x, global.opposite_door.y - 25, 100);
		break;
		case "bottom":
			path_add_point(obj_player.path, global.opposite_door.x, obj_player.y, 100)
			path_add_point(obj_player.path, global.opposite_door.x, global.opposite_door.y + 30, 100);
		break;
	}
	obj_player.player_controlled = false;
}
else
{
	exit;
}