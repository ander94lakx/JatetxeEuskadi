
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../css/estilo.css" type="text/css" media="all">
        <title>Historial de reservas</title>
    </head>
    <body>
        <%@page import="java.sql.*" %>
        <%@page import="java.util.*" %>
        <header id="headerHistorico">
           <a href="index.jsp"><img id="logo"></a>
        </header>
        <nav id="navHistorico">
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
        <section id="sectionHistorico">
            <div id="webHistorico">
                <form name="formuhistorico" id="formuhistorico" method="get" action="../Anular">
        <% 
            Connection conn;
            if(config.getServletContext().getAttribute("CONEXION") == null) {
                String dsn = "jdbc:odbc:"+config.getServletContext().getInitParameter("BD");
                Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                conn = DriverManager.getConnection(dsn, "", "");
            } else {
                conn = (Connection) config.getServletContext().getAttribute("CONEXION");
            }

            if(session.getAttribute("usuarioActual") != null) {
                String usuario = (String) session.getAttribute("usuarioActual");
                Statement st = conn.createStatement();
                ResultSet rs = rs = st.executeQuery("SELECT * FROM Reserva WHERE usuario='"+usuario+"';");

        %>
        <table border="3">
            <thead>
                <tr>
                    <th>Restaurante</th>
                    <th>Fecha</th>
                    <th>Hora</th>
                    <th>Numero de mesas</th>
                    <th>Estado</th>
                </tr>
            </thead>
            <tbody> 
        <%  
                while(rs.next()) {
                    String restaurante = rs.getString("restaurante");
                    String usu = rs.getString("usuario");
                    java.sql.Date fecha = rs.getDate("fecha");
                    boolean cancelada = rs.getBoolean("cancelada");
                    java.util.Date fechaActual = new java.util.Date();
                    java.util.Date fechaReservaUtil = new java.util.Date(fecha.getTime());
                    String hora = rs.getString("hora");
                    String estado = null;
                    int numMesas = rs.getInt("mesasreservadas");
                    String valueBoton = usu + " " + fecha + " " + restaurante;

        %>
                <tr>
                    <td><%=restaurante%></td>
                    <td><%=fecha%></td>
                    <td><%=hora%></td>
                    <td><%=numMesas%></td>
                    <%
                    if(cancelada){
                        estado = "Cancelada";
                    }else{
                        if(fechaActual.compareTo(fechaReservaUtil) > 0){
                            estado = "Realizada";
                        } else{
                            estado = "Pendiente";
                        }
                    }
                    %>
                    <td><%=estado%></td>
                    <%
                    if(cancelada) { %>
                        <td><input type="radio" name="cancelar" disabled="disabled"</td>
                    <%  
                    } else {
                        if(fechaActual.compareTo(fechaReservaUtil) > 0){ %>
                            <td><input type="radio" name="cancelar" disabled="disabled"</td>
                        <%
                        } else{ %>
                            <td><input type="radio" name="cancelar" value="<%=valueBoton%>"</td>
                        <%
                        }
                    }
                    %>
                </tr>
        <%
                }
        %>
            </tbody>
        </table><br><br>
        <%
            }
        %>
        <input type="submit" value="CANCELAR RESERVA" name="cancelarReserva" id="cancelarReserva"/>
                </form><br>
                <% if(session.getAttribute("estadoAnulacion") != null) { %>
                    <label class="mensajesDeError"><%= (String) session.getAttribute("estadoAnulacion")%></label>
                <%
                    session.setAttribute("estadoAnulacion", null);
                    } 
                %> 
            </div>
        </section>
        <footer id="footerHistorico">
            <br>
            <a href="http://creativecommons.org/licenses/by-nc-nd/3.0/" id="licencia">CC BY-NC-ND 3.0</a>
            <label id="autores">Copyright © 2014 Julen Aristimuño y Ander Granado</label>
        </footer>
    </body>
</html>
