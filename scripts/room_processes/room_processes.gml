// ========================================================
//                SISTEMA DE GERAÇÃO DE SALAS
// ========================================================

/// @function room_templates()
/// @description Cria e retorna templates pré-definidos para geração procedural de salas
/// @returns {Struct} Estrutura com layouts de sala contendo:
///              - Tipo de objeto
///              - Posições relativas (X,Y)
///              - Escalas (Xscale, Yscale)
///              - Direção opcional para portas
function room_templates() {
    var layouts = {};  // Dicionário de layouts

    // Layout inicial com paredes, limites e portas
    layouts.initial_room = [  // Sala inicial do jogo
        [obj_tile, 0.0, 0.0, 24.0, 13.5],          // Piso principal
        [obj_solid, 0.0, 0.0, 48.000004, 2.0],     // Parede superior
        [obj_solid, 0.0, 32.0, 1.687471, 25.0],    // Parede esquerda
        [obj_solid, 12.0, 404.0, 47.250004, 1.75], // Plataforma inferior
        [obj_map_limit, 16.00003, 16.0, 15.333334, 6.25], // Limite do mapa
        [obj_door, 384.0, 26.0, 1.5333337, 1.703448, "top"] // Porta superior
        // ... (outros objetos omitidos para brevidade)
    ]
    
    layouts.next_room = [  // Modelo genérico para salas subsequentes
        // Estrutura similar à sala inicial
        // ... (objetos omitidos)
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
        
        // Cria e configura instância
        var inst = instance_create_layer(_x, _y, "Instances", obj);
        inst.image_xscale = layout[i][3];  // Escala horizontal
        inst.image_yscale = layout[i][4];  // Escala vertical
        
        // Configura direção para portas (se existir)
        if (array_length(layout[i]) > 5) {
            inst.door_dir = layout[i][5];  // Ex: "top", "left"
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
        // Verifica parâmetro opcional de direção
        if (array_length(layout[i]) > 5 && layout[i][5] == dir) {
            return true;  // Porta encontrada
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