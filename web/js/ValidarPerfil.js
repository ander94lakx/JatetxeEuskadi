window.addEventListener("load", iniciar, false);

function iniciar() {
    // Eventos relacionados con el formulario de registro
    document.getElementById("botonGuardar").addEventListener('click',validarDatos, false);
    // Eventos relacionados con la imagen
    document.getElementById('caja').addEventListener('dragover', permitirDrop, false);
    document.getElementById('caja').addEventListener('drop', drop, false);
    document.getElementById('archivo').addEventListener('change', cargar, false);
    // Eventos relacionados con la geolocalizacion
    document.getElementById('obtener').addEventListener('click', recuperarLocalizacion, false);
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

function ponerEnDireccion() {
    document.getElementById("direccion").value = direccion;
}

// Metodo para guardar los cambios del usuario

function guardarUsuario() {
    var usuario = new Array();
    usuario.dni = document.getElementById("dni").value;
    usuario.sexo = document.getElementById("sexo").value;
    usuario.nombre = document.getElementById("nombre").value;
    usuario.apellido = document.getElementById("apellido").value;
    usuario.contrasena = document.getElementById("contrasena").value;
    usuario.provincia = document.getElementById("provincia").value;
    usuario.ciudad = document.getElementById("ciudad").value;
    usuario.codigopostal = document.getElementById("codigopostal").value;
    usuario.telefono = document.getElementById("telefono").value;
    usuario.dia = document.getElementById("dia").value;
    usuario.mes = document.getElementById("mes").value;
    usuario.ano = document.getElementById("ano").value;
    usuario.imagen = null; // TO-DO
    usuario.direccion = null; // TO-DO
    
    for(var f = 0; f < localStorage.length; f++){
        var clave = localStorage.key(f);
        if(usuario.email == clave) {
            localStorage.removeItem(usuario.email);
            localStorage.setItem(usuario.email, usuario);
        }
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
    } else if(mes == 2 || mes == 4 || mes == 6 || mes == 9 || mes == 11) {
        if(dia > 30){
            return false;
        }
    }
    
    /*
     * Esta parte serviria para comprobar si es una fecha anterior a la del dia de hoy
     * o una fecha minima acordada, pero no es necesaria si en la lista desplegable
     * del año solo tenemos unos años ya definidos
     */
    var fechaActual = new Date();
    if(fechaActual.getFullYear() >= ano) {
        if(fechaActual.getMonth() >= mes) {
            if(fechaActual.getDay() > dia) {
                return true;
            }
            else {
                return false;
            }
        }
    } // Esto solo comprueba que la fecha sea anterior al dia actual
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
}

function leer(e) {
    document.getElementById('caja').style.backgroundImage = "url('" + e.target.result + "')";
}

function drop(e) {
    e.preventDefault();
    var arch = new FileReader();
    arch.addEventListener('load', leer, false);
    arch.readAsDataURL(e.dataTransfer.files[0]);
}

function permitirDrop(e) {
    e.preventDefault();
}

