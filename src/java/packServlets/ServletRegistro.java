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
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Julen
 */
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
    short dia = 0;
    short mes = 0;
    short ano = 0;
    String direccion = "";
    String imagen = "";
    
    Connection conn = null;
    
    @Override
    public void init(ServletConfig config) throws ServletException {
        // Llamada al método init() de la superclase (GenericServlet)
        // Así se asegura una correcta inicialización del servlet
        super.init(config);

        // dsn (Data Source Name) de la base de datos
        String dsn = "jdbc:odbc:bdjatetxe";

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

        System.out.println("Iniciando ServletRegistro...");
    }
    
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
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
        
        if(!request.getParameter("dia").equals(""))
            dia = Short.parseShort(request.getParameter("dia"));
        else
            existeError = true;
        
        if(!request.getParameter("mes").equals(""))
            mes = Short.parseShort(request.getParameter("mes"));
        else
            existeError = true;
        
        if(!request.getParameter("ano").equals(""))
            ano = Short.parseShort(request.getParameter("ano"));
        else
            existeError = true;
        
        if(!request.getParameter("direccion").equals(""))
            direccion = request.getParameter("direccion");
        else
            existeError = true;
        
        if(!request.getParameter("cimagen").equals(""))
            imagen = request.getParameter("imagen");
        else
            existeError = true;
        
        if(!existeError)
            insertarUsuarioBD();
        else
            System.out.println("Se ha producido un error");
        
        
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ServletRegistro</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ServletRegistro at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }
    
    private void insertarUsuarioBD() {
       Statement st = null;
       
       try{
           st= conn.createStatement();
           st.executeUpdate("INSERT INTO Usuario VALUES " + "('"+email+"','"+dni+"','"+sexo+"','"+nombre+"','"
                   +apellido+"','"+provincia+"','"+ciudad+"','"+codigopostal+"','"+telefono+"','"
                   +dia+"','"+mes+"','"+ano+"','"+direccion+"','"+imagen+"')");
       }catch(SQLException sql){
           System.out.println("Se produjo un errror creando el Statement");
           System.out.println(sql.getMessage());
        }
    }

    /*
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
            processRequest(request,response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold
}
