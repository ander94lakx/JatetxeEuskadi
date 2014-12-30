<!DOCTYPE html>
<html>
    <head>
        <title>Perfil</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="../css/estilo.css" type="text/css" media="all">
        <script type="text/javascript" src="../js/ValidarPerfil.js"></script>
    </head>
    <body id="bodyPerfil">
        <header id="headerperfil">
            <img id="logo">    
        </header>
        <nav id="navPerfil">
            
        </nav>
        <br>
        <section id="sectionPerfil">
            <div id="webPerfil">
               <div id="imagen">
                    <div id="caja"></div>
                    <input type="file" id="archivo">
                </div>
                <div id="divPerfil">
                    <fieldset id="fieldsetPerfil">
                        <form name="perfil" id="perfil" method="get">

                            <label class="camposDeReg">Eres: *</label>
                            <input type="radio" name="sexo" id="h" value="Hombre" required="required">Hombre
                            <input type="radio" name="sexo" id="m" value="Mujer">Mujer<br><br>

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

                            <label class="camposDeReg">Email: *</label>
                            <input type="email" name="email" id="email" 
                                   pattern="[A-Za-z]([_\-.]?[A-Za-z0-9]+)+@[A-Za-z0-9]+\.[A-za-z]{2,5}"
                                   title="El email introducido no tiene un formato de email valido"
                                   required="required" ><br><br>

                            <label class="camposDeReg">Contraseña: *</label>
                            <input type="password" name="contrasena" id="contrasena" 
                                   pattern="[a-zA-Z0-9]{6,25}" 
                                   title="La contrasena tiene que tener entre 6 y 25 caracteres (solo caracteres alfanuméricos"><br><br>

                            <label class="camposDeReg">Provincia: *</label>
                            <select name="provincia" id="provincia" required="required">
                                <option selected value="">Elige una opción</option>
                                <option value="1">Álava</option>
                                <option value="2">Guipuzcoa</option>
                                <option value="3">Vizcaya</option>
                            </select><br><br>

                            <label class="camposDeReg">Ciudad:</label>
                            <select name="ciudad" id="ciudad">
                                <option selected value="">Elige una opción</option>
                                <option value="1">Gasteiz</option>
                                <option value="2">Donosti</option>
                                <option value="3">Bilbo</option>
                            </select><br><br>
                            
                            <label class="camposDeReg">Dirección:</label>
                            <textarea id="direccion" rows="3" cols="47" form= "perfil" wrap= "soft">
                                
                            </textarea><br><br>

                            <label class="camposDeReg">Código Postal: *</label>
                            <input type="text" name="codigopostal" id="codigopostal" required="required"
                                   pattern="[0-9]{5}" 
                                   title="El código postal no es válido"><br><br>

                            <label class="camposDeReg">Telefono: *</label>
                            <input type="text" name="telefono" id="telefono" required="required"
                                   pattern="[0-9]{9}"><br><br>

                            <label class="camposDeReg">Fecha de nacimiento:</label>
                            <!-- <input type="date" name="fechaNac" id="fechaNac" required="required"><br><br> -->
                            <select name="dia" id="dia">
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>
                                <option value="5">5</option>
                                <option value="6">6</option>
                                <option value="7">7</option>
                                <option value="8">8</option>
                                <option value="9">9</option>
                                <option value="10">10</option>
                                <option value="11">11</option>
                                <option value="12">12</option>
                                <option value="13">13</option>
                                <option value="14">14</option>
                                <option value="15">15</option>
                                <option value="16">16</option>
                                <option value="17">17</option>
                                <option value="18">18</option>
                                <option value="19">19</option>
                                <option value="20">20</option>
                                <option value="21">21</option>
                                <option value="22">22</option>
                                <option value="23">23</option>
                                <option value="24">24</option>
                                <option value="25">25</option>
                                <option value="26">26</option>
                                <option value="27">27</option>
                                <option value="28">28</option>
                                <option value="29">29</option>
                                <option value="30">30</option>
                                <option value="31">31</option>
                            </select>
                            <select name="mes" id="mes">
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>
                                <option value="5">5</option>
                                <option value="6">6</option>
                                <option value="7">7</option>
                                <option value="8">8</option>
                                <option value="9">9</option>
                                <option value="10">10</option>
                                <option value="11">11</option>
                                <option value="12">12</option>
                            </select>
                            <select name="ano" id="ano">
                                <option value="1984">1984</option>
                                <option value="1985">1985</option>
                                <option value="1986">1986</option>
                                <option value="1987">1987</option>
                                <option value="1988">1988</option>
                                <option value="1989">1989</option>
                                <option value="1990">1990</option>
                                <option value="1991">1991</option>
                                <option value="1992">1992</option>
                                <option value="1993">1993</option>
                                <option value="1994">1994</option>
                            </select><br><br>

                            Los campos marcados con * son obligatorios<br><br>

                            <input type="submit" name="botonGuardar" id="botonGuardar" value="Guardar Cambios">
                        </form>
                    </fieldset>
                </div>
                <div id="localizacion">
                    <!-- Pagina muy intersante sobre Google Maps Api Key
                            http://www.maestrosdelweb.com/trabajando-con-el-api-de-google-maps/ -->
               
                            <input type="button" id="obtener" value="Obtener la localización actual"> <br>
                            <div id="dato"></div><br><br>
                </div>
            </div>
        </section>
        <br>
       <footer id="footerPerfil">
            <br>
            <a href="http://creativecommons.org/licenses/by-nc-nd/3.0/" id="licencia">CC BY-NC-ND 3.0</a>
            <label id="autores">Copyright © 2014 Julen Aristimuño y Ander Granado</label>
        </footer>
    </body>
</html>