/// @description Desenha botão com texto redimensionado e centralizado  
draw_self()                            // Renderiza o sprite/base do botão  

// Configura alinhamento centralizado para o texto  
draw_set_halign(fa_center)             // Horizontal: centro (FA = Fonte Alinhamento)  
draw_set_valign(fa_middle)             // Vertical: meio  

// Desenha texto com escala reduzida (40% do tamanho original)  
draw_text_transformed(x, y, button_text, 0.4, 0.4, 0)  // (X, Y, texto, escala_X, escala_Y, rotação)  

// Restaura configurações padrão de alinhamento  
draw_set_halign(fa_left)               // Horizontal: esquerda (padrão)  
draw_set_valign(fa_top)                // Vertical: topo (evita afetar outros elementos UI)  