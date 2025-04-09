#macro ROOM_WIDTH 768
#macro ROOM_HEIGHT 432
#macro WORLD_CENTER_X 3840
#macro WORLD_CENTER_Y 2160
#macro Ts 16

enum states{
	IDLE,
	MOVE,
	ATTACK,
	DEAD,
	KNOCKBACK,
}

enum damages{
	RADIANT,	  // 0
	PHYSICAL	  // 1
}

global.damages_sprites = [
	sprite_the_power_of_the_sun,
	sprite_physical
]