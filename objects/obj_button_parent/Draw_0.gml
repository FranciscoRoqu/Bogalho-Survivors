/// @description Desenha elementos visuais do botão (sprite + texto centralizado)  
draw_self()                     // Desenha o sprite padrão do objeto  

// Configurações de texto para UI  
draw_set_font(fnt_menu)         // Usa fonte específica para menus/interface  
draw_set_halign(fa_center)      // Alinhamento horizontal CENTRO (FA = Font Alignment)  
draw_set_valign(fa_middle)      // Alinhamento vertical MEIO  

// Desenho do texto principal  
draw_text(x, y, button_text)    // Renderiza texto centralizado nas coordenadas do botão  

// Reset de formatação para evitar efeitos colaterais  
draw_set_halign(fa_left)        // Restaura alinhamento horizontal padrão (esquerda)  
draw_set_valign(fa_top)         // Restaura alinhamento vertical padrão (topo)  