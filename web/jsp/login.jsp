<!DOCTYPE html>
<html>
    <head>
        <title>Login</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="../css/estilo.css" type="text/css" media="all">
        <script type="text/javascript" src="../js/ValidarLogin.js"></script>
    </head>
    <body id="bodyLogin">
        <header id="headerLogin">
            <a href="index.jsp"><img id="logo"></a> 
        </header>
        <nav id="navLogin">
        </nav>
        <br>
        <section id="sectionLogin">
            <div id="webLogin">
                <div id="divLogin">
                    <fieldset id="fieldsetLogin">
                        <form name="login" id="login" method="post" action="../Loguearse">

                            <label class="camposDeReg">Email:  </label>
                            <input type="email" name="email" id="email" 
                                   pattern="[A-Za-z]([_\-.]?[A-Za-z0-9]+)+@[A-Za-z0-9]+\.[A-za-z]{2,5}"
                                   title="El email introducido no tiene un formato de email valido"
                                   required="required"><br><br>

                            <label class="camposDeReg">Contrase�a:  </label>
                            <input type="password" name="contrasena" id="contrasena" 
                                   pattern="[a-zA-Z0-9]{6,25}" 
                                   title="La contrasena tiene que tener entre 6 y 25 caracteres (solo caracteres alfanuméricos"
                                   required="required"><br><br>

                            <input type="submit" name="botonEntrar" id="botonEntrar" value="Entrar">
                        </form>
                    </fieldset>
                    <% if(session.getAttribute("errorLogin") != null) { %>
                        <label class="mensajesDeError"><%= (String) session.getAttribute("errorLogin")%></label>
                    <% 
                        session.setAttribute("errorLogin", null);
                        } 
                    %>
                </div>
            </div>
        </section>
        <br>
        <footer id="footerLogin">
            <br>
            <a href="http://creativecommons.org/licenses/by-nc-nd/3.0/" id="licencia">CC BY-NC-ND 3.0</a>
            <label id="autores">Copyright � 2014 Julen Aristimu�o y Ander Granado</label>
        </footer>
    </body>
</html>