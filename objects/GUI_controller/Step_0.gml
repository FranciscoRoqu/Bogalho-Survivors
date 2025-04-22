if(keyboard_check_pressed(vk_tab))
{
	if(bogalho.current_weapon != noone)
	{
		global.showInfo = !global.showInfo;
		alarm[0] = room_speed * 10
	}
}
if(global.showInfo)
{
	targetX1 = 75;
}
else
{
	targetX1 = -100;
	alarm[0] = -1;
}
if(bogalho.current_weapon == noone)
{
	global.showInfo = false
}