window.addEventListener("load", iniciar, false);

function iniciar() {
    // Eventos relacionados con el formulario de registro
    document.getElementById("botonEntrar").addEventListener('click',validarDatos, false);
}

function validarDatos(e) {
    
    if (document.getElementById('login').checkValidity()) {        
        //evento.preventDefault() impide que se complete el submit cuando la validación del formulario en HTML 5
        //es correcta y permite terminar con la validación necesaria en javascript.
        e.preventDefault();
        loguearUsuario();
    }   
}    

function loguearUsuario() {
    
    email = document.getElementById("email").value;
    contrasena = document.getElementById("contrasena").value;

    logueado = false;

    for(var f = 0; f < localStorage.length; f++){
        var clave = localStorage.key(f);
        var valor = JSON.parse(localStorage.getItem(clave));
        
        if(clave == email) {
            if(valor.contrasena == contrasena) {
                logueado = true;
                break;
            }
            else {
                alert("Contraseña incorrecta");
            }
        }
    }
    
    if(logueado) {
        // 
    } else {
        alert("El usuario no existe");
    }
}