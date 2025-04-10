// Inicializa a seed aleatória para geração procedural
randomize();

// Cria estruturas de dados globais para armazenamento de salas
global.room_layout_map = ds_map_create();  // Mapa para layouts gerados
global.room_templates = room_templates();  // Carrega templates pré-definidos

// Configuração inicial para geração procedural
var all_keys = variable_struct_get_names(global.room_templates);  // Nomes dos templates
var num_rooms = 6;  // Número máximo de salas a gerar
var directions = [   // Direções possíveis com offsets de grid
    ["top",    0, -1],   // Movimento para cima
    ["bottom", 0,  1],   // Movimento para baixo
    ["left",  -1,  0],   // Movimento para esquerda
    ["right",  1,  0]    // Movimento para direita
];

// Mapeamento de direções opostas para conexão de portas
var reverse_dir_map = ds_map_create();  
ds_map_add(reverse_dir_map, "top", "bottom");  // Topo ↔ Base
ds_map_add(reverse_dir_map, "bottom", "top");
ds_map_add(reverse_dir_map, "left", "right");  // Esquerda ↔ Direita
ds_map_add(reverse_dir_map, "right", "left");

// Controle de posições geradas
var room_positions = ds_map_create();  // Registro de salas existentes
ds_map_add(room_positions, "0,0", true);  // Sala inicial (origem)

var open_positions = ds_list_create();  // Fronteira de expansão
ds_list_add(open_positions, [0, 0]);  // Adiciona posição inicial

// Constrói sala inicial no centro do mundo
build_room_at(global.room_templates.initial_room, 0, 0);

// Loop principal de geração procedural
var rooms_built = 0;
while (rooms_built < num_rooms && ds_list_size(open_positions) > 0) {
    // Seleciona posição aleatória da fronteira
    var index = irandom(ds_list_size(open_positions) - 1);
    var from_pos = open_positions[| index];  // Posição atual
    var from_x = from_pos[0];  // Coordenada X no grid
    var from_y = from_pos[1];  // Coordenada Y no grid

    var shuffled = array_shuffle(directions);  // Embaralha direções

    // Tenta expandir em todas as direções
    for (var d = 0; d < array_length(shuffled); d++) {
        var dir = shuffled[d][0];  // Direção atual (ex: "top")
        var dx = shuffled[d][1];   // Offset X
        var dy = shuffled[d][2];   // Offset Y
        var nx = from_x + dx;      // Nova coordenada X
        var ny = from_y + dy;      // Nova coordenada Y
        var key = string(nx) + "," + string(ny);  // Chave de posição
        
        // Verifica se sala atual tem porta na direção pretendida
        var from_room_layout = get_room_layout(from_x, from_y);
        if (!layout_has_door(from_room_layout, dir)) {
            continue; // Ignora direções sem porta correspondente
        }
        
        // Debug de processo de geração
        show_debug_message("Trying direction: " + dir);
        if (from_room_layout == undefined) {
            show_debug_message("ERROR: Origin room layout not found!");
        }
        if (!layout_has_door(from_room_layout, dir)) {
            show_debug_message("Skipping direction " + dir + " (origin room lacks door)");
        }

        // Verifica se posição está livre
        if (!ds_map_exists(room_positions, key)) {
            var valid_layouts = [];  // Templates compatíveis

            // Procura templates com porta oposta
            for (var i = 0; i < array_length(all_keys); i++) {
                var layout_name = all_keys[i];
                if (layout_name == "initial_room") continue;  // Ignora sala inicial
                
                var layout = variable_struct_get(global.room_templates, layout_name);
                var opposite = ds_map_find_value(reverse_dir_map, dir);  // Direção oposta
                if (layout_has_door(layout, opposite)) {
                    array_push(valid_layouts, layout);  // Template válido
                }
            }

            // Constrói sala se encontrar templates válidos
            if (array_length(valid_layouts) > 0) {
                var random_index = irandom(array_length(valid_layouts) - 1);
                var chosen_layout = valid_layouts[random_index];  // Seleção aleatória
                build_room_at(chosen_layout, nx, ny);  // Constrói nova sala
                
                // Atualiza estruturas de controle
                ds_map_add(room_positions, key, true);
                ds_list_add(open_positions, [nx, ny]);
                rooms_built += 1;  // Incrementa contador
                break;  // Passa para próxima posição
            }
        }
    }
}

// Spawn player in center of start room
var player_x = WORLD_CENTER_X + ROOM_WIDTH / 2;
var player_y = WORLD_CENTER_Y + ROOM_HEIGHT / 2;
instance_create_layer(player_x, player_y, "Player", bogalho);