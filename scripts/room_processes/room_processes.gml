function room_templates() {
    var layouts = {};

	layouts.initial_room = [
		[obj_tile, 0.0, 0.0, 24.0, 13.5],
		[obj_solid, 0.0, 0.0, 48.000004, 2.0],
		[obj_solid, 0.0, 32.0, 1.687471, 25.0],
		[obj_solid, 12.0, 404.0, 47.250004, 1.75],
		[obj_solid, 741.0, 32.0, 1.9375001, 24.0],
		[obj_map_limit, 16.00003, 16.0, 15.333334, 6.25],
		[obj_blank, 0.0, 0.0, 48.0, 1.0],
		[obj_blank, 752.0, 16.0, 1.0, 26.0],
		[obj_blank, 0.0, 416.0, 47.0, 1.0],
		[obj_blank, 0.0, 16.0, 1.0, 25.0],
		[obj_door, 384.0, 26.0, 1.5333337, 1.703448, "top"],
		[obj_door, 27.0, 212.0, 0.13000005, 1.551724, "left"],
		[inverted_door, 27.0, 220.0, 0.13333334, 1.551724],
		[obj_door, 741.0, 212.72414, -0.1300001, 1.551724, "right"],
		[inverted_door, 741.0, 220.72414, -0.1333333, 1.551724],
		[obj_door, 384.0, 403.0, 1.5333333, 0.20689656, "bottom"]
	]
	
	layouts.next_room = [
		[obj_tile, 0.0, 0.0, 24.0, 13.5],
		[obj_solid, 0.0, 0.0, 48.000004, 2.0],
		[obj_solid, 0.0, 32.0, 1.687471, 25.0],
		[obj_solid, 12.0, 404.0, 47.250004, 1.75],
		[obj_solid, 741.0, 32.0, 1.9375001, 24.0],
		[obj_map_limit, 16.00003, 16.0, 15.333334, 6.25],
		[obj_blank, 0.0, 0.0, 48.0, 1.0],
		[obj_blank, 752.0, 16.0, 1.0, 26.0],
		[obj_blank, 0.0, 416.0, 47.0, 1.0],
		[obj_blank, 0.0, 16.0, 1.0, 25.0],
		[obj_door, 384.0, 26.0, 1.5333337, 1.703448, "top"],
		[obj_door, 27.0, 212.0, 0.13000005, 1.551724, "left"],
		[inverted_door, 27.0, 220.0, 0.13333334, 1.551724],
		[obj_door, 741.0, 212.72414, -0.1300001, 1.551724, "right"],
		[inverted_door, 741.0, 220.72414, -0.1333333, 1.551724],
		[obj_door, 384.0, 403.0, 1.5333333, 0.20689656, "bottom"]
	]
	
	layouts.another_room = [         
		[weapon_rahhhhGun, 368.0, 160.0, 1.0, 1.0, 0.0],
        [obj_door, 384.0, 403.0, 1.533333, 0.2068966, 0.0, "top"],
        [inverted_door, 741.0, 220.7241, -0.1333333, 1.551724, 0.0],
        [obj_door, 741.0, 212.7241, -0.1300001, 1.551724, 0.0, "right"],
        [obj_door, 27.0, 212.0, 0.1300001, 1.551724, 0.0, "left"],
        [obj_door, 384.0, 26.0, 1.533334, 1.703448, 0.0, "bottom"],
        [obj_blank, 0.0, 16.0, 1.0, 25.0, 0.0],
        [obj_blank, 0.0, 416.0, 47.0, 1.0, 0.0],
        [obj_blank, 752.0, 16.0, 1.0, 26.0, 0.0],
        [obj_blank, 0.0, 0.0, 48.0, 1.0, 0.0],
        [obj_map_limit, 16.00003, 16.0, 15.333334, 6.25, 0.0],
        [obj_tile, 0.0, 0.0, 24.0, 13.5, 0.0],
        [inverted_door, 27.0, 220.0, 0.13333334, 1.551724, 0.0],
        [obj_solid, 740.0, 32.0, 2.0, 24.0, 0.0],
        [obj_solid, 12.0, 404.0, 47.250004, 1.75, 0.0],
        [obj_solid, 0.0, 32.0, 1.75, 25.0, 0.0],
		[obj_solid, 0.0, 0.0, 48.000004, 2.3125, 0.0]
	]
    return layouts;
}


function build_room_at(layout, gx, gy) {
    // Colocar a sala no centro do mundo e ajustar com o offset correto
    var base_x = WORLD_CENTER_X + gx * ROOM_WIDTH;
    var base_y = WORLD_CENTER_Y + gy * ROOM_HEIGHT;

    // Debug da colocação da sala
    show_debug_message("Building room at: (" + string(base_x) + ", " + string(base_y) + ")");

    for (var i = 0; i < array_length(layout); i++) {
        var obj = layout[i][0];
        
        // Os objetos são colocados relativos ao centro
        var _x = base_x + layout[i][1];  
        var _y = base_y + layout[i][2];

        var xscale = layout[i][3];
        var yscale = layout[i][4];

        // Debug da posição do objeto
        show_debug_message("Object " + string(i) + " position: (" + string(_x) + ", " + string(_y) + ")");

        var inst = instance_create_layer(_x, _y, "Instances", obj);
        inst.image_xscale = xscale;
        inst.image_yscale = yscale;

        if (array_length(layout[i]) > 5) {
            inst.door_dir = layout[i][5]; // opcional
        }
    }

    // Debugging: Desenhar um quadrado vermelho no centro da sala
    draw_set_color(c_red);
    draw_rectangle(base_x - 5, base_y - 5, base_x + 5, base_y + 5, false);
}

function layout_has_door(layout, dir) {
    for (var i = 0; i < array_length(layout); i++) {
        if (array_length(layout[i]) > 5 && layout[i][5] == dir) {
            return true;
        }
    }
    return false;
}


function pick_layout_with_door(required_door) {
    var keys = variable_struct_get_names(global.room_templates);
    var valid_layouts = [];

    for (var i = 0; i < array_length(keys); i++) {
        var layout = global.room_templates[? keys[i]];
        if (layout_has_door(layout, required_door)) {
            array_push(valid_layouts, layout);
        }
    }

    if (array_length(valid_layouts) > 0) {
        return choose(valid_layouts);
    } else {
        return undefined;
    }
}
