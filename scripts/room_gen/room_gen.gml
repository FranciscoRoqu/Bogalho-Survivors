// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações
function room_gen(layout, offset_x, offset_y, room_id, other_room, other_room_direction)
{
	var new_room = 
	{
		id: room_id,
		top: -1,
		bottom: -1,
		left: -1,
		right: -1,
		doors: [],
		offset_x: 0,
		offset_y: 0
	}
	if(!is_undefined(other_room) and !is_undefined(other_room_direction))
	{
		switch(other_room_direction)
		{
			case "top":
				new_room.top = other_room
				global.room_hierarchy[other_room].bottom = room_id
			break;
			case "bottom":
				new_room.bottom = other_room
				global.room_hierarchy[other_room].top = room_id
			break;
			case "left":
				new_room.left = other_room
				global.room_hierarchy[other_room].right = room_id
			break;
			case "right":
				new_room.right = other_room
				global.room_hierarchy[other_room].left = room_id
			break;
		}
	}
	new_room.offset_x = offset_x
	new_room.offset_y = offset_y
	new_room.doors = extract_doors(layout)
	array_push(global.room_hierarchy, new_room)
	for (var i = 0; i < array_length(layout); i++) 
	{
        var obj = layout[i][0]; // Object
        var _x = layout[i][1] + offset_x; // X position
        var _y = layout[i][2] + offset_y; // Y position
        
        // If it's a door, define a direction
        if (is_array(layout[i]) && array_length(layout[i]) > 5) 
		{
            var _direction = layout[i][5]; // "top", "bottom", etc.
            var inst = instance_create_layer(_x, _y, "MapLayout", obj);
            inst._direction = _direction;
			inst.image_xscale = layout[i][3];
			inst.image_yscale = layout[i][4];
		}
		else 
		{
			var inst = instance_create_layer(_x, _y, "MapLayout", obj);
			inst.image_xscale = layout[i][3];
			inst.image_yscale = layout[i][4];
		}
	}
}