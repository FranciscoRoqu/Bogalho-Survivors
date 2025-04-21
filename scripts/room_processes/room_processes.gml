// ========================================================
//                SISTEMA DE GERAÇÃO DE SALAS
// ========================================================

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

// ========================================================
//                GESTÃO DE TRANSIÇÕES
// ========================================================

/// @function transition_to_room(new_x, new_y, door_dir)
/// @description Executa transição suave entre salas
/// @param {Number} new_x   Nova coordenada X na grelha
/// @param {Number} new_y   Nova coordenada Y na grelha
/// @param {String} door_dir Direção da porta de entrada
function transition_to_room(new_x, new_y, door_dir) {
    // Bloqueia inputs durante transição
    global.is_transitioning = true;
    global.transition_progress = 0;

    // Calcula posição-alvo com base na direção
    var room_world_x = WORLD_CENTER_X + new_x * ROOM_WIDTH;
    var room_world_y = WORLD_CENTER_Y + new_y * ROOM_HEIGHT;
    var offset = 60;  // Distância de spawn relativa à porta

    // Define ponto de spawn conforme direção
    switch (door_dir) {
        case "top":    // Spawn abaixo da porta superior
            global.player_target_y = room_world_y + ROOM_HEIGHT - offset;
            break;
        case "bottom": // Spawn acima da porta inferior
            global.player_target_y = room_world_y + offset;
            break;
        // ... outros casos
    }

    // Atualiza registros globais
    global.current_room_x = new_x;
    global.current_room_y = new_y;
    global.target_cam_x = room_world_x;  // Alvo para câmera
    global.target_cam_y = room_world_y;
}

/// @function get_target_room(current_x, current_y, door_dir)
/// @description Calcula coordenadas da sala adjacente
/// @returns {Struct} Coordenadas {x, y} da sala destino
function get_target_room(current_x, current_y, door_dir) {
    var target = { x: current_x, y: current_y };
    
    // Ajusta coordenadas conforme direção
    switch (door_dir) {
        case "top":    target.y--; break;  // Sala acima
        case "bottom": target.y++; break;  // Sala abaixo
        case "left":   target.x--; break;
		case "right":  target.x++; break;
    }
    
    return target;
}

/// @function room_exists_at(gx, gy)
/// @description Verifica existência de sala nas coordenadas
/// @returns {Boolean} True se sala já foi gerada
function room_exists_at(gx, gy) {
    var key = string(gx) + "," + string(gy);
    return ds_map_exists(global.room_layout_map, key);  // Consulta mapa global
}