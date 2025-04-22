event_inherited()
show_healthbar();

// Add to enemy Draw event
if keyboard_check(vk_control) {
    // Knockback direction arrow
    draw_set_color(c_orange);
    var end_x = x + lengthdir_x(30, knockback_direction);
    var end_y = y + lengthdir_y(30, knockback_direction);
    draw_arrow(x, y, end_x, end_y, 3);
    
    // Knockback stats
    draw_text_transformed(x, y-50, "KB Force: " + string(knockback_force), 0.25, 0.25, 0);
    draw_text_transformed(x, y-30, "KB Duration: " + string(knockback_duration), 0.25, 0.25, 0);
}

function draw_arrow(x1, y1, x2, y2, width) {
    draw_line_width(x1, y1, x2, y2, width);
    var dir = point_direction(x1, y1, x2, y2);
    draw_line_width(x2, y2, x2 + lengthdir_x(-10, dir-135), y2 + lengthdir_y(-10, dir-135), width);
    draw_line_width(x2, y2, x2 + lengthdir_x(-10, dir+135), y2 + lengthdir_y(-10, dir+135), width);
}