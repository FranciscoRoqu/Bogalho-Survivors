
/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

if(collided)

{
	// Calcula a nova posição da câmera
	// Posição atual da câmera
	var camera = view_camera[0];
	var current_camera_x = camera_get_view_x(camera);
	var current_camera_y = camera_get_view_y(camera);
	
	// Objetivo (nova sala)
	var target_camera_x = _offset_x;
	var target_camera_y = _offset_y;
	
	// Interpolação suave
	var smooth_speed = 0.075; // Quanto menor, mais suave
	var new_camera_x = lerp(current_camera_x, target_camera_x, smooth_speed);
	var new_camera_y = lerp(current_camera_y, target_camera_y, smooth_speed);
	
	
	// Atualiza a posição da câmera
	camera_set_view_pos(camera, new_camera_x, new_camera_y);
}