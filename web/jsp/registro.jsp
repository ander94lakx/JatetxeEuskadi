<!DOCTYPE html>
<html>
    <head>
        <title>Registro</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="../css/estilo.css" type="text/css" media="all">
        <script type="text/javascript" src="../js/ValidarRegistro.js"></script>
    </head>
    <body id="bodyRegistro">
        <header id="headerRegistro">
            <a href="index.jsp"><img id="logo"></a>
        </header>
        <nav id="navRegistro">
        </nav>
        <br>
        <section id="sectionRegistro">
            <div id="webRegistro">
                <div id="imagenRe">
                    <div id="cajaRe"></div>
                    <input type="file" id="archivoRe">
                </div>
                <div id="divRegistro">
                    <fieldset id="fieldsetRegistro">
                        <form name="registro" id="registro" method="post" action="../Registrarse">

                            <input type="hidden" id="imagenInput" name="imagenInput">
                            
                            <label class="camposDeReg">Eres: *</label>
                            <input type="radio" name="sexo" id="h" value="hombre" required="required">Hombre
                            <input type="radio" name="sexo" id="m" value="mujer">Mujer<br><br>

                            <label class="camposDeReg">Apellido: *</label>
                            <input type="text" name="apellido" id="apellido" 
                                   pattern="[A-Za-z]{2,20}" title="El apellido no es válido (tiene que ser una longitud entre 2 y 20 caracteres)" 
                                   required="required"><br><br>

                            <label class="camposDeReg">Nombre: *</label>
                            <input type="text" name="nombre" id="nombre" 
                                   pattern="[A-Za-z]{2,20}" 
                                   title="El nombre no es válido (tiene que ser una longitud entre 2 y 20 caracteres)" 
                                   required="required"><br><br>
                            
                            <label class="camposDeReg">DNI: *</label>
                            <input type="text" name="dni" id="dni" 
                                   pattern="[0-9]{8}[a-zA-Z]{1}" 
                                   title="El DNI no tiene un formato válido" 
                                   required="required"><br><br>

                            <label class="camposDeReg">Email: <a>*</a></label>
                            <input type="email" name="email" id="email" 
                                   pattern="[A-Za-z]([_\-.]?[A-Za-z0-9]+)+@[A-Za-z0-9]+\.[A-za-z]{2,5}"
                                   title="El email introducido no tiene un formato de email valido"
                                   required="required" ><br><br>

                            <label class="camposDeReg">Contrase�a: *</label>
                            <input type="password" name="contrasena" id="contrasena" 
                                   pattern="[a-zA-Z0-9]{6,25}" 
                                   title="La contrasena tiene que tener entre 6 y 25 caracteres (solo caracteres alfanuméricos"
                                   required="required"><br><br>

                            <label class="camposDeReg">Provincia: *</label>
                            <select name="provincia" id="provincia" required="required">
                                <option selected value="">Elige una opci�n</option>
                                <option value="alava">�lava</option>
                                <option value="guipuzcoa">Guipuzcoa</option>
                                <option value="vizacaya">Vizcaya</option>
                            </select><br><br>

                            <label class="camposDeReg">Ciudad:</label>
                            <select name="ciudad" id="ciudad">
                                <option selected value="">Elige una opci�n</option>
                                <option value="gasteiz">Gasteiz</option>
                                <option value="donosti">Donosti</option>
                                <option value="bilbo">Bilbo</option>
                            </select><br><br>

                            <label class="camposDeReg">C�digo Postal: *</label>
                            <input type="text" name="codigopostal" id="codigopostal" required="required"
                                   pattern="[0-9]{5}" 
                                   title="El código postal no es válido"><br><br>

                            <label class="camposDeReg">Telefono: *</label>
                            <input type="text" name="telefono" id="telefono" required="required"
                                   pattern="[0-9]{9}"><br><br>

                            Los campos marcados con * son obligatorios<br><br>

                            <input type="submit" name="botonRegistrar" id="botonRegistrar" value="Regístrate">
                        </form>
                    </fieldset>
                    <% if(session.getAttribute("errorRegistro") != null) { %>
                        <label class="mensajesDeError"><%= (String) session.getAttribute("errorRegistro")%></label>
                    <%
                        session.setAttribute("errorRegistro", null);
                        } 
                    %>
                </div>
            </div>
        </section>
        <br>
        <footer id="footerRegistro">
            <br>
            <a href="http://creativecommons.org/licenses/by-nc-nd/3.0/" id="licencia">CC BY-NC-ND 3.0</a>
            <label id="autores">Copyright � 2014 Julen Aristimu�o y Ander Granado</label>
        </footer>
    </body>
</html>