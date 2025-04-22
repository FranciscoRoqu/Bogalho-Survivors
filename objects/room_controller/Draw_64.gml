if (global.show_minimap) {
    var map_x = MINIMAP_PADDING;
    var map_y = MINIMAP_PADDING + 30;
    
    // Add spacing between rooms
    var CELL_SPACING = 1.75; // Pixels between rooms
    var ROOM_SIZE = MINIMAP_CELL_SIZE - CELL_SPACING;
    
    // Calculate total map size with spacing
    var total_width = global.grid_width * MINIMAP_CELL_SIZE;
    var total_height = global.grid_height * MINIMAP_CELL_SIZE;
    
    // Draw background
    draw_set_color(make_color_rgb(0, 0, 0));
	draw_set_alpha(0.5)
    draw_rectangle(map_x, map_y, map_x + total_width, map_y + total_height, false);
    
    // Draw rooms
	draw_set_alpha(1)
    for(var xx = 0; xx < global.grid_width; xx++) {
        for(var yy = 0; yy < global.grid_height; yy++) {
            if(ds_grid_get(global.room_grid, xx, yy) != -1) {
                // Calculate position with spacing
                var xpos = (map_x - 5) + (xx * MINIMAP_CELL_SIZE) + CELL_SPACING;
                var ypos = (map_y - 5) + (yy * MINIMAP_CELL_SIZE) + CELL_SPACING;
                
                var col = (xx == global.current_room_x + 5 && yy == global.current_room_y + 5) 
                    ? CURRENT_ROOM_COLOR 
                    : MINIMAP_COLOR;
                
                // Draw smaller rectangle with spacing
                draw_set_color(col);
                draw_rectangle(xpos, ypos, 
                    xpos + ROOM_SIZE, 
                    ypos + ROOM_SIZE, 
                    true);
            }
        }
    }
    draw_set_color(c_white);
}