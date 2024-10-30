global.grid = 0
global.drag = 0.93
cursor_sprite = sprite_cursor
window_set_cursor(cr_none)

window_set_fullscreen(true)
camera_set_view_size(view_camera[0], 768, 432)
var base_w = 768;
var base_h = 432;
var aspect = base_w / base_h ; // get the GAME aspect ratio
if (display_get_width() < display_get_height())
    {
    //portrait
    var ww = min(base_w, display_get_width());
    var hh = ww / aspect;
    }
else
    {
    //landscape
    var hh = min(base_h, display_get_height());
    var ww = hh * aspect;
    }
surface_resize(application_surface, ww, hh);