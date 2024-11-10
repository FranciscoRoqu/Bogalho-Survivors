// Defina os limites da janela do jogo
var left_limit = window_get_x() + 17;
var right_limit = window_get_x() - 17 + window_get_width() - 17;
var top_limit = window_get_y() + 17;
var bottom_limit = window_get_y() - 17 + window_get_height() - 17;

// Verifique a posição do mouse e mantenha-o dentro da área da janela
var mouse_pos_x = display_mouse_get_x();
var mouse_pos_y = display_mouse_get_y();

if (mouse_pos_x < left_limit) {
    window_mouse_set(left_limit, mouse_pos_y);
}
else if (mouse_pos_x > right_limit) {
    window_mouse_set(right_limit, mouse_pos_y);
}

if (mouse_pos_y < top_limit) {
    window_mouse_set(mouse_pos_x, top_limit);
}
else if (mouse_pos_y > bottom_limit) {
    window_mouse_set(mouse_pos_x, bottom_limit);
}
