event_inherited()

if place_meeting(mouse_x,mouse_y,obj_weapon_parent){
	var inst_count = instance_number(obj_weapon_parent); // Número de instâncias do tipo obj_weapon_parent (incluindo filhos)

	for (var i = 0; i < inst_count; i++) {
	    // Encontra a i-ésima instância que é filho de obj_weapon_parent
	    var inst = instance_find(obj_weapon_parent, i); 
	
	    // Verifica se o mouse está sobre a instância
	    if (point_in_rectangle(mouse_x, mouse_y, inst.bbox_left, inst.bbox_top, inst.bbox_right, inst.bbox_bottom)) {
	        // Exibe o nome da arma (ou outra propriedade)
	        draw_set_color(c_white);
	        draw_text_transformed(mouse_x + 10, mouse_y + 10, string(inst.weapon_name),0.2,0.2,0);
	        break; // Sai do loop após encontrar a primeira instância
	    }
	}
}

draw_healthbar(obj_healthbarPos.x+10, obj_healthbarPos.y+10, obj_healthbarPos.x+200, obj_healthbarPos.y+25, hit_points/hit_points_max*100, $0003300, $3232FF, $00B200, 0, true, true)