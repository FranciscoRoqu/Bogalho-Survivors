// Iterate through all instances of the parent object
with (obj_enemy_parent) 
{
	effect_create_above(ef_explosion, x, y, 50, c_red); // Explosion Effect
    instance_destroy(); // Destroy each enemy instance
}
audio_play_sound(sound_explosion_long,1,false)