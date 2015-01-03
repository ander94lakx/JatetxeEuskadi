<!DOCTYPE html>
<html>
    
    <%@page import="java.sql.*" %>
        
    <% 
        Connection conn = null;
        if(request.getParameter("restaurante") != null) {
            if(config.getServletContext().getAttribute("CONEXION") == null) {
                String dsn = "jdbc:odbc:"+config.getServletContext().getInitParameter("BD");
                Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                conn = DriverManager.getConnection(dsn, "", "");
            } else {
                conn = (Connection) config.getServletContext().getAttribute("CONEXION");
            }
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
            Restaurante: <%=nombre%> <br>
            Dirección: <%=direccion%> <br>
            Ciudad: <%=ciudad%> <br>
            <form name="reserva" id="reserva" method="post" action="Reservar">
                Personas: <input type="number" id="personas" name="personas" min="1" max="8"><br><br>
                Fecha<input type="date" name="fecha" id="fecha"><br><br>
                Hora: <select name="hora" id="hora">
                    <option selected value="2100">21:00</option>
                    <option value="2130">21:30</option>
                    <option value="2200">22:00</option>
                    <option value="2230">22:00</option>
                </select><br><br>
                <input type="submit" id="reservar" name="reservar" value="RESERVAR"><br><br>
            </form>
        <%
            }
        %>
    </body>
</html>
