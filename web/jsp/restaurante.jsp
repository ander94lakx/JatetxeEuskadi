<!DOCTYPE html>
<html>
    
    <%@page import="java.sql.*" %>
        
    <% 
        Connection conn = null;
        String restaurante = "";
        if(request.getParameter("restaurante") != null) {
            if(config.getServletContext().getAttribute("CONEXION") == null) {
                String dsn = "jdbc:odbc:"+config.getServletContext().getInitParameter("BD");
                Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                conn = DriverManager.getConnection(dsn, "", "");
            } else {
                conn = (Connection) config.getServletContext().getAttribute("CONEXION"); 
            }
            restaurante = request.getParameter("restaurante");
            session.setAttribute("restauranteActual", restaurante);
        }

        
    %>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../css/estilo.css" type="text/css" media="all">
        <title><%=restaurante%></title>
    </head>
    <body>
        <header id="headerRestaurante">
           <a href="index.jsp"><img id="logo"></a>
        </header>
        <nav id="navRestaurante">
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
        <section id="sectionRestaurante">
            <div id="webRestaurante">
                <img id="imagenSection" src="../img/<%=restaurante%>.jpg" height="400" width="400">
            </div>
            <fieldset id="restauranteDatos">
        <%        
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM Restaurante WHERE nombre='"+restaurante+"';");

            if(rs.next()) {
                String nombre = rs.getString("nombre");
                String direccion = rs.getString("direccion");
                String ciudad = rs.getString("ciudad");
                String coordenadas = rs.getString("coordenadas");
        
        %>
            Restaurante: <%=nombre%> <br><br>
            Dirección: <%=direccion%> <br><br>
            Ciudad: <%=ciudad%> <br><br>
            <form name="reserva" id="reserva" method="post" action="../Reservar">
                Personas: <input type="number" id="personas" name="personas" min="1" max="8"><br><br>
                Fecha: <input type="date" name="fecha" id="fecha"><br><br>
                Hora: <select name="hora" id="hora">
                    <option selected value="2100">21:00</option>
                    <option value="2130">21:30</option>
                    <option value="2200">22:00</option>
                    <option value="2230">22:30</option>
                </select><br><br>
                <input type="submit" id="reservar" name="reservar" value="RESERVAR"><br><br>
            </form>
        <%
            }
        %>
        <% if(session.getAttribute("estadoReserva") != null) { %>
            <label class="mensajesDeError"><%= (String) session.getAttribute("estadoReserva")%></label>
        <%
            session.setAttribute("estadoReserva", null);
            } 
        %>
            </fieldset>
        </section>
        <footer id="footerRestaurante">
            <br>
            <a href="http://creativecommons.org/licenses/by-nc-nd/3.0/" id="licencia">CC BY-NC-ND 3.0</a>
            <label id="autores">Copyright © 2014 Julen Aristimuño y Ander Granado</label>
        </footer>
    </body>
</html>
