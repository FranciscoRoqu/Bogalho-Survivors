// Set initial camera target to the starting room
global.target_cam_x = WORLD_CENTER_X + global.current_room_x * ROOM_WIDTH;
global.target_cam_y = WORLD_CENTER_Y + global.current_room_y * ROOM_HEIGHT;
global.is_transitioning = false;
global.transition_progress = 0;
global.player_start_x = 0;
global.player_start_y = 0;
global.player_target_x = 0;
global.player_target_y = 0;