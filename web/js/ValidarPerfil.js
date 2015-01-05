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
    
    imagen = document.getElementById("imagenInput").value;
    document.getElementById('caja').style.backgroundImage = "url('" + imagen + "')";
}
    
function validarDatos(e) {
    if (document.getElementById('perfil').checkValidity()) {        
//        e.preventDefault();
//        if(!validarDNI()) {
//            alert("El DNI introducido no existe");
//        } else {
//            if(!validarFecha())
//                alert("La fecha seleccionada no existe");
//        }
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
//    ponerEnDireccion(direccion);
}

function ponerEnDireccion(dir) {
    document.getElementById("direccion").value = dir;
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
    var dia = parseInt(document.getElementById("dia").value);
    var mes = parseInt(document.getElementById("mes").value);
    var ano = parseInt(document.getElementById("ano").value);
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
    return true;
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
        document.getElementById("imagenInput").value = imagen;
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
        document.getElementById("imagenInput").value = imagen;
        console.log(imagen);
    };
}

function permitirDrop(e) {
    e.preventDefault();
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
            if(validarFecha()) {
                document.getElementById("dia").style.borderColor = '#64FE2E';
                document.getElementById("mes").style.borderColor = '#64FE2E';
                document.getElementById("ano").style.borderColor = '#64FE2E';
            }
            else {
                document.getElementById("dia").style.borderColor = '#FF0000';
                document.getElementById("mes").style.borderColor = '#FF0000';
                document.getElementById("ano").style.borderColor = '#FF0000';
            }
        }
    } else {
        elemento.style.borderColor = '#FF0000';
    }
}

function validacion(evento) {
    var elemento = evento.target;
    elemento.style.borderColor = '#FF0000';
}
