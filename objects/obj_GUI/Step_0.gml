if(keyboard_check_pressed(vk_tab))
{
	showInfo = !showInfo;
	alarm[0] = room_speed * 10;
}
if(showInfo)
{
	targetX1 = 75;
}
else
{
	targetX1 = -100;
	alarm[0] = -1;
}