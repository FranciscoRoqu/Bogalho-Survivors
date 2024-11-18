/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

// Inherit the parent event
event_inherited();

draw_healthbar(obj_game.x-20, obj_game.y-20, obj_game.x+20, obj_game.y-15, obj_player.hit_points/obj_player.hit_points_max*100, $0003300, $3232FF, $00B200, 0, true, true)