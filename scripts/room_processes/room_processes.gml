/// @function room_templates() Returns a struct of predefined room layouts.
/// @description Initializes and returns a struct containing room templates. Each template is an array of 
///              object placement data, including positions, scales, and door directions.
/// @returns {Struct} A struct where keys are room names (e.g., "initial_room") and values are arrays of 
///                   object definitions. Example structure:
///                   {
///                     initial_room: [[obj_type, x, y, xscale, yscale, door_dir?], ...],
///                     next_room: [...],
///                     ...
///                   }
function room_templates() {
    var layouts = {};

	layouts.initial_room = [
		[obj_tile, 0.0, 0.0, 24.0, 13.5],
		[obj_solid, 0.0, 0.0, 48.000004, 2.0],
		[obj_solid, 0.0, 32.0, 1.687471, 25.0],
		[obj_solid, 12.0, 404.0, 47.250004, 1.75],
		[obj_solid, 741.0, 32.0, 1.9375001, 24.0],
		[obj_map_limit, 16.00003, 16.0, 15.333334, 6.25],
		[obj_blank, 0.0, 0.0, 48.0, 1.0],
		[obj_blank, 752.0, 16.0, 1.0, 26.0],
		[obj_blank, 0.0, 416.0, 47.0, 1.0],
		[obj_blank, 0.0, 16.0, 1.0, 25.0],
		[obj_door, 384.0, 26.0, 1.5333337, 1.703448, "top"],
		[obj_door, 27.0, 212.0, 0.13000005, 1.551724, "left"],
		[inverted_door, 27.0, 220.0, 0.13333334, 1.551724],
		[obj_door, 741.0, 212.72414, -0.1300001, 1.551724, "right"],
		[inverted_door, 741.0, 220.72414, -0.1333333, 1.551724],
		[obj_door, 384.0, 403.0, 1.5333333, 0.20689656, "bottom"]
	]
	
	layouts.next_room = [
		[obj_tile, 0.0, 0.0, 24.0, 13.5],
		[obj_solid, 0.0, 0.0, 48.000004, 2.0],
		[obj_solid, 0.0, 32.0, 1.687471, 25.0],
		[obj_solid, 12.0, 404.0, 47.250004, 1.75],
		[obj_solid, 741.0, 32.0, 1.9375001, 24.0],
		[obj_map_limit, 16.00003, 16.0, 15.333334, 6.25],
		[obj_blank, 0.0, 0.0, 48.0, 1.0],
		[obj_blank, 752.0, 16.0, 1.0, 26.0],
		[obj_blank, 0.0, 416.0, 47.0, 1.0],
		[obj_blank, 0.0, 16.0, 1.0, 25.0],
		[obj_door, 384.0, 26.0, 1.5333337, 1.703448, "top"],
		[obj_door, 27.0, 212.0, 0.13000005, 1.551724, "left"],
		[inverted_door, 27.0, 220.0, 0.13333334, 1.551724],
		[obj_door, 741.0, 212.72414, -0.1300001, 1.551724, "right"],
		[inverted_door, 741.0, 220.72414, -0.1333333, 1.551724],
		[obj_door, 384.0, 403.0, 1.5333333, 0.20689656, "bottom"]
	]
    return layouts;
}

/// @function build_room_at(layout, gx, gy) Instantiates a room layout at a grid position.
/// @description Places objects from a room template into the game world, offset by grid coordinates.
///              Draws a debug rectangle at the room's center and logs positions for validation.
/// @param {Array} layout The room template array (from `room_templates()`).
/// @param {Number} gx    The grid X-coordinate (e.g., 0, 1, -1).
/// @param {Number} gy    The grid Y-coordinate (e.g., 0, 1, -1).
/// @note Objects are placed relative to `WORLD_CENTER_X/Y` and scaled using `image_xscale/yscale`.
///       Doors with a `door_dir` parameter (e.g., "top") are tagged for connection logic.
function build_room_at(layout, gx, gy) {
    // Colocar a sala no centro do mundo e ajustar com o offset correto
    var base_x = WORLD_CENTER_X + gx * ROOM_WIDTH;
    var base_y = WORLD_CENTER_Y + gy * ROOM_HEIGHT;

    // Debug da colocação da sala
    show_debug_message("Building room at: (" + string(base_x) + ", " + string(base_y) + ")");

    for (var i = 0; i < array_length(layout); i++) {
        var obj = layout[i][0];
        
        // Os objetos são colocados relativos ao centro
        var _x = base_x + layout[i][1];  
        var _y = base_y + layout[i][2];

        var xscale = layout[i][3];
        var yscale = layout[i][4];

        // Debug da posição do objeto
        show_debug_message("Object " + string(i) + " position: (" + string(_x) + ", " + string(_y) + ")");

        var inst = instance_create_layer(_x, _y, "Instances", obj);
        inst.image_xscale = xscale;
        inst.image_yscale = yscale;

        if (array_length(layout[i]) > 5) {
            inst.door_dir = layout[i][5]; // opcional
        }
    }
	// Store the layout in the global map
    var key = string(gx) + "," + string(gy);
    ds_map_add(global.room_layout_map, key, layout);
}

/// @function layout_has_door(layout, dir) Checks if a room layout has a door in a specific direction.
/// @description Iterates through a room template to check for door objects with a matching `door_dir`.
/// @param {Array}  layout The room template array to check.
/// @param {String} dir    The door direction to test (e.g., "top", "left").
/// @returns {Boolean}     Returns `true` if the layout contains a door in the specified direction.
function layout_has_door(layout, dir) {
    for (var i = 0; i < array_length(layout); i++) {
        if (array_length(layout[i]) > 5 && layout[i][5] == dir) {
            return true;
        }
    }
    return false;
}

/// @function pick_layout_with_door(required_door) Randomly selects a room template with a specific door direction.
/// @description Filters room templates (excluding "initial_room") to find those compatible with the required door direction.
///              Returns a random valid template using `choose()`.
/// @param {String} required_door The door direction the layout must include (e.g., "bottom").
/// @returns {Array|Undefined} Returns a random valid room template or `undefined` if none match.
/// @note The "initial_room" template is explicitly skipped to prevent reuse.
function pick_layout_with_door(required_door) {
    var keys = variable_struct_get_names(global.room_templates);
    var valid_layouts = [];

    for (var i = 0; i < array_length(keys); i++) {
        var layout_name = keys[i];
        if (layout_name == "initial_room") continue;

        var layout = global.room_templates[? layout_name];
        if (layout_has_door(layout, required_door)) {
            array_push(valid_layouts, layout);
        }
    }

    return (array_length(valid_layouts) > 0 ? choose(valid_layouts) : undefined);
}

function get_room_layout(gx, gy) {
    var key = string(gx) + "," + string(gy);
    return ds_map_exists(global.room_layout_map, key) ? global.room_layout_map[? key] : undefined;
}

function transition_to_room(new_x, new_y, door_dir) {
    // Update the current room grid position
    global.current_room_x = new_x;
    global.current_room_y = new_y;

    // Calculate the new camera target
    global.target_cam_x = WORLD_CENTER_X + new_x * ROOM_WIDTH;
    global.target_cam_y = WORLD_CENTER_Y + new_y * ROOM_HEIGHT;

    // Reposition the player (example for "top" door)
    var player = bogalho;
    switch (door_dir) {
        case "top":
            player.y = global.target_cam_y + ROOM_HEIGHT - 64; // Bottom of new room
            break;
        case "bottom":
            player.y = global.target_cam_y + 64; // Top of new room
            break;
        case "left":
            player.x = global.target_cam_x + ROOM_WIDTH - 64; // Right of new room
            break;
        case "right":
            player.x = global.target_cam_x + 64; // Left of new room
            break;
    }
}

/// @function get_target_room(current_x, current_y, door_dir)
/// @description Calculates the target grid coordinates based on the current room and door direction.
/// @param {Number} current_x The current grid X-coordinate.
/// @param {Number} current_y The current grid Y-coordinate.
/// @param {String} door_dir   The door direction ("top", "bottom", "left", "right").
/// @returns {Struct}          A struct with `x` and `y` properties representing the target grid position.
function get_target_room(current_x, current_y, door_dir) {
    var target_x = current_x;
    var target_y = current_y;

    switch (door_dir) {
        case "top":    target_y--; break;
        case "bottom": target_y++; break;
        case "left":   target_x--; break;
        case "right":  target_x++; break;
    }

    return { x: target_x, y: target_y };
}

/// @function room_exists_at(gx, gy)
/// @description Checks if a room exists at the specified grid coordinates by verifying the key in `global.room_layout_map`.
/// @param {Number} gx Grid X-coordinate.
/// @param {Number} gy Grid Y-coordinate.
/// @returns {Boolean} `true` if the room exists, `false` otherwise.
function room_exists_at(gx, gy) {
    var key = string(gx) + "," + string(gy);
    return ds_map_exists(global.room_layout_map, key);
}