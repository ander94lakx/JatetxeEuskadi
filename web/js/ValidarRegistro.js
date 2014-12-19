window.addEventListener("load", iniciar, false);

var imagen = ""; // se guarda la imagen en una variable local para poder despues guardarla en el registro

function iniciar() {
    // Eventos relacionados con el formulario de registro
    document.getElementById("botonRegistrar").addEventListener('click',validarDatos, false);
    // Eventos relacionados con la imagen
    document.getElementById('cajaRe').addEventListener('dragover', permitirDrop, false);
    document.getElementById('cajaRe').addEventListener('drop', drop, false);
    document.getElementById('archivoRe').addEventListener('change', cargar, false);
    // Validacion en tiempo real
    document.registro.addEventListener("input", controlar, false);
    document.getElementById("dni").addEventListener("input", validarDNI, false);
}
    
function validarDatos(e) {
    
    if (document.getElementById('registro').checkValidity()) {        
        e.preventDefault();
        if(!validarDNI()) {
            alert("El DNI introducido no existe");
        }
    }   
}

// Partte relacionada con la validacion de los datos

function validarDNI() {
    var dni = document.getElementById("dni").value;
    var numero = dni.substr(0,dni.length-1);
    var let = dni.substr(dni.length-1,1);
    numero = numero % 23;
    var letra = 'TRWAGMYFPDXBNJZSQVHLCKET';
    letra = letra.substring(numero,numero+1);
    if (letra != let) {
        return false;
    }
    else {
        return true;
    }
}

// Metodos relacionados con la carga de la imagen

/*
 *  Notas:
 *      -> 'caja' es un div que contendrá la imagen
 *      -> 'archivo' es un input de tipo file par seleccionar la imagen manualmente
 */

function cargar(e) {
    var arch = new FileReader();
    arch.addEventListener('load', leer, false);
    arch.readAsDataURL(e.target.files[0]);
    arch.onloadend = function () {
        imagen = arch.result;
        console.log(imagen);
    };
}

function leer(e) {
    document.getElementById('cajaRe').style.backgroundImage = "url('" + e.target.result + "')";
}

function drop(e) {
    e.preventDefault();
    var arch = new FileReader();
    arch.addEventListener('load', leer, false);
    arch.readAsDataURL(e.dataTransfer.files[0]);
    arch.onloadend = function () {
        imagen = arch.result;
        console.log(imagen);
    };
}

function permitirDrop(e) {
    e.preventDefault();
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
        if(elemento == document.getElementById("dni")) {
            if(validarDNI())
                elemento.style.borderColor = '#64FE2E';
            else
                elemento.style.borderColor = '#FF0000';
        }
    } else {
        elemento.style.borderColor = '#FF0000';
    }
}

function validacion(evento) {
    var elemento = evento.target;
    elemento.style.borderColor = '#FF0000';
}
