/// @description Collision with the player

if(collided == false and bogalho.player_controlled == true)
{
	var path = path_add()
	var next_room_index = -1
	collided = true
	
	path_add_point(path, x, y, 100)

	mp_grid_clear_all(global.grid)
	
	var mp_path = mp_grid_path(global.grid, path, bogalho.x, bogalho.y, x, y, true)

	switch(_direction)
	{
		case "left":
			global._offset_x = global._offset_x - 768
			next_room_index = global.room_hierarchy[global.current_room_index].left
		break;
		case "right":
			global._offset_x = global._offset_x + 768
			next_room_index = global.room_hierarchy[global.current_room_index].right
		break;
		case "top":
			global._offset_y = global._offset_y - 432
			next_room_index = global.room_hierarchy[global.current_room_index].top
		break;
		case "bottom":
			global._offset_y = global._offset_y + 432
			next_room_index = global.room_hierarchy[global.current_room_index].bottom
		break;
	}
	global.current_room_index = next_room_index
	bogalho.player_controlled = false;
	
}
else
{
	exit;
}