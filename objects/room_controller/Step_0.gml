/// @description Decrementa o cooldown de transição a cada frame e garante que não fique negativo
global.transition_cooldown -= 1; // Reduz o cooldown a cada frame
if (global.transition_cooldown < 0) global.transition_cooldown = 0; // Garante que não seja menor que 0