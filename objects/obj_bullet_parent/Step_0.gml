/// @description Verifica se a bala excedeu o alcance máximo permitido  
var _dis = point_distance(xstart, ystart, x, y);  // Calcula distância percorrida desde o ponto inicial  

// Lógica de autodestruição por distância excessiva  
if (_dis > range) {  
    bullet_die();  // Ativa efeito de destruição (ex: explosão/desaparecimento)  
}  