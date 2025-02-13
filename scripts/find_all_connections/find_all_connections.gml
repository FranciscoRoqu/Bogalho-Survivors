function find_all_connections(room_to_check, absolute_position)
{
	if(!is_undefined(room_to_check))
	{
		var found_room;
		var directions = [
		    ["top",    0, -1],
		    ["bottom", 0,  1],
		    ["left",  -1,  0],
		    ["right",  1,  0]
		];
		
		for(var i = 0; i < array_length(directions); i++)
		{
			var _direction = directions[i][0];
			var new_position = [
				absolute_position[0] + directions[i][1],
				absolute_position[1] + directions[i][2]
			];
			var adjacent_key = string(new_position)
			if(ds_map_exists(global.rooms_by_position, adjacent_key))
			{
				var adjacent_room_id = ds_map_find_value(global.rooms_by_position, adjacent_key)
				show_debug_message(adjacent_room_id)
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
		return room_to_check
	}
	return;
}