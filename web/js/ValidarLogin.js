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
        e.preventDefault();
        loguearUsuario();
    }   
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
