/// @description Camera transition
var target_camera_x = 0
var target_camera_y = 0
var camera = view_camera[0];
if(begin_transition)
{
	// Current camera position
	var current_camera_x = camera_get_view_x(camera);
	var current_camera_y = camera_get_view_y(camera);
	
	// Objective (new room)
	target_camera_x = global._offset_x;
	target_camera_y = global._offset_y;
	
	// Smooth interpolation
	var smooth_speed = 0.09; // Lower = smoother
	var new_camera_x = lerp(current_camera_x, target_camera_x, smooth_speed);
	var new_camera_y = lerp(current_camera_y, target_camera_y, smooth_speed);
	
	// Update camera position
	camera_set_view_pos(camera, new_camera_x, new_camera_y);
}
// If the camera reached it's destination
if(camera_get_view_x(camera) == target_camera_x and 
   camera_get_view_y(camera) == target_camera_y)
{
	begin_transition = false
}
