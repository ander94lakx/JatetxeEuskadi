window.addEventListener("load", iniciar, false);

function iniciar() {
    // Eventos relacionados con el formulario de registro
    document.getElementById("botonRegistrar").addEventListener('click',validarDatos, false);
}
    
function validarDatos(e) {
    
    if (document.getElementById('registro').checkValidity()) {        
        //evento.preventDefault() impide que se complete el submit cuando la validación del formulario en HTML 5
        //es correcta y permite terminar con la validación necesaria en javascript.
        e.preventDefault();
        if(!validarDNI()) {
            alert("El DNI introducido no existe");
        } else {
            registrarUsuario();
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

// Metodos para registrar el registro de un usuario

function registrarUsuario() {
    // Se crea ej JSON con la info del usuario
    var usuario = {
        email: document.getElementById("email").value,
        dni: document.getElementById("dni").value,
        sexo: obtenerSexo(),
        nombre: document.getElementById("nombre").value,
        apellido: document.getElementById("apellido").value,
        contrasena: obtenerHash(document.getElementById("contrasena").value),
        provincia: document.getElementById("provincia").value,
        ciudad: document.getElementById("ciudad").value,
        codigopostal: document.getElementById("codigopostal").value,
        telefono: document.getElementById("telefono").value,
    };
    registrar = true;
    // Esto comprueba si el usuario ya existe
    for(var f = 0; f < localStorage.length; f++){
        var clave = localStorage.key(f);
        if(usuario.email == clave) {
            alert("El usuario ya existe");
            registrar = false;
        }
    }
    // Y si no existe lo registra
    if(registrar) {
        localStorage.setItem(usuario.email, JSON.stringify(usuario));
    }
}

// Pequeña funcion para obtener el sexo
function obtenerSexo() {
    if(document.getElementById("h").checked) {
        return "h";
    } else { 
        return "m";
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