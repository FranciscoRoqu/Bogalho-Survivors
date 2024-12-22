event_inherited()
state = states.IDLE
move_speed = 1.75
facing = 1
up=0
down=0
left=0
right=0
aim_dir=0
can_fire = false
player_controlled = true

alarm[0] = 20


random_num = ceil(random(1000000))
show_debug_message(random_num)
if random_num == 1
{
	state = states.DEAD
}