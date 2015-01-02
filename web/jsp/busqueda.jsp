<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../css/estilo.css" type="text/css" media="all">
        <title>Busqueda</title>
    </head>
    <body>
        
        <%@page import="java.sql.*" %>
        
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
                
            String busqueda = (String) request.getParameter("buscado");
                
            Statement st = conn.createStatement();
            ResultSet rs = null;
            
            switch(busqueda){
                case "Gasteiz":
                    rs = st.executeQuery("SELECT * FROM Restaurante WHERE ciudad='"+busqueda+"';");
                    break;
                case "Donosti":
                    rs = st.executeQuery("SELECT * FROM Restaurante WHERE ciudad='"+busqueda+"';");
                    break;
                case "Bilbo":
                    rs = st.executeQuery("SELECT * FROM Restaurante WHERE ciudad='"+busqueda+"';");
                    break;
                default:
                    rs = st.executeQuery("SELECT * FROM Restaurante WHERE email LIKE '"+busqueda+"';");
            }

            while(rs.next()) {
                String nombre = rs.getString("nombre");
                String direccion = rs.getString("direccion");
                String ciudad = rs.getString("ciudad");
                String coordenadas = rs.getString("coordenadas");
        %>
            <%-- TO-DO: Mostrar los restaurantes aqui uno a uno --%>
        <%
            }
        %>
    </body>
</html>
