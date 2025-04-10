if (global.is_transitioning) {
    // Increment progress (adjust 0.05 for speed)
    global.transition_progress = min(global.transition_progress + 0.05, 1);

    // Ease both camera and player
    var cam = view_camera[0];
    var cam_x = ease_out_quad(camera_get_view_x(cam), global.target_cam_x, global.transition_progress);
    var cam_y = ease_out_quad(camera_get_view_y(cam), global.target_cam_y, global.transition_progress);
    camera_set_view_pos(cam, cam_x, cam_y);

    // Ease player position
    bogalho.x = ease_out_quad(global.player_start_x, global.player_target_x, global.transition_progress);
    bogalho.y = ease_out_quad(global.player_start_y, global.player_target_y, global.transition_progress);

    // End transition
    if (global.transition_progress >= 1) {
        global.is_transitioning = false;
    }

    // Disable player input during transition
    bogalho.can_move = false;
	
	    // Transition completion check
    if (global.transition_progress >= 1) {
        global.is_transitioning = false;
        bogalho.is_transitioning = false; // Force-reset player’s transitioning state
        bogalho.can_move = true; // Ensure control is restored
    }
} else {
    // Re-enable input
    bogalho.can_move = true;
}