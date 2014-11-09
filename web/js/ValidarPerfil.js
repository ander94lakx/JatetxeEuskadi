window.addEventListener("load", iniciar, false);

var imagen = ""; // se guarda la imagen en una variable local para poder despues guardarla en el registro

function iniciar() {
    // Eventos relacionados con el formulario de registro
    document.getElementById("botonGuardar").addEventListener('click',validarDatos, false);
    // Eventos relacionados con la imagen
    document.getElementById('caja').addEventListener('dragover', permitirDrop, false);
    document.getElementById('caja').addEventListener('drop', drop, false);
    document.getElementById('archivo').addEventListener('change', cargar, false);
    // Eventos relacionados con la geolocalizacion
    document.getElementById('obtener').addEventListener('click', recuperarLocalizacion, false);
    // Validacion en tiempo real
    document.perfil.addEventListener("invalid", validacion, true);
    document.perfil.addEventListener("input", controlar, false);
    cargarDatos();
}

function cargarDatos() {
    var usuarioActual = JSON.parse(localStorage.getItem(sessionStorage.getItem("usuarioActual")));
    document.getElementById("email").value = usuarioActual.email;
    document.getElementById("dni").value = usuarioActual.dni;
    document.getElementById("nombre").value = usuarioActual.nombre ;
    document.getElementById("apellido").value =  usuarioActual.apellido;
    document.getElementById("contrasena").value = ""; // no se muestra nada ya que no se almacena la contraseña
    document.getElementById("provincia").value = usuarioActual.provincia;
    document.getElementById("ciudad").value = usuarioActual.ciudad;
    document.getElementById("codigopostal").value = usuarioActual.codigopostal;
    document.getElementById("telefono").value = usuarioActual.telefono;
    document.getElementById("dia").value = usuarioActual.dia;
    document.getElementById("mes").value =  usuarioActual.mes; 
    document.getElementById("ano").value = usuarioActual.ano;
    if(usuarioActual.sexo == "h")
        document.getElementById("h").checked = true;
    else
        document.getElementById("m").checked = true;
    document.getElementById('caja').style.backgroundImage = "url('" + usuarioActual.imagen + "')";
    imagen = usuarioActual.imagen; // se guarda tambien en formato string la imagen en la  variable global por si no se acaba modificando
}
    
function validarDatos(e) {
    if (document.getElementById('perfil').checkValidity()) {        
        //evento.preventDefault() impide que se complete el submit cuando la validación del formulario en HTML 5
        //es correcta y permite terminar con la validación necesaria en javascript.
        e.preventDefault();
        if(!validarDNI()) {
            alert("El DNI introducido no existe");
        } else {
            if(!validarFecha()) {
                alert("La fecha seleccionada no existe");
            } else {
                guardarUsuario();
            }
        }
    }   
}

// Parte de la geolocalizacion

function recuperarLocalizacion() {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(mostrarCoordenada);
    } else {
        alert('El navegador no dispone la capacidad de geolocalización');
    }
}

function mostrarCoordenada(posicion) {
    var direccion = posicion.coords.latitude + "," + posicion.coords.longitude;
    var mapa = "http://maps.googleapis.com/maps/api/staticmap?center="+direccion+"&zoom=14&size=320x320&sensor=false";
    document.getElementById("dato").innerHTML = "<img src='"+mapa+"'>";
    ponerEnDireccion(direccion);
}

function ponerEnDireccion(dir) {
    document.getElementById("direccion").value = dir;
}

// Metodo para guardar los cambios del usuario

function guardarUsuario() {
    // Esta primera parte comprueba si se desea cambiar la contrasena y actua en consecuencia
    var contr;
    if(document.getElementById("contrasena").value == "")
        contr = document.getElementById("contrasena").value;
    else
        contr = obtenerHash(document.getElementById("contrasena").value);
    // Se crea ej JSON con la info del usuario
    var usuario = {
        email: document.getElementById("email").value,
        dni: document.getElementById("dni").value,
        sexo: obtenerSexo(),
        nombre: document.getElementById("nombre").value,
        apellido: document.getElementById("apellido").value,
        contrasena: contr,
        provincia: document.getElementById("provincia").value,
        ciudad: document.getElementById("ciudad").value,
        codigopostal: document.getElementById("codigopostal").value,
        telefono: document.getElementById("telefono").value,
        dia: document.getElementById("dia").value,
        mes: document.getElementById("mes").value,
        ano: document.getElementById("ano").value,
        direccion: document.getElementByid("direccion").value,
        imagen: imagen,
    };
    // Y se guarda la informacion, eliminando antes la antigua
    localStorage.removeItem(usuario.email);
    localStorage.setItem(usuario.email, usuario);

}

// Pequeña funcion para obtener el sexo
function obtenerSexo() {
    if(document.getElementByid("h").checked) {
        return "h";
    } else { 
        return "m";
    }
}

// Metodos relacionados con la validacion de los datos

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

function validarFecha() {
    var dia = document.getElementById("dia").value;
    var mes = document.getElementById("mes").value;
    var ano = document.getElementById("ano").value;
    if(mes == 2) {
	if(((ano % 4 == 0) && (ano % 100 != 0)) || (ano % 400 == 0)) {
            if(dia > 29) {
                return false;
            }
        }
        else {
            if(dia > 28) {
                return false;
            }
        }        
    } else if(mes == 4 || mes == 6 || mes == 9 || mes == 11) {
        if(dia > 30){
            return false;
        }
    }
    
    /*
     * Esta parte serviria para comprobar si es una fecha anterior a la del dia de hoy
     * o una fecha minima acordada, pero no es necesaria si en la lista desplegable
     * del año solo tenemos unos años ya definidos
     */
//    var fechaActual = new Date();
//    if(fechaActual.getFullYear() >= ano) {
//        if(fechaActual.getMonth() >= mes) {
//            if(fechaActual.getDay() > dia) {
//                return true;
//            }
//            else {
//                return false;
//            }
//        }
//    } // Esto solo comprueba que la fecha sea anterior al dia actual
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
    }
}

function leer(e) {
    document.getElementById('caja').style.backgroundImage = "url('" + e.target.result + "')";
}

function drop(e) {
    e.preventDefault();
    var arch = new FileReader();
    arch.addEventListener('load', leer, false);
    arch.readAsDataURL(e.dataTransfer.files[0]);
    arch.onloadend = function () {
        imagen = arch.result;
        console.log(imagen);
    }
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
        else if(elemento == document.getElementById("dia") || 
                elemento == document.getElementById("mes") ||
                elemento == document.getElementById("ano")) {
            if(validarFecha())
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
