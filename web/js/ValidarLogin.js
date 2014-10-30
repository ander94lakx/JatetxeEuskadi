window.addEventListener("load", iniciar, false);

function iniciar() {
    // Eventos relacionados con el formulario de registro
    document.getElementById("botonEntrar").addEventListener('click',validarDatos, false);
    // Validacion en tiempo real
    document.login.addEventListener("invalid", validacion, true);
    document.login.addEventListener("input", controlar, false);
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
    contrasena = obtenerHash(document.getElementById("contrasena").value);

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
        sessionStorage.removeItem("usuarioActual");
        sessionStorage.setItem("usuarioActual", email);
    } else {
        alert("El usuario no existe");
    }
}

// Funcion para obtener el hash de la contraseña
function obtenerHash(cadena) {
    var hash = 0;
    var i, chr, len;
    if(cadena.length == 0)
        return hash;
    for(i = 0, len = cadena.length; i < len; i++) {
        chr = cadena.charCodeAt(i);
        hash = ((hash << 5) - hash) + chr;
        hash |=0;
    }
    return hash;
}

//Se controla en tiempo real los cambios en los inputs
function controlar(evento) {
    var elemento = evento.target;
    if (elemento.validity.valid) {
        elemento.style.borderColor = '#64FE2E';
    } else {
        elemento.style.borderColor = '#FF0000';
    }
}

function validacion(evento) {
    var elemento = evento.target;
    elemento.style.borderColor = '#FF0000';
}
