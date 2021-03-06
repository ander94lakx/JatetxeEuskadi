<!DOCTYPE html>
<html>
    <head>
        <title>Euskadi Jatetxe</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="../css/estilo.css" type="text/css" media="all">
    </head>
    <body id="bodyIndex">
        <header id="headerIndex">
           <a href="index.jsp"><img id="logo"></a>
        </header>
        <nav id="navIndex">
            <% if(session.getAttribute("usuarioActual") == null) { %>
                <a id="linkRegistro" class="linksDelNav" href="registro.jsp">REGISTRARSE</a>
                <a id="linkLogin" class="linksDelNav" href="login.jsp">INICIAR SESION</a>
                <% } else { %>
                <label id="hola">Hola, <%= (String) session.getAttribute("usuarioActual")%></label>
                <a id="linkSalir" class="linksDelNav" href="../Logout">SALIR</a>
                <a id="linkeHistorico" class="linksDelNav" href="historicoReservas.jsp">HISTORIAL DE RESERVAS</a>
                <a id="linkPerfil" class="linksDelNav" href="perfil.jsp">TU PERFIL</a>
            <% } %>
        </nav>
        <section id="sectionIndex">
            <div id="divImagenes">
                <br><br>
                <div id="busqueda">
                    <form id="formBusqueda" name="formBusqueda" method="get" action="busqueda.jsp">
                        <input type="text" id="buscado" name="buscado" placeholder="Busca tu restaurante">
                        <!--<input type="submit" id="botonBuscar" name="botonBuscar" value="BUSCAR">-->
                        <input type="submit" id="botonBuscar" name="botonBuscar" value="BUSCAR">
                    </form>
                </div>
                <br><br>
                <h1 id="texto">La mejor Web para reservar restaurantes</h1>
                <a href="busqueda.jsp?buscado=gasteiz"><img id="gasteizN"></a>
                <a href="busqueda.jsp?buscado=bilbo"><img id="bilbaoN"></a>
                <a href="busqueda.jsp?buscado=donosti"><img id="donostiN"></a>
            </div>
        </section>
        <footer id="footerIndex">
            <br>
            <a href="http://creativecommons.org/licenses/by-nc-nd/3.0/" id="licencia">CC BY-NC-ND 3.0</a>
            <label id="autores">Copyright © 2014 Julen Aristimuño y Ander Granado</label>
        </footer>
    </body>
</html>
