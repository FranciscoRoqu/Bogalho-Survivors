function enemy_take_damage() {
    if(state == enemy_state.active) {
        state = enemy_state.staggered;
        // Short knockback
        motion_set(point_direction(bogalho.x, bogalho.y, x, y), 8);
        alarm[0] = 15; // Stagger duration
    }
}

function update_facing() {
    if path_exists(path) && path_get_number(path) > 0 {
        // Get next path point coordinates
        var next_x = path_get_point_x(path, 0);
        var dx = next_x - x;
        
        // Horizontal direction only
        if dx != 0 {
            facing = sign(dx) * -1; // 1 for right, -1 for left
        }
    }
}

function collision() {
    // Horizontal collision
    if place_meeting(x + hspeed, y, obj_solid) {
        while(!place_meeting(x + sign(hspeed), y, obj_solid)) {
            x += sign(hspeed);
        }
        hspeed = 0;
    }
    
    // Vertical collision
    if place_meeting(x, y + vspeed, obj_solid) {
        while(!place_meeting(x, y + sign(vspeed), obj_solid)) {
            y += sign(vspeed);
        }
        vspeed = 0;
    }
}