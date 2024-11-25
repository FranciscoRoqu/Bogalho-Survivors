// Procurar todas as instâncias de objetos filhos de obj_weapon_parent
var inst_count = instance_number(obj_weapon_parent); // Contagem das instâncias do tipo obj_weapon_parent (incluindo os filhos)

for (var i = 0; i < inst_count; i++) {
    var inst = instance_find(obj_weapon_parent, i); // Pega a i-ésima instância do objeto filho

    // Verifica se o mouse está tocando nesta instância
    if (place_meeting(mouse_x, mouse_y, inst)) {
		
		current_weapon = instance_create_layer(x,y,"Instances",obj_devGun)
        // Aqui, você pode acessar qualquer propriedade ou comportamento da instância tocada
        show_debug_message("Objeto filho tocado: " + string(inst));
        break; // Opcional: interrompe o loop após encontrar a primeira instância tocada
    }
}
