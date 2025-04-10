/// @description
global.transition_cooldown -= 1; // Decrement cooldown each frame
if (global.transition_cooldown < 0) global.transition_cooldown = 0;