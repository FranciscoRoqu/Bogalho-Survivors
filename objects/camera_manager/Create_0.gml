// Set initial camera target to the starting room
global.target_cam_x = WORLD_CENTER_X + global.current_room_x * ROOM_WIDTH;
global.target_cam_y = WORLD_CENTER_Y + global.current_room_y * ROOM_HEIGHT;
global.is_transitioning = false;
global.transition_progress = 0;
global.player_start_x = 0;
global.player_start_y = 0;
global.player_target_x = 0;
global.player_target_y = 0;

global.show_full_map = false;
main_view = view_camera[0];
full_map_view = camera_create_view(0, 0, 7680, 4320); // Full dungeon size

// Configure viewports
view_visible[1] = false; // Start with minimap hidden
view_set_wport(1, 768);  // Same size as main view
view_set_hport(1, 432);