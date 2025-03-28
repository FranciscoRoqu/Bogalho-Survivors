event_inherited()
state = states.IDLE
move_speed = 2.75
max_speed = move_speed
facing = 1
up=0
down=0
left=0
right=0
aim_dir=0
can_fire = false
player_controlled = true
pathing = false
collided = false
path = path_add()
mp_grid = noone

alarm[0] = 20


random_num = ceil(random(1000000))
if random_num == 1
{
	state = states.DEAD
}