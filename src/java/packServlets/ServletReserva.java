/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package packServlets;

import com.sun.org.apache.xalan.internal.xsltc.compiler.util.ResultTreeType;
import java.io.IOException;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Asus
 */
public class ServletReserva extends HttpServlet {
    int personas = 0;
    String fecha = "";
    String hora = "";
    String restaurante = "";
    String usuario = "";
    
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
        
        boolean existeError = false;
        if(!request.getParameter("personas").equals(""))
            personas = Integer.parseInt(request.getParameter("personas"));
        else
            existeError = true;
        
        if(!request.getParameter("fecha").equals(""))
            fecha = request.getParameter("fecha");
        else
            existeError = true;
         
        if(!request.getParameter("hora").equals("")) {
            String temp = request.getParameter("hora");
            hora = temp.charAt(0) + temp.charAt(1) + ":" + temp.charAt(2) + temp.charAt(3);
        }
        else
            existeError = true;
        
        if(request.getSession(true).getAttribute("restauranteActual") != null) {
            restaurante = (String) request.getSession(true).getAttribute("restauranteActual");
            request.getSession(true).setAttribute("restauranteActual", null);
        } else
            existeError = true;
        
        if(request.getSession(true).getAttribute("usuarioActual") != null) {
            usuario = (String) request.getSession(true).getAttribute("usuarioActual");
        } else
            existeError = true;
        
        if(!existeError) {
            realizarReserva(request,response);
        }
        else
            System.out.println("Error al recibir los parametros");
        
    }
    
    private void realizarReserva(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int mesasReservadas = 0;
        int tamanoMesa = 0;
        int numDeMesasAReservar = 0;
        int numDeMesasTotales = 0;
        String dni = "";
        float saldo = 0;
        
        try {
            // 1- comprobar si para esa fecha y hora en ese restaurante hay plazas suficientes para todos
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("SELECT mesasreservadas FROM Reserva "
                    + "WHERE restaurante='"+restaurante+"' and fecha=datevalue('"+fecha+"') and hora='"+hora+"';");
           
            while(rs.next()) {
                mesasReservadas += rs.getInt("mesasreservadas");
            }
            
            Statement st2 = conn.createStatement();
            ResultSet rs2 = st2.executeQuery("SELECT nummesas, numasientos FROM Restaurante WHERE nombre='"+restaurante+"';");
            
            while(rs2.next()) {
                numDeMesasTotales = rs2.getInt("nummesas");
                tamanoMesa = rs2.getInt("numasientos");
            }
            
            numDeMesasAReservar = personas / tamanoMesa;
            
            if(personas % tamanoMesa != 0)
                numDeMesasAReservar++;
            
            if(numDeMesasAReservar + mesasReservadas <= numDeMesasTotales) {
                // Hay espacio para reservar en ese restaurante
                Statement st3 = conn.createStatement();
                ResultSet rs3 = st3.executeQuery("SELECT dni FROM Usuario WHERE email='"+usuario+"';");
                
                if(rs3.next())
                    dni = rs3.getString("dni");
                
                Statement st4 = conn.createStatement();
                ResultSet rs4 = st4.executeQuery("SELECT saldo FROM Saldos WHERE dni='"+dni+"';");
                
                if(rs4.next())
                    saldo = rs4.getFloat("saldo");
                
                if(saldo > 10.0f) {
                    // Hay saldo para realizar la reserva
                    Statement st5 = conn.createStatement();
                    st5.executeUpdate("INSERT INTO Reserva VALUES('"+restaurante+"','"+usuario+"',datevalue('"+fecha+"'),'"+hora+"',0,"+numDeMesasAReservar+");");
                    
                    st5.executeUpdate("UPDATE Saldos SET saldo=saldo-10 WHERE dni='"+dni+"';");
                    
                    String msg = "Reserva realizada para las: "+hora+" de "+fecha+". Saldo restante en su cuenta: "+(saldo-10);
                    System.out.println(msg);
                    request.getSession(true).setAttribute("estadoReserva", msg);
                    response.sendRedirect("jsp/restaurante.jsp?restaurante="+restaurante);
                    
                } else {
                    System.out.println("Reserva NO realizada, no hay saldo suficiente en su cuenta");
                    request.getSession(true).setAttribute("estadoReserva", "Reserva NO realizada, no hay saldo suficiente en su cuenta");
                    response.sendRedirect("jsp/restaurante.jsp?restaurante="+restaurante);
                }
            } else {
                System.out.println("Reserva NO realizada, no hay espacio suficiente en el restaurante");
                request.getSession(true).setAttribute("estadoReserva", "\"Reserva NO realizada, no hay espacio suficiente en el restaurante");
                response.sendRedirect("jsp/restaurante.jsp?restaurante="+restaurante);
            }
            
            
        } catch (SQLException ex) {
            Logger.getLogger(ServletReserva.class.getName()).log(Level.SEVERE, null, ex);
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
}
