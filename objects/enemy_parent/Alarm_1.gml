/// @description
global.particle_system = part_system_create();
global.blood_particles = part_type_create();

// Configure blood particles
part_type_shape(global.blood_particles, pt_shape_smoke);
part_type_size(global.blood_particles, 0.4, 0.8, 0.02, 0);
part_type_color2(global.blood_particles, c_maroon, c_red);
part_type_speed(global.blood_particles, 2, 6, 0, 0);
part_type_direction(global.blood_particles, 0, 359, 0, 0);
part_type_alpha3(global.blood_particles, 1, 0.8, 0);
part_type_life(global.blood_particles, 20, 40);
image_alpha -= 0.04;
image_blend = merge_color(image_blend, c_red, 0.3);
image_angle += 10; // Spin effect