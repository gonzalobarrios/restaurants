# restaurants

Este proyecto simplemente muestra un listado de restaurantes. 
Version de Xcode: 14.0.1 
Version de Swift: 5

Utlice MVVM para separar la logica de UI de la logica de negocio. La logica de negocio reside en ViewModel y el ViewController solo se encarga de Crear y actualizar la UI.
Para el Netwroking creé un APIManager y utilizo Combine para hacer los Request y tambien el en el ViewModel para el manejo de las respuestas de los requests. 

Tambien creé un Loader y Cache de imagenes para que al scrollear sea mas perfomante. 

Para correr el proyecto simplemente es necesario descargar el proyecto y abrirlo con XCode. No hace falta instalar ninguna libreria dado que lo hice con los frameworks nativos que nos provee Swift.
