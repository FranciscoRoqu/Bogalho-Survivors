/// @description

if keyboard_check(vk_alt){
	mp_grid_draw(global.grid)
	draw_set_alpha(0.5)
}
else
{
	draw_set_alpha(1)
}