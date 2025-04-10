/// @description Estado de morte: congela animação e define visual final  
switch(state)  
{  
    case states.DEAD:  
        image_speed = 0;          // Congela a animação no frame atual  
        image_index = image_number - 1;  // Define o frame para o último da sequência (ex: corpo caído)  
    break;  
}  