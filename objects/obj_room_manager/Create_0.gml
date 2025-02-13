/// @desc Room creation logic
randomize()
random_set_seed(0)
global.room_layouts = [
    [
         [obj_door, 384.0, 403.0, 1.5333333, 0.20689656, "bottom"],
         [inverted_door, 741.0, 220.72414, -0.1333333, 1.551724],
         [obj_door, 741.0, 212.72414, -0.1300001, 1.551724, "right"],
         [inverted_door, 27.0, 220.0, 0.13333334, 1.551724],
         [obj_door, 27.0, 212.0, 0.13000005, 1.551724, "left"],
         [obj_door, 384.0, 26.0, 1.5333337, 1.703448, "top"],
         [obj_blank, 0.0, 16.0, 1.0, 25.0],
         [obj_blank, 0.0, 416.0, 47.0, 1.0],
         [obj_blank, 752.0, 16.0, 1.0, 26.0],
         [obj_blank, 0.0, 0.0, 48.0, 1.0],
         [obj_map_limit, 16.00003, 16.0, 15.333334, 6.25],
         [obj_solid, 741.0, 32.0, 1.9375001, 24.0],
         [obj_solid, 12.0, 404.0, 47.250004, 1.75],
         [obj_solid, 0.0, 32.0, 1.687471, 25.0],
         [obj_solid, 0.0, 0.0, 48.000004, 2.0],
         [obj_tile, 0.0, 0.0, 24.0, 13.5]
	],
	[
		 [obj_door, 384.0, 403.0, 1.5333333, 0.20689656, "bottom"],
         [inverted_door, 741.0, 220.72414, -0.1333333, 1.551724],
         [obj_door, 741.0, 212.72414, -0.1300001, 1.551724, "right"],
         [inverted_door, 27.0, 220.0, 0.13333334, 1.551724],
         [obj_door, 27.0, 212.0, 0.13000005, 1.551724, "left"],
         [obj_door, 384.0, 26.0, 1.5333337, 1.703448, "top"],
         [obj_blank, 0.0, 16.0, 1.0, 25.0],
         [obj_blank, 0.0, 416.0, 47.0, 1.0],
         [obj_blank, 752.0, 16.0, 1.0, 26.0],
         [obj_blank, 0.0, 0.0, 48.0, 1.0],
         [obj_map_limit, 16.00003, 16.0, 15.333334, 6.25],
         [obj_solid, 741.0, 32.0, 1.9375001, 24.0],
         [obj_solid, 12.0, 404.0, 47.250004, 1.75],
         [obj_solid, 0.0, 32.0, 1.687471, 25.0],
         [obj_solid, 0.0, 0.0, 48.000004, 2.0],
         [obj_tile, 0.0, 0.0, 24.0, 13.5]
	]
];
// Initialize global storage
global.rooms = [];
global.rooms_by_position = ds_map_create();

// Initial room
global.current_room_index = 0;

// Define offsets and corresponding doors
var room_positions = [
    {offset: [0, -432], direction: "top"},
    {offset: [0, 432], direction: "bottom"},
    {offset: [-768, 0], direction: "left"},
    {offset: [768, 0], direction: "right"}
];

global._offset_x = 3840;
global._offset_y = 2160;
var offset_x = global._offset_x;
var offset_y = global._offset_y;
var offsets = []
var last_room_id = 0;
var retry;
// Create Room 0
var room_0 = add_room(undefined, undefined, 0, global.room_layouts[0], offset_x, offset_y)

// Store the root room for reference
global.root_room = room_0;
room_gen(global.room_layouts[0], offset_x, offset_y)

// Room ID counter for unique room IDs
global.room_id_counter = 1;
for(var i = 0; i < 4; i++)
{
	var pos = room_positions[i];
	var candidate_rooms = [] //Rooms that have an opposite door
	
	for(var j = 1; j < array_length(global.room_layouts); j++)
	{
		if(has_opposite_door(global.room_layouts[j], pos.direction))
		{
			array_push(candidate_rooms, global.room_layouts[j])
		}
	}
	// Randomly choose a room from the candidates
	if(array_length(candidate_rooms) > 0)
	{
		// Assign a unique ID to the room
        var new_room_id = global.room_id_counter;
		
		var chosen_room = candidate_rooms[irandom(array_length(candidate_rooms) - 1)];
		room_gen(chosen_room, offset_x + pos.offset[0], offset_y + pos.offset[1]);
		do {
		    retry = add_room(global.root_room, pos.direction, global.room_id_counter, chosen_room, offset_x + pos.offset[0], offset_y + pos.offset[1])
		} until (retry != undefined);
		global.room_id_counter += 1; // Increment the counter for the next room
	}
	else
	{
		show_message("No room found with opposing doors");
	}
}
var room_number = irandom_range(global.room_id_counter + 3, 15);
var current_room = undefined
for(var i = global.room_id_counter; i < room_number; i++)
{
	var incomplete_rooms = [];
	for(var j = 0; j < array_length(global.rooms); j++)
	{
		current_room = global.rooms[j]
		if(current_room.top == undefined
		or current_room.bottom == undefined
		or current_room.left == undefined
		or current_room.right == undefined)
		{
			if(current_room.doors[0].direction == "top"
			or current_room.doors[0].direction == "bottom"
			or current_room.doors[0].direction == "left"
			or current_room.doors[0].direction == "right")
			{
				array_push(incomplete_rooms, current_room)
			}
		}
	}
	do {
		var random_incomplete = incomplete_rooms[irandom(array_length(incomplete_rooms) - 1)];
		var random_incomplete_id = random_incomplete.id
		var incomplete_directions = [];
		current_room = global.rooms[random_incomplete_id]
		if(current_room.top == undefined)
		{
			array_push(incomplete_directions, "top")
		}
			if(current_room.bottom == undefined)
		{
			array_push(incomplete_directions, "bottom")
		}
			if(current_room.left == undefined)
		{
			array_push(incomplete_directions, "left")
		}
			if(current_room.right == undefined)
		{
			array_push(incomplete_directions, "right")
		}
		offsets = current_room.offsets
	    var random_direction_number = irandom(array_length(incomplete_directions) - 1)
		var random_direction = incomplete_directions[random_direction_number]
		switch(random_direction)
		{
			case "top":
				offsets[1] = offsets[1] - 432
			break;
			case "bottom":
				offsets[1] = offsets[1] + 432
			break;
			case "left":
				offsets[0] = offsets[0] - 768
			break;
			case "right":
				offsets[0] = offsets[0] + 768
			break;
		}
		var room_layout = global.room_layouts[irandom_range(1, array_length(global.room_layouts) - 1)]
		retry = add_room(random_incomplete, random_direction, global.room_id_counter, room_layout, offsets[0], offsets[1])
	} until (retry != undefined);

	global.room_id_counter++
	room_gen(room_layout, offsets[0], offsets[1])	
}
show_message(global.rooms[0].offsets)