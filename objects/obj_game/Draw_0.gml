/// @description

// Set the color and font (optional)
draw_set_color(c_white);   // Set text color to white (or choose any color you prefer)
draw_set_font(-1);         // Use the default font, or set a custom one if you have one

// Draw FPS at the top-left corner (10 pixels from top and left edge for padding)
draw_text(10, 30, "FPS: " + string(fps_real));
