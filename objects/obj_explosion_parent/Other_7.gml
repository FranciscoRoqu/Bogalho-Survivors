/// @description Destrói imediatamente esta instância e liberta os seus recursos  
instance_destroy();  // Função nativa que remove a instância atual da memória (ex: uso quando inimigo é derrotado)  

/**  
Parâmetros implícitos:  
- self (instância atual) - Destruída permanentemente  
Efeitos:  
- Remoção de todos os componentes associados (sprites, sons, variáveis)  
- Não dispara eventos futuros (ex: Step, Draw)  
Nota: Ação instantânea e irreversível  
**/  