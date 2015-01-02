<!DOCTYPE html>
<html>
    
    <%@page import="java.sql.*" %>
        
    <% 
        if(request.getParameter("restaurante") != null) {
            Connection conn;
            if(config.getServletContext().getAttribute("CONEXION") == null) {
                String dsn = "jdbc:odbc:"+config.getServletContext().getInitParameter("BD");
                Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                conn = DriverManager.getConnection(dsn, "", "");
            } else {
                conn = (Connection) config.getServletContext().getAttribute("CONEXION");
            }

        String restaurante = (String) request.getParameter("buscado");
    %>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../css/estilo.css" type="text/css" media="all">
        <title><%=restaurante%></title>
    </head>
    <body>
        <%        
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM Restaurante WHERE nombre='"+restaurante+"';");

            if(rs.next()) {
                String nombre = rs.getString("nombre");
                String direccion = rs.getString("direccion");
                String ciudad = rs.getString("ciudad");
                String coordenadas = rs.getString("coordenadas");
        
        %>
            <%-- TO-DO: Mostrar todfa la info del restaurante y los botones necesarios --%>
        <%
            }
        %>
    </body>
</html>
