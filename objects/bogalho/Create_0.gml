event_inherited()
state = states.IDLE
initial_moveSpeed = 2.75
move_speed = initial_moveSpeed
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

alarm[0] = 20


random_num = ceil(random(1000000))
if random_num == 1
{
	state = states.DEAD
}