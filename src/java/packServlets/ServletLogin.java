package packServlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ServletLogin extends HttpServlet {
    
    String email;
    String contrasena;
    
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
        
        if(!request.getParameter("contrasena").equals(""))
            contrasena = request.getParameter("contrasena");
        else
            existeError = true;
        
        if(!existeError){
            Statement st = null;
            String contrasenaAlmacenada = "";
            try {
                st = conn.createStatement();
                ResultSet rs = st.executeQuery("SELECT contrasena FROM Usuario WHERE email='"+email+"';");
                if(rs.next()){
                    contrasenaAlmacenada = rs.getString("contrasena");
                    if(obtenerHash(contrasena).equals(contrasenaAlmacenada)){
                        // Se loguea, y se guarde en una var de sesion su email
                        request.getSession(true).setAttribute("usuarioActual", email);
                        request.getRequestDispatcher("index.jsp").forward(request, response);
                    } else {
                        String error = "No se ha podido loguear: la contraseña es incorrecta";
                        request.getSession(true).setAttribute("errorLogin", error);
                        request.getRequestDispatcher("login.jsp").forward(request, response);
                    }
                } else {
                    String error = "No se ha podido loguear: el usuario no esta registrado";
                    request.getSession(true).setAttribute("errorLogin", error);
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }               
            } catch(SQLException sql){
                System.out.println("Se produjo un errror creando el Statement");
                System.out.println(sql.getMessage());
            }
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
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
