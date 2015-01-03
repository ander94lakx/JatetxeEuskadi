
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
            if(request.getParameter("buscado") != null) {
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
                    ResultSet rs = rs = st.executeQuery("SELECT * FROM Restaurante WHERE email='"+usuario+"';");
            

                    while(rs.next()) {
                        String restaurante = rs.getString("restaurante");
                        String usu = rs.getString("usuario");
                        java.sql.Date fecha = rs.getDate("fecha");
                        boolean coordenadas = rs.getBoolean("cancelada");
                    
            
                
            
        %>
            
        <%
                    }
                }
            }
        %>
    </body>
</html>
