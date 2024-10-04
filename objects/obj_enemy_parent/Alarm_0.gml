/// @description
show_debug_message("Alarme")
switch(state)
{
	case states.DEAD:
		instance_destroy()
		break;
}