/// @desc Room creation logic

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

// Initial room
global.current_room_index = 0;

// Array that holds the hierarchy of rooms
global.room_hierarchy = [];


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
var last_room_id = 0;
room_gen(global.room_layouts[0], offset_x, offset_y, 0)

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
        global.room_id_counter += 1; // Increment the counter for the next room
		
		var chosen_room = candidate_rooms[irandom(array_length(candidate_rooms) - 1)];
		room_gen(chosen_room, offset_x + pos.offset[0], offset_y + pos.offset[1], new_room_id, last_room_id, get_opposite_door(pos.direction));
	}
	else
	{
		show_message("No room found with opposing doors");
	}
}

var room_number = irandom_range(global.room_id_counter + 6, 15);
var _room = undefined;
// Generate the other rooms
for(var i = 0; i < room_number; i++)
{
	var incomplete_rooms = [];  // Array to store the IDs of incomplete rooms
	// Loop through the room hierarchy to check each room
	for (var j = 0; j < global.room_id_counter; j++) 
	{
		_room = global.room_hierarchy[j];
		// Check if the room is incomplete by seeing if any side is not connected (-1)
		if (_room.bottom == -1
		or _room.right == -1
		or _room.left == -1
		or _room.top == -1)
		{
			if(_room.doors[0] == "bottom"
			or _room.doors[0] == "right"
			or _room.doors[0] == "left"
			or _room.doors[0] == "top")
			{
				// Add the room ID to the incomplete_rooms array
				array_push(incomplete_rooms, _room.id);
			}
		}

	}
	var random_incomplete = incomplete_rooms[irandom(array_length(incomplete_rooms) - 1)]
	var incomplete_directions = []
	_room = global.room_hierarchy[random_incomplete]
	if(_room.top == -1)
	{
		array_push(incomplete_directions, "top")
	}
	if(_room.bottom == -1)
	{
		array_push(incomplete_directions, "bottom")
	}
	if(_room.left == -1)
	{
		array_push(incomplete_directions, "left")
	}
	if(_room.right == -1)
	{
		array_push(incomplete_directions, "right")
	}
	var off_x = global.room_hierarchy[random_incomplete].offset_x
	var off_y = global.room_hierarchy[random_incomplete].offset_y
	var random_direction = irandom(array_length(incomplete_directions) - 1)
	random_direction = incomplete_directions[random_direction]
	switch(random_direction)
	{
		case "top":
			off_y = off_y - 432
		break;
		case "bottom":
			off_y = off_y + 432
		break;
		case "left":
			off_x = off_x - 768
		break;
		case "right":
			off_x = off_x + 768
		break;
	}
	room_gen(global.room_layouts[irandom_range(1, array_length(global.room_layouts) - 1)], off_x, off_y, global.room_id_counter, random_incomplete, get_opposite_door(random_direction))
	global.room_id_counter++
}

// Function to visualize room hierarchy
function visualize_room_hierarchy()
{
    // Loop through each room in the hierarchy and display its information
    for (var i = 0; i < array_length(global.room_hierarchy); i++)
    {
        var _room = global.room_hierarchy[i];
        
        // Format the room's details as a string
        var room_info = "Room ID: " + string(_room.id) + "\n";
        room_info += "  Top: " + (_room.top == -1 ? "None" : string(_room.top)) + "\n";
        room_info += "  Bottom: " + (_room.bottom == -1 ? "None" : string(_room.bottom)) + "\n";
        room_info += "  Left: " + (_room.left == -1 ? "None" : string(_room.left)) + "\n";
        room_info += "  Right: " + (_room.right == -1 ? "None" : string(_room.right)) + "\n";
        
        // Output the room info to the debug console or a message box
        show_debug_message(room_info);
    }
}

visualize_room_hierarchy();