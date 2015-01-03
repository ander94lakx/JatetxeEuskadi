<!DOCTYPE html>
<html>
    <head>
        <title>Perfil</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="../css/estilo.css" type="text/css" media="all">
        <script type="text/javascript" src="../js/ValidarPerfil.js"></script>
    </head>
    <body id="bodyPerfil">
        
        <%@page import="java.sql.*" %>
       
        <header id="headerperfil">
            <img id="logo">    
        </header>
        <nav id="navPerfil">
            
        </nav>
        <% 
            if(session.getAttribute("usuarioActual") != null) {
                Connection conn;
                if(config.getServletContext().getAttribute("CONEXION") == null) {
                    String dsn = "jdbc:odbc:"+config.getServletContext().getInitParameter("BD");
                    Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                    conn = DriverManager.getConnection(dsn, "", "");
                } else {
                    conn = (Connection) config.getServletContext().getAttribute("CONEXION");
                }
                
                String email = (String) session.getAttribute("usuarioActual");
                
                Statement st = conn.createStatement();
                ResultSet rs = st.executeQuery("SELECT * FROM Usuario WHERE email='"+email+"';");
                
                String dni = "";
                String sexo = "";
                String nombre = "";
                String apellido = "";
                String provincia = "";
                String ciudad = "";
                int codigopostal = 0;
                int telefono = 0;
                int dia = 0;
                int mes = 0;
                int ano = 0;
                String direccion = "";
                String imagen = "";
                String contrasena = "";
                
                if(rs.next()) {
                    dni = rs.getString("dni");
                    sexo = rs.getString("sexo");
                    nombre = rs.getString("nombre");
                    apellido = rs.getString("apellido");
                    provincia = rs.getString("provincia");
                    ciudad = rs.getString("ciudad");
                    codigopostal = rs.getInt("codigopostal");
                    telefono = rs.getInt("telefono");
                    dia = rs.getInt("dia");
                    mes = rs.getInt("mes");
                    ano = rs.getInt("ano");
                    direccion = rs.getString("direccion");
                    imagen = rs.getString("imagen");
                    contrasena = rs.getString("contrasena");
                }
    
        %>
        <br>
        <section id="sectionPerfil">
            <div id="webPerfil">
               <div id="imagen">
                    <div id="caja"></div>
                    <input type="file" id="archivo">
                </div>
                <div id="divPerfil">
                    <fieldset id="fieldsetPerfil">
                        <form name="perfil" id="perfil" method="post" action="ModificarPerfil">

                            <label class="camposDeReg">Eres: *</label>
                            <% if(sexo.equals("h")) { %>
                                <input type="radio" name="sexo" id="h" value="Hombre" required="required" checked="checked">Hombre
                                <input type="radio" name="sexo" id="m" value="Mujer">Mujer<br><br>
                            <% } else if(sexo.equals("m")) { %>
                                <input type="radio" name="sexo" id="h" value="Hombre" required="required">Hombre
                                <input type="radio" name="sexo" id="m" value="Mujer" checked="checked">Mujer<br><br>
                            <% } %>
                            <label class="camposDeReg">Apellido: *</label>
                            <input type="text" name="apellido" id="apellido" 
                                   pattern="[A-Za-z]{2,20}" title="El apellido no es válido (tiene que ser una longitud entre 2 y 20 caracteres)" 
                                   required="required"
                                   value="<%=apellido%>"><br><br>

                            <label class="camposDeReg">Nombre: *</label>
                            <input type="text" name="nombre" id="nombre" 
                                   pattern="[A-Za-z]{2,20}" 
                                   title="El nombre no es válido (tiene que ser una longitud entre 2 y 20 caracteres)" 
                                   required="required"
                                   value="<%=nombre%>"><br><br>

                            <label class="camposDeReg">DNI: *</label>
                            <input type="text" name="dni" id="dni" 
                                   pattern="[0-9]{8}[a-zA-Z]{1}" 
                                   title="El DNI no tiene un formato válido" 
                                   required="required"
                                   value="<%=dni%>"><br><br>

                            <label class="camposDeReg">Email: *</label>
                            <input type="email" name="email" id="email" 
                                   pattern="[A-Za-z]([_\-.]?[A-Za-z0-9]+)+@[A-Za-z0-9]+\.[A-za-z]{2,5}"
                                   title="El email introducido no tiene un formato de email valido"
                                   required="required"
                                   value="<%=email%>"
                                   disabled><br><br>

                            <label class="camposDeReg">Contraseña: *</label>
                            <input type="password" name="contrasena" id="contrasena" 
                                   pattern="[a-zA-Z0-9]{6,25}" 
                                   title="La contrasena tiene que tener entre 6 y 25 caracteres (solo caracteres alfanuméricos"
                                   value="<%=contrasena%>"><br><br>

                            <label class="camposDeReg">Provincia: *</label>
                            <select name="provincia" id="provincia" required="required">
                                <% if (provincia.equals("alava")) {%>
                                    <option selected value="alava">Álava</option>
                                    <option value="guipuzcoa">Guipuzcoa</option>
                                    <option value="vizacaya">Vizcaya</option>
                                <% if (provincia.equals("guipuzcoa")) {%>
                                    <option value="alava">Álava</option>
                                    <option selected value="guipuzcoa">Guipuzcoa</option>
                                    <option value="vizacaya">Vizcaya</option>
                                <% } else if(provincia.equals("Vvizcaya")) { %>
                                    <option value="alava">Álava</option>
                                    <option value="guipuzcoa">Guipuzcoa</option>
                                    <option selected value="vizacaya">Vizcaya</option>
                                <% } %>
                            </select><br><br>

                            <label class="camposDeReg">Ciudad:</label>
                            <select name="ciudad" id="ciudad">
                                <% if (ciudad.equals("gasteiz")) {%>
                                    <option selected value="gasteiz">Gasteiz</option>
                                    <option value="donosti">Donosti</option>
                                    <option value="bilbo">Bilbo</option>
                                <% if (ciudad.equals("donosti")) {%>
                                    <option value="gasteiz">Gasteiz</option>
                                    <option selected value="donosti">Donosti</option>
                                    <option value="bilbo">Bilbo</option>
                                <% } else if(ciudad.equals("bilbo")) { %>
                                    <option value="gasteiz">Gasteiz</option>
                                    <option value="donosti">Donosti</option>
                                    <option selected value="bilbo">Bilbo</option>
                                <% } %>
                            </select><br><br>
                            
                            <label class="camposDeReg">Dirección:</label>
                            <textarea id="direccion" rows="3" cols="47" form= "perfil" wrap= "soft">
                                <%=direccion%>
                            </textarea><br><br>

                            <label class="camposDeReg">Código Postal: *</label>
                            <input type="text" name="codigopostal" id="codigopostal" required="required"
                                   pattern="[0-9]{5}" 
                                   title="El código postal no es válido"
                                   value="<%=codigopostal%>"><br><br>

                            <label class="camposDeReg">Telefono: *</label>
                            <input type="text" name="telefono" id="telefono" required="required"
                                   pattern="[0-9]{9}"
                                   value="<%=telefono%>"><br><br>

                            <label class="camposDeReg">Fecha de nacimiento:</label>

                            <select name="dia" id="dia">
                                <%
                                    for(int i = 1; i <= 31; i++) {
                                        if(i == dia) {
                                %>
                                            <option selected value="<%=i%>"><%=i%></option>
                                <%      } else { %>
                                            <option value="<%=i%>"><%=i%></option>
                                <%      }
                                    }
                                %>
                            </select>
                            <select name="mes" id="mes">                              
                                <%
                                    for(int i = 1; i <= 12; i++) {
                                        if(i == mes) {
                                %>
                                            <option selected value="<%=i%>"><%=i%></option>
                                <%      } else { %>
                                            <option value="<%=i%>"><%=i%></option>
                                <%      }
                                    }
                                %>
                            </select>
                            <select name="ano" id="ano">
                                <%
                                    for(int i = 1984; i <= 1994; i++) {
                                        if(i == ano) {
                                %>
                                            <option selected value="<%=i%>"><%=i%></option>
                                <%      } else { %>
                                            <option value="<%=i%>"><%=i%></option>
                                <%      }
                                    }
                                %>
                            </select><br><br>

                            Los campos marcados con * son obligatorios<br><br>

                            <input type="submit" name="botonGuardar" id="botonGuardar" value="Guardar Cambios">
                        </form>
                    </fieldset>
                    <% if(session.getAttribute("errorPerfil") != null) { %>
                        <label class="mensajesDeError"><%= (String) session.getAttribute("errorPerfil")%></label>
                    <%
                        session.setAttribute("errorPerfil", null);
                        } 
                    %>
                </div>
                <div id="localizacion">
                    <!-- Pagina muy intersante sobre Google Maps Api Key
                            http://www.maestrosdelweb.com/trabajando-con-el-api-de-google-maps/ -->
               
                            <input type="button" id="obtener" value="Obtener la localización actual"> <br>
                            <div id="dato"></div><br><br>
                </div>
        <% } else { %>
        <label class="mensajesDeError">Error: no tiene acceso a esta pagina, no est� logueado</label>
        <% } %>
            </div>
        </section>
        <br>
       <footer id="footerPerfil">
            <br>
            <a href="http://creativecommons.org/licenses/by-nc-nd/3.0/" id="licencia">CC BY-NC-ND 3.0</a>
            <label id="autores">Copyright © 2014 Julen Aristimuño y Ander Granado</label>
        </footer>
    </body>
</html>
