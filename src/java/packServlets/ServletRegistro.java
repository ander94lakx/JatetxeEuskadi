package packServlets;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ServletRegistro extends HttpServlet {
    String email = "";
    String dni = "";
    char sexo = ' ';
    String nombre = "";
    String apellido = "";
    String provincia = "";
    String ciudad = "";
    int codigopostal = 0;
    int telefono = 0;
    String imagen = "";
    String contrasena = "";
    
    Connection conn = null;
    
    @Override
    public void init(ServletConfig config) throws ServletException {

        super.init(config);
        
        if(config.getServletContext().getAttribute("CONEXION") == null) {
            String dsn = "jdbc:odbc:"+config.getServletContext().getInitParameter("BD");
            try {
              Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
              conn = DriverManager.getConnection(dsn, "", "");
            } catch(ClassNotFoundException ex) {
              System.out.println("Error al cargar el driver");
            } catch (SQLException sqlEx) {
              System.out.println("Se ha producido un error al establecer la conexión con: " + dsn);
            }
        } else {
            conn = (Connection) config.getServletContext().getAttribute("CONEXION");
        }
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        boolean existeError = false;
        if(!request.getParameter("email").equals(""))
            email = request.getParameter("email");
        else
            existeError = true;
        
        if(!request.getParameter("dni").equals(""))
            dni = request.getParameter("dni");
        else
            existeError = true;
         
         if(!request.getParameter("sexo").equals(""))
            sexo =  request.getParameter("sexo").charAt(0);
        else
            existeError = true;
        
        if(!request.getParameter("nombre").equals(""))
            nombre = request.getParameter("nombre");
        else
            existeError = true;
           
        if(!request.getParameter("apellido").equals(""))
            apellido = request.getParameter("apellido");
        else
            existeError = true;
        
        if(!request.getParameter("provincia").equals(""))
            provincia = request.getParameter("provincia");
        else
            existeError = true;
         
        if(!request.getParameter("ciudad").equals(""))
            ciudad = request.getParameter("ciudad");
        else
            existeError = true;
           
        if(!request.getParameter("codigopostal").equals(""))
            codigopostal = Integer.parseInt(request.getParameter("codigopostal"));
        else
            existeError = true;
        
        if(!request.getParameter("telefono").equals(""))
            telefono = Integer.parseInt(request.getParameter("telefono"));
        else
            existeError = true;
        
        if(!request.getParameter("imagenInput").equals("")) {
            imagen = request.getParameter("imagenInput");
            System.out.println(imagen);
        }
        
        if(!request.getParameter("contrasena").equals(""))
            contrasena = obtenerHash(request.getParameter("contrasena"));
        else
            existeError = true;
        
        if(!existeError)
            insertarUsuarioBD(request,response);
        else
            System.out.println("Se ha producido un error");
    }
    
    private void insertarUsuarioBD(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Statement st = null;
        Statement st2 = null;
        try{
            st = conn.createStatement();
            ResultSet rs = st.executeQuery("SELECT email FROM Usuario");
            
            while(rs.next()) {
                if(rs.getString("email").equals(email)) {
                    String error = "Error al registrar al ususario: ya existe un uuario con el mismo email";
                    request.getSession(true).setAttribute("errorRegistro", error);
//                  request.getRequestDispatcher("registro.jsp").forward(request, response);
                    response.sendRedirect("jsp/registro.jsp");
                }
            }
            st2 = conn.createStatement();
            st2.executeUpdate("INSERT INTO Usuario "
                    + "(email,dni,sexo,nombre,apellido,provincia,ciudad,codigopostal,telefono,contrasena) VALUES " 
                    +"('"+email+"','"+dni+"','"+sexo+"','"+nombre+"','"+apellido+"','"
                    +provincia+"','"+ciudad+"','"+codigopostal+"','"+telefono+"','"+contrasena+"');");
            
            response.sendRedirect("jsp/index.jsp");
            
        } catch(SQLException sql){
            System.out.println("Se produjo un errror creando el Statement");
            System.out.println(sql.getMessage());
        }
    }
    
    private String obtenerHash(String cadena) {
        int hash = 0;
        int i, chr, len;
        if(cadena.length() == 0)
            return String.valueOf(hash);
        for(i = 0, len = cadena.length(); i < len; i++) {
            chr = cadena.charAt(i);
            hash = ((hash << 5) - hash) + chr;
            hash |=0;
        }
        return String.valueOf(hash);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            processRequest(request,response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
