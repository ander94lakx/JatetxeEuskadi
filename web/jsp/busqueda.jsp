<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../css/estilo.css" type="text/css" media="all">
        <title>Busqueda</title>
    </head>
    <body>
        <%@page import="java.sql.*" %>
        <header id="headerBusqueda">
           <img id="logo">
        </header>
        <nav id="navBusqueda">
            <% if(session.getAttribute("usuarioActual") == null) { %>
                <a id="linkRegistro" class="linksDelNav" href="registro.jsp">REGISTRARSE</a>
                <a id="linkLogin" class="linksDelNav" href="login.jsp">INICIAR SESION</a>
                <% } else { %>
                <label id="hola">Hola, <%= (String) session.getAttribute("usuarioActual")%></label>
                <a id="linkPerfil" class="linksDelNav" href="perfil.jsp">TU PERFIL</a>
                <a id="linkeHistorico" class="linksDelNav" href="historicoReservas.jsp">HISTORIAL DE RESERVAS</a>
            <% } %>
        </nav>
        <section id="sectionBusqueda">
            <h1>Realiza una reserva entre los mejores restaurantes de Euskadi</h1><br>
            <div id="webBusqueda">
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
                if(busqueda.equals("gasteiz")){
                    rs = st.executeQuery("SELECT * FROM Restaurante WHERE ciudad='"+busqueda+"';");
                }
                else if(busqueda.equals("bilbo")){
                    rs = st.executeQuery("SELECT * FROM Restaurante WHERE ciudad='"+busqueda+"';");
                }
                else if(busqueda.equals("donosti")){
                    rs = st.executeQuery("SELECT * FROM Restaurante WHERE ciudad='"+busqueda+"';");
                }
                else{
                    rs = st.executeQuery("SELECT * FROM Restaurante WHERE nombre LIKE '%"+busqueda+"%';"); 
                }
                while(rs.next()) {
                    String nombre = rs.getString("nombre");
                    String direccion = rs.getString("direccion");
                    String ciudad = rs.getString("ciudad");
                    String coordenadas = rs.getString("coordenadas");
        %>
        <div id="divRestaurantes">
            <img id="imagenRest" src="../img/<%=nombre%>.jpg">
                
            </div>
        <a href="restaurante.jsp?restaurante=<%=nombre%>"><%=nombre%></a><br>
        Direcci�n: <%=direccion%><br>
        Ciudad: <%=ciudad%><br>
        </div>
        <%
                }
            }
        %>
            </div>
        </section>
        <footer id="footerBusqueda">
            <br>
            <a href="http://creativecommons.org/licenses/by-nc-nd/3.0/" id="licencia">CC BY-NC-ND 3.0</a>
            <label id="autores">Copyright © 2014 Julen Aristimuño y Ander Granado</label>
        </footer>
    </body>
</html>
