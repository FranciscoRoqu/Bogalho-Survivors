if (current_weapon != noone) {
    // Configurações visuais
    var spacing = 20; // Espaço entre as linhas

    draw_set_color(c_white);  // Cor do texto
    draw_set_font(-1);        // Fonte padrão

    // Acessa os stats da arma
    draw_text(x, y, "Nome: " + string(current_weapon.weapon_name));
    draw_text(x, y + spacing, "Fire Rate: " + string(current_weapon.fire_rate));

    // Acessa o objeto da bala para exibir o dano
    var bullet = current_weapon.weapon_bullet; // Tipo de bala disparado pela arma
	
    // Confirma se o objeto da bala é um filho de obj_bullet_parent
   // Acessa o objeto da bala para exibir o dano
if (object_is_ancestor(bullet, obj_bullet_parent)) {
    var damage = variable_instance_get(bullet, "damage");
    var damage_type = variable_instance_get(bullet, "damage_type");

    draw_text(x, y + spacing * 2, "Dano: " + string(damage));
    draw_text(x, y + spacing * 3, "Tipo de Dano: " + string(damage_type));
}

}
