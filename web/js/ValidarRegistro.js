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
    var usuario = {
        dni: document.getElementById("dni").value,
        sexo: obtenerSexo(),
        nombre: document.getElementById("nombre").value,
        apellido: document.getElementById("apellido").value,
        contrasena: document.getElementById("contrasena").value,
        provincia: document.getElementById("provincia").value,
        ciudad: document.getElementById("ciudad").value,
        codigopostal: document.getElementById("codigopostal").value,
        telefono: document.getElementById("telefono").value,
    };
    
    registrar = true;
    
    for(var f = 0; f < localStorage.length; f++){
        var clave = localStorage.key(f);
        var valor = localStorage.getItem(clave);
        if(usuario.email == clave) {
            alert("El usuario ya existe");
            registrar = false;
        }
    }
    
    if(registrar) {
        localStorage.setItem(usuario.email, JSON.stringify(usuario));
    }
}

// Pequeña funcion para obtener el sexo
function obtenerSexo() {
    if(document.getElementById("sexo")[0].checked) {
        return "h";
    } else { 
        return "m";
    }
}