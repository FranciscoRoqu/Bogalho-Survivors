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
        var portrait_x = obj_portrait.x;  // Posição X do retrato
        var portrait_y = obj_portrait.y;  // Posição Y do retrato
        var sprite_x = portrait_x;           // Centraliza horizontalmente com o retrato
        var sprite_y = portrait_y; // Alinha abaixo do retrato (ajuste o + 8 conforme necessário)
		
		if(!instance_exists(obj_sprite_damage)) {
			instance_create_layer(sprite_x,sprite_y,"gunCard",obj_sprite_damage)
			obj_sprite_damage.depth = obj_portrait.depth + 1
			obj_info.depth = obj_sprite_damage.depth + 1
			obj_sprite_damage.image_xscale = 0.6
			obj_sprite_damage.image_yscale = 0.6
		}
		obj_sprite_damage.sprite_index = sprite_damage
    }
}
if(current_weapon == noone && instance_exists(obj_sprite_damage)) {
	instance_destroy(obj_sprite_damage)
}