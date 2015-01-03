<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../css/estilo.css" type="text/css" media="all">
        <title>Busqueda</title>
    </head>
    <body>
        
        <%@page import="java.sql.*" %>
        <h1>Realiza una reserva entre los mejores restaurantes de Euskadi</h1><br>
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

//                switch(busqueda){
//                    case "gasteiz":
//                        rs = st.executeQuery("SELECT * FROM Restaurante WHERE ciudad='"+busqueda+"';");
//                        break;
//                    case "donosti":
//                        rs = st.executeQuery("SELECT * FROM Restaurante WHERE ciudad='"+busqueda+"';");
//                        break;
//                    case "bilbo":
//                        rs = st.executeQuery("SELECT * FROM Restaurante WHERE ciudad='"+busqueda+"';");
//                        break;
//                    default:
//                        rs = st.executeQuery("SELECT * FROM Restaurante WHERE nombre LIKE '"+busqueda+"';");
//                }
                if(busqueda == "gasteiz"){
                    rs = st.executeQuery("SELECT * FROM Restaurante WHERE ciudad='"+busqueda+"';");
                }
                else if(busqueda == "bilbo"){
                    rs = st.executeQuery("SELECT * FROM Restaurante WHERE ciudad='"+busqueda+"';");
                }
                else if(busqueda == "donosti"){
                    rs = st.executeQuery("SELECT * FROM Restaurante WHERE ciudad='"+busqueda+"';");
                }
                else{
                    rs = st.executeQuery("SELECT * FROM Restaurante WHERE nombre LIKE '"+busqueda+"';"); 
                }

                while(rs.next()) {
                    String nombre = rs.getString("nombre");
                    String direccion = rs.getString("direccion");
                    String ciudad = rs.getString("ciudad");
                    String coordenadas = rs.getString("coordenadas");
        %>
        Restaurante: <a href="restaurante.jsp?restaurante=<%=nombre%>"><%=nombre%></a><br>
        Dirección: <%=direccion%><br>
        Ciudad: <%=ciudad%><br>
        <%
                }
            }
        %>
    </body>
</html>
