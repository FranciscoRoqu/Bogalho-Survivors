/// @description Remove seletivamente uma instância de projétil com controle de timing  
instance_destroy(  
    temp_bullet,     // Instância específica a ser destruída (ex: bala perdida ou obsoleta)  
    false            // Destruição não imediata (processada no final do step atual)  
);  

/**  
Funcionamento detalhado:  
- Parâmetro 1 (temp_bullet):  
  - Referência exata ao projétil criado anteriormente  
  - Evita destruir outras instâncias por engano  

- Parâmetro 2 (false):  
  - Destruição segura: permite conclusão da lógica do frame atual  
  - Útil quando outros sistemas ainda interagem com a instância  
**/  