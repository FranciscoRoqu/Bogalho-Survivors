draw_healthbar(10, 10, 200, 25, bogalho.hit_points/bogalho.hit_points_max*100, c_dkgray, $3232FF, $00B200, 0, true, true)
draw_sprite_ext(sprite_healthbar, -1, 2, 6, 2.15, 1.1, 0, c_white, 1)
var w = display_get_gui_width();  // GUI width (screen width)
var h = display_get_gui_height(); // GUI height (screen height)

if(bogalho.current_weapon != noone)
{
	var weapon = bogalho.current_weapon;
	var bullet = weapon.weapon_bullet;
	
	if (object_is_ancestor(bullet, bullet_parent)) 
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
		draw_text_transformed(currentX - 15, 174, string(bogalho.move_speed), 0.35, 0.35, 0)
	}
}