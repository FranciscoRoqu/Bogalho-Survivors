if (current_weapon != noone) {
    // Configurações visuais
    var spacingx = 10;
    var spacingy = 18; // Espaço entre as linhas

    // Acessa os stats da arma
    var weapon_x = obj_weaponinfoPos.x;
    var weapon_y = obj_weaponinfoPos.y;

    //draw_text_transformed(weapon_x + spacingx, weapon_y + spacingy, string(current_weapon.weapon_name), 0.3, 0.3, 0);

    // Acessa o objeto da bala para exibir o dano
    var bullet = current_weapon.weapon_bullet; // Tipo de bala disparado pela arma

    // Confirma se o objeto da bala é um filho de obj_bullet_parent
    if (object_is_ancestor(bullet, obj_bullet_parent)) {
        var damage = variable_instance_get(bullet, "damage");
        var damage_type = variable_instance_get(bullet, "damage_type");

        // Obtém o sprite do tipo de dano
        var sprite_damage = global.damages_sprites[damage_type];

        // Define a posição do sprite (à direita do texto "Nome")
        var sprite_x = sprite_portrait.x - 32 // Ajuste o valor conforme necessário
        var sprite_y = weapon_y + spacingy - 1;   // Ajuste o valor conforme necessário

        // Desenha o sprite de dano
        draw_sprite_ext(sprite_damage, 0, sprite_x, sprite_y, 0.6, 0.6, 0, c_white, 1);
		sprite_damage.depth = sprite_portrait.depth + 1

        // Exibe as demais informações abaixo do nome
        //draw_text_transformed(weapon_x + spacingx, weapon_y + spacingy * 2, "Fire Rate: " + string(current_weapon.fire_rate), 0.3, 0.3, 0);
        //draw_text_transformed(weapon_x + spacingx, weapon_y + spacingy * 3, "Dano: " + string(damage), 0.3, 0.3, 0);
    }
}
