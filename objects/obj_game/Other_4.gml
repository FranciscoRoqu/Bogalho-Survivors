/// @description
#macro Ts 16

global.grid = mp_grid_create(0, 0, ceil(room_width / Ts), ceil(room_height / Ts), Ts, Ts)
mp_grid_add_instances(global.grid, obj_solid,true)