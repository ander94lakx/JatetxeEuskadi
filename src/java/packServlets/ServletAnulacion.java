package packServlets;

import java.io.IOException;
import java.sql.*;
import java.util.*;
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
        
        Statement st, st2, st3;
        try {
            st = conn.createStatement();
            st.executeUpdate("UPDATE Reserva SET cancelada=1 WHERE restaurante='"+restaurante+"' and usuario='"+usuario+"' and fecha=datevalue('"+fecha+"');");
            
            float precioASumar = 0;
            int ano = Integer.parseInt(fecha.substring(0, 4));
            int mes = Integer.parseInt(fecha.substring(5, 7));
            int dia = Integer.parseInt(fecha.substring(8, 10));
            
            java.util.Date fechaActual = new java.util.Date();
            java.util.Date fechaDeLaReserva = new java.util.Date(ano, mes-1, dia);
            
            long MILLSECS_PER_DAY = 24 * 60 * 60 * 1000;
            long diferenciaDias = ( fechaDeLaReserva.getTime() - fechaActual.getTime() )/ MILLSECS_PER_DAY;
            
            if(diferenciaDias >= 2)
                precioASumar = 10;
            else if(diferenciaDias >= 1)
                precioASumar = 6.6f;
            
            st2 = conn.createStatement();
            ResultSet rs = st.executeQuery("SELECT saldo FROM Saldos WHERE dni=(SELECT dni FROM Usuario WHERE email='"+usuario+"')");
            
            float saldoRestante = 0;
            if(rs.next())
                saldoRestante = rs.getFloat("saldo") + precioASumar;
                
            st2 = conn.createStatement();
            st.executeUpdate("UPDATE Saldos SET saldo="+saldoRestante+" WHERE dni=(SELECT dni FROM Usuario WHERE email='"+usuario+"')");
            
            String msg = "Anulacion realizada, saldo restante: "+saldoRestante+" euros.";
            System.out.println(msg);
            request.getSession(true).setAttribute("estadoAnulacion", msg);
            response.sendRedirect("jsp/historicoReservas.jsp");         
         
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
