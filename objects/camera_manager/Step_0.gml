var cam = view_camera[0];
var current_x = camera_get_view_x(cam);
var current_y = camera_get_view_y(cam);
var progress = 0.04; // Adjust for speed (0.1 = slower, 0.3 = faster)

// Apply easing
camera_set_view_pos(
    cam,
    ease_out_quad(current_x, global.target_cam_x, progress),
    ease_out_quad(current_y, global.target_cam_y, progress)
);