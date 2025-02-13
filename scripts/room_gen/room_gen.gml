// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações
function room_gen(layout, offset_x, offset_y)
{
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