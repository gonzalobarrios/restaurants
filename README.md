# restaurants

Este proyecto simplemente muestra un listado de restaurantes. 
Version de Xcode: 14.0.1 
Version de Swift: 5

Utlice MVVM para separar la logica de UI de la logica de negocio. La logica de negocio reside en ViewModel y el ViewController solo se encarga de Crear y actualizar la UI.
Para el Netwroking creé un APIManager y utilizo Combine para hacer los Request y tambien el en el ViewModel para el manejo de las respuestas de los requests. 

Tambien creé un Loader y Cache de imagenes para que al scrollear sea mas perfomante. 

La interfaz de usuario es simple pero lo importante segun la letra es hacerla sin el uso de Storyboards ni Xibs, por lo cual lo hice puramente programatica 
lo cual es importante porque si hay algun error de UI es mas facil de corregirlo e identificarlo. 

Para correr el proyecto simplemente es necesario descargar el proyecto y abrirlo con XCode. No hace falta instalar ninguna libreria dado que lo hice con los frameworks nativos que nos provee Swift.



<img width="431" alt="image" src="https://user-images.githubusercontent.com/8472089/202293603-1c13a795-9c61-4441-9fa7-a0c7495c0e4a.png">
