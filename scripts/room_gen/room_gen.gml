function build_room_at(layout, gx, gy) {
    // Colocar a sala no centro do mundo e ajustar com o offset correto
    var base_x = WORLD_CENTER_X + gx * ROOM_WIDTH;
    var base_y = WORLD_CENTER_Y + gy * ROOM_HEIGHT;

    // Debug output for room placement
    show_debug_message("Building room at: (" + string(base_x) + ", " + string(base_y) + ")");

    for (var i = 0; i < array_length(layout); i++) {
        var obj = layout[i][0];
        
        // Os objetos são colocados relativos ao centro
        var _x = base_x + layout[i][1];  
        var _y = base_y + layout[i][2];

        var xscale = layout[i][3];
        var yscale = layout[i][4];

        // Debug the object position
        show_debug_message("Object " + string(i) + " position: (" + string(_x) + ", " + string(_y) + ")");

        var inst = instance_create_layer(_x, _y, "Instances", obj);
        inst.image_xscale = xscale;
        inst.image_yscale = yscale;

        if (array_length(layout[i]) > 5) {
            inst.door_dir = layout[i][5]; // optional
        }
    }

    // Debugging: Draw a small red square at the room's center
    draw_set_color(c_red);
    draw_rectangle(base_x - 5, base_y - 5, base_x + 5, base_y + 5, false);
}