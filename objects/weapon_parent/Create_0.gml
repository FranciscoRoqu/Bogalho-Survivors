/// @description Cria uma nova instância de projétil na camada "Bullet"  
// Você pode configurar propriedades adicionais do projétil abaixo  
temp_bullet = instance_create_layer(  
    room_width, room_height,   // Posição: canto inferior direito da sala (borda máxima X/Y)  
    "Bullet",                  // Camada de renderização dedicada a projéteis  
    weapon_bullet              // Objeto a ser instanciado (template do projétil)  
);  