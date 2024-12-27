draw_healthbar(10, 10, 200, 25, obj_player.hit_points/obj_player.hit_points_max*100, c_dkgray, $3232FF, $00B200, 0, true, true)
draw_sprite_ext(sprite_healthbar, -1, 2, 6, 2.15, 1.1, 0, c_white, 1)
var w = display_get_gui_width();  // GUI width (screen width)
var h = display_get_gui_height(); // GUI height (screen height)

if(obj_player.current_weapon != noone)
{

	var weapon = obj_player.current_weapon;
	var bullet = weapon.weapon_bullet
	
	if (object_is_ancestor(bullet, obj_bullet_parent)) 
	{
		var damage = variable_instance_get(bullet, "damage");
		var damage_type = variable_instance_get(bullet, "damage_type");
		
		var sprite_damage_type = global.damages_sprites[damage_type];
		
		currentX = lerp(currentX, targetX1, 0.1);
		draw_sprite_ext(sprite_info, -1, currentX, 125, 1.5, 1.5, 0, c_white, 1);
		draw_sprite_ext(sprite_damage_type, -1, currentX, 85, 0.65, 0.65, 0, c_white, 1);
		draw_sprite_ext(sprite_portrait, -1, currentX, 85, 1, 1, 0, c_white, 1);
		
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		draw_text_transformed(currentX, 50, weapon.weapon_name, 0.35, 0.35, 0);
		
		draw_sprite_ext(sprite_damage,1,currentX - 40, 125, 1, 1, 0, c_white, 1);
		
		draw_set_halign(fa_left);
		draw_set_valign(fa_middle);
		draw_text_transformed(currentX - 15, 125, string(damage), 0.35, 0.35, 0);
		
		draw_sprite_ext(sprite_attack_speed, -1, currentX - 40, 150, 0.85, 0.85, 0, c_white, 1);
		
		draw_set_halign(fa_left);
		draw_set_valign(fa_middle);
		draw_text_transformed(currentX - 15, 150, string(weapon.fire_rate / game_get_speed(gamespeed_fps)) + "s", 0.35, 0.35, 0)
		
		draw_sprite_ext(sprite_move_speed, -1, currentX - 40, 174, 0.9, 0.9, 0, c_white, 1);
		
		draw_set_halign(fa_left);
		draw_set_valign(fa_middle);
		draw_text_transformed(currentX - 15, 174, string(obj_player.move_speed), 0.35, 0.35, 0)
	}
}

//if (current_weapon != noone) {
//    // Configurações visuais
//    var spacingx = 10;
//    var spacingy = 18; // Espaço entre as linhas

//    // Acessa os stats da arma
//    var weapon_x = obj_weaponinfoPos.x;
//    var weapon_y = obj_weaponinfoPos.y;

//    // Acessa o objeto da bala para exibir o dano
//    var bullet = current_weapon.weapon_bullet; // Tipo de bala disparado pela arma

//    // Confirma se o objeto da bala é um filho de obj_bullet_parent
//    if (object_is_ancestor(bullet, obj_bullet_parent)) {
//        var damage = variable_instance_get(bullet, "damage");
//        var damage_type = variable_instance_get(bullet, "damage_type");

//        // Obtém o sprite do tipo de dano
//        var sprite_damage = global.damages_sprites[damage_type];

//        // Define a posição do sprite do tipo de dano em relação ao retrato
//        var portrait_x = obj_portrait.x;  // Posição X do retrato
//        var portrait_y = obj_portrait.y;  // Posição Y do retrato
//        var sprite_x = portrait_x;           // Centraliza horizontalmente com o retrato
//        var sprite_y = portrait_y; // Alinha abaixo do retrato (ajuste o + 8 conforme necessário)
		
//		if(!instance_exists(obj_sprite_damage)) {
//			instance_create_layer(sprite_x,sprite_y,"gunCard",obj_sprite_damage)
//			obj_sprite_damage.depth = obj_portrait.depth + 1
//			obj_info.depth = obj_sprite_damage.depth + 1
//			obj_sprite_damage.image_xscale = 0.6
//			obj_sprite_damage.image_yscale = 0.6
//		}
//		obj_sprite_damage.sprite_index = sprite_damage
//    }
//}
//if(current_weapon == noone && instance_exists(obj_sprite_damage)) {
//	instance_destroy(obj_sprite_damage)
//}