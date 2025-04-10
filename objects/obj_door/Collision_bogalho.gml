if (global.transition_cooldown <= 0) { // Prevent spamming transitions
    var target_room = get_target_room(global.current_room_x, global.current_room_y, door_dir);
    
    if (room_exists_at(target_room.x, target_room.y)) {
        // Trigger transition
        transition_to_room(target_room.x, target_room.y, door_dir);
        
        // Optional: Add a brief cooldown (0.5 seconds)
        global.transition_cooldown = room_speed * 0.5;
    }
}