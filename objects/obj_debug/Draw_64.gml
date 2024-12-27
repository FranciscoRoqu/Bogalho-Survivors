var w = display_get_gui_width();  // GUI width (screen width)
var h = display_get_gui_height(); // GUI height (screen height)

// Set alignment to bottom-right
draw_set_halign(fa_right);
draw_set_valign(fa_bottom);

// Draw the FPS text, scaled
draw_text_transformed(w - 10, h - 5, "FPS: " + string(fps), 0.35, 0.35, 0);

draw_set_halign(fa_left)
draw_set_valign(fa_bottom)
draw_text_transformed(10, h - 5, "Instance count: " + string(instance_count), 0.35, 0.35, 0)