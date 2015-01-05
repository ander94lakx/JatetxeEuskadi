package packServlets;

import java.io.IOException;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class ServletAnulacion extends HttpServlet {
    String restaurante = "";
    String usuario = "";
    String fecha = "";
    
    Connection conn;

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
        response.setContentType("text/html;charset=UTF-8");
        
        String datosReserva = "";
        restaurante = "";
        usuario = "";
        fecha = "";
        
        if(request.getParameter("cancelar") != null)
            datosReserva = request.getParameter("cancelar");
        else {
            System.out.println("no se ha podido realizar la anulacion");
            return;
        }
        
        int i = 0;
        
        while(datosReserva.charAt(i) != ' ') {
            usuario += datosReserva.charAt(i);
            i++;
        }
        
        i++;
               
        while(datosReserva.charAt(i) != ' ') {
            fecha += datosReserva.charAt(i);
            i++;
        }
        
        i++;
        
        while(i < datosReserva.length()) {
            restaurante += datosReserva.charAt(i);
            i++;
        }
            
        System.out.println("datosReserva: "+datosReserva);
        System.out.println("usuario: "+usuario);
        System.out.println("fecha: "+fecha);
        System.out.println("restaurante: "+restaurante);
        
        Statement st;
        try {
            st = conn.createStatement();
            int canc = st.executeUpdate("UPDATE Reserva SET cancelada=1 WHERE restaurante='"+restaurante+"' and usuario='"+usuario+"' and fecha=datevalue('"+fecha+"');");
            
            if(i == 1) {
                System.out.println("Anulacion realizada");
                request.getSession(true).setAttribute("estadoAnulacion", "Anulacion realizada");
                response.sendRedirect("jsp/historicoReservas.jsp");
            } else {
                System.out.println("Anulacion NO realizada");
                request.getSession(true).setAttribute("estadoAnulacion", "Anulacion NO realizada");
                response.sendRedirect("jsp/historicoReservas.jsp");
            }
            
            
        } catch (SQLException ex) {
            Logger.getLogger(ServletAnulacion.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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
