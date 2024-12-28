/// @description Collision with the player

if(collided == false and obj_player.player_controlled == true)
{	
	var next_room_index = -1
	collided = true
	
	obj_player.path = path_add()


	mp_grid_clear_all(global.grid)
	
	obj_player.mp_path = mp_grid_path(global.grid, obj_player.path, obj_player.x, obj_player.y, x, y, true)

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
	obj_player.player_controlled = false;
}
else
{
	exit;
}