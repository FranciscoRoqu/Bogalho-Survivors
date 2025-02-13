function get_complete_directions(roomId, previousId)
{
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