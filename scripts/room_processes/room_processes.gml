// ========================================================
//                SISTEMA DE GERAÇÃO DE SALAS
// ========================================================
function room_templates()
{
	var layouts = {}
	
	layouts.initial_room = [
		[door, 384.0, 403.0, 1.5333333, 0.20689656, 0.0, "bottom"],
		[inverted_door, 741.0, 220.72414, -0.1333333, 1.551724, 0.0],
		[door, 741.0, 212.72414, -0.1300001, 1.551724, 0.0, "right"],
		[inverted_door, 27.0, 220.0, 0.13333334, 1.551724, 0.0],
		[door, 27.0, 212.0, 0.13000005, 1.551724, 0.0, "left"],
		[door, 384.0, 26.0, 1.5333337, 1.703448, 0.0, "top"],
		[obj_blank, 0.0, 16.0, 1.0, 25.0, 0.0],
		[obj_blank, 0.0, 416.0, 47.0, 1.0, 0.0],
		[obj_blank, 752.0, 16.0, 1.0, 26.0, 0.0],
		[obj_blank, 0.0, 0.0, 48.0, 1.0, 0.0],
		[obj_map_limit, 16.00003, 16.0, 15.333334, 6.25, 0.0],
		[obj_solid, 741.0, 32.0, 1.9375001, 24.0, 0.0],
		[obj_solid, 12.0, 404.0, 47.250004, 1.75, 0.0],
		[obj_solid, 0.0, 32.0, 1.687471, 25.0, 0.0],
		[obj_solid, 0.0, 0.0, 48.000004, 2.0, 0.0],
		[tile, 0.0, 0.0, 24.0, 13.5, 0.0]
	]
	
	layouts.next_room = [
         [enemy_spawner, 464.0, 160.0, 0.5, 0.5, 0.0],
         [enemy_spawner, 304.0, 160.0, 0.5, 0.5, 0.0],
         [weapon_rahhhhGun, 80.0, 80.0, 1.0, 1.0, 0.0],
         [door, 384.0, 403.0, 1.533333, 0.2068966, 0.0, "bottom"],
         [inverted_door, 741.0, 220.7241, -0.1333333, 1.551724, 0.0],
         [door, 741.0, 212.7241, -0.1300001, 1.551724, 0.0, "right"],
         [door, 27.0, 212.0, 0.1300001, 1.551724, 0.0, "left"],
         [door, 384.0, 26.0, 1.533334, 1.703448, 0.0, "top"],
         [obj_blank, 0.0, 16.0, 1.0, 25.0, 0.0],
         [obj_blank, 0.0, 416.0, 47.0, 1.0, 0.0],
         [obj_blank, 752.0, 16.0, 1.0, 26.0, 0.0],
         [obj_blank, 0.0, 0.0, 48.0, 1.0, 0.0],
         [obj_map_limit, 16.00003, 16.0, 15.333334, 6.25, 0.0],
         [tile, 0.0, 0.0, 24.0, 13.5, 0.0],
         [inverted_door, 27.0, 220.0, 0.13333334, 1.551724, 0.0],
         [obj_solid, 740.0, 32.0, 2.0, 24.0, 0.0],
         [obj_solid, 12.0, 404.0, 47.250004, 1.75, 0.0],
         [obj_solid, 0.0, 32.0, 1.75, 25.0, 0.0],
         [obj_solid, 0.0, 0.0, 48.000004, 2.3125, 0.0]
	]
    return layouts;
}

/// @function build_room_at(layout, gx, gy)
/// @description Instancia objetos de um template de sala na posição especificada
/// @param {Array} layout Template de sala a ser construído
/// @param {Number} gx    Coordenada X na grelha de geração
/// @param {Number} gy    Coordenada Y na grelha de geração
function build_room_at(layout, gx, gy) {
    // Calcula posição base relativa ao centro do mundo
    var base_x = WORLD_CENTER_X + gx * ROOM_WIDTH;
    var base_y = WORLD_CENTER_Y + gy * ROOM_HEIGHT;

    // Depuração: mostra posição real da sala
    show_debug_message("Sala construída em: (" + string(base_x) + ", " + string(base_y) + ")");

    // Instancia cada objeto do template
    for (var i = 0; i < array_length(layout); i++) {
        var obj = layout[i][0];  // Tipo de objeto
        var _x = base_x + layout[i][1];  // Posição X absoluta
        var _y = base_y + layout[i][2];  // Posição Y absoluta
        
        // Os objetos são colocados relativos ao centro
        var _x = base_x + layout[i][1];  
        var _y = base_y + layout[i][2];

        var xscale = layout[i][3];
        var yscale = layout[i][4];
		var rotation = layout[i][5]

        // Debug da posição do objeto
        show_debug_message("Object " + string(i) + " position: (" + string(_x) + ", " + string(_y) + ")");

        var inst = instance_create_layer(_x, _y, "Instances", obj);
        inst.image_xscale = xscale;
        inst.image_yscale = yscale;
		inst.image_angle = rotation

        if (array_length(layout[i]) > 6) {
            inst.door_dir = layout[i][6];
        }
    }
    
    // Armazena layout no mapa global
    var key = string(gx) + "," + string(gy);
    ds_map_add(global.room_layout_map, key, layout);
}

/// @function layout_has_door(layout, dir)
/// @description Verifica se um template contém portas numa direção específica
/// @param {Array}  layout Template de sala para verificação
/// @param {String} dir    Direção a verificar ("top", "bottom", etc)
/// @returns {Boolean} True se encontrar pelo menos uma porta na direção
function layout_has_door(layout, dir) {
    for (var i = 0; i < array_length(layout); i++) {
        if (array_length(layout[i]) > 6 && layout[i][6] == dir) {
            return true;
        }
    }
    return false;  // Nenhuma porta nesta direção
}

/// @function pick_layout_with_door(required_door)
/// @description Seleciona aleatoriamente template compatível com conexão requerida
/// @param {String} required_door Direção da conexão necessária
/// @returns {Array|Undefined} Template válido ou undefined
function pick_layout_with_door(required_door) {
    var valid_layouts = [];
    
    // Filtra templates excluindo sala inicial
    var keys = variable_struct_get_names(global.room_templates);
    for (var i = 0; i < array_length(keys); i++) {
        var layout_name = keys[i];
        if (layout_name == "initial_room") continue;  // Ignora sala inicial
        
        var layout = global.room_templates[? layout_name];
        if (layout_has_door(layout, required_door)) {
            array_push(valid_layouts, layout);  // Adiciona candidato válido
        }
    }
    
    return (array_length(valid_layouts) > 0 ? choose(valid_layouts) : undefined);
}

function get_room_layout(gx, gy) {
    var key = string(gx) + "," + string(gy);
    return ds_map_exists(global.room_layout_map, key) ? global.room_layout_map[? key] : undefined;
}
function transition_to_room(new_x, new_y, door_dir) {
    // Prevent input during transition
    global.is_transitioning = true;
    global.transition_progress = 0;

    // Store player’s current position as the start point
    global.player_start_x = bogalho.x;
    global.player_start_y = bogalho.y;

    // Calculate target position based on door direction
    var room_world_x = WORLD_CENTER_X + new_x * ROOM_WIDTH;
    var room_world_y = WORLD_CENTER_Y + new_y * ROOM_HEIGHT;
    var offset = 60; // Adjust to match door positions

    switch (door_dir) {
        case "top":
            global.player_target_x = bogalho.x;
            global.player_target_y = room_world_y + ROOM_HEIGHT - offset;
            break;
        case "bottom":
            global.player_target_x = bogalho.x;
            global.player_target_y = room_world_y + offset;
            break;
        case "left":
            global.player_target_x = room_world_x + ROOM_WIDTH - offset;
            global.player_target_y = bogalho.y;
            break;
        case "right":
            global.player_target_x = room_world_x + offset;
            global.player_target_y = bogalho.y;
            break;
    }

    // Update global room and camera targets
    global.current_room_x = new_x;
    global.current_room_y = new_y;
    global.target_cam_x = room_world_x;
    global.target_cam_y = room_world_y;
	
	// Start transition
	bogalho.is_transitioning = true;
	
	// End transition (in camera manager Step Event)
	if (global.transition_progress >= 1) {
	    bogalho.is_transitioning = false;
	}
}

/// @function get_target_room(current_x, current_y, door_dir)
/// @description Calculates the target grid coordinates based on the current room and door direction.
/// @param {Number} current_x The current grid X-coordinate.
/// @param {Number} current_y The current grid Y-coordinate.
/// @param {String} door_dir   The door direction ("top", "bottom", "left", "right").
/// @returns {Struct}          A struct with `x` and `y` properties representing the target grid position.
function get_target_room(current_x, current_y, door_dir) {
    var target_x = current_x;
    var target_y = current_y;

    switch (door_dir) {
        case "top":    target_y--; break;
        case "bottom": target_y++; break;
        case "left":   target_x--; break;
        case "right":  target_x++; break;
    }

    return { x: target_x, y: target_y };
}

/// @function room_exists_at(gx, gy)
/// @description Checks if a room exists at the specified grid coordinates by verifying the key in `global.room_layout_map`.
/// @param {Number} gx Grid X-coordinate.
/// @param {Number} gy Grid Y-coordinate.
/// @returns {Boolean} `true` if the room exists, `false` otherwise.
function room_exists_at(gx, gy) {
    var key = string(gx) + "," + string(gy);
    return ds_map_exists(global.room_layout_map, key);
}