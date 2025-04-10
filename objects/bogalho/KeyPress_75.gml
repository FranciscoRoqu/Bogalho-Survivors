// Itera por todas as instâncias do objeto pai (ex: inimigos ativos)  
with (obj_enemy_parent) 
{
    // Efeito visual de explosão com configurações específicas:
    effect_create_above(ef_explosion, x, y, 50, c_red);  // (tipo, X, Y, intensidade, cor vermelha)
    instance_destroy(); // Destrói cada instância individualmente
}

// Efeito sonoro pós-destruição em massa  
audio_play_sound(sound_explosion_long,1,false)  // Reproduz som prolongado (prioridade 1, sem loop)  