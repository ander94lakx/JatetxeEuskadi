/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package packServlets;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Asus
 */
public class ServletPerfil extends HttpServlet {
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
        
        if(!request.getParameter("contrasena").equals(""))
            contrasena = request.getParameter("contrasena");
        else
            existeError = true;
        
        if(!existeError) {
            if(actualizarUsuarioBD()){
                request.getRequestDispatcher("index.jsp").forward(request, response);
            } else {
                String error = "Error al modificar los datos";
                request.getSession(true).setAttribute("errorPerfil", error);
                request.getRequestDispatcher("perfil.jsp").forward(request, response);
            }
            
        }
        else
            System.out.println("Se ha producido un error");
    }
    
    private boolean actualizarUsuarioBD() {
        Statement st = null;
        Statement st2 = null;
        try{
            st = conn.createStatement();
            ResultSet rs = st.executeQuery("SELECT email FROM Usuario");
            if(rs.getString("email") == null) {
                return false;
            } else {
                st.executeUpdate("UPDATE Usuario SET dni='"+dni+"',"+
                                                   "sexo='"+sexo+"',"+
                                                   "nombre='"+nombre+"',"+
                                                   "apellido='"+apellido+"',"+
                                                   "provincia='"+provincia+"',"+
                                                   "ciudad='"+ciudad+"',"+
                                                   "codigopostal="+codigopostal+","+
                                                   "telefono'"+telefono+","+
                                                   "dia="+dia+","+
                                                   "mes="+mes+","+
                                                   "ano="+ano+","+
                                                   "direccion='"+direccion+"',"+
                                                   "imagen='"+imagen+"'"+
                                "WHERE email='"+email+"';");
                st2 = conn.createStatement();
                ResultSet rs2 = st2.executeQuery("SELECT contrasena FROM Usuario WHERE email='"+email+"';");
                if(rs2.next()) {
                    if(rs2.getString("contrasena").equals(contrasena)) {
                        st2.executeUpdate("UPDATE Usuario SET contrasena='"+obtenerHash(contrasena)+"' WHERE email='"+email+"';");
                    }
                }
                return true;
            }
        } catch(SQLException sql){
            System.out.println("Se produjo un errror creando el Statement");
            System.out.println(sql.getMessage());
        }
        return false;
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
