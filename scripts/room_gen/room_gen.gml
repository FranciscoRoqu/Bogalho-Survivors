// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações
function room_gen(layout, offset_x, offset_y, previous_direction){
	global.opposite_door = noone
	for (var i = 0; i < array_length(layout); i++) {
        var obj = layout[i][0]; // Objeto
        var _x = layout[i][1] + offset_x; // Posição x
        var _y = layout[i][2] + offset_y; // Posição y
        
        // Se for uma porta, define a direção
        if (is_array(layout[i]) && array_length(layout[i]) > 5) {
            var _direction = layout[i][5]; // "top", "bottom", etc.
            var inst = instance_create_layer(_x, _y, "MapLayout", obj);
            inst._direction = _direction;
			inst.image_xscale = layout[i][3];
			inst.image_yscale = layout[i][4];
			if (opposite_direction(_direction) == previous_direction)
			{
				global.opposite_door = inst
			}
        } else {
            var inst = instance_create_layer(_x, _y, "MapLayout", obj);
			inst.image_xscale = layout[i][3];
			inst.image_yscale = layout[i][4];
        }
    }
}

function opposite_direction(_direction)
{
	var _opposite_direction = noone
	switch(_direction)
	{
		case "top": 
			_opposite_direction = "bottom";
			break;
		case "bottom": 
			_opposite_direction = "top";
			break;
		case "left": 
			_opposite_direction = "right";
			break;
		case "right": 
			_opposite_direction = "left";
			break;
		default: 
			_opposite_direction = "";
			break;
	}
	return _opposite_direction;
}