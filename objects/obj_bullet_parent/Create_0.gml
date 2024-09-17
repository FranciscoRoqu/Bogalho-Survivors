/// @description
range=160
owner_id = noone
knockback_time = 5

function bullet_die()
{
	speed = 0
	instance_change(bullet_explosion, false)
}