// Smoothly move the camera toward the target position
var cam = view_camera[0];
var lerp_speed = 0.1; // Adjust for faster/slower movement

// Update the camera position
camera_set_view_pos(
    cam,
    lerp(camera_get_view_x(cam), global.target_cam_x, lerp_speed),
    lerp(camera_get_view_y(cam), global.target_cam_y, lerp_speed)
);