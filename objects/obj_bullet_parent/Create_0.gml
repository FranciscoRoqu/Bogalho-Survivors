/// @description

function bullet_die()
{
	speed = 0
	instance_change(bullet_explosion, false)
}

// No Create Event de obj_bullet_parent ou seus filhos
if (!variable_global_exists("damage")) damage = 1 // Dano padrão
if (!variable_global_exists("damage_type")) damage_type = "Físico"; // Tipo de dano padrão
