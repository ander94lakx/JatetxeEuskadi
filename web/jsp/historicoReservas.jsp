
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Historial de reservas</title>
    </head>
    <body>
        <%@page import="java.sql.*" %>
        <%@page import="java.util.*" %>
        <header id="headerHistorico">
           <img id="logo">
        </header>
        <nav id="navHistorico">
            <% if(session.getAttribute("usuarioActual") == null) { %>
                <a id="linkRegistro" class="linksDelNav" href="registro.jsp">REGISTRARSE</a>
                <a id="linkLogin" class="linksDelNav" href="login.jsp">INICIAR SESION</a>
                <% } else { %>
                <label id="hola">Hola, <%= (String) session.getAttribute("usuarioActual")%></label>
                <a id="linkPerfil" class="linksDelNav" href="perfil.jsp">TU PERFIL</a>
                <a id="linkeHistorico" class="linksDelNav" href="historicoReservas.jsp">HISTORIAL DE RESERVAS</a>
            <% } %>
        </nav>
        <section id="sectionHistorico">
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
                    String estado = null;

        %>
                <tr>
                    <td><%=restaurante%></td>
                    <td><%=fecha%></td>
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
                </tr>
        <%
                }
        %>
            </tbody>
        </table>
        <%
            }
        %>
        </section>
        <footer id="footerHistorico">
            <br>
            <a href="http://creativecommons.org/licenses/by-nc-nd/3.0/" id="licencia">CC BY-NC-ND 3.0</a>
            <label id="autores">Copyright © 2014 Julen Aristimuño y Ander Granado</label>
        </footer>
    </body>
</html>