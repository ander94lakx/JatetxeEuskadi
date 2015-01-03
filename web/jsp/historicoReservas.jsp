
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Historial de reservas</title>
    </head>
    <body>
        <%@page import="java.sql.*" %>
        <%@page import="java.util.*" %>
        
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
    </body>
</html>
