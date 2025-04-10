/// @desc Prepara o sistema de geração de salas
// Inicializa a seed aleatória e estruturas de dados para geração de salas  
randomize();  
global.room_layout_map = ds_map_create(); // Mapeia posições (x,y) para layouts de sala  
global.room_templates = room_templates(); // Carrega templates pré-definidos de salas  
var num_rooms = irandom_range(4, 8)
var directions = [ // Direções possíveis com seus offsets no grid  
    ["top",    0, -1],  
    ["bottom", 0,  1],  
    ["left",  -1,  0],  
    ["right",  1,  0]  
];  

// Mapa para direções opostas (ex: top -> bottom)  
var reverse_dir_map = ds_map_create();  
ds_map_add(reverse_dir_map, "top", "bottom");  
// ... (restante das direções)  

// Estruturas para controle de geração  
var room_positions = ds_map_create();    // Salva posições ocupadas ("x,y")  
var open_positions = ds_list_create();   // Posições para expandir (fronteira)  
ds_map_add(room_positions, "0,0", true); // Sala inicial  
ds_list_add(open_positions, [0, 0]);  

// Constrói a sala inicial  
build_room_at(global.room_templates.initial_room, 0, 0);  

// Loop principal de geração procedural  
var rooms_built = 0;  
while (rooms_built < num_rooms && ds_list_size(open_positions) > 0) {  
    // Escolhe uma posição aleatória da fronteira  
    var index = irandom(ds_list_size(open_positions) - 1);  
    var from_pos = open_positions[| index];  
	
	// Extrai coordenadas X/Y da posição atual
    var from_x = from_pos[0]; 
    var from_y = from_pos[1]; 
	
    // Verifica direções em ordem aleatória  
    var shuffled = array_shuffle(directions);  
    for (var d = 0; d < array_length(shuffled); d++) {  
        var dir = shuffled[d][0];  
        var nx = from_x + shuffled[d][1]; // Nova posição X  
        var ny = from_y + shuffled[d][2]; // Nova posição Y  
        var key = string(nx) + "," + string(ny);  

        // Valida se a sala atual tem porta na direção  
        var from_room_layout = get_room_layout(from_x, from_y);  
        if (!layout_has_door(from_room_layout, dir)) continue;  

        // Se posição está vazia, tenta construir  
        if (!ds_map_exists(room_positions, key)) {  
            var valid_layouts = [];  
            var opposite = ds_map_find_value(reverse_dir_map, dir);  

            // Procura layouts com porta compatível  
            for (var i = 0; i < array_length(all_keys); i++) {  
                if (layout_name == "initial_room") continue;  
                var layout = variable_struct_get(global.room_templates, layout_name);  
                if (layout_has_door(layout, opposite)) {  
                    array_push(valid_layouts, layout);  
                }  
            }  

            // Constrói sala e atualiza estruturas
            if (array_length(valid_layouts) > 0) {  
                build_room_at(chosen_layout, nx, ny);  
                ds_map_add(room_positions, key, true);  
                ds_list_add(open_positions, [nx, ny]);  
                rooms_built++;  
                break; // Apenas uma sala por iteração  
            }  
        }  
    }  
}  

// Spawn do jogador no centro da sala inicial  
var player_x = WORLD_CENTER_X + ROOM_WIDTH / 2;  
var player_y = WORLD_CENTER_Y + ROOM_HEIGHT / 2;  
instance_create_layer(player_x, player_y, "Player", bogalho);  