if (current_weapon != noone) {
	// Configurações visuais
	var spacingx = 10;
    var spacingy = 18; // Espaço entre as linhas

    // Acessa os stats da arma
    draw_text_transformed(obj_weaponinfoPos.x + spacingx, obj_weaponinfoPos.y + spacingy, "Nome: " + string(current_weapon.weapon_name),0.3,0.3,0);
    draw_text_transformed(obj_weaponinfoPos.x + spacingx, obj_weaponinfoPos.y + spacingy * 2, "Fire Rate: " + string(current_weapon.fire_rate),0.3,0.3,0);

	// Acessa o objeto da bala para exibir o dano
    var bullet = current_weapon.weapon_bullet; // Tipo de bala disparado pela arma
	
   // Confirma se o objeto da bala é um filho de obj_bullet_parent
   // Acede ao objeto da bala para mostrar o dano
	if (object_is_ancestor(bullet, obj_bullet_parent)) {
	    var damage = variable_instance_get(bullet, "damage");
	    var damage_type = variable_instance_get(bullet, "damage_type");

		draw_text_transformed(obj_weaponinfoPos.x + spacingx, obj_weaponinfoPos.y + spacingy * 3, "Dano: " + string(damage),0.3,0.3,0);
	    draw_text_transformed(obj_weaponinfoPos.x + spacingx, obj_weaponinfoPos.y + spacingy * 4, "Tipo de Dano: " + string("Físico"),0.3,0.3,0);
	}

}
