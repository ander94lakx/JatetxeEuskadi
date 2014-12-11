/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package packServlets;

import java.io.IOException;
import java.io.PrintWriter;
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
        // Llamada al método init() de la superclase (GenericServlet)
        // Así se asegura una correcta inicialización del servlet
        super.init(config);

        // dsn (Data Source Name) de la base de datos
        String dsn = "jdbc:odbc:NombreLogicoBaseDeDatos";

        // Carga del Driver del puente JDBC-ODBC
        try {
          Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
        } catch(ClassNotFoundException ex) {
          System.out.println("Error al cargar el driver");
          System.out.println(ex.getMessage());
        }
        // Establecimiento de la conexión con la base de datos
        try {
          conn = DriverManager.getConnection(dsn, "", "");
        } catch (SQLException sqlEx) {
          System.out.println("Se ha producido un error al" +
                             " establecer la conexión con: " + dsn);
          System.out.println(sqlEx.getMessage());
        }

        System.out.println("Iniciando ServletLogin...");
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
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
                ResultSet rs = st.executeQuery("SELECT contrasena FROM Usuario WHERE email="+email);
                if(rs.next()){
                    contrasenaAlmacenada = rs.getString("contrasena");
                    if(obtenerHash(contrasena).equals(contrasenaAlmacenada)){
                        // Se loguea
                    } else {
                        // No te logueas: contraseña erronea
                    }
                } else {
                    // No te logueas: no estas registrado
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

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
