if (current_weapon != noone) {
    // Configurações visuais
    var spacingx = 10;
    var spacingy = 18; // Espaço entre as linhas

    // Acessa os stats da arma
    var weapon_x = obj_weaponinfoPos.x;
    var weapon_y = obj_weaponinfoPos.y;

    // Acessa o objeto da bala para exibir o dano
    var bullet = current_weapon.weapon_bullet; // Tipo de bala disparado pela arma

    // Confirma se o objeto da bala é um filho de obj_bullet_parent
    if (object_is_ancestor(bullet, obj_bullet_parent)) {
        var damage = variable_instance_get(bullet, "damage");
        var damage_type = variable_instance_get(bullet, "damage_type");

        // Obtém o sprite do tipo de dano
        var sprite_damage = global.damages_sprites[damage_type];

        // Define a posição do sprite do tipo de dano em relação ao retrato
        var portrait_x = sprite_portrait.x;  // Posição X do retrato
        var portrait_y = sprite_portrait.y;  // Posição Y do retrato
        var sprite_x = portrait_x;           // Centraliza horizontalmente com o retrato
        var sprite_y = portrait_y + sprite_height + 8; // Alinha abaixo do retrato (ajuste o + 8 conforme necessário)

        // Define a profundidade para garantir que fique atrás do retrato
        var previous_depth = depth; // Salva a profundidade atual
        depth = sprite_portrait.depth + 1; // Garante que seja desenhado antes do retrato

        // Desenha o sprite de dano
        draw_sprite_ext(sprite_damage, 0, sprite_x, sprite_y, 0.6, 0.6, 0, c_white, 1);

        // Restaura a profundidade anterior (opcional, se houver outros elementos)
        depth = previous_depth;
    }
}
