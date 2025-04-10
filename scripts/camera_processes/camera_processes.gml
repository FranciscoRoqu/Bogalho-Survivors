/// @function ease_out_quad(current, target, progress)  
/// @description Aplica interpolação com efeito de atenuação quadrática (ease-out)  
/// @param {Number} current  Posição atual da câmera (ex: coordenada X/Y atual)  
/// @param {Number} target   Posição-alvo da câmera (ex: destino da transição)  
/// @param {Number} progress Progresso normalizado da animação (0 a 1)  
/// @returns {Number}         Valor interpolado com efeito de atenuação quadrática  
function ease_out_quad(current, target, progress) {  
    var change = target - current;  // Calcula diferença entre destino e posição atual  
    return change * (1 - (1 - progress) * (1 - progress)) + current;  // Fórmula de easing quadrático (progress² em saída)  
}  